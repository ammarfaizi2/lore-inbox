Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266200AbTAQCof>; Thu, 16 Jan 2003 21:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267106AbTAQCof>; Thu, 16 Jan 2003 21:44:35 -0500
Received: from mail005.syd.optusnet.com.au ([210.49.20.136]:13973 "EHLO
	mail005.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S266200AbTAQCoe> convert rfc822-to-8bit; Thu, 16 Jan 2003 21:44:34 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Con Kolivas <conman@kolivas.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] 2.4.{19,20,20-ac2} with contest
Date: Fri, 17 Jan 2003 13:53:14 +1100
User-Agent: KMail/1.4.3
Cc: Nick Piggin <piggin@cyberone.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200301171353.23254.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Here's a set of contest benchmarks with the new version of contest for 2.4.x 
including 2.4.20-ac2:

no_load:
Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
2.4.19          3       76      96.1    0       0.0     1.00
2.4.20          3       77      94.8    0       0.0     1.00
2.4.20-ac2      2       76      96.1    0       0.0     1.00
2.5.58          2       79      96.2    0       0.0     1.00
2.5.58-mm1      4       79      96.2    0       0.0     1.00
cacherun:
Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
2.4.19          3       74      100.0   0       0.0     0.97
2.4.20          3       74      98.6    0       0.0     0.96
2.4.20-ac2      2       74      98.6    0       0.0     0.97
2.5.58          2       76      100.0   0       0.0     0.96
2.5.58-mm1      4       77      97.4    0       0.0     0.97
process_load:
Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
2.4.19          3       122     56.6    102     41.0    1.61
2.4.20          5       123     56.9    103     39.8    1.60
2.4.20-ac2      2       103     70.9    66      26.2    1.36
2.5.58          2       92      81.5    27      15.2    1.16
2.5.58-mm1      3       94      80.9    29      16.0    1.19
ctar_load:
Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
2.4.19          3       96      81.2    1       4.2     1.26
2.4.20          3       97      81.4    1       4.1     1.26
2.4.20-ac2      4       108     71.3    1       5.6     1.42
2.5.58          3       117     82.1    1       6.0     1.48
2.5.58-mm1      3       109     81.7    1       4.6     1.38
xtar_load:
Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
2.4.19          3       107     71.0    1       4.7     1.41
2.4.20          3       116     66.4    2       6.0     1.51
2.4.20-ac2      4       121     63.6    1       6.6     1.59
2.5.58          3       122     80.3    1       6.6     1.54
2.5.58-mm1      3       121     76.0    1       6.6     1.53
io_load:
Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
2.4.19          3       286     26.6    23      15.3    3.76
2.4.20          3       219     34.2    17      16.0    2.84
2.4.20-ac2      4       240     30.8    17      15.0    3.16
2.5.58          3       153     54.9    8       14.3    1.94
2.5.58-mm1      6       156     51.3    9       14.7    1.97
read_load:
Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
2.4.19          3       133     58.6    9       5.3     1.75
2.4.20          5       120     64.2    32      9.2     1.56
2.4.20-ac2      2       131     59.5    10      6.9     1.72
2.5.58          3       96      82.3    9       5.2     1.22
2.5.58-mm1      3       100     81.0    6       6.0     1.27
list_load:
Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
2.4.19          3       88      86.4    0       5.7     1.16
2.4.20          3       88      85.2    0       8.0     1.14
2.4.20-ac2      1       89      84.3    0       7.9     1.17
2.5.58          3       91      85.7    0       8.8     1.15
2.5.58-mm1      2       92      83.7    0       9.8     1.16
mem_load:
Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
2.4.19          3       96      78.1    43      1.0     1.26
2.4.20          3       95      80.0    45      1.1     1.23
2.4.20-ac2      3       101     77.2    91      4.0     1.33
2.5.58          3       107     73.8    66      1.9     1.35
2.5.58-mm1      3       104     75.0    50      1.0     1.32
dbench_load:
Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
2.4.19          3       149     49.0    7       38.3    1.96
2.4.20          3       148     49.3    7       38.5    1.92
2.4.20-ac2      3       111     67.6    3       23.4    1.46
2.5.58          3       122     64.8    3       24.6    1.54
2.5.58-mm1      3       118     66.9    3       22.0    1.49

The different scheduler in ac2 shows up in process_load. The ide changes 
appear to make io loads tend towards 2.5 results in places. ac2 is also prone 
to the same out of memory unable to fork problem immediately after io_load 
which goes away if overcommit is enabled.

* Note to those who are not aware this is an issue and using contest: *
Unfortunately by running make oldconfig && dep again I've changed the fs 
layout and will need to start with a new baseline from this point on. The 
number of page faults changes after this is done and kernel compilation takes 
a different length of time. Normally the number of page faults between runs 
is very close. And yes this does make a significant difference to the 
results. 

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE+J3AaF6dfvkL3i1gRApwYAJ9AyYtgyAbzpbE2rviKOuQUAvOYKQCffgp0
8osik5cj300BDMLnj+lTwrU=
=xKSy
-----END PGP SIGNATURE-----
