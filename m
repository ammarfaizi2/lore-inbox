Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270974AbTGPSFd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 14:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271042AbTGPSCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 14:02:04 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:60240 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S271040AbTGPSB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 14:01:29 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200307161816.h6GIGKH09243@devserv.devel.redhat.com>
Subject: Linux 2.6.0-test1-ac2
To: linux-kernel@vger.kernel.org
Date: Wed, 16 Jul 2003 14:16:20 -0400 (EDT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.0-test1-ac2
o	Fix the generic strncpy				(me)
o	Fix visws pci build				(Andrey Panin)
o	Fix make clean on initramfs_data.S		(Mikael Pettersson)
o	Fix build to use only posix compliant args	(Teemu Tervo)
	to head and tail
o	Fix usb ethernet breakage			(David Brownell)
o	Small ohci fixes				(David Brownell)
o	Fix remaming "seperate" typos in sound		(Steven Cole)
o	Add ikconfig back				(Randy Dunlap)
o	Fix a via-rhine breakage under load		(Roger Luethi)
o	Fix isapnp docs					(Jochen Hein)
o	Fix jffs2 build					(Jamey Hicks)
o	Fix jbd corrupting console log level		(Vita Samel)
o	Fix 8139too driver with swsuspend		(Peter Osterlund)
o	Fix seq8005 driver				(me)
o	Possible synaptics touchpad fix			(Peter Osterlund)
	| Please report if this helps
o	DVB resync					(Michael Hunold)
o	Fix cyrix mtrr breakage				(Zoltán Böszörményi)
o	ppp async xon/xoff support			(Samuel Thibault)
o	Fix non ISA requestirq in pcmcia		(Taral)
o	First cut at fixing ftape for new locking	(Paulo Andre)
o	Fix typo in kernel/sched docs			(Jasper Spaans)
o	Replace illegal with invalid in the many places	(Steven Cole)
	its wrongly used
o	Fix mtrr printk levels				(me)
o	Fix mtrr in 2.5 missing check for corrupting	(me)
	old intel chipset with write combine
o	Fix various wrong paths in IDE docs		(Helge Hafting)
o	Better description for ASIX PCMCIA config	(Komuro)
o	Fix a usb scanner open/close race		(Oliver Neukum)
o	Add more USB vendor ids				(Henning Meier-Geinitz)
o	EMU10K update to match CVS + fixes		(Rudo Thomas)
	| Again feedback appreciated [except from my speakers]
o	Don't assume new intel cpus will have same	(Venkatesh Pallipadi)
	perf registers
o	Further DVB fixes				(Michael Hunold)
o	IPv6 warning fixes				(YOSHIFUJI Hideaki)
o	Fix up the AD1816 driver			(Thorsten Knabe)
o	Initialize nodemgr generation			(Zwane Mwaikambo)
o	Remove obsolete nfsv3 xdr comment		(Frank Cusack)
o	Fix problem with NetApp and auth_gss		(Frank Cusack)
o	Fix iphase use of ioremap under locks		(Francois Romieu)
o	Make keyboard/console always enabled for	(Andi Kleen)
	non embedded
o	Update Changes and ver_linux			(Steven Cole)


2.6.0-test1-ac1
	Merge Linus 2.6.0-test1
	Revert bogus changes to 3c574/3c589_cs
	Revert tcic removals (Linus comment is wrong - we know why and
	fixes are out 8))
	Revert Linus broken spelling change (it is separate)
	[Cite: Oxford English Dictionary]
	Revert btaudio change (my fault - btaudio
	memsets the struct)
o	sethostname and friends corrupted their data	(Stephan Maciej)
	on -EFAULT returns
o	Fix exec elf loader bugs/holes			(me)
o	Fix environ race crash				(me)
o	Fix various proc leaks of data			(Solar Designer)
o	Fix new style serial driver leaks of data	(me)
	| Found by Solar Designer, someone needs to fix other old style
	| drivers
o	Fix incorrect credits for ad1980 plugin		(me)
o	Fix license text for Kalhua driver		(me)
o	Fix make rpm					(Nathan Fredrickson)
o	Fix qla1280 corruption				(Arjan van de Ven)
o	Ad1889 clean up fix				(Fracois Romieu)
o	Remove ip2 dead wood				(Adrian Bunk)
o	Remove pcxx dead wood				(Adrian Bunk)
o	Fix watchdog warnings				(Jan Dittmer)
o	Device mapper updates				(Joe Thornber)
o	Update magic numbers table			(Fabian Frederick)
o	Fix logo bitdepth check				(Bob Tracy)
o	Fix sock done handling				(Jamie Lokier)
o	RLIMIT_NPROC fixes				(Neil Brown)
o	Fix xjack dependancies				(Adrian Bunk)
o	Remove dead serial stuff			(Adrian Bunk)
o	Add support for 82801EB/ER TCO timer		(Wim Van Sebroeck)
o	Backport ZoomVideo PCMCIA support		(me)
o	Backport fixes for yenta socket hang		(me)
o	Fix isapnp check_region abuse			(me)
o	Fix the sym53c8xx irq handler types		(me)
o	Fix aha1542 warnings				(me)
o	Remove escaped MOD_INC_USE_COUNT in cs5520	(me)
o	Fix pas16 and qlogicfas DMA warnings		(me)
o	Remove warnings in phonedev			(me)
	| Still need to make it lock the called module
o	Fix up ni65 driver				(me)

2.5.75-ac (never released) differences remaining unmerged
o	Possible sedlbauer fix				(me)
o	WM97xx touchscreen plugins			(Liam Girdwood)
o	CS4281 fixes for new audio (incomplete)		(me)
o	HAL2 OSS driver					(Ladislav Michl)
o	Harmony OSS driver	(Jean-Christoph Vaugeois, Matthieu Delahaye,
				 Helge Deller, Alex deVries)
o	Cyrix Kahlua audio driver			(me)

Stuff on the todo list
	Forward port aacraid fixes
	Forward port 82092 updates
	Check xjack is in sync
	Fix phonedev/xjack module handling
	Who broke NCR5380 again, more importantly how this time...
	Final sound polish and commit to mark OSS down as done for 2.6
	Look at the horribly out of date 2.5 DRM layer
	Investigate where some of the framebuffers from 2.4 vanished (eg
		stifb)
	Plip appears short 2.4 fixes
	hfsplus is still 2.4 only too
