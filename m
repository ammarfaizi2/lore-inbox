Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263469AbRFTW15>; Wed, 20 Jun 2001 18:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264656AbRFTW1u>; Wed, 20 Jun 2001 18:27:50 -0400
Received: from adsl-64-175-255-50.dsl.sntc01.pacbell.net ([64.175.255.50]:5507
	"HELO kobayashi.soze.net") by vger.kernel.org with SMTP
	id <S263469AbRFTW1g>; Wed, 20 Jun 2001 18:27:36 -0400
Date: Wed, 20 Jun 2001 15:29:39 -0700 (PDT)
From: Justin Guyett <justin@soze.net>
X-X-Sender: <tyme@gw.soze.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: freeze with 2.4.5-ac16
In-Reply-To: <Pine.LNX.4.33.0106201405430.28876-100000@gw.soze.net>
Message-ID: <Pine.LNX.4.33.0106201527120.29004-100000@gw.soze.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jun 2001, Justin Guyett wrote:

> I got it to freeze in console (two generic find / -type f / type d), one
> process allocating and writing 0 to 192mb
>
> machine responds to pings, switching VTs works
>
> (256 physical, 512 swap)

happened again (vt1 and 2 echo but shells are unresponsive, vt3+ don't
echo) only active process was the program allocating 192mb and writing to
it, no find this time.

SysRq : Show Memory
Mem-info:
Free pages:        1524kB (     0kB HighMem)
( Active: 22717, inactive_dirty: 18852, inactive_clean: 0, free: 381 (383
766 1149) )
1*4kB 1*8kB 1*16kB 1*32kB 1*64kB 1*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB
= 508kB)
2*4kB 0*8kB 1*16kB 1*32kB 1*64kB 1*128kB 1*256kB 1*512kB 0*1024kB 0*2048kB
= 1016kB)
= 0kB)
Swap cache: add 241834, delete 202609, find 1028/3579
Free swap:       369532kB
65520 pages of RAM
0 pages of HIGHMEM
1595 reserved pages
1633 pages shared
39225 pages swap cached
0 pages in page table cache
Buffer memory:     5544kB
gffffSysRq : SAK


justin

