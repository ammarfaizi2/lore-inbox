Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261346AbTCTJiV>; Thu, 20 Mar 2003 04:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261349AbTCTJiV>; Thu, 20 Mar 2003 04:38:21 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:1231 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S261346AbTCTJiR>; Thu, 20 Mar 2003 04:38:17 -0500
From: "Sowmya Adiga" <sowmya.adiga@wipro.com>
To: <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK]AIM9 benchmark result for kernel 2.5.65
Date: Thu, 20 Mar 2003 15:15:16 +0530
Message-ID: <01cc01c2eec5$693ba600$6009720a@wipro.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Importance: Normal
X-OriginalArrivalTime: 20 Mar 2003 09:45:15.0802 (UTC) FILETIME=[6909E7A0:01C2EEC5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 Here is the AIM9 benchmark result for kernel 2.5.65.when compared with
kernel 2.5.64 showed following differences. 
========================================================================
 Test         Elapsed      Iteration    Iteration        Operation
 Name         Time(sec)   Count        Rate(loops/sec)  Rate (ops/sec)
------------------------------------------------------------------------
System Memory Allocations/second
brk_test      
[Linux-2.5.65]  65.56       2881        43.94448         747056.13 
[Linux-2.5.64]  65.56       2804        42.76998         727089.69

Directory Operations/second
dir_rtns_1   
[Linux-2.5.65]  65.54       12897       196.78059        1967805.92 
[Linux-2.5.64]  65.53       12968       197.89409        1978940.94

Pipe Messages/second
pipe_cpy     
[Linux-2.5.65]  65.54       206815      3155.55386       315555.39
[Linux-2.5.64]  65.54       196357      2995.98718       299598.72
========================================================================
*There is no much significant difference in other test result.

------------------------------------------------------------------------
-- 			     kernel-2.5.65
------------------------------------------------------------------------
--
Machine's name                                    : access1
Machine's configuration                           : PIII/868MHZ/128MB
Number of seconds to run each test [2 to 1000]    : 60
Path to disk files                                : /home


------------------------------------------------------------------------
--
TestTest      Elapsed    Iteration    Iteration         Operation
NumberName    Time(sec)  Count        Rate(loops/sec)   Rate(ops/sec)
------------------------------------------------------------------------
--
1 add_double    67.12       800   	   11.91895         214541.12 
Thousand Double Precision Additions/second

2 add_float     65.49       1171        17.88059         214567.11
Thousand Single Precision Additions/second

3 add_long      65.53       1929        29.43690         1766213.95 
Thousand Long Integer Additions/second

4 add_int       65.54       1929        29.43241         1765944.46 
Thousand Integer Additions/second

5 add_short     65.51       4820        73.57655         1765837.28 
Thousand Short Integer Additions/second

6 creat-clo     65.54       6483        98.91669         98916.69
File Creations and Closes/second

7 page_test     65.53       7468        113.96307        193737.22
System Allocations & Pages/second

8 brk_test      65.56       2881        43.94448         747056.13 
System Memory Allocations/second

9 jmp_test      65.51       351591      5366.98214       5366982.14 
Non-local gotos/second

10signal_test   65.54       12406       189.28898        189288.98
Signal Traps/second

11 exec_test    65.55       2988        45.58352         227.92 
Program Loads/second

12 fork_test    65.53       1609        24.55364         2455.36 
Task Creations/second

13 link_test    65.53       30056       458.66016        28895.59
Link/Unlink Pairs/second

14 disk_rr      65.57       486         7.41193          37949.06 
Random Disk Reads (K)/second

15 disk_rw      65.53       395         6.02777          30862.20
Random Disk Writes (K)/second

16 disk_rd      65.51       2812        42.92474         219774.69
Sequential Disk Reads (K)/second

17 disk_wrt     65.59       629         9.58988          49100.17 
Sequential Disk Writes (K)/second

18 disk_cp      65.58       495         7.54803          38645.93
Disk Copies (K)/second

19sync_disk_rw  79.13       5           0.06319          161.76 
Sync Random Disk Writes (K)/second

20sync_disk_wrt 69.34       2           0.02884          73.84 
Sync Sequential Disk Writes (K)/second

21 sync_disk_cp 69.28       2           0.02887          73.90 
Sync Disk Copies (K)/second

22 disk_src     60.66       19061       314.22684        23567.01
Directory Searches/second

23 div_double   65.56       1443        22.01037         66031.12 
Thousand Double Precision Divides/second

24 div_float    65.51       1442        22.01191         66035.72 
Thousand Single Precision Divides/second

25 div_long     65.56       1737        26.49481         23845.33 
Thousand Long Integer Divides/second

26 div_int      65.52       1736        26.49573         23846.15 
Thousand Integer Divides/second

27 div_short    65.53       1736        26.49168         23842.51 
Thousand Short Integer Divides/second

28 fun_cal      65.54       5147        78.53219         40208483.37
Function Calls (no arguments)/second

29 fun_cal1     65.53       11284       172.19594        88164321.68
Function Calls (1 argument)/second

30 fun_cal2     65.53       8182        124.85884        63927727.76
Function Calls (2 arguments)/second

31 fun_cal15    65.56       2678        40.84808         20914215.99
Function Calls (15 arguments)/second

32 sieve        66.57       45          0.67598          3.38 
Integer Sieves/second

33 mul_double   64.55       898         13.91170         166940.36
Thousand Double Precision Multiplies/second

34 mul_float    65.49       911         13.91052         166926.25 
Thousand Single Precision Multiplies/second

35 mul_long     65.51       82857       1264.79927       303551.82 
Thousand Long Integer Multiplies/second

36 mul_int      65.54       82857       1264.22032       303412.88 
Thousand Integer Multiplies/second

37 mul_short    65.53       66188       1010.04120       303012.36 
Thousand Short Integer Multiplies/second

38 num_rtns_1   65.54       40090       611.68752        61168.75 
Numeric Functions/second

39 new_raph     65.54       90488       1380.65304       276130.61 
Zeros Found/second

40 trig_rtns    65.54       2414        36.83247         368324.69
Trigonometric Functions/second

41 matrix_rtns  65.53       400229      6107.56905       610756.91
Point Transformations/second

42 array_rtns   65.59       1052        16.03903         320.78
Linear Systems Solved/second

43 string_rtns  65.58       581         8.85941          885.94 
String Manipulations/second

44 mem_rtns_1   65.44       2525        38.58496         1157548.90 
Dynamic Memory Operations/second

45 mem_rtns_2   65.53       143159      2184.63299       218463.30 
Block Memory Operations/second

46 sort_rtns_1  65.54       2734        41.71498         417.15 
Sort Operations/second

47 misc_rtns_1  65.53       56285       858.91958        8589.20 
Auxiliary Loops/second

48 dir_rtns_1   65.54       12897       196.78059        1967805.92
Directory Operations/second

49shell_rtns_1  65.55       3548        54.12662         54.13 
Shell Scripts/second

50shell_rtns_2  65.53       3575        54.55517         54.56 
Shell Scripts/second

51shell_rtns_3  65.54       3561        54.33323         54.33 
Shell Scripts/second

52 series_1     65.52       1605658     24506.37973      2450637.97 
Series Evaluations/second

53shared_memory 65.54       169032      2579.06622       257906.62 
Shared Memory Operations/second

54 tcp_test     65.54       33216       506.80500        45612.45
TCP/IP Messages/second

55 udp_test     65.53       70791       1080.28384       108028.38 
UDP/IP DataGrams/second

56 fifo_test    65.54       99432       1517.11932       151711.93 
FIFO Messages/second

57 stream_pipe  65.53       156612      2389.92828       238992.83 
Stream Pipe Messages/second

58 dgram_pipe   65.54       153640      2344.21727       234421.73 
DataGram Pipe Messages/second

59 pipe_cpy     65.54       206815      3155.55386       315555.39
Pipe Messages/second

60 ram_copy     65.53       1696481     25888.61590      647733169.85
Memory to Memory Copy/second
------------------------------------------------------------------------
--
Regards
 
Sowmya Adiga
Project Engineer
Wipro Technologies
53/1,Hosur Road,Madivala
Bangalore-560 068,INDIA
Tel: +91-80-5502001 Extn.5086

