Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314787AbSEUP34>; Tue, 21 May 2002 11:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314755AbSEUP3z>; Tue, 21 May 2002 11:29:55 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:57051 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S314743AbSEUP3y>; Tue, 21 May 2002 11:29:54 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200205211529.g4LFTsQ06820@devserv.devel.redhat.com>
Subject: Linux 2.2.21
To: linux-kernel@vger.kernel.org
Date: Tue, 21 May 2002 11:29:54 -0400 (EDT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.2.21
o	Add 32/64bit ioctl handling for random driver	(Marco Colombo)

2.2.21rc4
o	SiS900 updates					(Mufasa Yang)
o	Correct kd.h macros				(Andrej Lajovic)
o	sg buffer clean fix				(Douglas Gilbert)

2.2.21rc3
o	Plan B driver updates				(Michel Lanners)
o	3ware raid update				(Adam Radford)
o	Fix PowerMac compile				(Krzysiek Taraszka)
o	Fix nvram/rtc ioctl returns			(Paul Gortmaker)
o	OV511 compile/build fixes			(Toru SAGAMI)
o	Final ppp zlib bits				(Paul Mackerras)

2.2.21rc2
o	Fix Xeon crash on boot 				(Dave Jones)
o	Update keyspan maintainer			(Greg Kroah-Hartmann)
o	Fix visor oops add palm m125 support		(Greg Kroah-Hartmann)
o	Update whiteheat driver to fix SMP locking	(Greg Kroah-Hartmann)
o	Fix head.S asm for cpu type			(Mikael Pettersson)

2.2.21rc1
o	Add farsync driver				(Bob Dunlop)
o	Fix x86 cpu type reporting in some cases	(Barry Nathan)
o	Fix module_license tag compatibility macro	(Keith Owens)
o	Update MAINTAINERS entry			(Mark McClelland)
o	Fix fb.h comment error				(Krzysiek Taraszka)
o	Zlib fix					(Arjan van de Ven)
o	Back out problem mce change

2.2.21pre4
o	Fix FAT breakage in pre3			(Dmitry Levin)
o	Add S/390 LCS driver (IBM opensourced it now)	(DJ Barrow,
							 Frank Pavlic)
o	Update COPYING file to match FSF update		(Dan Quinlann)
	| basically swap 19xx example for this century..
o	Fix a file name comment				(William Stearns)
o	Add realtek phy support to 2.2 sis900 driver	(Allan Jacobsen)
o	Fix MCE address reporting order, fix oops with	(Dave Jones)
	newer gcc due to bad asm constraints
o	Starfire update					(Ion Badulescu)
o	Always victimise the dcache a little when	(John Lash, me)
	short of memory

2.2.21pre3
o	Fix a case where a non blocking tty write could	(Peter Benie)
	get stuck
o	Fix non blocking midi close on es1370, es1371	(me)
	sonicvibes right this time 
o	Fix menu/xconfig warnings			(René Scharfe)
o	Fix non blocking midi close on cmpci, cs4281,	(me)
	esssolo, trident.
o	Add eepro100VE ident				(Hanno Boeck)
o	Fix DRM oops case				(Herbert Xu)
o	Fix an oops causing datagram AF_UNIX race	(Paul Menage)
o	Support newer geodes using new CPUID properly	(Hiroshi Miura)
o	Fix up RTC build for non pmac ppc boxes		(Tom Rini)
o	Fix MCE address reporting			(Pete Wyckoff)
o	Vibra16 docs update				(Neale Banks)
o	Eicon include file fix				(Herbert Xu)
o	ISDN loop and header fixes			(Kai Germaschewski)
o	Fix eepro100 out of memory during init path	(Neale Banks)
o	Fix BSD partition table handling breakage	(Andries Brouwer)
o	Add WD XD signature to xd driver		(Paul)
o	3Ware driver update				(Adam Radford)
o	S/390 debugging updates				(Carsten Otte)
o	S/390 DASD updates				(Carsten Otte)
o	S/390 CIO updates				(Carsten Otte)
o	Update USB serial, belkin, digi_acceleport,	(Greg Kroah-Hartmann)
	empeg, ftdsio, edgeport, keyspan, mctu232,
	omninet, prolific, visor
o	Cyberjack USB driver				(Matthias Bruestle)
o	USB ir dongle driver				(Greg Kroah-Hartmann)
o	Support very large FAT file systems		(Vijay Kumar)
o	Backport 2.4 modversions build fix		(Mikael Pettersson)
o	Backport 2.4 es1371 init for new revs		(Julian Anastasov)
o	3c507 driver fixes				(Mark Mackenzie)
o	ext2 obscure group descriptor corruption fix	(Daniel Phillips,
							 Al Viro)
o	Correct a problem where rpciod didnt give up	(Andreas Haumer)
	its current dir

2.2.21pre2
o	Fix non blocking midi close on es1370, es1371	(me)
	sonicvibes
o	Update osst driver				(Willem Riede)
o	Update machine check support in 2.2 to match 2.4(Dave Jones)
o	Additional P4, Rise, Winchip handling for setup	(Dave Jones)
o	Fix extended MMX initialisation on Cyrix MII	(me)
o	Backport a lot of x86 setup (cache size etc)	(Dave Jones)
o	ISDN cleanups					(Kai Germaschewski)
o	Backport eicon driver fixes			(Kai Germaschewski)
o	ISDN ppp fixes					(Andre Beck)
o	Fix timeout handling in eicon driver		(Kai Germaschewski)
o	Fix null pointer bug in isdnloop		(Kai Germaschewski)
o	Menuconfig refresh fixup			(Willy Tarreau)
o	Modular ati frame buffer build fix		(Krzysztof Taraszka)
o	Backport VIA chipset fixes to 2.2		(me)
o	Make DCD high->low work on SX16 with CLOCAL set	(Ado Arnolds)

2.2.21pre1
o	Fix potential corruption with vmalloc on	(Ralf Baechle)
	virtually cached boxes
o	Small PPC build fixups				(Tom Rini)
o	zImage booting fix				(Kalev Soikonen)
o	EIO on NFS read fixup				(Trond Myklebust)
o	Update 3ware raid driver			(Adam Radford)
o	page_alloc race fix				(Andrea Arcangeli)
o	Update USB maintainers				(Greg Kroah-Hartmann)
o	bttv clipcount=0 fix				(Solar Designer)
o	Fix multiple eepro driver bugs			(Aris)
o	Sym53c8xx queue handling fix			(Gerard Roudier)
o	Update SubmittingDrivers document		(Michal Svec)
o	8139too performance tune			(Jens David)
o	procfs follow link return fix			(Solar Designer)
o	Backport SEM_UNDO overflow fix from 2.4		(Leonid Igolnik)
o	VM86 fixes					(Manfred Spraul)
o	Fix alpha build					(Kim Heino)
