Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266356AbSKGEGD>; Wed, 6 Nov 2002 23:06:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266357AbSKGEGD>; Wed, 6 Nov 2002 23:06:03 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:22457 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S266356AbSKGEGB>; Wed, 6 Nov 2002 23:06:01 -0500
Message-ID: <057d01c28613$e5d976d0$7609720a@M3104487>
Reply-To: "Siva Koti Reddy" <siva.kotireddy@wipro.com>
From: "Siva Koti Reddy" <siva.kotireddy@wipro.com>
To: "lkml" <linux-kernel@vger.kernel.org>
Cc: "Linux Coe" <lin_coe@wipro.com>,
       <wipro-linuxcoe-request@sourceforge.wipro.com>
Subject: [BENCHMARK] tiobenchmark resulta of various kernels.
Date: Thu, 7 Nov 2002 09:42:33 +0530
Organization: wipro
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPartTM-000-46ac6a2a-0a48-4e39-97dd-a122586168e9"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
X-OriginalArrivalTime: 07 Nov 2002 04:12:32.0083 (UTC) FILETIME=[E4CB6230:01C28613]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

------=_NextPartTM-000-46ac6a2a-0a48-4e39-97dd-a122586168e9
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Unit information
================
File size = megabytes
Blk Size  = bytes
Rate      = megabytes per second
CPU%      = percentage of CPU used during the test
Latency   = milliseconds
Lat%      = percent of requests that took longer than X seconds
CPU Eff   = Rate divided by CPU% - throughput per cpu load

Sequential Reads
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.44                        256   4096    1   26.52 12.14%     0.439       96.07   0.00000  0.00000   218
2.5.45                        256   4096    1   19.14 9.763%     0.609      207.96   0.00000  0.00000   196
2.5.46                        256   4096    1   24.05 12.56%     0.484      152.53   0.00000  0.00000   191

2.5.44                        256   4096    2   10.55 4.997%     2.203      462.03   0.00000  0.00000   211
2.5.45                        256   4096    2    9.42 5.016%     2.482     1123.82   0.00000  0.00000   188
2.5.46                        256   4096    2    8.64 4.772%     2.704     1051.54   0.00000  0.00000   181

2.5.44                        256   4096    4    8.52 4.103%     5.405      637.86   0.00000  0.00000   208
2.5.45                        256   4096    4    8.85 4.715%     5.238     1166.98   0.00000  0.00000   188
2.5.46                        256   4096    4    8.60 4.653%     5.368     1544.86   0.00000  0.00000   185

2.5.44                        256   4096    8    8.99 4.277%    10.152     1049.74   0.00000  0.00000   210
2.5.45                        256   4096    8    8.55 4.907%    10.698     1387.93   0.00000  0.00000   174
2.5.46                        256   4096    8    8.66 4.749%    10.563     1610.22   0.00000  0.00000   182

Random Reads
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.44                        256   4096    1    0.41 0.486%    28.234      207.38   0.00000  0.00000    85
2.5.45                        256   4096    1    0.37 0.513%    31.326      167.34   0.00000  0.00000    73
2.5.46                        256   4096    1    0.37 0.493%    31.662      210.06   0.00000  0.00000    75

2.5.44                        256   4096    2    0.41 0.386%    55.780      264.47   0.00000  0.00000   107
2.5.45                        256   4096    2    0.38 0.411%    60.792      299.28   0.00000  0.00000    93
2.5.46                        256   4096    2    0.38 0.438%    61.786      269.67   0.00000  0.00000    86

2.5.44                        256   4096    4    0.43 0.423%   104.585      525.61   0.00000  0.00000   101
2.5.45                        256   4096    4    0.40 0.466%   115.030      510.12   0.00000  0.00000    86
2.5.46                        256   4096    4    0.38 0.450%   118.814      595.94   0.00000  0.00000    84

2.5.44                        256   4096    8    0.49 0.573%   178.352      720.89   0.00000  0.00000    86
2.5.45                        256   4096    8    0.43 0.719%   200.146      787.62   0.00000  0.00000    60
2.5.46                        256   4096    8    0.42 0.600%   211.034      866.61   0.00000  0.00000    70


Sequential Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.44                        256   4096    1   23.61 38.17%     0.388     3259.07   0.00000  0.00000    62
2.5.45                        256   4096    1   21.48 38.70%     0.458     3220.72   0.00000  0.00000    55
2.5.46                        256   4096    1   21.38 38.59%     0.461     3468.41   0.00000  0.00000    55

2.5.44                        256   4096    2   20.12 33.37%     0.958     5121.31   0.00153  0.00000    60
2.5.45                        256   4096    2   20.13 37.16%     0.944     4811.59   0.00153  0.00000    54
2.5.46                        256   4096    2   21.41 38.57%     0.905     3707.53   0.00000  0.00000    55

2.5.44                        256   4096    4   19.63 33.25%     1.590     6844.90   0.00763  0.00000    59
2.5.45                        256   4096    4   18.45 34.18%     1.860    11060.52   0.01069  0.00000    54
2.5.46                        256   4096    4   19.78 36.14%     1.758     7390.83   0.01221  0.00000    55

2.5.44                        256   4096    8   19.47 33.65%     3.081    13874.48   0.03052  0.00000    58
2.5.45                        256   4096    8   18.29 34.20%     3.180    15179.59   0.04577  0.00000    53
2.5.46                        256   4096    8   19.47 35.92%     3.153    15959.89   0.03815  0.00000    54

Random Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.44                        256   4096    1    0.78 0.986%     0.302      724.22   0.00000  0.00000    79
2.5.45                        256   4096    1    0.76 1.052%     0.633     2000.79   0.00000  0.00000    73
2.5.46                        256   4096    1    0.74 0.998%     0.824     1827.75   0.00000  0.00000    74

2.5.44                        256   4096    2    0.79 1.041%     1.037     2746.68   0.00000  0.00000    75
2.5.45                        256   4096    2    0.69 0.983%     1.002     2793.57   0.00000  0.00000    70
2.5.46                        256   4096    2    0.76 1.062%     0.665     1842.03   0.00000  0.00000    72

2.5.44                        256   4096    4    0.79 0.968%     0.578     1778.13   0.00000  0.00000    81
2.5.45                        256   4096    4    0.78 1.084%     2.965     6066.62   0.05000  0.00000    72
2.5.46                        256   4096    4    0.75 1.005%    10.012     5841.44   0.10000  0.00000    74

2.5.44                        256   4096    8    0.80 1.057%     4.654     8948.62   0.12500  0.00000    76
2.5.45                        256   4096    8    0.78 1.081%     4.005     7120.35   0.07500  0.00000    72
2.5.46                        256   4096    8    0.79 1.097%     7.722    10560.47   0.20000  0.00000    72



Rgds
Siva


------=_NextPartTM-000-46ac6a2a-0a48-4e39-97dd-a122586168e9
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

------=_NextPartTM-000-46ac6a2a-0a48-4e39-97dd-a122586168e9--
