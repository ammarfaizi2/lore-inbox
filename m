Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266038AbTAPKFX>; Thu, 16 Jan 2003 05:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266078AbTAPKFW>; Thu, 16 Jan 2003 05:05:22 -0500
Received: from c16688.thoms1.vic.optusnet.com.au ([210.49.244.54]:16841 "EHLO
	mail.kolivas.net") by vger.kernel.org with ESMTP id <S266038AbTAPKFU> convert rfc822-to-8bit;
	Thu, 16 Jan 2003 05:05:20 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Con Kolivas <conman@kolivas.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] 2.5.5{4,5,6,7,8} with contest 
Date: Thu, 16 Jan 2003 21:14:04 +1100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200301162114.12467.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Here are a set of contest (http://contest.kolivas.net) benchmarks using the 
osdl (http://www.osdl.org) hardware with the complete rewrite of contest 
(v0.61pre):

The only change in the format is that the ratio is now the ratio vs the 
no_load value for that kernel. All of these are new results as the old values 
are no longer valid with the new version.

no_load:
Kernel [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.54      2   79      94.9    0       0.0     1.00
2.5.55      2   78      96.2    0       0.0     1.00
2.5.56      3   79      96.2    0       0.0     1.00
2.5.57      3   79      96.2    0       0.0     1.00
2.5.58      2   79      96.2    0       0.0     1.00
cacherun:
Kernel [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.54      2   76      98.7    0       0.0     0.96
2.5.55      2   76      98.7    0       0.0     0.97
2.5.56      3   76      100.0   0       0.0     0.96
2.5.57      3   76      100.0   0       0.0     0.96
2.5.58      2   76      100.0   0       0.0     0.96
process_load:
Kernel [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.54      2   93      81.7    29      17.2    1.18
2.5.55      2   94      79.8    30      17.0    1.21
2.5.56      3   93      80.6    29      16.1    1.18
2.5.57      3   93      81.7    28      16.1    1.18
2.5.58      2   92      81.5    27      15.2    1.16
ctar_load:
Kernel [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.54      3   133     83.5    1       3.8     1.68
2.5.55      3   133     78.9    1       3.8     1.71
2.5.56      3   152     75.7    1       4.6     1.92
2.5.57      3   132     79.5    1       3.8     1.67
2.5.58      3   117     82.1    1       6.0     1.48
xtar_load:
Kernel [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.54      3   104     80.8    1       4.8     1.32
2.5.55      3   113     79.6    1       6.2     1.45
2.5.56      3   111     78.4    1       6.3     1.41
2.5.57      3   107     80.4    1       5.6     1.35
2.5.58      3   122     80.3    1       6.6     1.54
io_load:
Kernel [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.54      3   126     61.9    6       11.8    1.59
2.5.55      3   126     63.5    6       12.7    1.62
2.5.56      3   131     59.5    7       13.0    1.66
2.5.57      5   124     64.5    5       11.3    1.57
2.5.58      3   153     54.9    8       14.3    1.94
read_load:
Kernel [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.54      3   95      82.1    9       5.3     1.20
2.5.55      3   95      82.1    9       5.3     1.22
2.5.56      3   99      80.8    6       6.1     1.25
2.5.57      3   100     80.0    6       7.0     1.27
2.5.58      3   96      82.3    9       5.2     1.22
list_load:
Kernel [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.54      3   91      84.6    0       8.8     1.15
2.5.55      3   91      84.6    0       8.8     1.17
2.5.56      3   91      84.6    0       8.8     1.15
2.5.57      3   91      84.6    0       8.8     1.15
2.5.58      3   91      85.7    0       8.8     1.15
mem_load:
Kernel [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.54      3   107     76.6    47      0.9     1.35
2.5.55      3   116     73.3    66      1.7     1.49
2.5.56      3   107     80.4    45      0.9     1.35
2.5.57      3   110     80.0    47      0.9     1.39
2.5.58      3   107     73.8    66      1.9     1.35
dbench_load:
Kernel [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.54      3   118     66.1    3       24.6    1.49
2.5.55      3   117     68.4    2       16.2    1.50
2.5.56      3   89      60.7    4       24.7    1.13
2.5.57      4   96      64.6    2       20.7    1.22
2.5.58      3   122     64.8    3       24.6    1.54

A full set of archived results and hardware specs can be found here:
http://www.osdl.org/projects/ctdevel/results/

This is a good time to repeat the bug report that looked like spam last time I 
posted it (sorry my mailer seemed to bork):

Since moving contest to c I get an error trying to fork with all 2.5 kernels I 
try after running it on the 6th load. The error does not occur with any 2.4 
kernels. I have confirmed it is still present on 2.5.58.

To reproduce the problem:
Run the latest version of contest without arguments (0.61pre) and after
no_load,cacherun,process_load,ctar_load,xtar_load and io_load it bombs out 
with:
bmark.c:43: SYSTEM ERROR: Cannot allocate memory : fork error

It seems to occur only after a few loads followed by io_load.

This is not an application error and does not occur with 2.4.x kernels. It
happens every time and with all 2.5 kernels I have tried. I can start contest
again without problems after each error and eventually will run into the same 
error.

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE+JoXvF6dfvkL3i1gRAtvyAJ9eRxKkc6vZO2tVjKFyWTnGlOPXKwCgnFXf
4vzAV6EWX0rg1fcZEucuvxk=
=BAuy
-----END PGP SIGNATURE-----
