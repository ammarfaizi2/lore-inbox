Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264021AbSJ3GT4>; Wed, 30 Oct 2002 01:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264037AbSJ3GT4>; Wed, 30 Oct 2002 01:19:56 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:56560 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S264021AbSJ3GTr>; Wed, 30 Oct 2002 01:19:47 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPartTM-000-cee719f8-0bc9-4839-bb44-9896335aeb15"
Subject: AIM Bench Mark results for different kernels
Date: Wed, 30 Oct 2002 11:55:59 +0530
Message-ID: <7F396B9772328640B7593FA817EEEDAD05FF3C@blr-m3-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: AIM Bench Mark results for different kernels
Thread-Index: AcJ/3TWm4+GF0OJvR/2w9PCb03JKAQ==
From: "Pavan Kumar Reddy N.S." <pavan.kumar@wipro.com>
To: <kernelnewbies@nl.linux.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 30 Oct 2002 06:26:00.0317 (UTC) FILETIME=[36C4EAD0:01C27FDD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

------=_NextPartTM-000-cee719f8-0bc9-4839-bb44-9896335aeb15
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

=20
AIM Independent Resource Benchmark - Suite IX v1.1, January 22, 1996=20
Copyright (c) 1996 - 2001 Caldera International, Inc. All Rights
Reserved
=20
Machine's name                                      : access1
Machine's configuration                             : PIII 868MHz 128M
Number of seconds to run each test [2 to 1000]      : 60
Path to disk files                                  : /tmp
glibc version                                       : 2.2.5-34
=20
------------------------------------------------------------------------
----------
 Test Num                  Elapsed    Iteration   Iteration
Operation=20
  & Name                  Time(sec)     Count    Rate(loops/sec)
Rate(loops/sec)=20
------------------------------------------------------------------------
----------
 1 add_double         Thousand Double Precision Additions/second
     linux-2.4.19           60.08       721       12.00067
216011.98          =20
     linux-2.4.20-pre11     60.05       723       12.03997
216719.40          =20
=20
     linux-2.5.42           60.07       715       11.90278
214250.04=20
     linux-2.5.43           60.06       715       11.90476
214285.71
     linux-2.5.44           60.03       713       11.87739
213793.10
 2 add_float          Thousand Single Precision Additions/second
     linux-2.4.19           60.01       1084      18.06366
216763.87
     linux-2.4.20-pre11     60.01       1084      18.06366
216763.87
=20
     linux-2.5.42           60.03       1073      17.87440
214492.75=20
     linux-2.5.43           60.02       1073      17.87737
214528.49=20
     linux-2.5.44           60.02       1073      17.87737
214528.49=20
 3 add_long           Thousand Long Integer Additions/second
     linux-2.4.19           60.02       1784      29.72343
1783405.53
     linux-2.4.20-pre11     60.02       1784      29.72343
1783405.53

     linux-2.5.42           60.03       1766      29.41862
1765117.44=20
     linux-2.5.43           60.00       1765      29.41667
1765000.00=20
     linux-2.5.44           60.03       1766      29.41862
1765117.44=20
 4 add_int            Thousand Integer Additions/second
     linux-2.4.19           60.01       1784      29.72838
1783702.72
     linux-2.4.20-pre11     60.01       1784      29.72838
1783702.72
=20
     linux-2.5.42           60.02       1766      29.42353
1765411.53=20
     linux-2.5.43           60.02       1766      29.42353
1765411.53=20
     linux-2.5.44           60.02       1766      29.42353
1765411.53=20
 5 add_short          Thousand Short Integer Additions/second
     linux-2.4.19           60.01       4458      74.28762
1782902.85
     linux-2.4.20-pre11     60.01       4459      74.30428
1783302.78
=20
     linux-2.5.42           60.01       4413      73.53774
1764905.85=20
     linux-2.5.43           60.02       4414      73.54215
1765011.66=20
     linux-2.5.44           60.00       4413      73.55000
1765200.00=20
 6 creat-clo          File Creations and Closes/second
     linux-2.4.19           60.01       3164      52.72455
52724.55
     linux-2.4.20-pre11     60.01       3012      50.19163
50191.63
=20
     linux-2.5.42           60.04       1311      21.83544
21835.44=20
     linux-2.5.43           60.00       2998      49.96667
49966.67=20
     linux-2.5.44           60.01       1282      21.36311
21363.11=20
 7 page_test          System Allocations & Pages/second
     linux-2.4.19           60.00       8764      146.06667
248313.33
     linux-2.4.20-pre11     60.00       9040      150.66667
256133.33
=20
     linux-2.5.42           60.00       6698      111.63333
189776.67=20
     linux-2.5.43           60.00       6747      112.45000
191165.00=20
     linux-2.5.44           60.01       6604      110.04833
187082.15=20
 8 brk_test           System Memory Allocations/second
     linux-2.4.19           60.01       3542      59.02350
1003399.43
     linux-2.4.20-pre11     60.00       3643      60.71667
1032183.33
=20
     linux-2.5.42           60.02       2411      40.16994
682889.04=20
     linux-2.5.43           60.01       2450      40.82653
694050.99=20
     linux-2.5.44           60.02       2342      39.02033
663345.55=20
 9 jmp_test           Non-local gotos/second
     linux-2.4.19           60.00      321133     5352.21667
5352216.67
     linux-2.4.20-pre11     60.00      321135     5352.25000
5352250.00
=20
     linux-2.5.42           60.00      317665     5294.41667
5294416.67=20
     linux-2.5.43           60.00      317726     5295.43333
5295433.33=20
     linux-2.5.44           60.00      317684     5294.73333
5294733.33=20
10 signal_test        Signal Traps/second
     linux-2.4.19           60.00      13349      222.48333
222483.33
     linux-2.4.20-pre11     60.00      13449      224.15000
224150.00
=20
     linux-2.5.42           60.01      9099       151.62473
151624.73=20
     linux-2.5.43           60.00      11969      199.48333
199483.33=20
     linux-2.5.44           60.00      9186       153.10000
153100.00=20
11 exec_test          Program Loads/second
     linux-2.4.19           60.00      2866       47.76667
238.83
     linux-2.4.20-pre11     60.02      2858       47.61746
238.09
=20
     linux-2.5.42           60.03      1947       32.43378
162.17=20
     linux-2.5.43           60.03      2270       37.81443
189.07=20
     linux-2.5.44           60.02      1917       31.93935
159.70=20
12 fork_test          Task Creations/second
     linux-2.4.19           60.01      2001       33.34444
3334.44
     linux-2.4.20-pre11     60.00      1904       31.73333
3173.33
=20
     linux-2.5.42           60.03      772        12.86024
1286.02=20
     linux-2.5.43           60.05      939        15.63697
1563.70=20
     linux-2.5.44           60.01      806        13.43109
1343.11=20
13 link_test          Link/Unlink Pairs/second
     linux-2.4.19           60.00      31961      532.68333
33559.05
     linux-2.4.20-pre11     60.00      30131      502.18333
31637.55
=20
     linux-2.5.42           60.01      7142       119.01350
7497.85=20
     linux-2.5.43           60.00      30945      515.75000
32492.25=20
     linux-2.5.44           60.00      7023       117.05000
7374.15=20
14 disk_rr            Random Disk Reads (K)/second
     linux-2.4.19           60.11      438        7.28664
37307.60
     linux-2.4.20-pre11     60.12      414        6.88623
35257.49
=20
     linux-2.5.42           60.08      377        6.27497
32127.83=20
     linux-2.5.43           60.02      428        7.13096
36510.50=20
     linux-2.5.44           60.14      376        6.25208
32010.64=20
15 disk_rw            Random Disk Writes (K)/second
     linux-2.4.19           60.09      331        5.50840
28203.03
     linux-2.4.20-pre11     60.02      303        5.04832
25847.38
=20
     linux-2.5.42           60.01      300        4.99917
25595.73=20
     linux-2.5.43           60.10      355        5.90682
30242.93=20
     linux-2.5.44           60.07      292        4.86100
24888.30=20
16 disk_rd            Sequential Disk Reads (K)/second
     linux-2.4.19           60.00       2837      47.28333
242090.67
     linux-2.4.20-pre11     60.01       2806      46.75887
239405.43
=20
     linux-2.5.42           60.02       2660      44.31856
226911.03=20
     linux-2.5.43           60.02       2639      43.96868
225119.63=20
     linux-2.5.44           60.02       2591      43.16894
221024.99=20
17 disk_wrt           Sequential Disk Writes (K)/second
     linux-2.4.19           60.02        537      8.94702
45808.73
     linux-2.4.20-pre11     60.02        523      8.71376
44614.46
=20
     linux-2.5.42           60.06        478      7.95871
40748.58=20
     linux-2.5.43           60.04        541      9.01066
46134.58=20
     linux-2.5.44           60.02        463      7.71410
39496.17=20
18 disk_cp            Disk Copies (K)/second
     linux-2.4.19           60.09        449      7.47213
38257.28
     linux-2.4.20-pre11     60.02        429      7.14762
36595.80

     linux-2.5.42           60.08        395      6.57457
33661.78=20
     linux-2.5.43           60.00        442      7.36667
37717.33=20
     linux-2.5.44           60.01        378      6.29895
32250.62=20
19 sync_disk_rw       Sync Random Disk Writes (K)/second
     linux-2.4.19           81.48          1      0.01227
31.42
     linux-2.4.20-pre11     66.17          4      0.06045
154.75
=20
     linux-2.5.42           80.46          1      0.01243
31.82=20
     linux-2.5.43           78.99          1      0.01266
32.41=20
     linux-2.5.44           79.50          1      0.01258
32.20=20
20 sync_disk_wrt      Sync Sequential Disk Writes (K)/second
     linux-2.4.19           85.89          2      0.02329
59.61
     linux-2.4.20-pre11     85.97          2      0.02326
59.56
=20
     linux-2.5.42           86.20          2      0.02320
59.40=20
     linux-2.5.43           85.86          2      0.02329
59.63=20
     linux-2.5.44           85.43          2      0.02341
59.93=20
21 sync_disk_cp       Sync Disk Copies (K)/second
     linux-2.4.19           85.97          2      0.02326
59.56
     linux-2.4.20-pre11     85.53          2      0.02338
59.86
=20
     linux-2.5.42           85.25          2      0.02346
60.06=20
     linux-2.5.43           85.50          2      0.02339
59.88=20
     linux-2.5.44           85.50          2      0.02339
59.88=20
22 disk_src           Directory Searches/second
     linux-2.4.19           60.00      21596      359.93333
26995.00
     linux-2.4.20-pre11     60.00      20176      336.26667
25220.00
=20
     linux-2.5.42           60.00       9147      152.45000
11433.75=20
     linux-2.5.43           60.00      19670      327.83333
24587.50=20
     linux-2.5.44           60.01       9193      153.19113
11489.34=20
23 div_double         Thousand Double Precision Divides/second
     linux-2.4.19           60.02       1334      22.22592
66677.77
     linux-2.4.20-pre11     60.01       1334      22.22963
66688.89
=20
     linux-2.5.42           60.05       1321      21.99833
65995.00=20
     linux-2.5.43           60.04       1321      22.00200
66006.00=20
     linux-2.5.44           60.04       1321      22.00200
66006.00=20
24 div_float          Thousand Single Precision Divides/second
     linux-2.4.19           60.01       1334      22.22963
66688.89
     linux-2.4.20-pre11     60.00       1334      22.23333
66700.00
=20
     linux-2.5.42           60.04       1321      22.00200
66006.00=20
     linux-2.5.43           60.04       1321      22.00200
66006.00=20
     linux-2.5.44           60.04       1321      22.00200
66006.00=20
25 div_long           Thousand Long Integer Divides/second
     linux-2.4.19           60.01       1606      26.76221
24085.99
     linux-2.4.20-pre11     60.02       1606      26.75775
24081.97
=20
     linux-2.5.42           60.00      1589       26.48333
23835.00=20
     linux-2.5.43           60.03       1590      26.48676
23838.08=20
     linux-2.5.44           60.03       1590      26.48676
23838.08=20
26 div_int            Thousand Integer Divides/second
     linux-2.4.19           60.01       1606      26.76221
24085.99
     linux-2.4.20-pre11     60.01       1606      26.76221
24085.99
=20
     linux-2.5.42           60.00       1589      26.48333
23835.00=20
     linux-2.5.43           60.03       1590      26.48676
23838.08=20
     linux-2.5.44           60.03       1589      26.47010
23823.09=20
27 div_short          Thousand Short Integer Divides/second
     linux-2.4.19           60.01       1606      26.76221
24085.99
     linux-2.4.20-pre11     60.00       1605      26.75000
24075.00
=20
     linux-2.5.42           60.00       1589      26.48333
23835.00=20
     linux-2.5.43           60.03       1590      26.48676
23838.08=20
     linux-2.5.44           60.01       1589      26.47892
23831.03=20
28 fun_cal            Function Calls (no arguments)/second
     linux-2.4.19           60.00       4401      73.35000
37555200.00
     linux-2.4.20-pre11     60.01       4402      73.35444
37557473.75
=20
     linux-2.5.42           60.01       4356      72.58790
37165005.83=20
     linux-2.5.43           60.01       4357      72.60457
37173537.74=20
     linux-2.5.44           60.02       4357      72.59247
37167344.22=20
29 fun_cal1           Function Calls (1 argument)/second
     linux-2.4.19           60.00      10324      172.06667
88098133.33
     linux-2.4.20-pre11     60.00      10295      171.58333
87850666.67
=20
     linux-2.5.42           60.00      10172      169.53333
86801066.67=20
     linux-2.5.43           60.00      10218      170.30000
87193600.00=20
     linux-2.5.44           60.00      10216      170.26667
87176533.33=20
30 fun_cal2           Function Calls (2 arguments)/second
     linux-2.4.19           60.00       8043      134.05000
68633600.00
     linux-2.4.20-pre11     60.00       8043      134.05000
68633600.00
=20
     linux-2.5.42           60.00       7958      132.63333
67908266.67=20
     linux-2.5.43           60.00       7960      132.66667
67925333.33=20
     linux-2.5.44           60.01       7960      132.64456
67914014.33=20
31 fun_cal15          Function Calls (15 arguments)/second
     linux-2.4.19           60.01       2477      41.27645
21133544.41
     linux-2.4.20-pre11     60.02       2477      41.26958
21130023.33
=20
     linux-2.5.42           60.01       2451      40.84319
20911714.71=20
     linux-2.5.43           60.01       2451      40.84319
20911714.71=20
     linux-2.5.44           60.01       2453      40.87652
20928778.54=20
32 sieve              Integer Sieves/second
     linux-2.4.19           60.33         41      0.67960           3.40
     linux-2.4.20-pre11     61.22         42      0.68605           3.43
=20
     linux-2.5.42           60.90         41      0.67323           3.37

     linux-2.5.43           60.78         41      0.67456           3.37

     linux-2.5.44           60.61        41       0.67646           3.38

33 mul_double         Thousand Double Precision Multiplies/second
     linux-2.4.19           60.00        844      14.06667
168800.00
     linux-2.4.20-pre11     60.04        845      14.07395
168887.41
=20
     linux-2.5.42           60.02        835      13.91203
166944.35=20
     linux-2.5.43           60.03        835      13.90971
166916.54=20
     linux-2.5.44           60.02        835      13.91203
166944.35=20
34 mul_float          Thousand Single Precision Multiplies/second
     linux-2.4.19           60.03        843      14.04298
168515.74
     linux-2.4.20-pre11     60.01        843      14.04766
168571.90
=20
     linux-2.5.42           60.06        834      13.88611
166633.37=20
     linux-2.5.43           60.05        834      13.88843
166661.12=20
     linux-2.5.44           60.04        834      13.89074
166688.87=20
35 mul_long           Thousand Long Integer Multiplies/second
     linux-2.4.19           60.00      76292      1271.53333
305168.00
     linux-2.4.20-pre11     60.00      76289      1271.48333
305156.00
=20
     linux-2.5.42           60.00      75632      1260.53333
302528.00=20
     linux-2.5.43           60.00      75642      1260.70000
302568.00=20
     linux-2.5.44           60.00      75642      1260.70000
302568.00=20
36 mul_int            Thousand Integer Multiplies/second
     linux-2.4.19           60.00      76783      1279.71667
307132.00
     linux-2.4.20-pre11     60.00      76778      1279.63333
307112.00
=20
     linux-2.5.42           60.00      75851      1264.18333
303404.00=20
     linux-2.5.43           60.00      75871      1264.51667
303484.00=20
     linux-2.5.44           60.00      75836      1263.93333
303344.00=20
37 mul_short          Thousand Short Integer Multiplies/second
     linux-2.4.19           60.00      61071      1017.85000
305355.00
     linux-2.4.20-pre11     60.00      61046      1017.43333
305230.00
=20
     linux-2.5.42           60.00      60482      1008.03333
302410.00=20
     linux-2.5.43           60.00      60513      1008.55000
302565.00=20
     linux-2.5.44           60.00      60509      1008.48333
302545.00=20
38 num_rtns_1         Numeric Functions/second
     linux-2.4.19           60.00      32914      548.56667
54856.67
     linux-2.4.20-pre11     60.00      32908      548.46667
54846.67
=20
     linux-2.5.42           60.00      32499      541.65000
54165.00=20
     linux-2.5.43           60.00      32545      542.41667
54241.67=20
     linux-2.5.44           60.00      32560      542.66667
54266.67=20
39 new_raph           Zeros Found/second
     linux-2.4.19           60.00      80647      1344.11667
268823.33
     linux-2.4.20-pre11     60.00      80642      1344.03333
268806.67
=20
     linux-2.5.42           60.00      79746      1329.10000
265820.00=20
     linux-2.5.43           60.00      79793      1329.88333
265976.67=20
     linux-2.5.44           60.00      79786      1329.76667
265953.33=20
40 trig_rtns          Trigonometric Functions/second
     linux-2.4.19           60.01       2191      36.51058
365105.82
     linux-2.4.20-pre11     60.00       2186      36.43333
364333.33
=20
     linux-2.5.42           60.03       2165      36.06530
360653.01=20
     linux-2.5.43           60.01       2161      36.01066
360106.65=20
     linux-2.5.44           60.02       2163      36.03799
360379.87=20
41 matrix_rtns        Point Transformations/second
     linux-2.4.19           60.00     352813 	  5880.21667
588021.67
     linux-2.4.20-pre11     60.00     352785 	  5879.75000
587975.00
=20
     linux-2.5.42           60.00     349037      5817.28333
581728.33=20
     linux-2.5.43           60.00     349069      5817.81667
581781.67=20
     linux-2.5.44           60.00     349097      5818.28333
581828.33=20
42 array_rtns         Linear Systems Solved/second
     linux-2.4.19           60.01        964      16.06399
321.28
     linux-2.4.20-pre11     60.03        970      16.15859
323.17
=20
     linux-2.5.42           60.05        906      15.08743
301.75=20
     linux-2.5.43           60.05        935      15.57036
311.41=20
     linux-2.5.44           60.03        925      15.40896
308.18=20
43 string_rtns        String Manipulations/second
     linux-2.4.19           60.02        860      14.32856
1432.86
     linux-2.4.20-pre11     60.00        860      14.33333
1433.33
=20
     linux-2.5.42           60.01        849      14.14764
1414.76=20
     linux-2.5.43           60.06        850      14.15251
1415.25=20
     linux-2.5.44           60.02        849      14.14528
1414.53=20
44 mem_rtns_1         Dynamic Memory Operations/second
     linux-2.4.19           60.02       1855      30.90636
927190.94
     linux-2.4.20-pre11     60.00       1001      16.68333
500500.00
=20
     linux-2.5.42           60.00       1711      28.51667
855500.00=20
     linux-2.5.43           60.03       1634      27.21972
816591.70=20
     linux-2.5.44           60.01       1630      27.16214
814864.19=20
45 mem_rtns_2         Block Memory Operations/second
     linux-2.4.19           60.00     132264      2204.40000
220440.00
     linux-2.4.20-pre11     60.00     131151      2185.85000
218585.00
=20
     linux-2.5.42           60.00     129708      2161.80000
216180.00=20
     linux-2.5.43           60.00     130807      2180.11667
218011.67=20
     linux-2.5.44           60.00     130784      2179.73333
217973.33=20
46 sort_rtns_1        Sort Operations/second
     linux-2.4.19           60.01       2444      40.72655
407.27
     linux-2.4.20-pre11     60.00       2451      40.85000
408.50
=20
     linux-2.5.42           60.00       2420      40.33333
403.33=20
     linux-2.5.43           60.02       2421      40.33655
403.37=20
     linux-2.5.44           60.01       2420      40.32661
403.27=20
47 misc_rtns_1        Auxiliary Loops/second
     linux-2.4.19           60.00      55007      916.78333
9167.83
     linux-2.4.20-pre11     60.00      54012      900.20000
9002.00
=20
     linux-2.5.42           60.00      26928      448.80000
4488.00=20
     linux-2.5.43           60.00      49128      818.80000
8188.00=20
     linux-2.5.44           60.00      27964      466.06667
4660.67=20
48 dir_rtns_1         Directory Operations/second
     linux-2.4.19           60.00      11243      187.38333
1873833.33
     linux-2.4.20-pre11     60.00      11806      196.76667
1967666.67
=20
     linux-2.5.42           60.01      11217      186.91885
1869188.47=20
     linux-2.5.43           60.01      11272      187.83536
1878353.61=20
     linux-2.5.44           60.00      11221      187.01667
1870166.67=20
49 shell_rtns_1       Shell Scripts/second
     linux-2.4.19           60.00       3682      61.36667
61.37
     linux-2.4.20-pre11     60.01       3663      61.03983
61.04
=20
     linux-2.5.42           60.00       2365      39.41667
39.42=20
     linux-2.5.43           60.02       3012      50.18327
50.18=20
     linux-2.5.44           60.01       2385      39.74338
39.74=20
50 shell_rtns_2       Shell Scripts/second
     linux-2.4.19           60.01       3698      61.62306
61.62
     linux-2.4.20-pre11     60.00       3669      61.15000
61.15
=20
     linux-2.5.42           60.02       2370      39.48684
39.49=20
     linux-2.5.43           60.00       3018      50.30000
50.30=20
     linux-2.5.44           60.01       2389      39.81003
39.81=20
51 shell_rtns_3       Shell Scripts/second
     linux-2.4.19           60.01       3699      61.63973
61.64
     linux-2.4.20-pre11     60.01       3661      61.00650
61.01
=20
     linux-2.5.42           60.01       2369      39.47675
39.48=20
     linux-2.5.43           60.01       3020      50.32495
50.32=20
     linux-2.5.44           60.01       2392      39.86002
39.86=20
52 series_1           Series Evaluations/second
     linux-2.4.19           60.00    1477863      24631.05000
2463105.00
     linux-2.4.20-pre11     60.00    1477824      24630.40000
2463040.00
=20
     linux-2.5.42           60.00    1451202      24186.70000
2418670.00=20
     linux-2.5.43           60.00    1461605      24360.08333
2436008.33=20
     linux-2.5.44           60.00    1462285      24371.41667
2437141.67=20
53 shared_memory      Shared Memory Operations/second
     linux-2.4.19           60.00     173486      2891.43333
289143.33
     linux-2.4.20-pre11     60.00     173040      2884.00000
288400.00
=20
     linux-2.5.42           60.00     155967      2599.45000
259945.00=20
     linux-2.5.43           60.00     157403      2623.38333
262338.33=20
     linux-2.5.44           60.00     155154      2585.90000
258590.00=20
54 tcp_test           TCP/IP Messages/second
     linux-2.4.19           60.01      37209      620.04666
55804.20
     linux-2.4.20-pre11     60.00      36835      613.91667
55252.50
=20
     linux-2.5.42           60.00      9464       157.73333
14196.00=20
     linux-2.5.43           60.00      33309      555.15000
49963.50
     linux-2.5.44           60.00       9368      156.13333
14052.00=20
55 udp_test           UDP/IP DataGrams/second
     linux-2.4.19           60.00      82627      1377.11667
137711.67
     linux-2.4.20-pre11     60.00      81395      1356.58333
135658.33
=20
     linux-2.5.42           60.00      40754      679.23333
67923.33=20
     linux-2.5.43           60.00      70115      1168.58333
116858.33=20
     linux-2.5.44           60.00      37371      622.85000
62285.00=20
56 fifo_test          FIFO Messages/second
     linux-2.4.19           60.00     105384      1756.40000
175640.00
     linux-2.4.20-pre11     60.00     101236      1687.26667
168726.67
=20
     linux-2.5.42           60.00      63072      1051.20000
105120.00=20
     linux-2.5.43           60.00      88938      1482.30000
148230.00=20
     linux-2.5.44           60.00      59981      999.68333
99968.33=20
57 stream_pipe        Stream Pipe Messages/second
     linux-2.4.19           60.00     150369      2506.15000
250615.00
     linux-2.4.20-pre11     60.00     142557      2375.95000
237595.00
=20
     linux-2.5.42           60.00      62691      1044.85000
104485.00=20
     linux-2.5.43           60.00     131940      2199.00000
219900.00=20
     linux-2.5.44           60.01      59991      999.68339
99968.34=20
58 dgram_pipe         DataGram Pipe Messages/second
     linux-2.4.19           60.00     146980      2449.66667
244966.67
     lin-2.4.20-pre11       60.00     135363      2256.05000
225605.00
=20
     linux-2.5.42           60.00     60900       1015.00000
101500.00
     linux-2.5.43           60.00     134458      2240.96667
224096.67=20
     linux-2.5.44           60.00     60964       1016.06667
101606.67=20
59 pipe_cpy           Pipe Messages/second
     linux-2.4.19           60.00     238452      3974.20000
397420.00
     linux-2.4.20-pre11     60.00     234660      3911.00000
391100.00
=20
     linux-2.5.42           60.00     194433      3240.55000
324055.00=20
     linux-2.5.43           60.00     203475      3391.25000
339125.00=20
     linux-2.5.44           60.00     187933      3132.21667
313221.67=20
60 ram_copy           Memory to Memory Copy/second
     linux-2.4.19           60.00    1509934      25165.56667
629642478.00
     linux-2.4.20-pre11     60.00    1510038      25167.30000
629685846.00
=20
     linux-2.5.42           60.00    1492908      24881.80000
622542636.00=20
     linux-2.5.43           60.00    1493331      24888.85000
622719027.00=20
     linux-2.5.44           60.00    1493589      24893.15000
622826613.00=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
PAVAN KUMAR REDDY N.S.
Sr.Software Engineer
Wipro Technologies
53/1, Hosur road, Madivala
Bangalore - 68.
pavan.kumar@wipro.com
Phone Off: +91-80-5502001-8 extn: 5086.
      Res: +91-80-6685179
http://www.wipro.com/linux/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =20

------=_NextPartTM-000-cee719f8-0bc9-4839-bb44-9896335aeb15
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

------=_NextPartTM-000-cee719f8-0bc9-4839-bb44-9896335aeb15--
