//
//  ViewController.m
//  test@databaseOperation
//
//  Created by Henry on 15-5-20.
//  Copyright (c) 2015年 unbirdlikebird. All rights reserved.
//

#import "ViewController.h"
#import "FMDatabase.h"

@interface ViewController ()

@property   (nonatomic) FMDatabase  *testDatabase;

@end

@implementation ViewController

- (FMDatabase *)testDatabase
{
    if (!_testDatabase) {
        _testDatabase = [FMDatabase databaseWithPath:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"test.sqlite"]];
    }
    return _testDatabase;
}

- (void)sqliteCreateTable:(NSString *)tableName ID:(NSString *)ID name:(NSString *)name age:(NSString *)age address:(NSString *)address
{
    NSString *sqliteString = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (%@ INTEGER PRIMARY KEY AUTOINCREMENT, %@ TEXT, %@ INTEGER, %@ TEXT)", tableName, ID, name, age, address];

    if ([self.testDatabase open]) {

        BOOL result = [self.testDatabase executeUpdate:sqliteString];
        if (result) {
            NSLog(@"tabel created");
        }
        else{
            NSLog(@"table created error");
        }

        [self.testDatabase close];
    }
}

- (void)sqliteInsertInto:(NSString *)tableName name:(NSString *)name age:(NSString *)age address:(NSString *)address valuesname:(NSString *)pname age:(NSInteger)page address:(NSString *)paddress
{
    NSString *sqliteString = [NSString stringWithFormat:@"INSERT INTO %@ (%@, %@, %@) VALUES(%@, %ld, %@)", tableName, name, age, address, pname, (long)page, paddress];

    NSLog(@"%@", sqliteString);
    if ([self.testDatabase open]) {

        BOOL result = [self.testDatabase executeUpdate:sqliteString];
        if (result) {
            NSLog(@"data inserted");
        }
        else{
            NSLog(@"data inserted error");
        }

        [self.testDatabase close];
    }

}

- (void)sqliteSelectFrom:(NSString *)tableName
{
    NSString *sqliteString = [NSString stringWithFormat:@"SELECT * FROM %@", tableName];
    NSLog(@"%@", sqliteString);
    if ([self.testDatabase open]) {

        FMResultSet *resultSet = [self.testDatabase executeQuery:sqliteString];
        while ([resultSet next])
        {
            int ID = [resultSet intForColumn:@"ID"];
            NSString *name = [resultSet stringForColumn:@"NAME"];
            int age = [resultSet intForColumn:@"AGE"];
            NSString *address = [resultSet stringForColumn:@"ADDRESS"];

            NSLog(@"ID = %d | NAME IS %@ | AGE = %d | ADDRESS IS %@", ID, name, age, address);
        }

        [self.testDatabase close];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];

    [self sqliteCreateTable:@"PERSON" ID:@"ID" name:@"NAME" age:@"AGE" address:@"ADDRESS"];
    [self sqliteInsertInto:@"PERSON" name:@"NAME" age:@"AGE" address:@"ADDRESS" valuesname:@"'a'" age:1 address:@"'dalian'"];
    [self sqliteInsertInto:@"PERSON" name:@"NAME" age:@"AGE" address:@"ADDRESS" valuesname:@"'a'" age:1 address:@"'dalian'"];
    [self sqliteInsertInto:@"PERSON" name:@"NAME" age:@"AGE" address:@"ADDRESS" valuesname:@"'a'" age:1 address:@"'dalian'"];
    [self sqliteSelectFrom:@"PERSON"];
     //Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
