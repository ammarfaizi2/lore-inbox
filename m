Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265497AbTFVDqe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 23:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265493AbTFVDq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 23:46:26 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:25577 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S265265AbTFVDqX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 23:46:23 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] 2.5.72{,-mm1,-mm2} with contest
Date: Sun, 22 Jun 2003 14:01:09 +1000
User-Agent: KMail/1.5.2
Cc: Andrew Morton <akpm@digeo.com>, Nick Piggin <piggin@cyberone.com.au>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200306221401.15164.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Here are contest (http://contest.kolivas.org) results using Linus' employer's 
(http://www.osdl.org) hardware for the latest kernels.

no_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.70              1   79      94.9    0.0     0.0     1.00
2.5.70-mm8          1   78      93.6    0.0     0.0     1.00
2.5.72              1   79      94.9    0.0     0.0     1.00
2.5.72-mm1          1   78      93.6    0.0     0.0     1.00
2.5.72-mm2          1   77      94.8    0.0     0.0     1.00
cacherun:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.70              1   75      98.7    0.0     0.0     0.95
2.5.70-mm8          1   74      100.0   0.0     0.0     0.95
2.5.72              1   76      98.7    0.0     0.0     0.96
2.5.72-mm1          1   74      98.6    0.0     0.0     0.95
2.5.72-mm2          1   75      97.3    0.0     0.0     0.97
process_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.70              2   109     67.9    63.5    28.4    1.38
2.5.70-mm8          2   108     67.6    66.5    29.6    1.38
2.5.72              2   107     70.1    65.0    28.7    1.35
2.5.72-mm1          2   107     68.2    65.0    29.0    1.37
2.5.72-mm2          2   108     67.6    66.5    28.7    1.40
ctar_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.70              3   103     75.7    0.0     0.0     1.30
2.5.70-mm8          3   130     58.5    0.0     0.0     1.67
2.5.72              3   103     75.7    0.0     0.0     1.30
2.5.72-mm1          3   107     72.0    0.7     3.7     1.37
2.5.72-mm2          3   105     73.3    1.0     5.7     1.36
xtar_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.70              3   106     72.6    1.0     3.8     1.34
2.5.70-mm8          3   151     50.3    2.7     5.3     1.94
2.5.72              3   104     74.0    1.0     3.8     1.32
2.5.72-mm1          3   113     66.4    2.0     4.4     1.45
2.5.72-mm2          3   118     63.6    2.0     4.2     1.53
io_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.70              5   326     21.5    112.9   18.7    4.13
2.5.70-mm8          4   111     67.6    38.0    17.9    1.42
2.5.72              4   356     21.9    128.9   19.3    4.51
2.5.72-mm1          4   122     62.3    43.8    18.7    1.56
2.5.72-mm2          4   119     63.0    44.1    20.0    1.55
io_other:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.70              2   122     63.9    53.8    22.1    1.54
2.5.70-mm8          2   111     68.5    42.0    18.8    1.42
2.5.72              2   120     65.0    51.2    23.0    1.52
2.5.72-mm1          2   112     67.9    44.5    19.5    1.44
2.5.72-mm2          2   111     68.5    44.6    19.6    1.44
read_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.70              2   104     75.0    6.3     4.8     1.32
2.5.70-mm8          2   120     63.3    8.4     5.8     1.54
2.5.72              2   104     75.0    6.3     4.8     1.32
2.5.72-mm1          2   104     74.0    7.7     6.7     1.33
2.5.72-mm2          2   106     71.7    7.7     8.5     1.38
list_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.70              2   96      80.2    0.0     7.3     1.22
2.5.70-mm8          2   99      75.8    0.0     7.1     1.27
2.5.72              2   97      79.4    0.0     7.2     1.23
2.5.72-mm1          2   93      80.6    0.0     6.5     1.19
2.5.72-mm2          2   93      80.6    0.0     5.4     1.21
mem_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.70              2   97      80.4    53.5    2.1     1.23
2.5.70-mm8          2   125     61.6    63.5    2.4     1.60
2.5.72              2   95      82.1    54.0    2.1     1.20
2.5.72-mm1          2   111     69.4    53.5    1.8     1.42
2.5.72-mm2          2   111     69.4    53.5    1.8     1.44
dbench_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.70              5   321     22.1    4.0     44.5    4.06
2.5.70-mm8          4   274     27.4    3.8     47.8    3.51
2.5.72              4   397     19.6    5.5     50.4    5.03
2.5.72-mm1          4   333     22.5    4.2     44.7    4.27
2.5.72-mm2          4   328     22.6    4.5     48.0    4.26

2.5.72-mm* seems to have recovered ground cf 2.5.70-mm* on ctar_load, 
xtar_load, read_load and list_load, with a small drop in dbench_load. Not 
much difference b/w mm1 and mm2.

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+9SoHF6dfvkL3i1gRAr86AJ48bj3DQlRI/3+CR7+z9eVepNZ1JgCcDz5t
VIkKW6G4lAf+c2KyUVIuQn8=
=b6OE
-----END PGP SIGNATURE-----

