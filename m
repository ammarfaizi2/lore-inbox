Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318003AbSFSUuj>; Wed, 19 Jun 2002 16:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318004AbSFSUui>; Wed, 19 Jun 2002 16:50:38 -0400
Received: from revdns.flarg.info ([213.152.47.19]:22991 "EHLO noodles.internal")
	by vger.kernel.org with ESMTP id <S318003AbSFSUuh>;
	Wed, 19 Jun 2002 16:50:37 -0400
Date: Wed, 19 Jun 2002 21:51:36 +0100
From: Dave Jones <davej@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.23-dj2
Message-ID: <20020619205136.GA18903@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lots of bits got thrown out this time, as Christoph Hellwig went through
the patch and picked up on quite a few obviously wrong bits. In addition,
this patch introduces the mad axemen, who come to carve up all that is
monolithic. Patrick's MTRR split-up has been around for a while, and could
use a bit more testing before it goes to Linus. The AGPGART changes I did
this afternoon, and haven't seen much testing at all yet.

Finally, another round of compile fixes and the likes from Linux Kernel.

As usual,..

Patch against 2.5.23 vanilla is available from:
ftp://ftp.kernel.org/pub/linux/kernel/people/davej/patches/2.5/

Merged patch archive: http://www.codemonkey.org.uk/patches/merged/

Check http://www.codemonkey.org.uk/Linux-2.5.html before reporting
known bugs that are also in mainline.

 -- Davej.

2.5.23-dj2
o   Drop lots of obsolete/reversed changes.		(Christoph Hellwig)
o   Split up agpgart backends into per vendor files.	(Me)
o   Split up IA32 MTRR driver into per-CPU files.	(Patrick Mochel, Me)
o   Nuke 2 strtok() calls that crept back in.		(Me)
o   Add more missing tqueue includes.		(Andy Pfiffer, Matthew Harrell,
						 Stelian Pop, Adrian Bunk)
o   Mark some x86 SMP variables as initdata.		(Robert Love)
o   Offer P4 thermal monitoring when CONFIG_SMP=y	(Zwane Mwaikambo)
o   Add missing kmalloc check to iphase driver.		(petter@kernelspace.com)
o   Poll/Select fast path optimisation take 2.		(Andi Kleen)
o   Oops fix in tcp_v6_get_port().			(Carl Ritson)
o   Various janitor work in megaraid driver.		(William Stinson)
o   Move software suspend to power management menu.	(Brad Hards)
o   Shrink stack usage of check_nmi_watchdog()		(Mikael Pettersson)
o   Nuke unneeded headers from mm/page_alloc.c		(William Lee Irwin)
o   Various janitor work on ixj telephony driver.	(Sam Ravnborg)
o   Workaround for lockd deadlock.			(Daniel Forrest)
o   Update reference to MIPS documentation.		(Rolf Eike Beer)
o   Convert SAA7110 driver to new i2c.			(Frank Davis)


2.5.23-dj1
o   Small UP optimisation in the scheduler.		(James Bottomley)
o   Update x86 cpufreq scaling code.			(Dominik Brodowski)
o   Export ioremap_nocache() for modules.		(Andi Kleen)
o   Export default_wake_function() for modules.		(Benjamin LaHaise)
o   Compaq hotplug compile fixes.			(Felipe Contreras)
o   Fix migration thread for non linear numbered CPUs.	(Ingo Molnar)
o   Framebuffer updates.				(James Simmons)
o   Introduce CONFIG_ISA option for i386.		(Andi Kleen)
o   Fix bad locking in driver/ core.			(Arnd Bergmann)
-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
