Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261944AbTD3KfT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 06:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262013AbTD3KfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 06:35:19 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:19610 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S261944AbTD3KfR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 06:35:17 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] 2.5.68-mm3 with contest
Date: Wed, 30 Apr 2003 20:49:06 +1000
User-Agent: KMail/1.5.1
Cc: Andrew Morton <akpm@digeo.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200304302049.34952.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Contest benchmarks showing the requests/queue changes in 2.5.68-mm3

no_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.68              3   79      94.9    0.0     0.0     1.00
2.5.68-mm1          2   79      94.9    0.0     0.0     1.00
2.5.68-mm2          1   80      93.8    0.0     0.0     1.00
2.5.68-mm3          1   80      93.8    0.0     0.0     1.00
cacherun:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.68              3   75      100.0   0.0     0.0     0.95
2.5.68-mm1          1   75      100.0   0.0     0.0     0.95
2.5.68-mm2          1   76      98.7    0.0     0.0     0.95
2.5.68-mm3          1   76      98.7    0.0     0.0     0.95
process_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.68              3   181     40.9    193.3   57.5    2.29
2.5.68-mm1          2   178     41.6    191.5   56.7    2.25
2.5.68-mm2          2   177     41.8    177.5   56.5    2.21
2.5.68-mm3          2   177     42.4    181.5   55.9    2.21
ctar_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.68              3   105     74.3    0.0     0.0     1.33
2.5.68-mm1          3   112     69.6    1.0     5.3     1.42
2.5.68-mm2          3   108     73.1    1.0     5.6     1.35
2.5.68-mm3          3   120     66.7    1.0     5.0     1.50
xtar_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.68              3   105     72.4    1.0     3.8     1.33
2.5.68-mm1          3   108     71.3    1.0     4.6     1.37
2.5.68-mm2          3   107     72.0    1.0     4.7     1.34
2.5.68-mm3          3   111     69.4    1.7     4.5     1.39
io_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.68              3   492     15.9    167.1   19.7    6.23
2.5.68-mm1          4   128     59.4    47.6    19.4    1.62
2.5.68-mm2          4   131     58.8    47.0    18.9    1.64
2.5.68-mm3          4   271     28.4    89.2    17.9    3.39
io_other:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.68              3   148     52.7    65.7    25.0    1.87
2.5.68-mm1          2   117     66.7    48.9    22.0    1.48
2.5.68-mm2          2   120     65.0    49.2    22.3    1.50
2.5.68-mm3          2   127     61.4    45.1    19.5    1.59
read_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.68              3   109     71.6    6.2     4.6     1.38
2.5.68-mm1          2   115     68.7    9.1     6.1     1.46
2.5.68-mm2          2   115     67.8    9.1     6.1     1.44
2.5.68-mm3          2   117     67.5    9.2     6.0     1.46
list_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.68              3   95      81.1    0.0     5.3     1.20
2.5.68-mm1          2   96      79.2    0.0     7.3     1.22
2.5.68-mm2          2   97      79.4    0.0     7.2     1.21
2.5.68-mm3          2   96      80.2    0.0     7.3     1.20
mem_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.68              3   113     69.0    64.3    1.8     1.43
2.5.68-mm1          2   98      79.6    53.0    2.0     1.24
2.5.68-mm2          2   101     78.2    53.0    2.0     1.26
2.5.68-mm3          2   130     61.5    75.0    2.3     1.62
dbench_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.68              3   412     18.4    5.3     47.6    5.22
2.5.68-mm1          4   361     21.1    5.5     54.0    4.57
2.5.68-mm2          4   345     22.0    4.8     49.3    4.31
2.5.68-mm3          4   721     10.5    6.8     33.6    9.01

All the io-write based loads were affected. 

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+r6o0F6dfvkL3i1gRAlXPAJ9ixC20c46aTQfa34PS3T7KlV5LVgCgir/0
D4pO+1vTeSeg0uWikD0JqyQ=
=1Xbb
-----END PGP SIGNATURE-----

