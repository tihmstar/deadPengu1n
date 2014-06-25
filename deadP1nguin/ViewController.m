//
//  ViewController.m
//  deadP1nguin
//
//  Created by Georges Kanaan on 6/25/14.
//
//

#import "ViewController.h"

@interface NSTask : NSObject
- (void)setLaunchPath:(NSString *)path;
- (void)setStandardInput:(id)input;
- (void)setStandardOutput:(id)output;
- (void)setArguments:(NSArray *)arguments;
- (void)setStandardError:(id)error;
- (void)launch;
@end
@interface NSTask (NSTaskConveniences)
- (void)waitUntilExit;
@end


@interface ViewController ()
            

@end

@implementation ViewController

-(NSString *)doSystemCallOnPath:(NSString*)launchPath withArguments:(NSArray *)arguments{
    NSTask *task = [[NSTask alloc] init];
    NSData *data;
    
    NSPipe *pipe = [NSPipe pipe];
    NSFileHandle *file = [pipe fileHandleForReading];
    
    
    [task setLaunchPath: launchPath];
    if (arguments) {
        [task setArguments: arguments];
    }
    [task setStandardError: pipe];
    [task setStandardOutput: pipe];
    
    [task launch];
    data = [file readDataToEndOfFile];
    
    [task waitUntilExit];
    
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"/panguaxe"]) {
        [self doSystemCallOnPath:@"/panguaxe" withArguments:nil];
    }
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
