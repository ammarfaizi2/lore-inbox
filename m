Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267456AbTACIFb>; Fri, 3 Jan 2003 03:05:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267457AbTACIFa>; Fri, 3 Jan 2003 03:05:30 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:31957 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S267456AbTACIF1>; Fri, 3 Jan 2003 03:05:27 -0500
From: "Sowmya Adiga" <sowmya.adiga@wipro.com>
To: <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK]AIM benchmark result for kernel 2.5.54mm2
Date: Fri, 3 Jan 2003 13:43:43 +0530
Message-ID: <003701c2b300$084867d0$6009720a@wipro.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Importance: Normal
X-OriginalArrivalTime: 03 Jan 2003 08:13:44.0042 (UTC) FILETIME=[084CD4A0:01C2B300]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

   Here are the AIM benchmark result for kernel 2.5.54mm2.Kernel
2.5.54mm2 when compared with kernel 2.5.54 showed difference of
performance in following tests:- 
we can find that 2.5.54mm2 showed better performance than 2.5.54 in
1.Signal Traps/second
2.Dynamic Memory Operations/second
========================================================================

  Test      Elapsed      Iteration    Iteration        Operation 
  Name      Time (sec)   Count        Rate(loops/sec)  Rate (ops/sec)
------------------------------------------------------------------------
1 System Allocations & Pages/second
  page_test      
[2.5.54mm2]    60.00      8468         141.13333        239926.67 
[2.5.54]       60.00      8849         147.48333        250721.67

2 System Memory Allocations/second
  brk_test       
[2.5.54mm2]    60.01      3361         56.00733         952124.65 
[2.5.54]       60.01      3500         58.32361         991501.42 

3 Signal Traps/second
  signal_test   
[2.5.54mm2]    60.00      10071        167.85000        167850.00 
[2.5.54]       60.00      9282         154.70000        154700.00

4 Function Calls (1 argument)/second
   fun_cal1     
 [2.5.54mm2]   60.00      10194        169.90000        86988800.00 
 [2.5.54]      60.00      10231        170.51667        87304533.33 

5 Dynamic Memory Operations/second
   mem_rtns_1    
 [2.5.54mm2]   60.02      1902         31.68944         950683.11 
 [2.5.54]      60.04      1441         24.00067         720019.99 

6 UDP/IP DataGrams/second
   udp_test      
 [2.5.54mm2]   60.00      47522        792.03333        79203.33
 [2.5.54]      60.00      49179        819.65000        81965.00

========================================================================
*There is no much significant difference in other test result.

------------------------------------------------------------------------
----
					kernel 2.5.54mm2
------------------------------------------------------------------------
----

Machine's name                                    : access1
Machine's configuration                           : PIII/868MHZ/128MB
Number of seconds to run each test [2 to 1000]    : 60
Path to disk files                                : /tmp 

------------------------------------------------------------------------
----
 TestTest      Elapsed     Iteration   Iteration        Operation
NumberName     Time (sec)  Count       Rate (loops/sec) Rate (ops/sec)
------------------------------------------------------------------------
----
1 add_double     60.02      716         11.92936         214728.42
Thousand Double Precision Additions/second
 
2 add_float      60.01      1074        17.89702         214764.21 
Thousand Single Precision Additions/second

3 add_long       60.01      1768        29.46176         1767705.38 
Thousand Long Integer Additions/second

4 add_int        60.01      1768        29.46176         1767705.38 
Thousand Integer Additions/second

5 add_short      60.00      4419        73.65000         1767600.00
Thousand Short Integer Additions/second

6 creat-clo      60.00      2124        35.40000         35400.00 
File Creations and Closes/second

7 page_test      60.00      8468        141.13333        239926.67 
System Allocations & Pages/second

8 brk_test       60.01      3361        56.00733         952124.65 
System Memory Allocations/second

9 jmp_test       60.00      318196      5303.26667       5303266.67 
Non-local gotos/second

10 signal_test   60.00      10071       167.85000        167850.00 
Signal Traps/second

11 exec_test     60.02      2087        34.77174         173.86 
Program Loads/second

12 fork_test     60.01      1264        21.06316         2106.32
Task Creations/second

13 link_test     60.00      9867        164.45000        10360.35
Link/Unlink Pairs/second

14 disk_rr       60.00      483         8.05000          41216.00 
Random Disk Reads (K)/second

15 disk_rw       60.08      382         6.35819          32553.93
Random Disk Writes (K)/second

16 disk_rd       60.00      2804        46.73333         239274.67
Sequential Disk Reads (K)/second

17 disk_wrt      60.07      608         10.12152         51822.21
Sequential Disk Writes (K)/second

18 disk_cp       60.02      487         8.11396          41543.49 
Disk Copies (K)/second

19 sync_disk_rw  60.69      1           0.01648          42.18
Sync Random Disk Writes (K)/second

20 sync_disk_wrt 76.78      2           0.02605          66.68
Sync Sequential Disk Writes (K)/second

21 sync_disk_cp  76.91      2           0.02600          66.57 
Sync Disk Copies (K)/second

22 disk_src      60.01      10383       173.02116        12976.59
Directory Searches/second

23 div_double    60.00      1322        22.03333         66100.00 
Thousand Double Precision Divides/second

24 div_float     60.01      1322        22.02966         66088.99 
Thousand Single Precision Divides/second

25 div_long      60.03      1592        26.52007         23868.07 
Thousand Long Integer Divides/second

26 div_int       60.03      1592        26.52007         23868.07 
Thousand Integer Divides/second

27 div_short     60.03      1592        26.52007         23868.07
Thousand Short Integer Divides/second

28 fun_cal       60.00      4362        72.70000         37222400.00
Function Calls (no arguments)/second

29 fun_cal1      60.00      10194       169.90000        86988800.00
Function Calls (1 argument)/second

30 fun_cal2      60.00      7970        132.83333        68010666.67
Function Calls (2 arguments)/second

31 fun_cal15     60.02      2454        40.88637         20933822.06
Function Calls (15 arguments)/second

32 sieve         60.44      41          0.67836          3.39 Integer
Sieves/second

33 mul_double    60.07      837         13.93374         167204.93 
Thousand Double Precision Multiplies/second

34 mul_float     60.06      834         13.88611         166633.37 
Thousand Single Precision Multiplies/second

35 mul_long      60.00      75830       1263.83333       303320.00 
Thousand Long Integer Multiplies/second

36 mul_int       60.00      76005       1266.75000       304020.00 
Thousand Integer Multiplies/second

37 mul_short     60.00      60556       1009.26667       302780.00 
Thousand Short Integer Multiplies/second

38 num_rtns_1    60.00      32589       543.15000        54315.00
Numeric Functions/second

39 new_raph      60.00      79901       1331.68333       266336.67 
Zeros Found/second

40 trig_rtns     60.02      2157        35.93802         359380.21
Trigonometric Functions/second

41 matrix_rtns    60.00     349452      5824.20000       582420.00 
Point Transformations/second

42 array_rtns     60.05     961         16.00333         320.07
Linear Systems Solved/second

43 string_rtns    60.02     851         14.17861         1417.86 
String Manipulations/second

44 mem_rtns_1     60.02     1902         31.68944        950683.11 
Dynamic Memory Operations/second

45 mem_rtns_2     60.00     129917       2165.28333      216528.33 
Block Memory Operations/second

46 sort_rtns_1    60.01     2426         40.42660        404.27 
Sort Operations/second

47 misc_rtns_1    60.00     31111        518.51667       5185.17 
Auxiliary Loops/second

48 dir_rtns_1     60.01     13069        217.78037       2177803.70
Directory Operations/second

49 shell_rtns_1   60.02     2513         41.86938        41.87 
Shell Scripts/second

50 shell_rtns_2   60.01     2514         41.89302        41.89
Shell Scripts/second

51 shell_rtns_3   60.00     2513         41.88333        41.88
Shell Scripts/second

52 series_1       60.00     1464309      24405.15000     2440515.00
Series Evaluations/second

53 shared_memory  60.00     163747       2729.11667      272911.67
Shared Memory Operations/second

54 tcp_test       60.00     15713        261.88333       23569.50 
TCP/IP Messages/second

55 udp_test       60.00     47522        792.03333       79203.33
UDP/IP DataGrams/second

56 fifo_test      60.00     86218        1436.96667      143696.67 
FIFO Messages/second

57 stream_pipe    60.00     76486        1274.76667      127476.67 
Stream Pipe Messages/second

58 dgram_pipe     60.00     73844        1230.73333      123073.33
DataGram Pipe Messages/second

59 pipe_cpy       60.00     250909       4181.81667      418181.67
Pipe Messages/second

60 ram_copy        60.00    1496165      24936.08333     623900805.00 
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
sowmya.adiga@wipro.com

