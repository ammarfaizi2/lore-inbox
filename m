Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265190AbTACELb>; Thu, 2 Jan 2003 23:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266686AbTACELa>; Thu, 2 Jan 2003 23:11:30 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:56568 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S265190AbTACEL1>; Thu, 2 Jan 2003 23:11:27 -0500
From: "Sowmya Adiga" <sowmya.adiga@wipro.com>
To: <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK]AIM benchmark result for kernel 2.5.54mm1
Date: Fri, 3 Jan 2003 09:49:44 +0530
Message-ID: <002901c2b2df$57f26630$6009720a@wipro.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Importance: Normal
X-OriginalArrivalTime: 03 Jan 2003 04:19:44.0346 (UTC) FILETIME=[57FD3BA0:01C2B2DF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

   Here are the AIM benchmark result for kernel 2.5.54mm1.Kernel
2.5.54mm1 when compared with kernel 2.5.54 showed difference of
performance in following tests:-
========================================================================

Test        Elapsed      Iteration    Iteration        Operation
Name        Time (sec)   Count        Rate(loops/sec)  Rate (ops/sec)
------------------------------------------------------------------------
1 System Memory Allocations/second
  brk_test        
[2.5.54mm1]  60.01        3381         56.34061          957790.37 
[2.5.54]     60.01        3500         58.32361          991501.42

2 Sequential Disk Writes (K)/second
  disk_wrt        
[2.5.54mm1]  60.04        617          10.27648          52615.59 
[2.5.54]     60.04        645          10.74284          55003.33

3 Dynamic Memory Operations/second
  mem_rtns_1     
[2.5.54mm1]  60.02        1828         30.45651          913695.43
[2.5.54]     60.04        1441         24.00067          720019.99

========================================================================
*There is no much significant difference in other test result.
------------------------------------------------------------------------
----
					kernel 2.5.54mm1
------------------------------------------------------------------------
----
Machine's name                                    : access1
Machine's configuration                           : PIII/868MHZ/128MB
Number of seconds to run each test [2 to 1000]    : 60
Path to disk files                                : /tmp


------------------------------------------------------------------------
----
Test Test       Elapsed     Iteration    Iteration        Operation
Number Name      Time (sec)   Count      Rate(loops/sec)  Rate (ops/sec)
------------------------------------------------------------------------
----
1 add_double      60.02       716        11.92936          214728.42
Thousand Double Precision Additions/second

2 add_float       60.05       1075       17.90175          214820.98
Thousand Single Precision Additions/second

3 add_long        60.01       1768       29.46176          1767705.38
Thousand Long Integer Additions/second

4 add_int         60.03       1768       29.45194          1767116.44
Thousand Integer Additions/second

5 add_short       60.01       4419       73.63773          1767305.45
Thousand Short Integer Additions/second

6 creat-clo       60.00       2135       35.58333          35583.33 
File Creations and Closes/second

7 page_test       60.01       7975       132.89452         225920.68 
System Allocations & Pages/second

8 brk_test        60.01       3381       56.34061          957790.37 
System Memory Allocations/second

9 jmp_test        60.00       318143     5302.38333        5302383.33
Non-local gotos/second

10 signal_test    60.00       10054      167.56667         167566.67 
Signal Traps/second

11 exec_test      60.02       2114       35.22159          176.11 
Program Loads/second

12 fork_test      60.04       1242       20.68621          2068.62 
Task Creations/second

13 link_test      60.00       9889       164.81667         10383.45
Link/Unlink Pairs/second

14 disk_rr        60.01       487        8.11531           41550.41 
Random Disk Reads (K)/second

15 disk_rw        60.03       378        6.29685           32239.88 
Random Disk Writes (K)/second

16 disk_rd        60.00       2834       47.23333          241834.67
Sequential Disk Reads (K)/second

17 disk_wrt       60.04       617        10.27648          52615.59
Sequential Disk Writes (K)/second

18 disk_cp        60.10       505        8.40266           43021.63 
Disk Copies (K)/second

19 sync_disk_rw   60.71       1          0.01647           42.17
Sync Random Disk Writes (K)/second

20 sync_disk_wrt  77.04       2          0.02596           66.46 
Sync Sequential Disk Writes (K)/second

21 sync_disk_cp   76.68       2          0.02608           66.77 
Sync Disk Copies (K)/second

22 disk_src       60.00       10324      172.06667         12905.00
Directory Searches/second

23 div_double     60.01       1322       22.02966          66088.99
Thousand Double Precision Divides/second

24 div_float      60.02       1322       22.02599          66077.97 
Thousand Single Precision Divides/second

25 div_long       60.03       1592       26.52007          23868.07
Thousand Long Integer Divides/second

26 div_int        60.03       1592       26.52007          23868.07 
Thousand Integer Divides/second

27 div_short      60.03       1592       26.52007          23868.07 
Thousand Short Integer Divides/second

28 fun_cal        60.00       4362       72.70000          37222400.00
Function Calls (no arguments)/second

29 fun_cal1       60.00       10192      169.86667         86971733.33
Function Calls (1 argument)/second

30 fun_cal2        60.01      7971       132.82786         68007865.36
Function Calls (2 arguments)/second

31 fun_cal15       60.02      2455       40.90303          42352.55 
Function Calls (15 arguments)/second

32 sieve           60.43      41         0.67847           3.39 
Integer Sieves/second

33 mul_double      60.07      837        13.93374         167204.93 
Thousand Double Precision Multiplies/second

34 mul_float       60.01      833        13.88102         166572.24 
Thousand Single Precision Multiplies/second

35 mul_long        60.00      75681      1261.35000       302724.00
Thousand Long Integer Multiplies/second

36 mul_int         60.00      76001      1266.68333       304004.00 
Thousand Integer Multiplies/second

37 mul_short       60.00      60547      1009.11667       302735.00
Thousand Short Integer Multiplies/second

38 num_rtns_1      60.00      32590      543.16667        54316.67
Numeric Functions/second

39 new_raph        60.00      79893      1331.55000       266310.00
Zeros Found/second

40 trig_rtns       60.01      2163       36.04399         360439.93
Trigonometric Functions/second

41 matrix_rtns     60.00      349514     5825.23333       582523.33 
Point Transformations/second

42 array_rtns      60.05      961        16.00333         320.07 
Linear Systems Solved/second

43 string_rtns     60.01      851        14.18097         1418.10 
String Manipulations/second

44 mem_rtns_1      60.02      1828       30.45651         913695.43
Dynamic Memory Operations/second

45 mem_rtns_2      60.00      129871     2164.51667       216451.67 
Block Memory Operations/second

46 sort_rtns_1     60.01      2426       40.42660         404.27 
Sort Operations/second

47 misc_rtns_1     60.00      31522      525.36667        5253.67
Auxiliary Loops/second

48 dir_rtns_1      60.00      13081      218.01667        2180166.67
Directory Operations/second

49 shell_rtns_1    60.02      2493       41.53615         41.54 
Shell Scripts/second

50 shell_rtns_2    60.01      2492       41.52641         41.53
Shell Scripts/second

51 shell_rtns_3    60.03      2494       41.54589         41.55
Shell Scripts/second

52 series_1        60.00      1464061    24401.01667      2440101.67 
Series Evaluations/second

53 shared_memory   60.00      162318     2705.30000       270530.00 
Shared Memory Operations/second

54 tcp_test        60.00      15820      263.66667        23730.00 
TCP/IP Messages/second

55 udp_test        60.00      48225      803.75000        80375.00 
UDP/IP DataGrams/second

56 fifo_test       60.00      89879      1497.98333       149798.33 
FIFO Messages/second

57 stream_pipe     60.00      76665      1277.75000       127775.00
Stream Pipe Messages/second

58 dgram_pipe      60.00      75965      1266.08333       126608.33 
DataGram Pipe Messages/second

59 pipe_cpy        60.00      253569     4226.15000       422615.00
Pipe Messages/second

60 ram_copy         60.00     1495797    24929.95000      623747349.00
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
 

