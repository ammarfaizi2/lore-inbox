Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262806AbSLZJDr>; Thu, 26 Dec 2002 04:03:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262808AbSLZJDr>; Thu, 26 Dec 2002 04:03:47 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:23482 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S262806AbSLZJDg>; Thu, 26 Dec 2002 04:03:36 -0500
From: "Sowmya Adiga" <sowmya.adiga@wipro.com>
To: <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] AIM benchmark result for kernel 2.5.53
Date: Thu, 26 Dec 2002 10:46:01 +0530
Organization: Wipro Technologies
Message-ID: <001c01c2ac9d$e19ef850$6009720a@wipro.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
X-OriginalArrivalTime: 26 Dec 2002 05:16:01.0504 (UTC) FILETIME=[E1A0A600:01C2AC9D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

      Here are the AIM benchmark result for kernel 2.5.53. Kernel 2.5.53
when compared with kernel 2.5.52 showed difference of performance in
following tests:-
========================================================================

 Test Test     Elapsed     Iteration    Iteration        Operation
NumberName     Time (sec)    Count      Rate (loops/sec) Rate (ops/sec)
------------------------------------------------------------------------
System Memory Allocations/second
1 brk_test[2.5.53]  60.01      3331      55.50742        943626.06
  brk_test[2.5.52]  60.00      3365      56.08333        953416.67
 
Signal Traps/second
2signal_test[2.5.53]60.01      9277      154.59090       154590.90
 signal_test[2.5.52]60.01      9734      162.20630       162206.30

Task Creations/second
3fork_test[2.5.53]  60.02      1148      19.12696        1912.70
 fork_test[2.5.52]  60.03      1035      17.24138        1724.14

Disk Copies (K)/second
4disk_cp[2.5.53]    60.09      499       8.30421         42517.56
 disk_cp [2.5.52]   60.09      517       8.60376         44051.26 

Dynamic Memory Operations/second
5mem_rtns_1[2.5.53] 60.00      1643      27.38333        821500.00
 mem_rtns_1[2.5.52] 60.01      1617      26.94551        808365.27

FIFO Messages/second
6fifo_test[2.5.53]  60.00      92619     1543.65000      154365.00
 fifo_test[2.5.52]  60.00      92619     1543.65000      154365.00

========================================================================

*There is no much significant difference in other test result.

------------------------------------------------------------------------
--
                            Kernel 2.5.53
------------------------------------------------------------------------
----
Machine's name                                    : access1
Machine's configuration                           : PIII/868MHZ/128MB
Number of seconds to run each test [2 to 1000]    : 60
Path to disk files                                : /tmp

------------------------------------------------------------------------
 TestTest      Elapsed     Iteration    Iteration         Operation
NumberName     Time (sec)   Count       Rate (loops/sec)  Rate (ops/sec)
------------------------------------------------------------------------
1 add_double    60.02       716          11.92936         214728.42 
Thousand Double Precision Additions/second

2 add_float     60.05       1075         17.90175         214820.98 
Thousand Single Precision Additions/second

3 add_long      60.01       1768         29.46176         1767705.38 
Thousand Long Integer Additions/second

4 add_int       60.01       1768         29.46176         1767705.38
Thousand Integer Additions/second

5 add_short     60.00       4419         73.65000         1767600.00
Thousand Short Integer Additions/second

6 creat-clo     60.03       2125         35.39897         35398.97 
File Creations and Closes/second

7 page_test     60.00       8830         147.16667        250183.33
System Allocations & Pages/second

8 brk_test      60.01       3331         55.50742         943626.06
System Memory Allocations/second

9 jmp_test      60.00       318020       5300.33333       5300333.33
Non-local gotos/second

10 signal_test  60.01       9277         154.59090        154590.90
Signal Traps/second

11 exec_test    60.01       2045         34.07765         170.39 
Program Loads/second

12 fork_test    60.02       1148         19.12696         1912.70
Task Creations/second

13 link_test    60.01       9469         157.79037        9940.79 
Link/Unlink Pairs/second

14 disk_rr      60.03       489          8.14593          41707.15 
Random Disk Reads (K)/second

15 disk_rw      60.14       385          6.40173          32776.85
Random Disk Writes (K)/second

16 disk_rd      60.02       2833         47.20093         241668.78
Sequential Disk Reads (K)/second

17 disk_wrt     60.03       640          10.66134         54586.04 
Sequential Disk Writes (K)/second

18 disk_cp      60.09       499          8.30421          42517.56
Disk Copies (K)/second

19 sync_disk_rw 61.54       1            0.01625          41.60 
Sync Random Disk Writes (K)/second

20sync_disk_wrt 77.00       2            0.02597          66.49
Sync Sequential Disk Writes (K)/second

21 sync_disk_cp 76.97       2            0.02598          66.52
Sync Disk Copies (K)/second

22 disk_src     60.00       10781        179.68333        13476.25 
Directory Searches/second

23 div_double   60.01       1322         22.02966         66088.99 
Thousand Double Precision Divides/second

24 div_float    60.00       1322         22.03333         66100.00
Thousand Single Precision Divides/second

25 div_long     60.03       1592         26.52007         23868.07
Thousand Long Integer Divides/second

26 div_int      60.03       1592         26.52007         23868.07
Thousand Integer Divides/second

27 div_short    60.03       1592         26.52007         23868.07
Thousand Short Integer Divides/second

28 fun_cal       60.01      4361         72.67122         37207665.39
Function Calls (no arguments)/second

29 fun_cal1      60.00      10230        170.50000        87296000.00
Function Calls (1 argument)/second

30 fun_cal2      60.00      7971         132.85000        68019200.00
Function Calls (2 arguments)/second

31 fun_cal15     60.02      2455         40.90303         20942352.55
Function Calls (15 arguments)/second

32 sieve         60.44      41           0.67836          3.39 
Integer Sieves/second

33 mul_double    60.05      837          13.93838         167260.62
Thousand Double Precision Multiplies/second

34 mul_float     60.00      836          13.93333         167200.00
Thousand Single Precision Multiplies/second

35 mul_long      60.00      75686        1261.43333       302744.00
Thousand Long Integer Multiplies/second

36 mul_int       60.00      76002        1266.70000       304008.00
Thousand Integer Multiplies/second

37 mul_short     60.00      60553        1009.21667       302765.00
Thousand Short Integer Multiplies/second

38 num_rtns_1    60.00      32593        543.21667        54321.67
Numeric Functions/second

39 new_raph      60.00      79897        1331.61667       266323.33
Zeros Found/second

40 trig_rtns     60.02      2172         36.18794         361879.37
Trigonometric Functions/second

41 matrix_rtns   60.00      349540       5825.66667       582566.67
Point Transformations/second

42 array_rtns    60.02      935          15.57814         311.56
Linear Systems Solved/second

43 string_rtns   60.04      851          14.17388         1417.39
String Manipulations/second

44 mem_rtns_1    60.00      1643         27.38333         821500.00
Dynamic Memory Operations/second

45 mem_rtns_2    60.00      131019       2183.65000       218365.00
Block Memory Operations/second

46 sort_rtns_1   60.02      2425         40.40320         404.03
Sort Operations/second

47 misc_rtns_1   60.00      32061        534.35000        5343.50
Auxiliary Loops/second

48 dir_rtns_1    60.00      13140        219.00000        2190000.00
Directory Operations/second

49 shell_rtns_1  60.02      2394         39.88670         39.89
Shell Scripts/second

50 shell_rtns_2  60.01      2404         40.05999         40.06
Shell Scripts/second

51 shell_rtns_3  60.01      2404         40.05999         40.06
Shell Scripts/second

52 series_1      60.00      1464171      24402.85000      2440285.00
Series Evaluations/second

53shared_memory  60.00      165465       2757.75000       275775.00
Shared Memory Operations/second

54 tcp_test      60.00      11133        185.55000        16699.50
TCP/IP Messages/second

55 udp_test      60.00      47549        792.48333        79248.33
UDP/IP DataGrams/second

56 fifo_test     60.00      92619        1543.65000       154365.00
FIFO Messages/second

57 stream_pipe   60.00      70821        1180.35000       118035.00
Stream Pipe Messages/second

58 dgram_pipe    60.00      68575        1142.91667       114291.67
DataGram Pipe Messages/second

59 pipe_cpy      60.00      248600       4143.33333       414333.33
Pipe Messages/second

60 ram_copy      60.00      1495883      24931.38333      623783211.00
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
 
 

