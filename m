Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266761AbSLJLfN>; Tue, 10 Dec 2002 06:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266763AbSLJLfM>; Tue, 10 Dec 2002 06:35:12 -0500
Received: from c17928.thoms1.vic.optusnet.com.au ([210.49.249.29]:35200 "EHLO
	laptop.localdomain") by vger.kernel.org with ESMTP
	id <S266761AbSLJLfJ> convert rfc822-to-8bit; Tue, 10 Dec 2002 06:35:09 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Con Kolivas <conman@kolivas.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] 2.5.51 with contest
Date: Tue, 10 Dec 2002 22:44:45 +1100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200212102245.19862.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Here are contest results (http://contest.kolivas.net) for 2.5.51 and related 
kerneles using the dedicated osdl (http://www.osdl.org) hardware. 

Uniprocessor:
noload:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.49 [5]              70.0    96      0       0       1.05
2.5.50 [5]              69.9    96      0       0       1.05
2.5.50-mm1 [5]          71.4    94      0       0       1.07
2.5.51 [2]              69.8    96      0       0       1.05

cacherun:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.49 [5]              67.4    99      0       0       1.01
2.5.50 [5]              67.3    99      0       0       1.01
2.5.50-mm1 [5]          67.8    99      0       0       1.02
2.5.51 [2]              67.2    99      0       0       1.01

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.49 [5]              85.2    79      17      20      1.28
2.5.50 [5]              84.8    79      17      19      1.27
2.5.50-mm1 [5]          86.6    78      18      20      1.30
2.5.51 [2]              85.2    79      17      20      1.28

dbench_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.49 [5]              210.5   37      2       50      3.15
2.5.50 [5]              189.2   40      2       49      2.83
2.5.50-mm1 [5]          243.3   34      2       51      3.64
2.5.51 [12]             195.8   39      2       50      2.93

ctar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.49 [5]              106.1   82      2       9       1.59
2.5.50 [5]              107.5   81      3       9       1.61
2.5.50-mm1 [5]          88.0    83      1       4       1.32
2.5.51 [7]              107.0   81      3       9       1.60

xtar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.49 [5]              184.8   70      3       8       2.77
2.5.50 [5]              189.5   61      4       9       2.84
2.5.50-mm1 [5]          104.9   70      1       6       1.57
2.5.51 [7]              163.7   67      3       8       2.45

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.49 [5]              127.4   57      14      13      1.91
2.5.50 [5]              142.6   54      19      14      2.14
2.5.50-mm1 [5]          174.2   46      24      15      2.61
2.5.51 [7]              125.6   58      14      12      1.88

io_other:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.49 [5]              97.4    75      7       11      1.46
2.5.50 [5]              106.9   69      10      11      1.60
2.5.50-mm1 [5]          101.8   70      9       11      1.52
2.5.51 [7]              105.1   69      9       11      1.57

read_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.49 [5]              88.2    80      15      6       1.32
2.5.50 [5]              88.5    80      15      7       1.33
2.5.50-mm1 [5]          86.6    80      3       2       1.30
2.5.51 [2]              88.4    80      15      7       1.32

list_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.49 [5]              81.4    85      0       8       1.22
2.5.50 [5]              81.2    85      0       8       1.22
2.5.50-mm1 [5]          82.4    84      0       7       1.23
2.5.51 [2]              80.8    85      0       8       1.21

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.49 [5]              98.1    76      43      2       1.47
2.5.50 [5]              98.3    76      44      2       1.47
2.5.50-mm1 [5]          116.9   67      47      1       1.75
2.5.51 [7]              99.3    76      45      2       1.49

A little shorter compile times under io load and xtar load.


SMP:
noload:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.49 [6]              39.3    181     0       0       1.09
2.5.50 [5]              39.3    180     0       0       1.09
2.5.50-mm1 [6]          39.4    181     0       0       1.09
2.5.51 [3]              39.6    180     0       0       1.09

cacherun:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.49 [6]              36.6    194     0       0       1.01
2.5.50 [5]              36.5    194     0       0       1.01
2.5.50-mm1 [6]          36.6    194     0       0       1.01
2.5.51 [3]              36.5    195     0       0       1.01

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.49 [6]              50.0    141     11      52      1.38
2.5.50 [5]              47.8    148     10      46      1.32
2.5.50-mm1 [5]          47.6    150     8       43      1.31
2.5.51 [3]              50.5    139     12      54      1.39

dbench_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.49 [5]              119.8   96      0       26      3.31
2.5.50 [5]              199.8   101     0       24      5.52
2.5.50-mm1 [5]          164.3   67      0       29      4.54
2.5.51 [7]              57.9    144     0       27      1.60

ctar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.49 [5]              53.8    161     1       10      1.49
2.5.50 [5]              54.6    157     1       10      1.51
2.5.50-mm1 [5]          51.3    155     0       4       1.42
2.5.51 [7]              58.2    158     1       10      1.61

xtar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.49 [5]              72.9    132     1       10      2.01
2.5.50 [5]              116.2   103     2       10      3.21
2.5.50-mm1 [5]          83.9    111     1       9       2.32
2.5.51 [7]              104.8   124     2       10      2.89

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.49 [5]              75.5    110     9       18      2.09
2.5.50 [5]              87.6    102     14      22      2.42
2.5.50-mm1 [5]          99.0    92      14      21      2.73
2.5.51 [7]              84.6    102     13      21      2.34

io_other:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.49 [5]              64.2    130     8       19      1.77
2.5.50 [5]              59.3    139     7       18      1.64
2.5.50-mm1 [5]          70.5    125     10      22      1.95
2.5.51 [7]              64.5    134     7       18      1.78

read_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.49 [5]              49.1    152     5       7       1.36
2.5.50 [5]              49.3    151     5       7       1.36
2.5.50-mm1 [5]          52.1    142     2       3       1.44
2.5.51 [3]              48.5    154     5       7       1.34

list_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.49 [5]              43.4    167     0       8       1.20
2.5.50 [5]              43.4    167     0       8       1.20
2.5.50-mm1 [5]          44.0    167     0       7       1.22
2.5.51 [3]              43.5    167     0       8       1.20

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.49 [5]              62.5    145     35      3       1.73
2.5.50 [5]              63.3    141     36      3       1.75
2.5.50-mm1 [5]          67.1    126     39      3       1.85
2.5.51 [7]              62.6    148     38      3       1.73

The big difference in dbench_load in the SMP run is unusual but probably not 
as significant as it appears. This load seems to occasionally create 
pathological runs (probably the nature of running dbench as a load) and less 
pathological runs occured in 2.5.51.

Overall the difference b/w 2.5.50 and 2.5.51 is small

Full hardware details and log runs can be found when the web server syncs up 
at :
http://www.osdl.org/projects/ctdevel/results/

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE99dOwF6dfvkL3i1gRAkPYAKCVDe5hR7DS5sxG0va8ORTL/zAbRACeKrFi
32Klz15x4YrENT7dyMXJUsM=
=Zdjj
-----END PGP SIGNATURE-----
