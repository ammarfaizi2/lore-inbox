Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262686AbRFTVzZ>; Wed, 20 Jun 2001 17:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262901AbRFTVzP>; Wed, 20 Jun 2001 17:55:15 -0400
Received: from adsl-64-175-255-50.dsl.sntc01.pacbell.net ([64.175.255.50]:4995
	"HELO kobayashi.soze.net") by vger.kernel.org with SMTP
	id <S262686AbRFTVzG>; Wed, 20 Jun 2001 17:55:06 -0400
Date: Wed, 20 Jun 2001 14:57:05 -0700 (PDT)
From: Justin Guyett <justin@soze.net>
X-X-Sender: <tyme@gw.soze.net>
To: <linux-kernel@vger.kernel.org>
Subject: freeze with 2.4.5-ac16
Message-ID: <Pine.LNX.4.33.0106201405430.28876-100000@gw.soze.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got it to freeze in console (two generic find / -type f / type d), one
process allocating and writing 0 to 192mb

machine responds to pings, switching VTs works

(256 physical, 512 swap)

Mem-info
Free pages: 1524kB (0kB High)
( Active: 39586, inactive_dirty: 18590, inactive_clean: 0, free: 381 (383
766 1149) )
1 1 1 1 1 1 1 0 0 0 = 508kB
2 0 1 1 1 1 1 1 0 0 = 1016kB
Swap cache: add 152715, delete 98195, find 775/1918
Free swap:	307720kB
65520 pages of RAM
0 pages of HIGHMEM
1595 reserved pages
1146 pages shared
54520 pages swap cached
0 pages in page table cache
Buffer memory:	12444kB

find x/y seemed to be increasing y very slowly (5 minutes ago was at 1916,
free was at 380 I think)


justin

