Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262849AbTC1JVj>; Fri, 28 Mar 2003 04:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262852AbTC1JVj>; Fri, 28 Mar 2003 04:21:39 -0500
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:62115 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id <S262849AbTC1JVh> convert rfc822-to-8bit;
	Fri, 28 Mar 2003 04:21:37 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] 2.5.66-mm1 with contest
Date: Fri, 28 Mar 2003 20:32:43 +1100
User-Agent: KMail/1.5
Cc: Andrew Morton <akpm@digeo.com>, Nick Piggin <piggin@cyberone.com.au>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200303282032.45518.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Yep more contest benchmarks.

no_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.65-mm4          3   79      94.9    0.0     0.0     1.00
2.5.66              3   79      94.9    0.0     0.0     1.00
2.5.66-mm1          3   79      94.9    0.0     0.0     1.00
cacherun:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.65-mm4          3   76      98.7    0.0     0.0     0.96
2.5.66              3   76      98.7    0.0     0.0     0.96
2.5.66-mm1          3   75      100.0   0.0     0.0     0.95
process_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.65-mm4          3   240     31.2    304.3   67.6    3.04
2.5.66              3   241     30.7    311.0   68.0    3.05
2.5.66-mm1          3   240     30.8    295.3   67.9    3.04
ctar_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.65-mm4          3   111     71.2    1.0     5.4     1.41
2.5.66              3   105     74.3    0.0     0.0     1.33
2.5.66-mm1          3   110     70.9    1.0     5.5     1.39
xtar_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.65-mm4          3   107     72.0    1.0     4.7     1.35
2.5.66              3   105     72.4    1.0     3.8     1.33
2.5.66-mm1          3   104     74.0    1.0     3.8     1.32
io_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.65-mm4          3   142     54.2    51.5    19.6    1.80
2.5.66              3   438     17.8    150.4   20.9    5.54
2.5.66-mm1          3   132     58.3    45.8    18.9    1.67
io_other:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.65-mm4          3   131     59.5    59.3    25.0    1.66
2.5.66              3   158     49.4    70.0    27.2    2.00
2.5.66-mm1          3   134     58.2    57.5    23.7    1.70
read_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.65-mm4          3   122     64.8    9.2     5.7     1.54
2.5.66              3   110     70.9    6.2     4.5     1.39
2.5.66-mm1          3   121     65.3    9.2     5.8     1.53
list_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.65-mm4          3   97      79.4    0.0     7.2     1.23
2.5.66              3   97      79.4    0.0     7.2     1.23
2.5.66-mm1          3   97      80.4    0.0     7.2     1.23
mem_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.65-mm4          3   102     77.5    53.7    1.9     1.29
2.5.66              3   112     70.5    64.0    1.8     1.42
2.5.66-mm1          3   104     76.0    54.0    1.9     1.32
dbench_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.65-mm4          3   439     17.3    6.7     54.1    5.56
2.5.66              3   459     16.6    7.0     56.6    5.81
2.5.66-mm1          3   373     20.4    6.3     50.7    4.72

Compared to 2.5.65-mm4, 2.5.66-mm1 has improved a little further, with io 
load, xtar and dbench load dropping significantly.

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+hBa7F6dfvkL3i1gRAgbIAJ0Z//nyKfenmhHJBuOuSrDSMLjFUQCdElAP
DHLL+uaR9J2zgEqKNd3z8V8=
=HyzJ
-----END PGP SIGNATURE-----

