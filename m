Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277576AbRJHWip>; Mon, 8 Oct 2001 18:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277575AbRJHWih>; Mon, 8 Oct 2001 18:38:37 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:32248 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S277576AbRJHWiT>;
	Mon, 8 Oct 2001 18:38:19 -0400
Date: Tue, 9 Oct 2001 00:38:48 +0200
From: David Weinehall <tao@acc.umu.se>
To: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] kernel v2.0.40-pre2
Message-ID: <20011009003847.Y7800@khan.acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First of all, I'd like to thank Seiichi Nakashima for reporting
a few of these errors, and Jari Ruusu for reporting the problem with
the new version-name and modules. If this still doesn't work, I'll
remove the KERNELRELEASE-stuff completely.

This release is dedicated to all the innocent people of Afghanistan
that inevitably, and sadly, will suffer in the hunt for Usama Bin Ladin.


2.0.40pre2

o	Make pci2000 compile			(Joseph Martin)
o	Use KERNELRELEASE in module		(me)
	installpath as well
o	Removed unused variable in		(me)
	ext2/super.c
o	Fixed warning in ext2/dir.c		(me)
o	Fix a blunder of my own in		(me)
	arch/kernel/i386/traps.c
o	Fix typo in sched.c			(Tim Sutherland)
o	Fix bug in mkdep.c			(Tim Sutherland)
o	Fix bug in autoirq.c			(Michael Deutschmann)
o	Add allocation debugging code		(Michael Deutschmann)
o	Fix bugs in the math-emu code		(Bill Metzenthen,
						 Michael Deutschmann)


2.0.40pre1

o	Fixed the ordering of			(Philipp Rumpf)
	watchdog initialising, to make sure
	hardware watchdogs takes precedence
	over the softdog driver
o	Fix the CREDITS-entry for		(Kai Petzke)
	Kai Petzke
o	Updated the MAINTAINERS-file a little	(me)
o	Fix "dumpable"-race			(Solar Designer)
o	Fix theoretical exploit in printk	(Solar Designer)
o	Backported checkconfig.pl,		(me)
	checkhelp.pl and checkincludes.pl
	from v2.4
o	Backported support for tags and		(me)
	TAGS
o	Added an extra-version entry to		(me)
	the version#, to keep track of
	the prepatches etc.
o	Fix all occurences of			(me)
	#endif BLABLA type; don't forget
	that it should be /* BLABLA */ !!!


/David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
