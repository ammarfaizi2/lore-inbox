Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267773AbTCFEGy>; Wed, 5 Mar 2003 23:06:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267775AbTCFEGy>; Wed, 5 Mar 2003 23:06:54 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:10420 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S267773AbTCFEGt>; Wed, 5 Mar 2003 23:06:49 -0500
From: "Sowmya Adiga" <sowmya.adiga@wipro.com>
To: <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK]AIM9 benchmark result for kernel 2.5.64
Date: Thu, 6 Mar 2003 09:47:03 +0530
Message-ID: <005201c2e397$3ddd10e0$6009720a@wipro.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Importance: Normal
X-OriginalArrivalTime: 06 Mar 2003 04:17:03.0687 (UTC) FILETIME=[3DD71D70:01C2E397]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	 Here is the AIM9 benchmark result for kernel 2.5.64.when
compared with kernel 2.5.63 showed following differences.
========================================================================
 Test         Elapsed      Iteration    Iteration        Operation
 Name         Time(sec)   Count        Rate(loops/sec)  Rate (ops/sec)
------------------------------------------------------------------------
1 Dynamic Memory Operations/second
mem_rtns_1       
[Linux-2.5.64]  65.49       3059         46.70942        1401282.64 
[Linux-2.5.63]  60.01       2347         39.11015        1173304.45 

2 Pipe Messages/second
pipe_cpy         
[linux-2.5.64]  65.54       196357       2995.98718      299598.72 
[Linux-2.5.63]  60.00       188382       3139.70000      313970.00 

========================================================================
*There is no much significant difference in other test result.


------------------------------------------------------------------------
---
					kernel-2.5.64
------------------------------------------------------------------------
---
Machine's name                                    : access1
Machine's configuration                           : /PIII/868MHZ/128MB
Number of seconds to run each test [2 to 1000]    : 60
Path to disk files                                : /tmp 

------------------------------------------------------------------------
---
Test   Test       Elapsed     Iteration    Iteration        Operation
Number Name       Time (sec)  Count        Rate(loops/sec)
Rate(ops/sec)
------------------------------------------------------------------------
---
1 add_double        75.26      897         11.91868         214536.27 
Thousand Double Precision Additions/second

2 add_float         65.48      1171        17.88332         214599.88
Thousand Single Precision Additions/second

3 add_long          65.54      1929        29.43241         765944.46
Thousand Long Integer Additions/second

4 add_int           65.54      1929        29.43241         1765944.46
Thousand Integer Additions/second

5 add_short         65.53      4821        73.56936         1765664.58
Thousand Short Integer Additions/second

6 creat-clo         65.53      6333        96.64276         96642.76
File Creations and Closes/second

7 page_test         65.53      7442        113.56631        193062.72
System Allocations & Pages/second

8 brk_test          65.56      2804        42.76998         727089.69
System Memory Allocations/second

9 jmp_test          65.51      351562      5366.53946       5366539.46
Non-local gotos/second

10 signal_test      65.54      11918       181.84315        181843.15
Signal Traps/second

11 exec_test        65.54      2957   	 45.11749         225.59 
Program Loads/second

12 fork_test        65.57      1511        23.04408         2304.41 
Task Creations/second

13 link_test        65.50      30249       461.81679        29094.46
Link/Unlink Pairs/second

14 disk_rr          65.62      470         7.16245          36671.75
Random Disk Reads (K)/second

15 disk_rw          65.50      381         5.81679          29781.98 
Random Disk Writes (K)/second

16 disk_rd          65.50      2778        42.41221         217150.53
Sequential Disk Reads (K)/second

17 disk_wrt         65.58      612         9.33211          47780.42
Sequential Disk Writes (K)/second

18 disk_cp          65.48      483         7.37630          37766.65 
Disk Copies (K)/second

19 sync_disk_rw     78.96      5           0.06332          162.11 
Sync Random Disk Writes (K)/second

20 sync_disk_wrt    69.28      2           0.02887          73.90 
Sync Sequential Disk Writes (K)/second

21 sync_disk_cp     68.61      2           0.02915          74.62 
Sync Disk Copies (K)/second

22 disk_src         61.35      19229       313.43113        23507.33
Directory Searches/second

23 div_double       65.56      1443        22.01037         66031.12
Thousand Double Precision Divides/second

24 div_float        65.51      1442        22.01191         66035.72
Thousand Single Precision Divides/second

25 div_long         65.56      1737        26.49481         23845.33
Thousand Long Integer Divides/second

26 div_int          65.53      1736        26.49168         23842.51
Thousand Integer Divides/second

27 div_short        65.52      1736        26.49573         23846.15
Thousand Short Integer Divides/second

28 fun_cal          65.54      5147        78.53219         40208483.37
Function Calls (no arguments)/second

29 fun_cal1         65.53      11285       172.21120        88172134.90
Function Calls (1 argument)/second

30 fun_cal2         65.54      8183        124.85505        63925785.78
Function Calls (2 arguments)/second

31 fun_cal15        65.55      2678        40.85431         20917406.56
Function Calls (15 arguments)/second

32 sieve            66.52      45          0.67649          3.38 
Integer Sieves/second

33 mul_double       64.53      898         13.91601         166992.10
Thousand Double Precision Multiplies/second

34 mul_float        65.56      912         13.91092         166931.06
Thousand Single Precision Multiplies/second

35 mul_long         65.51      82834       1264.44818       303467.56
Thousand Long Integer Multiplies/second

36 mul_int          65.54      82635       1260.83308       302599.94
Thousand Integer Multiplies/second

37 mul_short        65.54      66119       1008.83430       302650.29
Thousand Short Integer Multiplies/second

38 num_rtns_1       65.53      40054       611.23150        61123.15
Numeric Functions/second

39 new_raph         65.54      90493       1380.72933       276145.87
Zeros Found/second

40 trig_rtns        65.54      2414        36.83247         368324.69
Trigonometric Functions/second

41 matrix_rtns      65.53      400306      6108.74409       610874.41 
Point Transformations/second

42 array_rtns       65.55      1091        16.64378         332.88 
Linear Systems Solved/second

43 string_rtns      65.58      581         8.85941          885.94
String Manipulations/second

44 mem_rtns_1       65.49      3059        46.70942         1401282.64
Dynamic Memory Operations/second

45 mem_rtns_2       65.52      143158      2184.95116       218495.12 
Block Memory Operations/second

46 sort_rtns_1      65.55      2734        41.70862         417.09 
Sort Operations/second

47 misc_rtns_1      65.53      55648       849.19884        8491.99
Auxiliary Loops/second

48 dir_rtns_1       65.53      12968       197.89409        1978940.94
Directory Operations/second

49 shell_rtns_1     65.54      3509        53.53982         53.54 
Shell Scripts/second

50 shell_rtns_2     65.53      3534        53.92950         53.93 
Shell Scripts/second

51 shell_rtns_3     65.55      3539        53.98932         53.99 
Shell Scripts/second

52 series_1         65.52      1605912     24510.25641      2451025.64
Series Evaluations/second

53 shared_memory    65.53      166343      2538.42515       253842.51
Shared Memory Operations/second

54 tcp_test         65.54      31785       484.97101        43647.39 
TCP/IP Messages/second

55 udp_test         65.53      69143       1055.13505       105513.51
UDP/IP DataGrams/second

56 fifo_test        65.54      95241       1453.17363       145317.36
FIFO Messages/second

57 stream_pipe      65.54      146323      2232.57553       223257.55
Stream Pipe Messages/second

58 dgram_pipe       65.53      143068      2183.24432       218324.43
DataGram Pipe Messages/second

59 pipe_cpy         65.54      196357      2995.98718       299598.72 
Pipe Messages/second

60 ram_copy         65.53      1696521     25889.22631      647748442.24
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

