Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267700AbSLGCNF>; Fri, 6 Dec 2002 21:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267701AbSLGCNE>; Fri, 6 Dec 2002 21:13:04 -0500
Received: from c17928.thoms1.vic.optusnet.com.au ([210.49.249.29]:7808 "EHLO
	laptop.localdomain") by vger.kernel.org with ESMTP
	id <S267700AbSLGCM7> convert rfc822-to-8bit; Fri, 6 Dec 2002 21:12:59 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Con Kolivas <conman@kolivas.net>
Date: Sat, 7 Dec 2002 13:22:55 +1100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] 2.4.20-ck1 with contest
Message-Id: <200212071323.03153.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Here are contest (http://contest.kolivas.net) results for 2.4.20-ck1 
(http://kernel.kolivas.net). This is the default ck1 patchset with the -aavm 
and these include the optional low latency disk hack enabled:

Uniprocessor:
noload:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              67.2    97      0       0       1.01
2.4.20 [5]              67.3    97      0       0       1.01
2.4.20-ck1 [5]          66.2    98      0       0       0.99

cacherun:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              65.9    99      0       0       0.99
2.4.20 [5]              65.7    99      0       0       0.98
2.4.20-ck1 [5]          65.4    98      0       0       0.98

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              106.2   58      82      40      1.59
2.4.20 [5]              108.1   58      84      40      1.62
2.4.20-ck1 [5]          89.6    70      55      28      1.34

dbench_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              215.9   31      2       45      3.23
2.4.20 [5]              207.2   32      2       46      3.10
2.4.20-ck1 [5]          109.5   64      0       28      1.64

ctar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              85.6    81      2       8       1.28
2.4.20 [5]              85.4    83      2       9       1.28
2.4.20-ck1 [5]          82.5    84      2       8       1.24

xtar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              104.5   65      2       7       1.57
2.4.20 [5]              107.6   64      2       8       1.61
2.4.20-ck1 [5]          85.5    78      1       6       1.28

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              182.3   37      36      14      2.73
2.4.20 [5]              203.4   33      40      15      3.05
2.4.20-ck1 [5]          81.7    80      5       5       1.22

io_other:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              111.9   60      21      15      1.68
2.4.20 [5]              120.3   56      24      16      1.80
2.4.20-ck1 [4]          71.8    90      5       6       1.08

read_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              95.8    76      16      4       1.43
2.4.20 [5]              88.8    82      16      4       1.33
2.4.20-ck1 [4]          79.9    88      15      6       1.20

list_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              76.8    87      0       7       1.15
2.4.20 [5]              75.7    88      0       8       1.13
2.4.20-ck1 [4]          76.2    87      0       9       1.14

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              87.3    78      43      2       1.31
2.4.20 [5]              84.8    80      44      2       1.27
2.4.20-ck1 [4]          120.6   56      45      1       1.81


SMP:
noload:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              38.0    183     0       0       1.05
2.4.20 [5]              36.9    189     0       0       1.02
2.4.20-ck1 [2]          37.0    186     0       0       1.02

cacherun:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              35.9    193     0       0       0.99
2.4.20 [5]              35.8    194     0       0       0.99
2.4.20-ck1 [2]          35.5    194     0       0       0.98

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              49.8    140     20      57      1.38
2.4.20 [5]              51.0    138     20      59      1.41
2.4.20-ck1 [2]          46.3    146     19      52      1.28

dbench_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              159.4   45      0       40      4.40
2.4.20 [5]              144.8   49      0       38      4.00
2.4.20-ck1 [2]          72.9    96      0       19      2.01

ctar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              43.7    165     1       10      1.21
2.4.20 [5]              43.1    169     1       11      1.19
2.4.20-ck1 [2]          43.8    162     0       8       1.21

xtar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              49.2    144     1       10      1.36
2.4.20 [5]              63.5    114     1       12      1.75
2.4.20-ck1 [2]          44.4    158     0       7       1.23

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              162.3   45      28      19      4.48
2.4.20 [5]              164.9   45      31      21      4.55
2.4.20-ck1 [2]          50.4    140     5       11      1.39

io_other:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              62.3    117     11      20      1.72
2.4.20 [5]              89.6    86      17      21      2.47
2.4.20-ck1 [2]          42.7    163     3       11      1.18

read_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              60.2    123     9       7       1.66
2.4.20 [5]              51.0    143     7       7       1.41
2.4.20-ck1 [2]          41.7    173     5       8       1.15

list_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              40.3    174     0       8       1.11
2.4.20 [5]              40.4    175     0       8       1.12
2.4.20-ck1 [2]          39.3    178     0       7       1.09

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              53.7    133     36      3       1.48
2.4.20 [5]              52.0    139     37      3       1.44
2.4.20-ck1 [2]          76.6    93      36      2       2.12

Points to note: 
It is more than just coincidence that the results of -ck are good with contest 
since responsiveness is the main aim in my patchset and contest is my main 
testing method. I resisted posting these results because they look rigged, 
but many people have asked for them

A lot of these benchmarks occur in the setting of competing writes/reads from 
disk and the disk hack will be responsible for most of the low scores. This 
disk hack is not recommended for use in situations where throughput is 
important (eg servers). The lower throughput is not noticeable most of the 
time on a desktop, but the lack of pauses and increased responsiveness is 
noticed. It does cause a noticeable slowdown on devices with poor caching of 
their own (eg zip disks).

I am looking into the lower mem_load performance. This appears to have 
surfaced with the resync to 2.4.20. Most of the vm changes to 2.4.20-ck1 were 
similar to 2.4.19-ck* but were the latest patches from -aa's tree. I have 
been investigating moving to -rmap for the default tree as it matures but 
it's performance, while improving, is not quite as good on contest just yet.

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE98VuCF6dfvkL3i1gRAobVAJ4+RFkunqKRLRLUewSu6Q++ZmJ4ngCcCIph
/enT8LVfj7V26gludYLSQyQ=
=y9uF
-----END PGP SIGNATURE-----
