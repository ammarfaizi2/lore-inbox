Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262040AbTAIJJt>; Thu, 9 Jan 2003 04:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262089AbTAIJJt>; Thu, 9 Jan 2003 04:09:49 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:25728 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S262040AbTAIJJp>; Thu, 9 Jan 2003 04:09:45 -0500
From: "Sowmya Adiga" <sowmya.adiga@wipro.com>
To: <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK]AIM benchmark result for kernel 2.5.55
Date: Thu, 9 Jan 2003 14:48:13 +0530
Message-ID: <007c01c2b7c0$090a29a0$6009720a@wipro.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
x-mimeole: Produced By Microsoft MimeOLE V6.00.2462.0000
Importance: Normal
X-OriginalArrivalTime: 09 Jan 2003 09:18:13.0305 (UTC) FILETIME=[090A0290:01C2B7C0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 Here are the AIM benchmark result for kernel 2.5.55.Kernel 2.5.55 when
compared with kernel 2.5.54 showed difference of performance in
following tests:- 
Kernel 2.5.55 showed better performance in 1)signal traps/second and
2)Dynamic memory operation/second when compared with 2.5.54.

========================================================================

Test        Elapsed      Iteration    Iteration        Operation
Name        Time (sec)   Count        Rate(loops/sec)  Rate (ops/sec)
------------------------------------------------------------------------
System Memory Allocations/second
brk_test 
[2.5.55]      60.02       3417        56.93102          967827.39 
[2.5.54]      60.01       3500        58.32361          991501.42

Signal Traps/second
signal_test
[2.5.55]      60.00       9651        160.85000         160850.00 
[2.5.54]      60.00       9282        154.70000         154700.00

Dynamic Memory Operations/second
mem_rtns_1 
[2.5.55]      60.01       1838        30.62823          918846.86
[2.5.54]      60.04       1441        24.00067          720019.99 

========================================================================
*There is no much significant difference in other test result.

------------------------------------------------------------------------
----
					kernel 2.5.55
------------------------------------------------------------------------
----
Machine's name                                    : access1
Machine's configuration                           : PIII/868MHZ/128MB
Number of seconds to run each test [2 to 1000]    : 60
Path to disk files                                : /tmp 

------------------------------------------------------------------------
----
TestTest        Elapsed     Iteration    Iteration         Operation
NumberName      Time (sec)   Count      Rate(loops/sec)    Rate(ops/sec)
------------------------------------------------------------------------
----
1 add_double     60.02        716        11.92936          214728.42
Thousand Double Precision Additions/second

2 add_float      60.05       1075        17.90175          214820.98
Thousand Single Precision Additions/second

3 add_long       60.03       1768        29.45194          1767116.44
Thousand Long Integer Additions/second

4 add_int        60.01       1768        29.46176          1767705.38
Thousand Integer Additions/second

5 add_short      60.01       4419        73.63773          1767305.45
Thousand Short Integer Additions/second

6 creat-clo      60.00       2149        35.81667          35816.67 
File Creations and Closes/second

7 page_test      60.00       8556        142.60000         242420.00 
System Allocations & Pages/second

8 brk_test       60.02       3417        56.93102          967827.39 
System Memory Allocations/second

9 jmp_test       60.00       318222      5303.70000        5303700.00
Non-local gotos/second

10signal_test    60.00       9651        160.85000         160850.00 
Signal Traps/second

11 exec_test     60.02       2084        34.72176          173.61
Program Loads/second

12 fork_test     60.05       1192        19.85012          1985.01 
Task Creations/second

13 link_test     60.00       9858        164.30000         10350.90
Link/Unlink Pairs/second

14 disk_rr       60.01       500         8.33194           42659.56 
Random Disk Reads (K)/second

15 disk_rw       0.11        397         6.60456           33815.34
Random Disk Writes (K)/second

16 disk_rd       60.02       2833        47.20093          241668.78
Sequential Disk Reads (K)/second

17 disk_wrt      60.05       634         10.55787          54056.29
Sequential Disk Writes (K)/second

18 disk_cp       60.04       500         8.32778           42638.24 
Disk Copies (K)/second

19sync_disk_rw   61.18       1           0.01635           41.84 
Sync Random Disk Writes (K)/second

20sync_disk_wrt  76.86       2           0.02602           66.61 
Sync Sequential Disk Writes (K)/second

21 sync_disk_cp  77.09       2           0.02594           66.42 
Sync Disk Copies (K)/second

22 disk_src      60.00       10478       174.63333         13097.50
Directory Searches/second

23 div_double    60.02       1322        22.02599          66077.97 
Thousand Double Precision Divides/second

24 div_float     60.01       1322        22.02966          66088.99 
Thousand Single Precision Divides/second

25 div_long      60.03       1592        26.52007          23868.07 
Thousand Long Integer Divides/second

26 div_int       60.03       1592        26.52007          23868.07
Thousand Integer Divides/second

27 div_short     60.02       1592        26.52449          23872.04 
Thousand Short Integer Divides/second

28 fun_cal       60.00       4362        72.70000          37222400.00
Function Calls (no arguments)/second

29 fun_cal1      60.00       10230       170.50000         87296000.00
Function Calls (1 argument)/second

30 fun_cal2      60.00       7971        132.85000         68019200.00
Function Calls (2 arguments)/second

31 fun_cal15     60.02       2455        40.90303          20942352.55
Function Calls (15 arguments)/second

32 sieve         60.51       41          0.67757           3.39 
Integer Sieves/second

33 mul_double    60.00       836         13.93333          167200.00
Thousand Double Precision Multiplies/second

34 mul_float     60.03       836         13.92637          167116.44
Thousand Single Precision Multiplies/second

35 mul_long      60.00       75700       1261.66667        302800.00
Thousand Long Integer Multiplies/second

36 mul_int       60.00       76021       1267.01667        304084.00
Thousand Integer Multiplies/second

37 mul_short     60.00       60568       1009.46667        302840.00
Thousand Short Integer Multiplies/second

38 num_rtns_1    60.00       32604       543.40000         54340.00
Numeric Functions/second

39 new_raph      60.00       79918       1331.96667        266393.33
Zeros Found/second

40 trig_rtns     60.00       2165        36.08333          360833.33
Trigonometric Functions/second

41 matrix_rtns   60.00       349604      5826.73333        582673.33 
Point Transformations/second

42 array_rtns    60.01       958         15.96401          319.28 
Linear Systems Solved/second

43 string_rtns   60.01       851         14.18097          1418.10 
String Manipulations/second

44 mem_rtns_1    60.01       1838        30.62823          918846.86
Dynamic Memory Operations/second

45 mem_rtns_2    60.00       131060      2184.33333        218433.33 
Block Memory Operations/second

46 sort_rtns_1   60.01       2424        40.39327          403.93 
Sort Operations/second

47 misc_rtns_1   60.00       31890       531.50000         5315.00 
Auxiliary Loops/second

48 dir_rtns_1    60.00       13086       218.10000         2181000.00
Directory Operations/second

49 shell_rtns_1  60.02       2541        42.33589          42.34 
Shell Scripts/second

50 shell_rtns_2  60.01       2541        42.34294          42.34 
Shell Scripts/second

51 shell_rtns_3  60.00       2540        42.33333          42.33 
Shell Scripts/second

52 series_1      60.00       1463914     24398.56667       2439856.67
Series Evaluations/second

53 shared_memory 60.00       165217      2753.61667        275361.67 
Shared Memory Operations/second

54 tcp_test      60.00       16148       269.13333         24222.00 
TCP/IP Messages/second

55 udp_test      60.00       48569       809.48333         80948.33 
UDP/IP DataGrams/second

56 fifo_test     60.00       88536       1475.60000        147560.00 
FIFO Messages/second

57 stream_pipe   60.00       76223       1270.38333        127038.33 
Stream Pipe Messages/second

58 dgram_pipe    60.00       75782       1263.03333        126303.33
DataGram Pipe Messages/second

59 pipe_cpy      60.00       254680      4244.66667        424466.67 
Pipe Messages/second

60 ram_copy      60.00       1496330     24938.83333       623969610.00
Memory to Memory Copy/second
------------------------------------------------------------------------
----
Regards
 
Sowmya Adiga
Project Engineer
Wipro Technologies
53/1,Hosur Road,Madivala
Bangalore-560 068,INDIA
Tel: +91-80-5502001 Extn.5086
sowmya.adiga@wipro.com

