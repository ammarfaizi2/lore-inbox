Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261523AbSLMHa3>; Fri, 13 Dec 2002 02:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261545AbSLMHa3>; Fri, 13 Dec 2002 02:30:29 -0500
Received: from wiprom2mx2.wipro.com ([203.197.164.42]:21669 "EHLO
	wiprom2mx2.wipro.com") by vger.kernel.org with ESMTP
	id <S261523AbSLMHaV>; Fri, 13 Dec 2002 02:30:21 -0500
From: "Sowmya Adiga" <sowmya.adiga@wipro.com>
To: <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] AIM benchmark result for kernel 2.5.51 with mm2 patch .
Date: Fri, 13 Dec 2002 13:07:54 +0530
Organization: Wipro Technologies
Message-ID: <001c01c2a27a$8cac7f20$6009720a@wipro.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
X-OriginalArrivalTime: 13 Dec 2002 07:37:55.0277 (UTC) FILETIME=[8CDC8FD0:01C2A27A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 Here are the AIM benchmark result for kernel 2.5.51 with mm2 patch. 

 kernel 2.5.51 with mm2 patch performed better in following tests,when
compared with kernel 2.5.51mm1 patch:-
 1)File Creations and Closes/second 2) System Memory Allocations/second
3) Task Creations/second 4)  Shared Memory Operations/second
 5)  TCP/IPMessages/second 6) Pipe Messages/second.7)  Program
Loads/second.on the other side kernel 2.5.51mm2 could not do better in
 Dynamic Memory Operations/second  when compared to kernel 2.5.51mm1
patch.

 kernel 2.5.51mm2 patch performed better in following tests,when
compared with kernel 2.5.51 :-
1) Program Loads/second 2)Task Creations/second 3) File Creations and
Closes/second 4)  Pipe Messages/second 
At the same time 2.5.51mm2 patch had a drop in following performance
when compared with kernel 2.5.51:- 
1)  System Memory Allocations/second 2)  Dynamic Memory
Operations/second 3)  UDP/IP DataGrams/second 4)  FIFO Messages/second 

------------------------------------------------------------------------
---------------------------------------------------
AIM Independent Resource Benchmark - Suite IX v1.1, January 22, 1996
Copyright (c) 1996 - 2001 Caldera International, Inc.
All Rights Reserved

Machine's name                                                    :
access1
Machine's configuration
:PIII/868MHZ/128MB
Number of seconds to run each test [2 to 1000]    : 60
Path to disk files                                                   :
/tmp
------------------------------------------------------------------------
------------------------------------
    Test   Test                             Elapsed
Iteration           Iteration                        Operation 
 Number Name                        Time (sec)          Count
Rate (loops/sec)           Rate (ops/sec)
------------------------------------------------------------------------
------------------------------------
     1 add_double                           Thousand Double Precision
Additions/second
         linux-2.5.51                        60.02                 716
11.92936                     214728.42
         linux-2.5.51[mm1]              60.02                 716
11.92936                     214728.42
         linux-2.5.51[mm2]              60.01                 716
11.93134                     214764.21


      2 add_float                               Thousand Single
Precision Additions/second
        linux-2.5.51                         60.05                 1075
17.90175                     214820.98 
        linux-2.5.51[mm1]               60.00                 1074
17.90000                     214800.00
        linux-2.5.51[mm2]               60.05                 1075
17.90175                     214820.98 

     3 add_long                               Thousand Long Integer
Additions/second
        linux-2.5.51                         60.01                 1768
29.46176                     1767705.38
        linux-2.5.51[mm1]               60.01                 1768
29.46176                     1767705.38
        linux-2.5.51[mm2]               60.01                 1768
29.46176                     1767705.38

      4 add_int                                Thousand Integer
Additions/second
         linux-2.5.51                         60.02                1768
29.45685                     1767410.86
         linux-2.5.51[mm1]               60.01                1768
29.46176                     1767705.38 
         linux-2.5.51[mm2]               60.01                1768
29.46176                     1767705.38

      5 add_short                             Thousand Short Integer
Additions/second
         linux-2.5.51                         60.00                4419
73.65000                      1767600.00   
         linux-2.5.51[mm1]               60.01                4419
73.63773                      1767305.45
         linux-2.5.51[mm2]               60.00                4419
73.65000                      1767600.00

     6 creat-clo                                File Creations and
Closes/second
         linux-2.5.51                          60.02               2157
35.93802                      35938.02 
         linux-2.5.51[mm1]                60.02               2142
35.68810                      35688.10
         linux-2.5.51[mm2]                60.02               2176
36.25458                      36254.58

     7 page_test                               System Allocations &
Pages/second 
         linux-2.5.51                          60.00              8822
147.03333                    249956.67 
         linux-2.5.51[mm1]                60.01              8546
142.40960                    242096.32
         linux-2.5.51[mm2]                60.00              8606
143.43333                    243836.67

     8 brk_test                                  System Memory
Allocations/second
         linux-2.5.51                           60.01             3404
56.72388                     964305.95 
         linux-2.5.51[mm1]                 60.01             3236
53.92435                     916713.88
         linux-2.5.51[mm2]                 60.01             3327
55.44076                     942492.92

     9 jmp_test                                 Non-local gotos/second
         linux-2.5.51                           60.00            318154
5302.56667                  5302566.67
         linux-2.5.51[mm1]                 60.00            318197
5303.28333                  5303283.33 
         linux-2.5.51[mm2]                 60.00            318115
5301.91667                  5301916.67

    10 signal_test                             Signal Traps/second
         linux-2.5.51                           60.00             9573
159.55000                    159550.00
         linux-2.5.51[mm1]                 60.01             9517
158.59023                    158590.23
         linux-2.5.51[mm2]                 60.00             9529
158.81667                    158816.67 

    11 exec_test                              Program Loads/second
         linux-2.5.51                           60.03              2054
34.21623                      171.08
         linux-2.5.51[mm1]                 60.00              2082
34.70000                      173.50
         linux-2.5.51[mm2]                 60.01              2101
35.01083                      175.05

    12 fork_test                               Task Creations/second
         linux-2.5.51                           60.04               1016
16.92205                      1692.21
         linux-2.5.51[mm1]                 60.03               1022
17.02482                      1702.48 
         linux-2.5.51[mm2]                 60.01               1099
18.31361                      1831.36 

    13 link_test                                Link/Unlink Pairs/second
         linux-2.5.51                           60.01               9963
166.02233                    10459.41 
         linux-2.5.51[mm1]                 60.00               9857
164.28333                    10349.85
         linux-2.5.51[mm2]                 60.00               9929
165.48333                    10425.45 

    14 disk_rr                                 Random Disk Reads
(K)/second
         linux-2.5.51                           60.00               496
8.26667                       42325.33
         linux-2.5.51[mm1]                 60.06               501
8.34166                       42709.29
         linux-2.5.51[mm2]                 60.06               489
8.14186                       41686.31

    15 disk_rw                                Random Disk Writes
(K)/second
         linux-2.5.51                           60.12               394
6.55356                       33554.22
         linux-2.5.51[mm1]                 60.17               387
6.43178                       32930.70
         linux-2.5.51[mm2]                 60.07               387
6.44248                       32985.52 

    16 disk_rd                                Sequential Disk Reads
(K)/second
         linux-2.5.51                           60.02               2813
46.86771                      239962.68 
         linux-2.5.51[mm1]                 60.01               2795
46.57557                      238466.92
         linux-2.5.51[mm2]                 60.01               2822
47.02550                      240770.54

    17 disk_wrt                              Sequential Disk Writes
(K)/second
         linux-2.5.51                           60.07               646
10.75412                      55061.10
         linux-2.5.51[mm1]                 60.07               644
10.72083                      54890.63
         linux-2.5.51[mm2]                 60.06               633
10.53946                      53962.04

    18 disk_cp                              Disk Copies (K)/second
         linux-2.5.51                           60.10               509
8.46922                        43362.40
         linux-2.5.51[mm1]                 60.06               501
8.34166                        42709.29 
         linux-2.5.51[mm2]                 60.00               499
8.31667                        42581.33

    19 sync_disk_rw                     Sync Random Disk Writes
(K)/second
         linux-2.5.51                          60.91                1
0.01642                        42.03
         linux-2.5.51[mm1]                60.11                1
0.01664                        42.59
         linux-2.5.51[mm2]                60.21                1
0.01661                        42.52

    20 sync_disk_wrt                    Sync Sequential Disk Writes
(K)/second
         linux-2.5.51                          76.81                 2
0.02604                        66.66 
         linux-2.5.51[mm1]                76.42                 2
0.02617                        67.00 
         linux-2.5.51[mm2]                76.85                 2
0.02602                        66.62

    21 sync_disk_cp                     Sync Disk Copies (K)/second
         linux-2.5.51                          77.63                 2
0.02576                        65.95
         linux-2.5.51[mm1]                77.86                 2
0.02569                        65.76
         linux-2.5.51[mm2]                77.57                 2
0.02578                        66.00

    22 disk_src                             Directory Searches/second
        linux-2.5.51                          60.00
10811          180.18333                     13513.75
        linux-2.5.51[mm1]                60.01                 10741
178.98684                     13424.01
        linux-2.5.51[mm2]                60.01                 10715
178.55357                     13391.52

    23 div_double                        Thousand Double Precision
Divides/second
        linux-2.5.51                          60.01                 1322
22.02966                      66088.99 
        linux-2.5.51[mm1]                60.01                 1322
22.02966                      66088.99
        linux-2.5.51[mm2]                60.01                 1322
22.02966                      66088.99

    24 div_float                            Thousand Single Precision
Divides/second
        linux-2.5.51                          60.00                 1322
22.03333                     66100.00
        linux-2.5.51[mm1]                60.00                 1322
22.03333                     66100.00
        linux-2.5.51[mm2]                60.00                 1322
22.03333                     66100.00

    25 div_long                            Thousand Long Integer
Divides/second
        linux-2.5.51                          60.03
1592            26.52007                    23868.07
        linux-2.5.51[mm1]                60.03                  1592
26.52007                    23868.07
        linux-2.5.51[mm2]                60.04                  1592
26.51566                    23864.09

    26 div_int                               Thousand Integer
Divides/second
        linux-2.5.51                          60.03
1592            26.52007                   23868.07 
        linux-2.5.51[mm1]                60.03                   1592
26.52007                   23868.07 
        linux-2.5.51[mm2]                60.01                   1591
26.51225                   23861.02

    27 div_short                          Thousand Short Integer
Divides/second
        linux-2.5.51                        60.01
1591             26.51225                  23861.02 
        linux-2.5.51[mm1]              60.03                     1592
26.52007                  23868.07 
        linux-2.5.51[mm2]              60.03                     1592
26.52007                  23868.07 

    28 fun_cal                             Function Calls (no
arguments)/second 
         linux-2.5.51                       60.01
4362            72.68789                  37216197.30
         linux-2.5.51[mm1]             60.01                     4362
72.68789                  37216197.30
         linux-2.5.51[mm2]             60.01                     4362
72.68789                  37216197.30

    29 fun_cal1                           Function Calls (1
argument)/second
         linux-2.5.51                       60.00
10231          170.51667                 87304533.33
         linux-2.5.51[mm1]             60.00                    10230
170.50000                 87296000.00
         linux-2.5.51[mm2]             60.00                    10231
170.51667                 87304533.33

    30 fun_cal2                           Function Calls (2
arguments)/second
         linux-2.5.51                       60.00
7971            132.85000                 68019200.00
         linux-2.5.51[mm1]             60.00                    7968
132.80000                 67993600.00
         linux-2.5.51[mm2]             60.00                    7970
132.83333                 68010666.67

    31 fun_cal15                          Function Calls (15
arguments)/second
         linux-2.5.51                       60.03
2455            40.89622                   20938863.90 
         linux-2.5.51[mm1]             60.03                    2455
40.89622                   20938863.90
         linux-2.5.51[mm2]             60.03                    2455
40.89622                   20938863.90 

    32 sieve                                 Integer Sieves/second
         linux-2.5.51                       60.47                    41
0.67802                    3.39
         linux-2.5.51[mm1]             60.49                    41
0.67780                    3.39
         linux-2.5.51[mm2]             60.46                    41
0.67813                    3.39

    33 mul_double                      Thousand Double Precision
Multiplies/second
         linux-2.5.51                       60.01                    833
13.88102                  166572.24
         linux-2.5.51[mm1]             60.05                    838
13.95504                  167460.45
         linux-2.5.51[mm2]             60.07                    837
13.93374                  167204.93

    34 mul_float                         Thousand Single Precision
Multiplies/second
         linux-2.5.51                       60.03                    836
13.92637                  167116.44
         linux-2.5.51[mm1]             60.02                    835
13.91203                  166944.35
         linux-2.5.51[mm2]             60.05                    837
13.93838                  167260.62

    35 mul_long                         Thousand Long Integer
Multiplies/second
         linux-2.5.51                       60.00
75687          1261.45000             302748.00
         linux-2.5.51[mm1]             60.00                   75693
1261.55000             302772.00 
         linux-2.5.51[mm2]             60.00                   75675
1261.25000             302700.00

    36 mul_int                           Thousand Integer
Multiplies/second
          linux-2.5.51                      60.00
76015           1266.91667            304060.00 
          linux-2.5.51[mm1]            60.00                   76013
1266.88333            304052.00
          linux-2.5.51[mm2]            60.00                   75978
1266.30000            303912.00

    37 mul_short                        Thousand Short Integer
Multiplies/second
          linux-2.5.51                      60.00
60527           1008.78333            302635.00
          linux-2.5.51[mm1]            60.00                   60564
1009.40000            302820.00
          linux-2.5.51[mm2]            60.00                   60624
1010.40000            303120.00 

    38 num_rtns_1                    Numeric Functions/second
          linux-2.5.51                      60.00
32603           543.38333              54338.33
          linux-2.5.51[mm1]            60.00                   32602
543.36667              54336.67
          linux-2.5.51[mm2]            60.00                   32587
543.11667              54311.67

    39 new_raph                      Zeros Found/second
         linux-2.5.51                       60.00
79903           1331.71667             266343.33
         linux-2.5.51[mm1]             60.00                   79905
1331.75000             266350.00
         linux-2.5.51[mm2]             60.00                   79890
1331.50000             266300.00

    40 trig_rtns                         Trigonometric Functions/second
          linux-2.5.51                      60.01                   2160
35.99400                359940.01
          linux-2.5.51[mm1]            60.02                   2168
36.12129                361212.93
          linux-2.5.51[mm2]            60.01                   2168
36.12731                361273.12

    41 matrix_rtns                     Point Transformations/second
          linux-2.5.51                      60.00
349540          5825.66667            582566.67 
          linux-2.5.51[mm1]            60.00                  349593
5826.55000            582655.00
          linux-2.5.51[mm2]            60.00                  349515
5825.25000            582525.00

    42 array_rtns                      Linear Systems Solved/second
         linux-2.5.51                       60.00                   959
15.98333               319.67
         linux-2.5.51[mm1]             60.05                   960
15.98668               319.73 
         linux-2.5.51[mm2]             60.03                   959
15.97535               319.51 

    43 string_rtns                     String Manipulations/second
         linux-2.5.51                       60.01                   851
14.18097               1418.10 
         linux-2.5.51[mm1]             60.06                   852
14.18581               1418.58
         linux-2.5.51[mm2]             60.06                   852
14.18581               1418.58

    44 mem_rtns_1                 Dynamic Memory Operations/second
          linux-2.5.51                      60.00                   1640
27.33333              820000.00 
          linux-2.5.51[mm1]            60.02                   1910
31.82273              954681.77
          linux-2.5.51[mm2]            60.04                   1530
25.48301              764490.34

    45 mem_rtns_2                 Block Memory Operations/second
         linux-2.5.51                       60.00
131025           2183.75000          218375.00 
         linux-2.5.51[mm1]             60.00                   131053
2184.21667          218421.67
         linux-2.5.51[mm2]             60.00                   131034
2183.90000          218390.00 

    46 sort_rtns_1                  Sort Operations/second
          linux-2.5.51                      60.02                   2425
40.40320              404.03
          linux-2.5.51[mm1]            60.02                   2425
40.40320              404.03 
          linux-2.5.51[mm2]            60.01                   2424
40.39327              403.93 

     47 misc_rtns_1                 Auxiliary Loops/second
           linux-2.5.51                     60.00
32379             539.65000             5396.50 
           linux-2.5.51[mm1]           60.00                   31628
527.13333             5271.33 
           linux-2.5.51[mm2]           60.00                   31911
531.85000             5318.50 

    48 dir_rtns_1                    Directory Operations/second
           linux-2.5.51                    60.00
13181             219.68333             2196833.33 
           linux-2.5.51[mm1]          60.00                    12621
210.35000             2103500.00
           linux-2.5.51[mm2]          60.00                    13128
218.80000             2188000.00 

    49 shell_rtns_1                Shell Scripts/second
           linux-2.5.51                    60.02                    2472
41.18627              41.19
           linux-2.5.51[mm1]          60.01                    2479
41.30978              41.31
           linux-2.5.51[mm2]          60.00                    2470
41.16667              41.17 

    50 shell_rtns_2                 Shell Scripts/second
            linux-2.5.51                   60.00                    2479
41.31667              41.32
            linux-2.5.51[mm1]         60.01                    2478
41.29312              41.29 
            linux-2.5.51[mm2]         60.02                    2480
41.31956              41.32

    51 shell_rtns_3                   Shell Scripts/second
            linux-2.5.51                   60.01                    2479
41.30978              41.31 
            linux-2.5.51[mm1]         60.02                    2480
41.31956              41.32 
            linux-2.5.51[mm2]         60.00                    2478
41.30000              41.30

    52 series_1                        Series Evaluations/second
           linux-2.5.51                    60.00
1464266          24404.43333        2440443.33           
           linux-2.5.51[mm1]          60.00                   1464388
24406.46667        2440646.67
           linux-2.5.51[mm2]          60.00                   1464074
24401.23333        2440123.33 

    53 shared_memory            Shared Memory Operations/second
           linux-2.5.51                    60.00
168202            2803.36667          280336.67
           linux-2.5.51[mm1]          60.00                   157980
2633.00000          263300.00
           linux-2.5.51[mm2]          60.00                   166154
2769.23333          276923.33 

    54 tcp_test                        TCP/IPMessages/second
          linux-2.5.51                     60.01                   11200
186.63556            16797.20
          linux-2.5.51[mm1]           60.00                   10780
179.66667            16170.00
          linux-2.5.51[mm2]           60.00                   10927
182.11667            16390.50

    55 udp_test                      UDP/IP DataGrams/second
          linux-2.5.51                     60.00                   49319
821.98333            82198.33 
          linux-2.5.51[mm1]           60.00                   47033
783.88333            78388.33
          linux-2.5.51[mm2]           60.00                   46617
776.95000            77695.00

    56 fifo_test                        FIFO Messages/second 
          linux-2.5.51                     60.00                   92331
1538.85000          153885.00
          linux-2.5.51[mm1]           60.00                   88371
1472.85000          147285.00 
          linux-2.5.51[mm2]           60.00                   89477
1491.28333          149128.33 

    57 stream_pipe                 Stream Pipe Messages/second
           linux-2.5.51                   60.00                    70959
1182.65000         118265.00
           linux-2.5.51[mm1]         60.00                    70192
1169.86667         116986.67
           linux-2.5.51[mm2]         60.00                    70782
1179.70000         117970.00 

    58 dgram_pipe                  DataGram Pipe Messages/second
           linux-2.5.51                   60.00                    69617
1160.28333         116028.33
           linux-2.5.51[mm1]         60.00                    68397
1139.95000         113995.00
           linux-2.5.51[mm2]         60.00                    70214
1170.23333         117023.33

    59 pipe_cpy                      Pipe Messages/second
            linux-2.5.51                  60.00                   248370
4139.50000         413950.00
            linux-2.5.51[mm1]        60.00                   236957
3949.28333         394928.33
            linux-2.5.51[mm2]        60.00                   253724
4228.73333         422873.33 

     60 ram_copy                   Memory to Memory Copy/second
            linux-2.5.51                  60.00                  1496002
24933.36667       623832834.00 
            linux-2.5.51[mm1]        60.00                  1495745
24929.08333       623725665.00
            linux-2.5.51[mm2]        60.00                  1495977
24932.95000       623822409.00
------------------------------------------------------------------------
------------------------------------


Regards
Sowmya Adiga

