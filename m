Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261615AbTBRKSp>; Tue, 18 Feb 2003 05:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264790AbTBRKSp>; Tue, 18 Feb 2003 05:18:45 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:4520 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S261615AbTBRKSl>; Tue, 18 Feb 2003 05:18:41 -0500
From: "Sowmya Adiga" <sowmya.adiga@wipro.com>
To: <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK]AIM9 benchmark result for kernel 2.5.62.
Date: Tue, 18 Feb 2003 15:58:27 +0530
Message-ID: <015301c2d738$79a879e0$6009720a@wipro.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
X-OriginalArrivalTime: 18 Feb 2003 10:28:27.0824 (UTC) FILETIME=[799C9300:01C2D738]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 Here is the AIM9 benchmark result for kernel 2.5.62. when compared with
kernel 2.5.61 showed difference of performance in following tests:- 
========================================================================
 Test          Elapsed      Iteration    Iteration        Operation
 Name          Time (sec)   Count        Rate(loops/sec)  Rate (ops/sec)
------------------------------------------------------------------------
1 File Creations and Closes/second
  creat-clo 
[linux-2.5.62]  60.00       6025         100.41667        100416.67

[linux-2.5.61]  60.01       5662         94.35094         94350.94 

2 Signal Traps/second
  signal_test  
[linux-2.5.62]  60.00       11086        184.76667        184766.67 
[linux-2.5.61]  60.00       10670        177.83333        177833.33

3 Dynamic Memory Operations/second
mem_rtns_1    
[linux-2.5.62]  60.01       2449         40.80987         1224295.95
[linux-2.5.61]  60.01       2839         47.30878         1419263.46
========================================================================
*There is no much significant difference in other test result.

------------------------------------------------------------------------
---
					kernel-2.5.62
------------------------------------------------------------------------
---
Machine's name                                    : access1
Machine's configuration                           : PIII/868MHZ/128MB
Number of seconds to run each test [2 to 1000]    : 60
Path to disk files                                : /tmp

------------------------------------------------------------------------
---
Test  Test      Elapsed      Iteration    Iteration         Operation
NumberName      Time(sec)    Count        Rate(loops/sec)
Rate(ops/sec)
------------------------------------------------------------------------
---
1 add_double     60.07        716          11.91943         214549.69 
Thousand Double Precision Additions/second

2 add_float      60.05        1074         17.88510         214621.15
Thousand Single Precision Additions/second

3 add_long       60.00        1766         29.43333         1766000.00
Thousand Long Integer Additions/second

4 add_int        60.03        1767         29.43528         1766116.94
Thousand Integer Additions/second

5 add_short      60.01        4415         73.57107         1765705.72
Thousand Short Integer Additions/second

6 creat-clo      60.00        6025         100.41667        100416.67 
File Creations and Closes/second

7 page_test      60.01        6789         113.13114        192322.95
System Allocations & Pages/second

8 brk_test       60.02        2480         41.31956         702432.52
System Memory Allocations/second

9 jmp_test       60.00        321989       5366.48333       5366483.33
Non-local gotos/second

10 signal_test   60.00        11086        184.76667        184766.67
Signal Traps/second

11 exec_test     60.01        2717         45.27579         226.38 
Program Loads/second

12 fork_test     60.01        1274         21.22980         2122.98 
Task Creations/second

13 link_test     60.00        27681        461.35000        29065.05
Link/Unlink Pairs/second

14 disk_rr       60.12        437          7.26880          37216.23 
Random Disk Reads (K)/second

15 disk_rw       60.16        360          5.98404          30638.30 
Random Disk Writes (K)/second

16 disk_rd       60.01        2541         42.34294         216795.87
Sequential Disk Reads (K)/second

17 disk_wrt      60.07        564          9.38905          48071.92
Sequential Disk Writes (K)/second

18 disk_cp       60.20        446          7.40864          37932.23 
Disk Copies (K)/second

19sync_disk_rw   94.42        2            0.02118          54.23
Sync Random Disk Writes (K)/second

20sync_disk_wrt  69.42        2            0.02881          73.75 
Sync Sequential Disk Writes (K)/second

21 sync_disk_cp  69.22        2            0.02889          73.97 
Sync Disk Copies (K)/second

22 disk_src      60.00        18179        302.98333        22723.75
Directory Searches/second

23 div_double    60.02        1321         22.00933         66027.99
Thousand Double Precision Divides/second

24 div_float     60.02        1321         22.00933         66027.99
Thousand Single Precision Divides/second

25 div_long      60.01        1590         26.49558         23846.03
Thousand Long Integer Divides/second

26 div_int       60.01        1590         26.49558         23846.03
Thousand Integer Divides/second

27 div_short     60.01        1590         26.49558         23846.03
Thousand Short Integer Divides/second

28 fun_cal       60.00        4712         78.53333         40209066.67
Function Calls (no arguments)/second

29 fun_cal1      60.01        10333        172.18797        88160239.96
Function Calls (1 argument)/second

30 fun_cal2      60.00        7492         124.86667        63931733.33
Function Calls (2 arguments)/second

31 fun_cal15     60.00        2451         40.85000         20915200.00
Function Calls (15 arguments)/second

32 sieve         60.85        41           0.67379          3.37 
Integer Sieves/second

33 mul_double    60.02        835          13.91203         166944.35
Thousand Double Precision Multiplies/second

34 mul_float     60.01        835          13.91435         166972.17
Thousand Single Precision Multiplies/second

35 mul_long      60.00        75712        1261.86667       302848.00
Thousand Long Integer Multiplies/second

36 mul_int       60.00        75651        1260.85000       302604.00
Thousand Integer Multiplies/second

37 mul_short     60.00        60570        1009.50000       302850.00
Thousand Short Integer Multiplies/second

38 num_rtns_1    60.00        36668        611.13333        61113.33
Numeric Functions/second

39 new_raph      60.00        82838        1380.63333       276126.67 
Zeros Found/second

40 trig_rtns     60.02        2209         36.80440         368043.99
Trigonometric Functions/second

41 matrix_rtns   60.00        366477       6107.95000       610795.00 
Point Transformations/second

42 array_rtns    60.04        999          16.63891         332.78 
Linear Systems Solved/second

43 string_rtns   60.06        532          8.85781          885.78 
String Manipulations/second

44 mem_rtns_1    60.01        2449         40.80987         1224295.95
Dynamic Memory Operations/second

45 mem_rtns_2    60.00        131090       2184.83333       218483.33 
Block Memory Operations/second

46 sort_rtns_1   60.02        2505         41.73609         417.36 
Sort Operations/second

47 misc_rtns_1   60.00        51450        857.50000        8575.00
Auxiliary Loops/second

48 dir_rtns_1    60.00        11911        198.51667        1985166.67
Directory Operations/second

49 shell_rtns_1  60.01        3183         53.04116         53.04 
Shell Scripts/second

50 shell_rtns_2  60.01        3199         53.30778         53.31 
Shell Scripts/second

51 shell_rtns_3  60.02        3198         53.28224         53.28 
Shell Scripts/second

52 series_1      60.00        1470405      24506.75000      2450675.00
Series Evaluations/second

53shared_memory  60.00        153744       2562.40000       256240.00
Shared Memory Operations/second

54 tcp_test      60.00        29360        489.33333        44040.00 
TCP/IP Messages/second

55 udp_test      60.00        65167        1086.11667       108611.67
UDP/IP DataGrams/second

56 fifo_test     60.00        88336        1472.26667       147226.67 
FIFO Messages/second

57 stream_pipe   60.00        139441       2324.01667       232401.67
Stream Pipe Messages/second

58 dgram_pipe    60.00        134006       2233.43333       223343.33
DataGram Pipe Messages/second

59 pipe_cpy      60.00        185467       3091.11667       309111.67 
Pipe Messages/second

60 ram_copy      60.00        1552904      25881.73333      647560968.00
Memory to Memory Copy/second
------------------------------------------------------------------------
---
Regards
 
Sowmya Adiga
Project Engineer
Wipro Technologies
53/1,Hosur Road,Madivala
Bangalore-560 068,INDIA
Tel: +91-80-5502001 Extn.5086

 

