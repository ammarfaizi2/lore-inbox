Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261286AbSLUAgd>; Fri, 20 Dec 2002 19:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261292AbSLUAgd>; Fri, 20 Dec 2002 19:36:33 -0500
Received: from air-2.osdl.org ([65.172.181.6]:52441 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261286AbSLUAgc>;
	Fri, 20 Dec 2002 19:36:32 -0500
Date: Fri, 20 Dec 2002 16:43:26 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: george anzinger <george@mvista.com>
cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] High-res-timers part 2 (x86 platform code) take 21
In-Reply-To: <3E02E875.8BF23AAE@mvista.com>
Message-ID: <Pine.LNX.4.33L2.0212201641210.1703-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Dec 2002, george anzinger wrote:

| This is the platform part of the high-res timers for the
| x86.
|
| Changes since last time:
| CONFIG dependency added to not turn on stuff only needed
| when CONFIG_HIGH_RES = y.
| ----------
|
| The 3 parts to the high res timers are:
|  core		The core kernel (i.e. platform independent) changes
| *i386		The high-res changes for the i386 (x86) platform
|  hrposix	The changes to the POSIX clocks & timers patch to
| use high-res timers
|
| Please apply.


George,

This arch/i386/Kconfig file contains some KGDB options that keep
it from applying cleanly.  Not delaying me, but it might delay someone.



$ patch -p1 -b --dry-run < ~/cglstage/HRT_2002_1220/03-hrtimers-x86.patch
patching file arch/i386/Kconfig
Hunk #2 FAILED at 1665.
Hunk #3 FAILED at 1857.
Hunk #4 FAILED at 1866.
3 out of 4 hunks FAILED -- saving rejects to file arch/i386/Kconfig.rej

-- 
~Randy

