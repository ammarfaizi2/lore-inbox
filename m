Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267118AbTBTWXH>; Thu, 20 Feb 2003 17:23:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267175AbTBTWXH>; Thu, 20 Feb 2003 17:23:07 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:14252 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267118AbTBTWXC>; Thu, 20 Feb 2003 17:23:02 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200302202233.h1KMX8408821@devserv.devel.redhat.com>
Subject: Linux 2.5.62-ac1
To: linux-kernel@vger.kernel.org
Date: Thu, 20 Feb 2003 17:33:08 -0500 (EST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This has more IDE and PCI toys. Handle with care. This brings most of the
quirk handling from 2.4 into 2.5. The ALi Magick one requires the video4linux
stuff is fixed in 2.5 as well. I've not yet merged the 450NX patch to mtrr
(450NX mtrr write combining has errata)

Linux 2.5.62-ac1
	Merge Linus 2.5.62
o	UNEXPECTED_IO_APIC can be static		(Pavel Machek)
o	Update IPMI driver to version 18		(Corey Minyard)
o	Tons of spelling fixes				(Steven Cole)
o	FBdev updates					(James Simmons)
o	PC-9800 update					(Osamu Tomita)
o	Remove dead scripts				(Brian Gerst)
o	v850 updates					(Miles Bader)
o	Update 3c523 to new MCA api (untested)		(James Bottomley)
o	Toshiba keyboard workaround			(Pavel Machek)
o	Fix mremap file name in comments		(Paul Larson)
o	Firestream typo fixes				(Maciej Soltysiak)
o	Backport trident reset fix from 2.4		(Muli Ben-Yehuda)
o	Morse code panics are back!			(Tomas Szepe)
o	Fix aicasm build				(Bob Tracy)
o	Fixes for 700/710 drivers			(Rolf Eike Beer)
o	Spelling fixes					(Rolf Eike Beer)
o	Optimise CRC32					(Joakim Tjernlund)
o	Next batch of v850 updates			(Miles Bader)
o	Takayoshi Kochi has moved email			(Takayoshi Kochi)
o	SunRPC race fix					(Trond Myklebust)
o	Refix addr/port naming confusion in IDE iops	(me)
o	Forward port VIA APIC handling quirks		(me)
o	Forward port ALi magick quirk flag handler	(me)
	| Needs bt848 etc to acquire the fix too
o	Forward port IDE bases fix			(me)
o	Forward port pci irq search for legacy IDE	(me)

Linux 2.5.61-ac1
	Merge Linus 2.5.61
o	Fix aic7xxx makefile				(Sam Ravnborg)
o	Fix ieee1394 build on Alpha			(Ben Collins)
o	Fix isdn_net build with X.25			(Adriank Bunk)
o	Typo fix					(Steven Bosscher)
o	A pile of other typo fixes			(Steven Cole)
o	C99 initializers				(Art Haas)
o	dasd typo fix					(Maciej Soltysiak)
o	Remove an unused variable in sunrpc		(Robert Love)
o	Remove duplicate different BSD partition names	(Andries Brouwer)
o	PPC plural fix					(Steven Cole)
o	EISA driver class patches			(Marc Zyngier)
o	VIA Rhine updates				(Roger Luethi)
o	Further ppa scsi fix				(John Kim)
o	Kill unused __beep				(Hugh Dickins)
o	Merge visws support 				(Andrey Panin)
	| Some collisions with pc9800 but should be ok
o	Limits for upward growing stacks		(Matthew Wilcox)
o	ucLinux updates					(Greg Ungerer)
o	68328 frame buffer updates			(Greg Ungerer)
o	Merge ucLinux H8300 support			(Yoshinori Sato)
o	Fix aironet compile				(Ookhoi)
o	Fix DMA mask on OSS trident driver		(Ivan Kokshaysky)
o	Kill some old 2.4 glue code in DRM		(John Kim)
o	Fix compile of old "hd.c" driver		(Paul Gortmaker)
o	Add experimental BOCHS virtualisation		(Kevin Lawton)
o	Clean up intermezzo driver			(Adrian Bunk)
o	Clean up rio use of compatmac			(Adrian Bunk)
o	Remove 2.0 ifdefs from ipchains code		(Adrian Bunk)
o	Remove old junk from efs 			(Adrian Bunk)
o	Remove old 2.0/2.2 junk from media/video	(Adrian Bunk)
o	Remove unused variable in ali-ircc		(Adrian Bunk)
o	Remove 2.0 ifdefs from network drivers		(Adrian Bunk)
o	Clean up uglies in inia100			(Adrian Bunk)
o	Clean up uglies in i91u scsi 			(Adrian Bunk)
o	Clean up wan drivers 2.0/2.2 code		(Adrian Bunk)
o	Restore ontrack remap support			(Jim Houston)
	| I'd really like to see this get turned into device mapper..
o	Forward port emu10k1 driver to 2.5		(Rui Souza)
o	Fix boot on EPOX 4BEA-R and friends		(Alexandar Achenbach)
o	Switch alpha cia code to static inline		(Matt Reppert)
o	Fix pcmcia scsi compile breakages		(Mike Anderson)
o	EHCI workarounds				(David Brownell)

Linux 2.5.60-ac1 (not published)
	Includes Linus BK snapshot
	Merge relevant pieces from old -ac		(me)
	| Dropped visws and stuff thats been redone
	| also dropped out IRQ stacks (port is tricky!)
o	Fix build of cciss driver			(me)
o	Fix build of 3036 tv tuner			(me)
o	Remove i2o_lan					(me)
o	Fix i2o_scsi					(Randy Dunlap)
o	Fix iph5526 scsi changes (not fixed DMA)	(me)
o	Make starfire compile				(me)
o	Make mca-legacy warn if used			(me)
o	Make sim710 build with EISA			(me)
o	Make ultrastor compile				(me)
o	Make aha152x/aha154x build			(Randy Dunlap)
o	Fix aha154x/mca bits				(me)
o	Fix fd_mcs build				(me)
o	Fix NCR53c406a.c				(me)
o	Fix sym53c416.c					(me)
o	Fix ibmmca compile				(me)
o	Fix ppa compile					(me)
o	Fix NCR539x compile				(John Kim)
o	Fix mca_53c9x compile				(me)
