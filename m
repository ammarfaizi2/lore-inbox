Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S156310AbPGBAYF>; Thu, 1 Jul 1999 20:24:05 -0400
Received: by vger.rutgers.edu id <S155625AbPGBASx>; Thu, 1 Jul 1999 20:18:53 -0400
Received: from devserv.devel.redhat.com ([207.175.42.156]:21095 "EHLO devserv.devel.redhat.com") by vger.rutgers.edu with ESMTP id <S156090AbPGBAH3>; Thu, 1 Jul 1999 20:07:29 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <199907020007.UAA03365@devserv.devel.redhat.com>
Subject: Linux 2.2.10ac6
To: linux-kernel@vger.rutgers.edu
Date: Thu, 1 Jul 1999 20:07:28 -0400 (EDT)
Content-Type: text
Sender: owner-linux-kernel@vger.rutgers.edu


	ftp://ftp.*.kernel.org/pub/linux/kernel/alan/...


2.2.10ac6
o	Handle corrupt EFS superblocks		(Andrzej M. Krzysztofowicz)
o	Cyclades driver update			(Ivan Passos)
o	Z85230 driver fixes			(Daniel Marmier)
o	Merge 2.2.11pre1
o	Bounding set sysctl			(Matthew Kirkwood)
o	Fix lvm + !proc compile case		(Marcelo Tosatti)
o	Fix radiotrack2 compiled in case	(Jeremy Boulton)
o	Fix socket/glibc clash			(David Woodhouse)
o	SPARC resync				(Dave Miller)
o	Hash bucket fixes for TCP etc		(Dave Miller)
o	Enable SLAB poisoning so we can try 
	and get more clues on the disk problem
	a few folks see				(me)
o	Merge a slightly cleaned up Buz driver	(Rainer Johanni, Dave Perks)
	| I 'cleaned' this a bit so mail me bugs first not them

2.2.10ac5
o	Problems with new epic100 - backed out
o	Further small MIPS merges		(Ralf Baechle)
o	Fix sysctl for sysrq			(Willy Tarreau)
o	Wait longer on bootup for keyboard	(priikone)
o	FAT16/FAT28 update 			(Al Viro)
o	Removable media disk change bug fix	(Giuliano Pochini)
o	Allow Masq to handle extended irc CTCP	(Scottie Shore)
o	Fix shared IRQ handling in serial.c	(David Hinds)
o	Fix "doubly enqueued task"		(Trond Myklebust)
o	Sysctl doc update			(Peter Breitenloher)
o	DEPCA oversize packet fix		(Alexey Kuznetsov)


2.2.10ac4 
o	Merge with all the MIPS tree		(Ralf Baechle and co)
o	Trix sound driver takes "joystick=1"	(me)
o	Updated EPIC100 driver			(Don Becker)
o	Updated NE2K PCI driver			(Don Becker)
o	Updated RTL8139 driver			(Don Becker)
o	Updated Tulip driver			(Don Becker)
o	Updated VIA Rhine driver		(Don Becker)


2.2.10ac3
o	SCSI cmd_len fix			(?? off linux-kernel)
o	IN2000 SCSI fixes for newer binutils	(Alan Modra)
o	SMP scsi fixes				(Marcelo Tosatti/me)
o	Tulip fix				(Keith Owens)
o	Never oom init				(Andrea Arcangeli)
o	Fix eepro100 ring alignment		(Jes Sorensen)
o	Make sysrq runtime configurable		(me)
o	Quota race fix updates			(Jan Kara)
o	ARP crash fix				(Alexey Kuznetsov)
o	Drop the problematic sangoma stuff	(me)
o	Fix an NFS rpc out of memory handler	(James Yarbrough)
o	Fix cadet data corruption bug		(Fredrick Gleason)
o	Large nbd size fix			(??)
o	Shaper device stats			(Jordi Murgo)

2.2.10ac2
o	LVM support				(Heinz Mauelshagen)
o	Fix scsi and bttv symbol problems	(me)
o	SCSI sleep handling bug fix		(Chris Loveland)
o	Qlogic update				(Chris Loveland)
o	Now assume all ZIP IDE floppy firmware is
	funny. Testing seems to imply it is	(me)
o	Fix alpha compile bug			(Daniel Frasnelli)

2.2.10ac1
o	BTTV support for ultrasparc		(DaveM)
o	Tridge is smbfs maintainers		(Andy Tridgell)
o	Fix Coda includes			(Arvind Sankar)
o	Fix mknod over knfsd			(Pavel Krauz)


What is different between 2.2.10 and 2.2.10ac (main items)

o	System 5 file system supports V7 disk format
o	2Gig support or some alphas
o	Choose 1 or 2Gig support for X86
o	APM update
o	Large file arrays
o	Sparc 64 bttv TV card support
o	Mappable DMA memory driver for the G200 3D project
o	WDT watchdog configure options (command line yet to do)
o	IBM PCI token ring driver
o	ARLAN driver
o	Sealevel systems 4021 driver
o	SEEQ 8005 driver can be a module
o	SCSI-2 names known by the scsi loggers
o	Better handling of out of memory during scsi load/unload
o	SCSI error handler doesn't stop initrd unloads
o	Experimental sb mode enablers for ESS Maestro-1
o	Misc small sound fixes
o	ESS sound fixes (WIP)
o	VGA16 console support
o	Quota race fixes
o	Faster NFS client layer
o	Updated knfsd
o	Updated Sangoma drivers (seem to have bugs)
o	gethere trick for better network code generation
o	drop kernel lock on some performance critical user access paths
o	Multipath routing
o	Updated ksymoops package


	Alan Cox, Building #3		Red Hat Software
	 		<alan@redhat.com>
	  Spamfiltered by ORBS - http://www.orbs.org

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
