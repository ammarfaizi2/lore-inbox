Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317409AbSFHPuz>; Sat, 8 Jun 2002 11:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317412AbSFHPuz>; Sat, 8 Jun 2002 11:50:55 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:12462 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S317409AbSFHPuy>;
	Sat, 8 Jun 2002 11:50:54 -0400
Date: Sat, 8 Jun 2002 17:50:53 +0200
From: David Weinehall <tao@acc.umu.se>
To: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCEMENT] Linux-kernel v2.0.40-rc5
Message-ID: <20020608175053.G8523@khan.acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yet another release-candidate. The important things here are
the SuS/LSB compliance fixes by Christopher Yeuh.


2.0.40-rc5

o	Ignore SIGURG in SIG_DFL, as per SUSv3	(Christopher Yeoh, me)
o	Fix ipc/sem.c SuS/LSB compliance	(Christopher Yeoh)
	| Both these fixes contains whitespace
	| changes. Don't blame poor Chris for
	| this; I made them.
o	Changes to MAINTAINERS			(Riley Williams, me)
	| Added Riley Williams
	| Various tidying
	| Updated the address to the
	| Appletalk mailing-list
	| Updated Christoph Lameter's
	| e-mail address
	| Updated Andre Hedrick's entry
	| Updated Thomas Bogendörfer's entry
	| Updated Martin Mares' e-mail address


2.0.40-rc4

o	Commented out a printk in fs/buffer.c   (Michael Deutschmann)
	that complains about mismatching
	blocksizes

2.0.40-rc3

o	Fix memory-leak in af_unix		(Jon Nelson, Alan Cox, me)

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


/David
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
