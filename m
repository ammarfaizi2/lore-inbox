Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132558AbRDQF7m>; Tue, 17 Apr 2001 01:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132560AbRDQF7c>; Tue, 17 Apr 2001 01:59:32 -0400
Received: from media.umbc.edu ([130.85.179.78]:7692 "EHLO media.umbc.edu")
	by vger.kernel.org with ESMTP id <S132558AbRDQF7W>;
	Tue, 17 Apr 2001 01:59:22 -0400
From: Ray Shaw <ray@media.umbc.edu>
Date: Tue, 17 Apr 2001 01:59:16 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Athlon runtime problems
Message-ID: <20010417015916.A14437@media.umbc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>CPU model/stepping
AMD Duron, 800mhz

>chipset
VIA KT-133; motherboard is an ABIT KT7A-RAID

>amount of RAM
256M, single PC-133 SDRAM

>/proc/mtrr output
reg00: base=0x00000000 (   0MB), size= 256MB: write-back, count=1
reg05: base=0xd0000000 (3328MB), size=  64MB: write-combining, count=1

>compiler used
gcc version 2.95.2

It seems to blow up when I'm doing something which probably wants lots
of memory, ie running X and opening up several mozilla windows (though
it still crashes while just running X, Enlightenment, and w3m in an
Eterm...but it does take a little longer, though still < 30 min.).

I went back to 2.2.18 and the crashing stopped.  I am using UDMA66 on
one of my drives, no DMA on the other two.

I haven't tried a non-Athlon optimised kernel, nor one with as few
options as possible; hopefully I will get the chance to do this soon.


-- 
--Ray

-----------------------------
Sotto la panca la capra crepa
sopra la panca la capra campa
