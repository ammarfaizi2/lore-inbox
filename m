Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263389AbTDCNpJ>; Thu, 3 Apr 2003 08:45:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263391AbTDCNpJ>; Thu, 3 Apr 2003 08:45:09 -0500
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:19172 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id <S263389AbTDCNpF> convert rfc822-to-8bit;
	Thu, 3 Apr 2003 08:45:05 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] 2.5.66-mm3 with contest
Date: Thu, 3 Apr 2003 23:48:36 +1000
User-Agent: KMail/1.5.1
Cc: Andrew Morton <akpm@digeo.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200304032348.48118.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

no_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.66              3   79      94.9    0.0     0.0     1.00
2.5.66-mm1          3   79      94.9    0.0     0.0     1.00
2.5.66-mm2          3   80      93.8    0.0     0.0     1.00
2.5.66-mm3          3   79      94.9    0.0     0.0     1.00
cacherun:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.66              3   76      98.7    0.0     0.0     0.96
2.5.66-mm1          3   75      100.0   0.0     0.0     0.95
2.5.66-mm2          3   75      100.0   0.0     0.0     0.94
2.5.66-mm3          3   75      100.0   0.0     0.0     0.95
process_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.66              3   241     30.7    311.0   68.0    3.05
2.5.66-mm1          3   240     30.8    295.3   67.9    3.04
2.5.66-mm2          3   239     31.0    295.3   67.8    2.99*
2.5.66-mm3          3   176     42.6    184.3   56.2    2.23*
ctar_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.66              3   105     74.3    0.0     0.0     1.33
2.5.66-mm1          3   110     70.9    1.0     5.5     1.39
2.5.66-mm2          3   184     42.9    2.0     7.1     2.30*
2.5.66-mm3          3   108     73.1    1.0     5.6     1.37*
xtar_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.66              3   105     72.4    1.0     3.8     1.33
2.5.66-mm1          3   104     74.0    1.0     3.8     1.32
2.5.66-mm2          3   108     71.3    1.3     4.6     1.35*
2.5.66-mm3          3   102     74.5    1.0     3.9     1.29*
io_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.66              3   438     17.8    150.4   20.9    5.54
2.5.66-mm1          3   132     58.3    45.8    18.9    1.67
2.5.66-mm2          3   371     21.0    147.9   22.3    4.64*
2.5.66-mm3          3   130     58.5    44.5    18.5    1.65*
io_other:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.66              3   158     49.4    70.0    27.2    2.00
2.5.66-mm1          3   134     58.2    57.5    23.7    1.70
2.5.66-mm2          3   136     57.4    56.7    22.8    1.70
2.5.66-mm3          3   132     59.1    55.0    22.0    1.67
read_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.66              3   110     70.9    6.2     4.5     1.39
2.5.66-mm1          3   121     65.3    9.2     5.8     1.53
2.5.66-mm2          3   110     71.8    8.4     6.3     1.38
2.5.66-mm3          3   111     71.2    8.4     5.4     1.41
list_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.66              3   97      79.4    0.0     7.2     1.23
2.5.66-mm1          3   97      80.4    0.0     7.2     1.23
2.5.66-mm2          3   96      80.2    0.0     7.3     1.20
2.5.66-mm3          3   98      78.6    0.0     7.1     1.24
mem_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.66              3   112     70.5    64.0    1.8     1.42
2.5.66-mm1          3   104     76.0    54.0    1.9     1.32
2.5.66-mm2          3   109     71.6    57.7    1.8     1.36*
2.5.66-mm3          3   105     75.2    58.0    1.9     1.33*
dbench_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.66              3   459     16.6    7.0     56.6    5.81
2.5.66-mm1          3   373     20.4    6.3     50.7    4.72
2.5.66-mm2          3   323     23.2    4.7     51.4    4.04*
2.5.66-mm3          3   305     24.9    4.3     50.5    3.86*

Seems these "minor" scheduler tweaks cause major changes to the results with 
process load and most of the io based loads taking significantly less time. 
There weren't any elevator changes in this one were there?

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+jDu4F6dfvkL3i1gRAqFPAKCliMg9ZLN0M/51XPDiRwZt0Jzz4wCeMlbH
q1mjTDin1MN4M/IruXY9UqM=
=UTOg
-----END PGP SIGNATURE-----

