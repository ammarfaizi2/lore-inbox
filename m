Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282523AbRKZVBC>; Mon, 26 Nov 2001 16:01:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282521AbRKZU7R>; Mon, 26 Nov 2001 15:59:17 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:25289 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S282500AbRKZU6b>;
	Mon, 26 Nov 2001 15:58:31 -0500
Date: Mon, 26 Nov 2001 21:58:28 +0100
From: David Weinehall <tao@acc.umu.se>
To: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCEMENT] Linux 2.0.40-pre3
Message-ID: <20011126215828.P5770@khan.acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here comes another one. Unless I receive some more patches, the next
patch will be the first release-candidate for v2.0.40


2.0.40pre3

o	Fix typo in sched.c			(Tim Sutherland)
	| this time for real; I applied this
	| patch to the wrong kernel-tree last
	| time, hence the reject
o	IDE probe patch for some ATAPI drives	(Geert Van der Plas)


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


/David
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
