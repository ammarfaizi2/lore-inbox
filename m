Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265097AbTABJe1>; Thu, 2 Jan 2003 04:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265197AbTABJe1>; Thu, 2 Jan 2003 04:34:27 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:28829 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S265097AbTABJeX>; Thu, 2 Jan 2003 04:34:23 -0500
From: "Sowmya Adiga" <sowmya.adiga@wipro.com>
To: <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] AIM benchmark result for kernel 2.5.54.
Date: Thu, 2 Jan 2003 15:12:38 +0530
Message-ID: <001701c2b243$4988cbd0$6009720a@wipro.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
X-OriginalArrivalTime: 02 Jan 2003 09:42:38.0588 (UTC) FILETIME=[498633C0:01C2B243]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

   Here are the AIM benchmark result for kernel 2.5.54.Kernel 2.5.54
when compared with kernel 2.5.53 showed difference of performance in
following tests:-
========================================================================
==
  Test      Elapsed      Iteration    Iteration        Operation
  Name      Time (sec)   Count        Rate(loops/sec)  Rate (ops/sec)
------------------------------------------------------------------------
1 System Memory Allocations/second
brk_test
[2.5.54]     60.01        3500         58.32361        991501.42 
[2.5.53]     60.01        3331         55.50742        943626.06 

2 Dynamic Memory Operations/second
mem_rtns_1
[2.5.54]     60.04       1441          24.00067        720019.99
[2.5.53]     60.00       1643          27.38333        821500.00

3 TCP/IP Messages/second
tcp_test
[2.5.54]     60.00       16212         270.20000       24318.00 
[2.5.53]     60.00       11133         185.55000       16699.50 

4 UDP/IP DataGrams/second
udp_test
[2.5.54]     60.00       49179         819.65000       81965.00 
[2.5.53]     60.00       47549         792.48333       79248.33

========================================================================
*There is no much significant difference in other test result.
------------------------------------------------------------------------
----
					kernel 2.5.54
------------------------------------------------------------------------
----
Machine's name                                    : access1
Machine's configuration                           : PIII/868MHZ/128MB
Number of seconds to run each test [2 to 1000]    : 60
Path to disk files                                : /tmp 
------------------------------------------------------------------------
----
 TestTest     Elapsed      Iteration    Iteration        Operation
NumberName    Time (sec)   Count        Rate(loops/sec)  Rate (ops/sec)
------------------------------------------------------------------------
----
1 add_double    60.02       716          11.92936        214728.42 
Thousand Double Precision Additions/second

2 add_float     60.05       1075         17.90175        214820.98 
Thousand Single Precision Additions/second

3 add_long      60.01       1768         29.46176        1767705.38 
Thousand Long Integer Additions/second

4 add_int       60.01       1768         29.46176        1767705.38
Thousand Integer Additions/second

5 add_short     60.00       4419         73.65000        1767600.00 
Thousand Short Integer Additions/second

6 creat-clo     60.03       2140         35.64884        35648.84 
File Creations and Closes/second

7 page_test     60.00       8849         147.48333       250721.67 
System Allocations & Pages/second

8 brk_test      60.01       3500         58.32361        991501.42 
System Memory Allocations/second

9 jmp_test      60.00       318200       5303.33333      5303333.33
Non-local gotos/second

10 signal_test  60.00       9282         154.70000       154700.00 
Signal Traps/second

11 exec_test    60.02       2086         34.75508        173.78
Program Loads/second

12 fork_test    60.03       1219         20.30651        2030.65 
Task Creations/second

13 link_test    60.00       9983         166.38333       10482.15
Link/Unlink Pairs/second

14 disk_rr      60.05       500          8.32639         42631.14 
Random Disk Reads (K)/second

15 disk_rw      60.14       388          6.45161         33032.26 
Random Disk Writes (K)/second

16 disk_rd      60.01       2842         47.35877        242476.92
Sequential Disk Reads (K)/second

17 disk_wrt     60.04       645          10.74284        55003.33 
Sequential Disk Writes (K)/second

18 disk_cp      60.02       500          8.33056         42652.45
Disk Copies (K)/second

19sync_disk_rw  61.44       1            0.01628         41.67 
Sync Random Disk Writes (K)/second

20sync_disk_wrt 77.21       2            0.02590         66.31 
Sync Sequential Disk Writes (K)/second

21sync_disk_cp  76.89       2            0.02601         66.59 
Sync Disk Copies (K)/second

22 disk_src     60.01       10619        176.95384       13271.54 
Directory Searches/second

23 div_double   60.00       1322         22.03333        66100.00
Thousand Double Precision Divides/second

24 div_float    60.01       1322         22.02966        66088.99
Thousand Single Precision Divides/second

25 div_long     60.03       1592         26.52007        23868.07 
Thousand Long Integer Divides/second

26 div_int      60.03       1592         26.52007        23868.07 
Thousand Integer Divides/second

27 div_short    60.03       1592         26.52007        23868.07
Thousand Short Integer Divides/second

28 fun_cal      60.00       4362         72.70000        37222400.00
Function Calls (no arguments)/second

29 fun_cal1     60.00       10231        170.51667       87304533.33
Function Calls (1 argument)/second

30 fun_cal2     60.00       7968         132.80000       67993600.00
Function Calls (2 arguments)/second

31 fun_cal15    60.02       2454         40.88637        20933822.06
Function Calls (15 arguments)/second

32 sieve        60.56       41           0.67701         3.39 
Integer Sieves/second

33 mul_double   60.07       837          13.93374        167204.93
Thousand Double Precision Multiplies/second

34 mul_float    60.05       834          13.88843        166661.12 
Thousand Single Precision Multiplies/second

35 mul_long     60.00       75694        1261.56667      302776.00 
Thousand Long Integer Multiplies/second

36 mul_int      60.00       76014        1266.90000      304056.00
Thousand Integer Multiplies/second

37 mul_short    60.00       60568        1009.46667      302840.00
Thousand Short Integer Multiplies/second

38 num_rtns_1   60.00       32605        543.41667       54341.67 
Numeric Functions/second

39 new_raph     60.00       79912        1331.86667      266373.33 
Zeros Found/second

40 trig_rtns    60.00       2152         35.86667        358666.67
Trigonometric Functions/second

41 matrix_rtns  60.00       349604       5826.73333      582673.33 
Point Transformations/second

42 array_rtns   60.03       913          15.20906        304.18 
Linear Systems Solved/second

43 string_rtns  60.01       851          14.18097        1418.10 
String Manipulations/second

44 mem_rtns_1   60.04       1441         24.00067        720019.99
Dynamic Memory Operations/second

45 mem_rtns_2   60.00       131051       2184.18333      218418.33 
Block Memory Operations/second

46 sort_rtns_1  60.03       2426         40.41313        404.13
Sort Operations/second

47 misc_rtns_1  60.00       31913        531.88333       5318.83 
Auxiliary Loops/second

48 dir_rtns_1   60.00       13084        218.06667       2180666.67
Directory Operations/second

49 shell_rtns_1 60.01       2417         40.27662        40.28 
Shell Scripts/second

50 shell_rtns_2 60.00       2417         40.28333        40.28 
Shell Scripts/second

51 shell_rtns_3 60.01       2420         40.32661        40.33 
Shell Scripts/second

52 series_1     60.00       1464383      24406.38333     2440638.33 
Series Evaluations/second

53shared_memory 60.00       164206       2736.76667      273676.67
Shared Memory Operations/second

54 tcp_test     60.00       16212        270.20000       24318.00 
TCP/IP Messages/second

55 udp_test     60.00       49179        819.65000       81965.00 
UDP/IP DataGrams/second

56 fifo_test    60.00       88088        1468.13333      146813.33 
FIFO Messages/second

57 stream_pipe  60.00       74887        1248.11667      124811.67 
Stream Pipe Messages/second

58 dgram_pipe   60.00       72964        1216.06667      121606.67
DataGram Pipe Messages/second

59 pipe_cpy     60.00       248590       4143.16667      414316.67 
Pipe Messages/second

60 ram_copy     60.00       1495682      24928.03333     623699394.00
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

