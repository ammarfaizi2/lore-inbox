Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261855AbSLUFpn>; Sat, 21 Dec 2002 00:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262023AbSLUFpn>; Sat, 21 Dec 2002 00:45:43 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:23534 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S261855AbSLUFpl>;
	Sat, 21 Dec 2002 00:45:41 -0500
Message-ID: <3E0401D0.9EF68E64@mvista.com>
Date: Fri, 20 Dec 2002 21:53:20 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] High-res-timers part 2 (x86 platform code) take 21
References: <Pine.LNX.4.33L2.0212201641210.1703-100000@dragon.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the heads up.  A new patch is now posted.

-g


"Randy.Dunlap" wrote:
> 
> On Fri, 20 Dec 2002, george anzinger wrote:
> 
> | This is the platform part of the high-res timers for the
> | x86.
> |
> | Changes since last time:
> | CONFIG dependency added to not turn on stuff only needed
> | when CONFIG_HIGH_RES = y.
> | ----------
> |
> | The 3 parts to the high res timers are:
> |  core         The core kernel (i.e. platform independent) changes
> | *i386         The high-res changes for the i386 (x86) platform
> |  hrposix      The changes to the POSIX clocks & timers patch to
> | use high-res timers
> |
> | Please apply.
> 
> George,
> 
> This arch/i386/Kconfig file contains some KGDB options that keep
> it from applying cleanly.  Not delaying me, but it might delay someone.
> 
> $ patch -p1 -b --dry-run < ~/cglstage/HRT_2002_1220/03-hrtimers-x86.patch
> patching file arch/i386/Kconfig
> Hunk #2 FAILED at 1665.
> Hunk #3 FAILED at 1857.
> Hunk #4 FAILED at 1866.
> 3 out of 4 hunks FAILED -- saving rejects to file arch/i386/Kconfig.rej
> 
> --
> ~Randy

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
