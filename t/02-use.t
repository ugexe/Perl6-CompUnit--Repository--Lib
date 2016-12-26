use v6;
use Test;
plan 2;

use CompUnit::Repository::Lib;

use lib "CompUnit::Repository::Lib#{$?FILE.IO.parent.child('test-libs')}";

# XXX: Not sure why the `require` are needed, so these tests are probably bad

subtest {
    {
        nok '$!dist' ~~ any( ::("Candidate").^attributes>>.name ), 'module not yet loaded';
    }
    {
        use Zef;
        ok '$!dist' ~~ any( ::("Candidate").^attributes>>.name ),  'module is accessable';
    }
}, 'use module with no dependencies';

subtest {
    {
        nok '$!config' ~~ any( ::("Zef::Client").^attributes>>.name ), 'module not yet loaded';
    }
    {
        use Zef::Client;
        ok '$!config' ~~ any( ::("Zef::Client").^attributes>>.name ),  'module loaded';
    }
}, 'use modules with multi-level dependency chain';
