Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267068AbTAPNPI>; Thu, 16 Jan 2003 08:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267070AbTAPNPI>; Thu, 16 Jan 2003 08:15:08 -0500
Received: from c16688.thoms1.vic.optusnet.com.au ([210.49.244.54]:57547 "EHLO
	mail.kolivas.net") by vger.kernel.org with ESMTP id <S267068AbTAPNPH> convert rfc822-to-8bit;
	Thu, 16 Jan 2003 08:15:07 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Con Kolivas <conman@kolivas.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] 2.5.58-mm1 with contest
Date: Fri, 17 Jan 2003 00:23:42 +1100
User-Agent: KMail/1.4.3
Cc: Andrew Morton <akpm@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200301170024.00143.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Contest (0.61pre) benchmark results for 2.5.58-mm1

no_load:
Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
2.5.55          2       78      96.2    0       0.0     1.00
2.5.56          3       79      96.2    0       0.0     1.00
2.5.57          3       79      96.2    0       0.0     1.00
2.5.58          2       79      96.2    0       0.0     1.00
2.5.58-mm1      4       79      96.2    0       0.0     1.00
cacherun:
Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
2.5.55          2       76      98.7    0       0.0     0.97
2.5.56          3       76      100.0   0       0.0     0.96
2.5.57          3       76      100.0   0       0.0     0.96
2.5.58          2       76      100.0   0       0.0     0.96
2.5.58-mm1      4       77      97.4    0       0.0     0.97
process_load:
Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
2.5.55          2       94      79.8    30      17.0    1.21
2.5.56          3       93      80.6    29      16.1    1.18
2.5.57          3       93      81.7    28      16.1    1.18
2.5.58          2       92      81.5    27      15.2    1.16
2.5.58-mm1      3       94      80.9    29      16.0    1.19
ctar_load:
Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
2.5.55          3       133     78.9    1       3.8     1.71
2.5.56          3       152     75.7    1       4.6     1.92
2.5.57          3       132     79.5    1       3.8     1.67
2.5.58          3       117     82.1    1       6.0     1.48
2.5.58-mm1      3       109     81.7    1       4.6     1.38
xtar_load:
Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
2.5.55          3       113     79.6    1       6.2     1.45
2.5.56          3       111     78.4    1       6.3     1.41
2.5.57          3       107     80.4    1       5.6     1.35
2.5.58          3       122     80.3    1       6.6     1.54
2.5.58-mm1      3       121     76.0    1       6.6     1.53
io_load:
Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
2.5.55          3       126     63.5    6       12.7    1.62
2.5.56          3       131     59.5    7       13.0    1.66
2.5.57          5       124     64.5    5       11.3    1.57
2.5.58          3       153     54.9    8       14.3    1.94
2.5.58-mm1      6       156     51.3    9       14.7    1.97
read_load:
Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
2.5.55          3       95      82.1    9       5.3     1.22
2.5.56          3       99      80.8    6       6.1     1.25
2.5.57          3       100     80.0    6       7.0     1.27
2.5.58          3       96      82.3    9       5.2     1.22
2.5.58-mm1      4       96      83.3    176189  6.2     1.22
list_load:
Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
2.5.55          3       91      84.6    0       8.8     1.17
2.5.56          3       91      84.6    0       8.8     1.15
2.5.57          3       91      84.6    0       8.8     1.15
2.5.58          3       91      85.7    0       8.8     1.15
2.5.58-mm1      2       92      83.7    0       9.8     1.16
mem_load:
Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
2.5.55          3       116     73.3    66      1.7     1.49
2.5.56          3       107     80.4    45      0.9     1.35
2.5.57          3       110     80.0    47      0.9     1.39
2.5.58          3       107     73.8    66      1.9     1.35
2.5.58-mm1      3       104     75.0    50      1.0     1.32
dbench_load:
Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
2.5.55          3       117     68.4    2       16.2    1.50
2.5.56          2       124     62.9    3       25.8    1.57
2.5.57          3       121     64.5    3       22.3    1.53
2.5.58          3       122     64.8    3       24.6    1.54
2.5.58-mm1      3       118     66.9    3       22.0    1.49

Only statistically significant diff b/w 2.5.58 and 2.5.58-mm1 is in ctar_load 
which is faster in mm1. Trend towards being faster in mem_load.

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE+JrJhF6dfvkL3i1gRAjIzAKCX+TSDCaxs4p0tiodvSSsj4UZUsACfaXYS
qaQGJkgJ3SBFVPsQSLFU1AQ=
=JbRZ
-----END PGP SIGNATURE-----
