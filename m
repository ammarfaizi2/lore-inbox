Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261518AbSLYX3z>; Wed, 25 Dec 2002 18:29:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261523AbSLYX3z>; Wed, 25 Dec 2002 18:29:55 -0500
Received: from c16688.thoms1.vic.optusnet.com.au ([210.49.244.54]:48785 "EHLO
	mail.kolivas.net") by vger.kernel.org with ESMTP id <S261518AbSLYX3w>;
	Wed, 25 Dec 2002 18:29:52 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Con Kolivas <conman@kolivas.net>
Reply-To: conman@kolivas.net
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] 2.5.53 with contest
Date: Thu, 26 Dec 2002 10:37:45 +1100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200212261038.04015.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Here are some contest results using osdl hardware:

Uniprocessor:
noload:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.49 [5]              70.0    96      0       0       1.05
2.5.50 [5]              69.9    96      0       0       1.05
2.5.51 [2]              69.8    96      0       0       1.05
2.5.52 [3]              70.2    96      0       0       1.05
2.5.53 [7]              70.1    96      0       0       1.05

cacherun:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.49 [5]              67.4    99      0       0       1.01
2.5.50 [5]              67.3    99      0       0       1.01
2.5.51 [2]              67.2    99      0       0       1.01
2.5.52 [3]              67.5    99      0       0       1.01
2.5.53 [7]              67.6    99      0       0       1.01

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.49 [5]              85.2    79      17      20      1.28
2.5.50 [5]              84.8    79      17      19      1.27
2.5.51 [2]              85.2    79      17      20      1.28
2.5.52 [3]              84.4    79      17      19      1.26
2.5.53 [7]              86.9    77      18      21      1.30

ctar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.49 [5]              106.1   82      2       9       1.59
2.5.50 [5]              107.5   81      3       9       1.61
2.5.51 [7]              107.0   81      3       9       1.60
2.5.52 [3]              109.8   81      2       8       1.64
2.5.53 [7]              107.4   81      3       9       1.61

xtar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.49 [5]              184.8   70      3       8       2.77
2.5.50 [5]              189.5   61      4       9       2.84
2.5.51 [7]              163.7   67      3       8       2.45
2.5.52 [3]              161.4   69      3       8       2.42
2.5.53 [7]              151.0   69      3       8       2.26

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.49 [5]              127.4   57      14      13      1.91
2.5.50 [5]              142.6   54      19      14      2.14
2.5.51 [7]              125.6   58      14      12      1.88
2.5.52 [7]              120.9   60      13      12      1.81
2.5.53 [7]              113.9   63      12      12      1.71

io_other:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.49 [5]              97.4    75      7       11      1.46
2.5.50 [5]              106.9   69      10      11      1.60
2.5.51 [7]              105.1   69      9       11      1.57
2.5.52 [7]              94.9    76      7       10      1.42
2.5.53 [7]              99.5    73      8       10      1.49

read_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.49 [5]              88.2    80      15      6       1.32
2.5.50 [5]              88.5    80      15      7       1.33
2.5.51 [2]              88.4    80      15      7       1.32
2.5.52 [3]              88.1    80      15      7       1.32
2.5.53 [7]              88.2    80      15      6       1.32

list_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.49 [5]              81.4    85      0       8       1.22
2.5.50 [5]              81.2    85      0       8       1.22
2.5.51 [2]              80.8    85      0       8       1.21
2.5.52 [3]              81.0    86      0       9       1.21
2.5.53 [7]              81.5    85      0       9       1.22

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.49 [5]              98.1    76      43      2       1.47
2.5.50 [5]              98.3    76      44      2       1.47
2.5.51 [7]              99.3    76      45      2       1.49
2.5.52 [3]              100.0   78      45      2       1.50
2.5.53 [7]              98.7    80      44      2       1.48

Faster compile times in io_load and xtar_load compared to 2.5.52


SMP:
noload:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.49 [6]              39.3    181     0       0       1.09
2.5.50 [5]              39.3    180     0       0       1.09
2.5.51 [3]              39.6    180     0       0       1.09
2.5.52 [7]              39.3    181     0       0       1.09
2.5.53 [7]              39.4    181     0       0       1.09

cacherun:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.49 [6]              36.6    194     0       0       1.01
2.5.50 [5]              36.5    194     0       0       1.01
2.5.51 [3]              36.5    195     0       0       1.01
2.5.52 [7]              36.5    194     0       0       1.01
2.5.53 [7]              36.6    194     0       0       1.01

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.49 [6]              50.0    141     11      52      1.38
2.5.50 [5]              47.8    148     10      46      1.32
2.5.51 [3]              50.5    139     12      54      1.39
2.5.52 [7]              48.7    144     10      49      1.34
2.5.53 [7]              47.4    149     9       44      1.31

ctar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
1d3 [1]                 57.3    164     1       10      1.58
2.5.49 [5]              53.8    161     1       10      1.49
2.5.50 [5]              54.6    157     1       10      1.51
2.5.51 [7]              58.2    158     1       10      1.61
2.5.52 [7]              56.1    161     1       10      1.55
2.5.53 [7]              56.2    159     1       10      1.55

xtar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.49 [5]              72.9    132     1       10      2.01
2.5.50 [5]              116.2   103     2       10      3.21
2.5.51 [7]              104.8   124     2       10      2.89
2.5.52 [7]              83.1    138     1       9       2.29
2.5.53 [7]              82.9    129     1       9       2.29

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.49 [5]              75.5    110     9       18      2.09
2.5.50 [5]              87.6    102     14      22      2.42
2.5.51 [7]              84.6    102     13      21      2.34
2.5.52 [7]              73.1    111     10      19      2.02
2.5.53 [7]              80.0    104     12      21      2.21

io_other:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.49 [5]              64.2    130     8       19      1.77
2.5.50 [5]              59.3    139     7       18      1.64
2.5.51 [7]              64.5    134     7       18      1.78
2.5.52 [7]              75.1    120     10      21      2.07
2.5.53 [7]              73.6    123     10      21      2.03

read_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.49 [5]              49.1    152     5       7       1.36
2.5.50 [5]              49.3    151     5       7       1.36
2.5.51 [3]              48.5    154     5       7       1.34
2.5.52 [7]              49.4    151     5       7       1.36
2.5.53 [7]              50.7    151     5       7       1.40

list_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.49 [5]              43.4    167     0       8       1.20
2.5.50 [5]              43.4    167     0       8       1.20
2.5.51 [3]              43.5    167     0       8       1.20
2.5.52 [7]              43.2    167     0       9       1.19
2.5.53 [7]              43.7    166     0       9       1.21

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.49 [5]              62.5    145     35      3       1.73
2.5.50 [5]              63.3    141     36      3       1.75
2.5.51 [7]              62.6    148     38      3       1.73
2.5.52 [7]              63.5    148     38      3       1.75
2.5.53 [7]              63.2    144     37      3       1.75

Small plus here, minus there, no major change in SMP results compared to 
2.5.52

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE+CkFOF6dfvkL3i1gRAhHTAKCDlP8wKV1VLgmBuKcZuSc4WdfU4ACeMbcp
CRNV51mhYF0NVYb5lxZVQBo=
=nxlk
-----END PGP SIGNATURE-----
