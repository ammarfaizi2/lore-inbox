Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267248AbTBINUg>; Sun, 9 Feb 2003 08:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267252AbTBINUf>; Sun, 9 Feb 2003 08:20:35 -0500
Received: from web41404.mail.yahoo.com ([66.218.93.70]:8058 "HELO
	web41404.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S267248AbTBINUe>; Sun, 9 Feb 2003 08:20:34 -0500
Message-ID: <20030209133013.41763.qmail@web41404.mail.yahoo.com>
Date: Mon, 10 Feb 2003 00:30:13 +1100 (EST)
From: =?iso-8859-1?q?Con=20Kolivas?= <ckolivas@yahoo.com.au>
Subject: [BENCHMARK] 2.4.20-ck3 / aa / rmap with contest
To: lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are a set of contest benchmarks for 2.4.20-ck3
comparing it to vanilla 2.4.20
ck3a is with the default aa vm
ck3r is with the rmap vm option

no_load:
Kernel   [runs] Time    CPU%    Loads   LCPU%   Ratio
2.4.20        1 78      93.6    0.0     0.0     1.00
2420ck3a      1 78      94.9    0.0     0.0     1.00
2420ck3r      1 80      93.8    0.0     0.0     1.00
cacherun:
Kernel   [runs] Time    CPU%    Loads   LCPU%   Ratio
2.4.20        1 74      98.6    0.0     0.0     0.95
2420ck3a      1 75      98.7    0.0     0.0     0.96
2420ck3r      1 76      97.4    0.0     0.0     0.95
process_load:
Kernel   [runs] Time    CPU%    Loads   LCPU%   Ratio
2.4.20        1 123     56.1    105.0   41.5    1.58
2420ck3a      1 115     63.5    88.0    35.7    1.47
2420ck3r      1 120     61.7    94.0    35.8    1.50
ctar_load:
Kernel   [runs] Time    CPU%    Loads   LCPU%   Ratio
2.4.20        1 98      79.6    2.0     5.1     1.26
2420ck3a      1 92      82.6    1.0     2.2     1.18
2420ck3r      1 97      80.4    1.0     3.1     1.21
xtar_load:
Kernel   [runs] Time    CPU%    Loads   LCPU%   Ratio
2.4.20        1 130     59.2    2.0     4.6     1.67
2420ck3a      1 116     65.5    2.0     5.2     1.49
2420ck3r      1 127     60.6    2.0     3.9     1.59
io_load:
Kernel   [runs] Time    CPU%    Loads   LCPU%   Ratio
2.4.20        1 297     25.3    95.5    15.5    3.81
2420ck3a      1 124     61.3    32.9    12.9    1.59
2420ck3r      1 152     51.3    35.7    12.5    1.90
io_other:
Kernel   [runs] Time    CPU%    Loads   LCPU%   Ratio
2.4.20        1 100     74.0    32.8    15.8    1.28
2420ck3a      1 93      81.7    26.6    14.0    1.19
2420ck3r      1 110     70.0    29.7    13.6    1.38
read_load:
Kernel   [runs] Time    CPU%    Loads   LCPU%   Ratio
2.4.20        1 200     39.5    16.8    5.5     2.56
2420ck3a      1 93      82.8    6.1     5.4     1.19
2420ck3r      1 121     65.3    7.2     5.0     1.51
list_load:
Kernel   [runs] Time    CPU%    Loads   LCPU%   Ratio
2.4.20        1 95      78.9    0.0     5.3     1.22
2420ck3a      1 82      91.5    0.0     3.7     1.05
2420ck3r      1 94      80.9    0.0     3.2     1.18
mem_load:
Kernel   [runs] Time    CPU%    Loads   LCPU%   Ratio
2.4.20        1 91      84.6    50.0    1.1     1.17
2420ck3a      1 104     73.1    51.0    1.9     1.33
2420ck3r      1 105     76.2    54.0    3.8     1.31
dbench_load:
Kernel   [runs] Time    CPU%    Loads   LCPU%   Ratio
2.4.20        1 354     21.2    4.0     38.4    4.54
2420ck3a      1 135     61.5    0.0     0.0     1.73
2420ck3r      1 180     45.0    0.0     0.0     2.25

Con


http://greetings.yahoo.com.au - Yahoo! Greetings
- Send your seasons greetings online this year!
