Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287431AbRL3O6A>; Sun, 30 Dec 2001 09:58:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287430AbRL3O5v>; Sun, 30 Dec 2001 09:57:51 -0500
Received: from eos.telenet-ops.be ([195.130.132.40]:12493 "EHLO
	eos.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S287429AbRL3O5j>; Sun, 30 Dec 2001 09:57:39 -0500
Date: Sun, 30 Dec 2001 15:57:38 +0100 (CET)
From: Michael De Nil <linux@aerythmic.be>
X-X-Sender: linux@LiSa
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Out of Memory: Killed process pine, find, kza ...
Message-ID: <Pine.LNX.4.43.0112301550150.2297-100000@LiSa>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Heyz

I have a strange problem with kernel 2.4.14 & 2.4.17 (the two I tried on)
When I run a simple command like 'find /var -name sendmail* -print' (this
one) or when running pine, kza, etc. Iget the error: 'Out of Memory:
Killed process 2032 (find)'
I did a vmstat 2 while running 'find /var -name sendmail* -print'
Here is what I recieved after a while:


cs                      memory    swap          io     system         cpu
r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
6  0  2 205720   1408   1220   5176   0 1664    12  1682  332    67   6  93   1
1  0  0 210200   2148   1244   5172   0 1664    24  1664  336    60   4  95   0
1  0  0 214672   1508   1224   5176  32 1950    42  1980  359    90  11  87   2
1  0  0 218768   2568   1236   5176   0 1958    22  1960  416    60   4  96   0
5  1  4 221840   1284   1240   5172   0 2138     4  2144  503    52   5  95   0
1  0  1 226960   2820   1316   5172   0 2530    34  2576  510   108   8  91   2
1  0  1 231696   2692   1228   5172   0 2176    18  2176  431    86   7  92   1
1  0  0 234768   2600   1220   5172   0 1536    14  1554  309    69  11  87   2
1  0  0 238352   2096   1228   5176   0 1770    12  1770  425    43   9  91   0
1  0  0 240964   1396   1272   5160   0 1110    10  1150  328    76   7  93   0
1  0  0 240964   1328   1224   5000   0 924    10   924  231    71   8  92   0
Out of Memory: Killed process 2032 (find).


I have a P3 - 733 Mhz with 128 meg ram & 256 meg swap
I am running debian - woody


Michael

-----------------------------------------------------------------------
                Michael De Nil -- michael@aerythmic.be
      Linux LiSa 2.4.14 #6 SMP Sun Nov 25 16:59:04 CET 2001 i686
      15:56:01 up  2:41,  4 users,  load average: 0.04, 0.29, 0.54
-----------------------------------------------------------------------


