Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262543AbTFJVAd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 17:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262445AbTFJVAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 17:00:31 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:39660 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S264037AbTFJU7a convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 16:59:30 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] 2.5.70-mm7 with contest
Date: Wed, 11 Jun 2003 07:07:07 +1000
User-Agent: KMail/1.5.2
Cc: Andrew Morton <akpm@digeo.com>, Nick Piggin <piggin@cyberone.com.au>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200306110707.21468.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Here are contest results with 2.5.70-mm7:

no_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.70              1   79      94.9    0.0     0.0     1.00
2.5.70-mm2          1   78      94.9    0.0     0.0     1.00
2.5.70-mm3          1   79      94.9    0.0     0.0     1.00
2.5.70-mm7          1   78      94.9    0.0     0.0     1.00
cacherun:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.70              1   75      98.7    0.0     0.0     0.95
2.5.70-mm2          1   75      98.7    0.0     0.0     0.96
2.5.70-mm3          1   76      97.4    0.0     0.0     0.96
2.5.70-mm7          1   75      97.3    0.0     0.0     0.96
process_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.70              2   109     67.9    63.5    28.4    1.38
2.5.70-mm2          2   108     68.5    65.5    28.7    1.38
2.5.70-mm3          2   108     68.5    64.5    28.7    1.37
2.5.70-mm7          2   107     68.2    67.5    29.9    1.37
ctar_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.70              3   103     75.7    0.0     0.0     1.30
2.5.70-mm2          3   118     66.9    1.0     5.1     1.51
2.5.70-mm3          3   114     70.2    1.0     5.3     1.44
2.5.70-mm7          3   117     65.8    0.0     0.0     1.50
xtar_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.70              3   106     72.6    1.0     3.8     1.34
2.5.70-mm2          3   123     61.8    2.0     4.8     1.58
2.5.70-mm3          3   123     62.6    2.3     5.7     1.56
2.5.70-mm7          3   148     50.7    2.7     5.4     1.90
io_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.70              5   326     21.5    112.9   18.7    4.13
2.5.70-mm2          4   115     67.0    42.0    19.1    1.47
2.5.70-mm3          4   116     66.4    40.6    18.8    1.47
2.5.70-mm7          4   107     70.1    37.0    17.6    1.37
io_other:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.70              2   122     63.9    53.8    22.1    1.54
2.5.70-mm2          2   113     68.1    46.2    20.4    1.45
2.5.70-mm3          2   116     66.4    50.0    22.2    1.47
2.5.70-mm7          2   111     68.5    43.0    19.6    1.42
read_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.70              2   104     75.0    6.3     4.8     1.32
2.5.70-mm2          2   106     73.6    8.2     5.7     1.36
2.5.70-mm3          2   104     75.0    8.2     5.8     1.32
2.5.70-mm7          2   135     56.3    11.3    6.6     1.73
list_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.70              2   96      80.2    0.0     7.3     1.22
2.5.70-mm2          2   94      81.9    0.0     7.4     1.21
2.5.70-mm3          2   95      80.0    0.0     7.4     1.20
2.5.70-mm7          2   96      77.1    0.0     6.2     1.23
mem_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.70              2   97      80.4    53.5    2.1     1.23
2.5.70-mm2          2   99      78.8    54.5    2.0     1.27
2.5.70-mm3          2   98      80.6    53.0    2.0     1.24
2.5.70-mm7          2   101     76.2    50.5    2.0     1.29
dbench_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.70              5   321     22.1    4.0     44.5    4.06
2.5.70-mm2          4   305     24.9    4.8     55.4    3.91
2.5.70-mm3          4   313     24.3    5.0     56.9    3.96
2.5.70-mm7          4   305     24.6    4.8     54.2    3.91

Shifts up in ctar, xtar, read and mem loads. Down in io and io_other.
Note I have posted contest benchmarks on 2.5.70-mm3 with 1000 v 100Hz 
previously.

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+5kh+F6dfvkL3i1gRAklBAJ9KcqAYUp6P+m6XHlHtWvNnLxrA6gCfV4Te
gp8ZdArOodEWc1ivC9qbE7s=
=0DJc
-----END PGP SIGNATURE-----

