Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289904AbSAWXKV>; Wed, 23 Jan 2002 18:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290192AbSAWXKH>; Wed, 23 Jan 2002 18:10:07 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:63206 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S289904AbSAWXJv>;
	Wed, 23 Jan 2002 18:09:51 -0500
Date: Thu, 24 Jan 2002 00:09:48 +0100
From: David Weinehall <tao@acc.umu.se>
To: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [Announcement] linux-2.0.40-rc2
Message-ID: <20020124000948.R1735@khan.acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seems like objections never arise before I declare my intent to
make a final release. Then again, this caused some very important
fixes (and some less so) to make it into the upcoming 2.0.40.
Again, if you find any reason for not releasing 2.0.40 yet, or
something that you consider worth including in 2.0.40, please
speak up as soon as possible.


2.0.40-rc2

o	Fix ICMP bug				(David S. Miller)
o	Add autodetection for wd1002s-wx2	(Paul, who appears to
	in the xd-driver			 have no last name =])
o	Fix path MTU discovery for		(Kirk Petersen)
	transparent TCP sockets
o	Revert array-size change in		(me, on advise from
	include/linux/module.h			 Jari Ruusu)
o	Remove workaround for gcc-2.4.5		(Adrian Bunk)
	| This is basically a whitespace-
	| change, since it removes code
	| inside an #ifdef #endif clause


2.0.40-rc1

o	Fix possible vmalloc bug for		(Ralf Baechle)
	architectures with virtually
	indexed caches
o	Micro-optimization in vmalloc		(Ralf Baechle)
o	Fix group descriptor corruption		(Daniel Phillips,
	in ext2fs				 Ville Herva,
						 Samuli Kärkkäinen)
o	Fix some missing includes		(me)
o	Change array-size from 0 to 1 for	(me)
	two arrays in the symbol-table
	in include/linux/module.h
o	Fix type of struct timeval xtime in	(me)
	include/linux/sched.h
o	Fix warnings in include/linux/skbuff.h	(me)
o	Fix a few typos in Configure.help	(me)
o	Various small whitespace changes	(me)
	and fixes of strange indentation
	| I know some of you won't like this
	| and I don't give a damn ;-)


2.0.40-pre3

o	Fix typo in sched.c			(Tim Sutherland)
	| this time for real; I applied this
	| patch to the wrong kernel-tree last
	| time, hence the reject
o	IDE probe patch for some ATAPI drives	(Geert Van der Plas)


2.0.40-pre2

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


2.0.40-pre1

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
