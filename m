Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264786AbSJaIvM>; Thu, 31 Oct 2002 03:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264788AbSJaIvL>; Thu, 31 Oct 2002 03:51:11 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:29413 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S264786AbSJaIvH>; Thu, 31 Oct 2002 03:51:07 -0500
Message-ID: <027c01c280bb$7f95d240$7609720a@M3104487>
Reply-To: "Siva Koti Reddy" <siva.kotireddy@wipro.com>
From: "Siva Koti Reddy" <siva.kotireddy@wipro.com>
To: "lkml" <linux-kernel@vger.kernel.org>
Cc: "Siva Koti Reddy" <siva.kotireddy@wipro.com>
Subject: [BENCHMARK] AIM Bench Mark Results for 2.5.44 kernel and 2.5.45 kernels
Date: Thu, 31 Oct 2002 14:27:10 +0530
Organization: wipro
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPartTM-000-a5f9ca9a-c756-4a06-aa7a-d36ff53328a7"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
X-OriginalArrivalTime: 31 Oct 2002 08:57:18.0415 (UTC) FILETIME=[84267DF0:01C280BB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

------=_NextPartTM-000-a5f9ca9a-c756-4a06-aa7a-d36ff53328a7
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hai....
    Here is the AIM benchmark results for 2.5.44 kernel and 2.5.45 kernels.
    Results shows 2.5.45 kernel performed little better in pages allocation(page_test), Sequential,Random writes (sync_disk_rw,
sync_dsik_wrt,sync_disk_cp), linking/unlinkg(link_test) and 2.5.44 kernel performed little better in directory
operation(dir_rtns_1).
    Overall results look consistent.

Machine's name                                      : benchtest
Machine's configuration                           : PIII,128MB,800MHz
Number of seconds to run each test [2 to 1000]    : 60
Path to disk files                                : /tmp


Starting time:      Thu Oct 31 10:33:20 2002
Projected Run Time: 1:00:00
Projected finish:   Thu Oct 31 11:33:20 2002


------------------------------------------------------------------------------------------------------------
 Test        Test         Elapsed   Iteration Iteration       Operation
Number       Name        Time (sec)   Count    Rate (loops/sec)Rate (ops/sec)
------------------------------------------------------------------------------------------------------------
     1 add_double   [2.5.45]     60.02       1744   29.05698       523025.66 Thousand Double Precision Additions/second
     1 add_double   [2.5.44]     60.03       1743   29.03548       522638.68 Thousand Double Precision Additions/second

     2 add_float    [2.5.45]     60.02       2600   43.31889       519826.72 Thousand Single Precision Additions/second
     2 add_float    [2.5.44]     60.01       2618   43.62606       523512.75 Thousand Single Precision Additions/second

     3 add_long     [2.5.45]     60.01       1616   26.92885      1615730.71 Thousand Long Integer Additions/second
     3 add_long     [2.5.44]     60.03       1617   26.93653      1616191.90 Thousand Long Integer Additions/second

     4 add_int      [2.5.45]     60.00       1616   26.93333      1616000.00 Thousand Integer Additions/second
     4 add_int      [2.5.44]     60.04       1617   26.93205      1615922.72 Thousand Integer Additions/second

     5 add_short    [2.5.45]     60.00       4039   67.31667      1615600.00 Thousand Short Integer Additions/second
     5 add_short    [2.5.44]     60.00       4011   66.85000      1604400.00 Thousand Short Integer Additions/second

     6 creat-clo    [2.5.45]     60.05       1227   20.43297        20432.97 File Creations and Closes/second
     6 creat-clo    [2.5.44]     60.04       1211   20.16989        20169.89 File Creations and Closes/second

     7 page_test    [2.5.45]     60.00       6416  106.93333       181786.67 System Allocations & Pages/second
     7 page_test    [2.5.44]     60.01       6153  102.53291       174305.95 System Allocations & Pages/second

     8 brk_test     [2.5.45]     60.02       2210   36.82106       625958.01 System Memory Allocations/second
     8 brk_test     [2.5.44]     60.00       2159   35.98333       611716.67 System Memory Allocations/second

     9 jmp_test     [2.5.45]     60.00     296083 4934.71667      4934716.67 Non-local gotos/second
     9 jmp_test     [2.5.44]     60.00     296210 4936.83333      4936833.33 Non-local gotos/second

    10 signal_test  [2.5.45]     60.01       6905  115.06416       115064.16 Signal Traps/second
    10 signal_test  [2.5.44]     60.01       8402  140.01000       140010.00 Signal Traps/second

    11 exec_test    [2.5.45]     60.01       1958   32.62790          163.14 Program Loads/second
    11 exec_test    [2.5.44]     60.02       1951   32.50583          162.53 Program Loads/second

    12 fork_test    [2.5.45]     60.01        824   13.73104         1373.10 Task Creations/second
    12 fork_test    [2.5.44]     60.04        808   13.45769         1345.77 Task Creations/second

    13 link_test    [2.5.45]     60.00       8297  138.28333         8711.85 Link/Unlink Pairs/second
    13 link_test    [2.5.44]     60.00       6460  107.66667         6783.00 Link/Unlink Pairs/second

    14 disk_rr      [2.5.45]     60.10        253    4.20965        21553.41 Random Disk Reads (K)/second
    14 disk_rr      [2.5.44]     60.16        252    4.18883        21446.81 Random Disk Reads (K)/second

    15 disk_rw      [2.5.45]     60.23        218    3.61946        18531.63 Random Disk Writes (K)/second
    15 disk_rw      [2.5.44]     60.15        214    3.55777        18215.79 Random Disk Writes (K)/second

    16 disk_rd      [2.5.45]     60.02       2538   42.28590       216503.83 Sequential Disk Reads (K)/second
    16 disk_rd      [2.5.44]     60.02       2555   42.56914       217954.02 Sequential Disk Reads (K)/second

    17 disk_wrt     [2.5.45]     60.01        292    4.86586        24913.18 Sequential Disk Writes (K)/second
    17 disk_wrt     [2.5.44]     60.08        287    4.77696        24458.06 Sequential Disk Writes (K)/second

    18 disk_cp      [2.5.45]     60.07        257    4.27834        21905.11 Disk Copies (K)/second
    18 disk_cp      [2.5.44]     60.21        253    4.20196        21514.03 Disk Copies (K)/second

    19 sync_disk_rw [2.5.45]     67.13          7    0.10428          266.94 Sync Random Disk Writes (K)/second
    19 sync_disk_rw [2.5.44]     61.28          6    0.09791          250.65 Sync Random Disk Writes (K)/second

    20 sync_disk_wrt[2.5.45]     61.39         28    0.45610         1167.62 Sync Sequential Disk Writes (K)/second
    20 sync_disk_wrt[2.5.44]     60.86         27    0.44364         1135.72 Sync Sequential Disk Writes (K)/second

    21 sync_disk_cp [2.5.45]     61.23         28    0.45729         1170.67 Sync Disk Copies (K)/second
    21 sync_disk_cp [2.5.44]     60.90         27    0.44335         1134.98 Sync Disk Copies (K)/second

    22 disk_src     [2.5.45]     60.01       8374  139.54341        10465.76 Directory Searches/second
    22 disk_src     [2.5.44]     60.01       8452  140.84319        10563.24 Directory Searches/second

    23 div_double   [2.5.45]     60.03       1779   29.63518        88905.55 Thousand Double Precision Divides/second
    23 div_double   [2.5.44]     60.00       1778   29.63333        88900.00 Thousand Double Precision Divides/second

    24 div_float    [2.5.45]     60.03       1779   29.63518        88905.55 Thousand Single Precision Divides/second
    24 div_float    [2.5.44]     60.02       1779   29.64012        88920.36 Thousand Single Precision Divides/second

    25 div_long     [2.5.45]     60.02       1455   24.24192        21817.73 Thousand Long Integer Divides/second
    25 div_long     [2.5.44]     60.03       1445   24.07130        21664.17 Thousand Long Integer Divides/second

    26 div_int      [2.5.45]     60.03       1455   24.23788        21814.09 Thousand Integer Divides/second
    26 div_int      [2.5.44]     60.02       1455   24.24192        21817.73 Thousand Integer Divides/second

    27 div_short    [2.5.45]     60.01       1444   24.06266        21656.39 Thousand Short Integer Divides/second
    27 div_short    [2.5.44]     60.01       1455   24.24596        21821.36 Thousand Short Integer Divides/second

    28 fun_cal      [2.5.45]     60.00       4312   71.86667     36795733.33 Function Calls (no arguments)/second
    28 fun_cal      [2.5.44]     60.00       4313   71.88333     36804266.67 Function Calls (no arguments)/second

    29 fun_cal1     [2.5.45]     60.01       9332  155.50742     79619796.70 Function Calls (1 argument)/second
    29 fun_cal1     [2.5.44]     60.01       9332  155.50742     79619796.70 Function Calls (1 argument)/second

    30 fun_cal2     [2.5.45]     60.00       7281  121.35000     62131200.00 Function Calls (2 arguments)/second
    30 fun_cal2     [2.5.44]     60.00       7228  120.46667     61678933.33 Function Calls (2 arguments)/second

    31 fun_cal15    [2.5.45]     60.00       2415   40.25000     20608000.00 Function Calls (15 arguments)/second
    31 fun_cal15    [2.5.44]     60.00       2415   40.25000     20608000.00 Function Calls (15 arguments)/second

    32 sieve        [2.5.45]     61.20         47    0.76797            3.84 Integer Sieves/second
    32 sieve        [2.5.44]     60.77         47    0.77341            3.87 Integer Sieves/second

    33 mul_double   [2.5.45]     60.03       1571   26.17025       314042.98 Thousand Double Precision Multiplies/second
    33 mul_double   [2.5.44]     60.00       1571   26.18333       314200.00 Thousand Double Precision Multiplies/second

    34 mul_float    [2.5.45]     60.01       1571   26.17897       314147.64 Thousand Single Precision Multiplies/second
    34 mul_float    [2.5.44]     60.00       1571   26.18333       314200.00 Thousand Single Precision Multiplies/second

    35 mul_long     [2.5.45]     60.01      69092 1151.34144       276321.95 Thousand Long Integer Multiplies/second
    35 mul_long     [2.5.44]     60.00      68623 1143.71667       274492.00 Thousand Long Integer Multiplies/second

    36 mul_int      [2.5.45]     60.00      69471 1157.85000       277884.00 Thousand Integer Multiplies/second
    36 mul_int      [2.5.44]     60.00      69416 1156.93333       277664.00 Thousand Integer Multiplies/second

    37 mul_short    [2.5.45]     60.00      54957  915.95000       274785.00 Thousand Short Integer Multiplies/second
    37 mul_short    [2.5.44]     60.00      55394  923.23333       276970.00 Thousand Short Integer Multiplies/second

    38 num_rtns_1   [2.5.45]     60.00      29888  498.13333        49813.33 Numeric Functions/second
    38 num_rtns_1   [2.5.44]     60.00      29691  494.85000        49485.00 Numeric Functions/second

    39 new_raph     [2.5.45]     60.00      89192 1486.53333       297306.67 Zeros Found/second
    39 new_raph     [2.5.44]     60.00      89236 1487.26667       297453.33 Zeros Found/second

    40 trig_rtns    [2.5.45]     60.02       2024   33.72209       337220.93 Trigonometric Functions/second
    40 trig_rtns    [2.5.44]     60.03       1957   32.60037       326003.66 Trigonometric Functions/second

    41 matrix_rtns  [2.5.45]     60.00     368170 6136.16667       613616.67 Point Transformations/second
    41 matrix_rtns  [2.5.44]     60.00     368253 6137.55000       613755.00 Point Transformations/second

    42 array_rtns   [2.5.45]     60.00        871   14.51667          290.33 Linear Systems Solved/second
    42 array_rtns   [2.5.44]     60.03        880   14.65934          293.19 Linear Systems Solved/second

    43 string_rtns  [2.5.45]     60.06        776   12.92041         1292.04 String Manipulations/second
    43 string_rtns  [2.5.44]     60.06        777   12.93706         1293.71 String Manipulations/second

    44 mem_rtns_1   [2.5.45]     60.04       1502   25.01666       750499.67 Dynamic Memory Operations/second
    44 mem_rtns_1   [2.5.44]     60.02       1547   25.77474       773242.25 Dynamic Memory Operations/second

    45 mem_rtns_2   [2.5.45]     60.00     119707 1995.11667       199511.67 Block Memory Operations/second
    45 mem_rtns_2   [2.5.44]     60.00     118838 1980.63333       198063.33 Block Memory Operations/second

    46 sort_rtns_1  [2.5.45]     60.02       2210   36.82106          368.21 Sort Operations/second
    46 sort_rtns_1  [2.5.44]     60.01       2213   36.87719          368.77 Sort Operations/second

    47 misc_rtns_1  [2.5.45]     60.00      25568  426.13333         4261.33 Auxiliary Loops/second
    47 misc_rtns_1  [2.5.44]     60.00      25169  419.48333         4194.83 Auxiliary Loops/second

    48 dir_rtns_1   [2.5.45]     60.00       7394  123.23333      1232333.33 Directory Operations/second
    48 dir_rtns_1   [2.5.44]     60.00       9413  156.88333      1568833.33 Directory Operations/second

    49 shell_rtns_1 [2.5.45]     60.02       2295   38.23725           38.24 Shell Scripts/second
    49 shell_rtns_1 [2.5.44]     60.02       2312   38.52049           38.52 Shell Scripts/second

    50 shell_rtns_2 [2.5.45]     60.01       2311   38.51025           38.51 Shell Scripts/second
    50 shell_rtns_2 [2.5.44]     60.02       2306   38.42053           38.42 Shell Scripts/second

    51 shell_rtns_3 [2.5.45]     60.00       2312   38.53333           38.53 Shell Scripts/second
    51 shell_rtns_3 [2.5.44]     60.01       2325   38.74354           38.74 Shell Scripts/second

    52 series_1     [2.5.45]     60.00    2233890 37231.50000      3723150.00 Series Evaluations/second
    52 series_1     [2.5.44]     60.00    2250305 37505.08333      3750508.33 Series Evaluations/second

    53 shared_memory[2.5.45]     60.00     143602 2393.36667       239336.67 Shared Memory Operations/second
    53 shared_memory[2.5.44]     60.00     141575 2359.58333       235958.33 Shared Memory Operations/second

    54 tcp_test     [2.5.45]     60.01       9422  157.00717        14130.64 TCP/IP Messages/second
    54 tcp_test     [2.5.44]     60.01       9042  150.67489        13560.74 TCP/IP Messages/second

    55 udp_test     [2.5.45]     60.01      33580  559.57340        55957.34 UDP/IP DataGrams/second
    55 udp_test     [2.5.44]     60.00      33212  553.53333        55353.33 UDP/IP DataGrams/second

    56 fifo_test    [2.5.45]     60.00      59276  987.93333        98793.33 FIFO Messages/second
    56 fifo_test    [2.5.44]     60.00      54602  910.03333        91003.33 FIFO Messages/second

    57 stream_pipe  [2.5.45]     60.00      52198  869.96667        86996.67 Stream Pipe Messages/second
    57 stream_pipe  [2.5.44]     60.00      52556  875.93333        87593.33 Stream Pipe Messages/second

    58 dgram_pipe   [2.5.45]     60.00      51941  865.68333        86568.33 DataGram Pipe Messages/second
    58 dgram_pipe   [2.5.44]     60.01      52024  866.92218        86692.22 DataGram Pipe Messages/second

    59 pipe_cpy     [2.5.45]     60.00     161995 2699.91667       269991.67 Pipe Messages/second
    59 pipe_cpy     [2.5.44]     60.00     172675 2877.91667       287791.67 Pipe Messages/second

    60 ram_copy     [2.5.45]     60.00    1384106 23068.43333    577172202.00 Memory to Memory Copy/second
    60 ram_copy     [2.5.44]     60.00    1373483 22891.38333    572742411.00 Memory to Memory Copy/second

------------------------------------------------------------------------------------------------------------
Projected Completion time:  Thu Oct 31 11:33:20 2002
Actual Completion time:     Thu Oct 31 11:33:32 2002
Difference:                 0:00:12

AIM Independent Resource Benchmark - Suite IX


Any comments/suggestions are welcome.

Rgds
Siva



------=_NextPartTM-000-a5f9ca9a-c756-4a06-aa7a-d36ff53328a7
Content-Type: text/plain;
	name="Wipro_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Wipro_Disclaimer.txt"

**************************Disclaimer**************************************************    
 
 Information contained in this E-MAIL being proprietary to Wipro Limited is 'privileged' 
and 'confidential' and intended for use only by the individual or entity to which it is 
addressed. You are notified that any use, copying or dissemination of the information 
contained in the E-MAIL in any manner whatsoever is strictly prohibited.

****************************************************************************************

------=_NextPartTM-000-a5f9ca9a-c756-4a06-aa7a-d36ff53328a7--
