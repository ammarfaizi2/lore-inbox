Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271216AbTGWS47 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 14:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271221AbTGWS47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 14:56:59 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:37018 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S271216AbTGWSzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 14:55:12 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200307231910.h6NJAHg02616@devserv.devel.redhat.com>
Subject: Linux 2.6.0-test1-ac3
To: linux-kernel@vger.kernel.org
Date: Wed, 23 Jul 2003 15:10:17 -0400 (EDT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Intentionally still focussing on small stuff and driver updates. Lots
more small fixes for driver stuff.

2.6.0-test1-ac3
o	Fix crash with Z85230 on SMP systems		(Dan Carpenter)
o	Resync Z85230 with 2.4				(me)
o	Finish ixj module check over			(me)
o	Fix build of 2.6.x on old old systems		(Mikael Pettersson)
o	Test patch for tosh keyboard bogus repeats	(Chris Heath)
o	Fix non ascii symbols in visor.c		(Jan Kasprzak)
o	Clean up remaining EXPORT_NO_SYMBOLS		(R Krishnakumar)
o	MSDOS file system updates			(OGAWA Hirofumi)
o	Make sure ax8817x actually gets built		(Måns Rullgård)
o	Remove a couple more __NO_VERSION__'s		(Adrian Bunk)
o	Fix module segment checking for parisc		(Rusty Russell)
o	Fix tdfx blit and palette handling		(Richard Drummond)
o	Add new zarus sla300 to USB idents		(Pavel Machek)
o	DC395 updates for testing			(Ali Akcaagac)
	| These are large so want a lot of testing but
	| the resulting driver is looking a fair bit more "Linux"
o	H8300 architecture updates			(Yoshinori Sato)
o	pktgen leak fix					(Kambo Lohan)
o	Fix delay setup in speedstep-ich		(Valdis Kletnieks)
o	Enable AD1980 output flipper plugin
o	Clean ups for harmony, fix config bits		(Francois Romieu)
o	Kahlua leak fix					(Francois Romieu)
o	Airo locking/buffer handling fixes		(Daniel Ritz)
o	Syskonnect sk98 updates				(Ralph Roesler)
o	v850 updates					(Miles Bader)
o	Fix missing formatting on slabinfo		(Junkio)
o	sunrpc doesnt need uaccess.h			(Frank Cusack)
o	Fix rmmod -f tainting				(Rusty Russell)
o	Clean up init_module redefinitions		(Rusty Russell)
o	Add module_put_and_exit for threads		(Rusty Russell)
o	Fix 2 byte leak in old old stat call
o	Add libata SATA driver to 2.6test		(Jeff Garzik)
o	Morse code panic support for test1-ac2		(Tomas Szepe)
o	Fix clashing symbols in dvb code		(Michael Hunold)
o	Switch the OSS drivers back to strlcpy but	(David Härdeman)
	with memset clearing first
o	i2c updates and nvidia i2c			(Hans-Frieder Vogt,
							 Greg Kroahn-Hartmann)
o	Fix section type conflict in sscape audio	(Rusty Russell)
o	Remove remaining missspellings of separate	(Steven Cole)
o	BT audio update					(Gerd Knorr)
o	Update bttv drivers				(Gerd Knorr)
o	USB fixes for isd200/jumpshot			(Matthew Dharm)
o	Remove now dead mode translation code		(Matthew Dharm)
o	Fix documentation warnings			(Greg Kroah-Hartmann)
o	Flush in flight usbs before calling disconnect	(Greg Kroah-Hartmann)
o	Fix cdc-acm tty and devfs names			(Greg Kroah-Hartmann)
o	Update gadget ethernet code			(David Brownell)
o	Update usbtest					(David Brownell)
o	Fix open race in usblp				(Oliver Neukum)
o	Fix usb-serial use after free			(Greg Kroah-Hartmann)
o	Update unusual devices				(Alan Stern)
o	Fix visor memory leak				(Greg Kroah-Hartmann)
o	FIx hpusbscsi bugs				(Oliver Neukum)
o	Fix race in usb-skeleton			(Greg Kroah-Hartmann)
o	Fix race in usb-lcd				(Oliver Neukum)
o	Fix usb storage DMA buffering			(Alan Stern)
o	Improve overcurrent handling with Intel USB	(Alan Stern)
o	Fix irq urb clean up in USB scanner		(Henning Meier-Geinitz)
o	Fix race in dabusb				(Oliver Neukum)
o	Improve locking on endpoint disable		(David Brownell)
o	Add DSS-20 syncstation support			(David Glance)
o	Add more ipaq idents 	(Matthijs van der Molen, Pavel Stoliarov,
				 Tod B. Schmidt, Matt Hartley)
o	Fix up pci_slot_name in USB code		(Greg Kroah-Hartmann)
o	Fix and re-enable the SiS DRM module		(Gaël Le Mignot)

2.6.0-test1-ac2
o	Fix the generic strncpy				(me)
X	Fix visws pci build				(Andrey Panin)
o	Fix make clean on initramfs_data.S		(Mikael Pettersson)
X	Fix build to use only posix compliant args	(Teemu Tervo)
	to head and tail
o	Fix usb ethernet breakage			(David Brownell)
o	Small ohci fixes				(David Brownell)
o	Fix remaining "seperate" typos in sound		(Steven Cole)
o	Add ikconfig back				(Randy Dunlap)
o	Fix a via-rhine breakage under load		(Roger Luethi)
X	Fix isapnp docs					(Jochen Hein)
X	Fix jffs2 build					(Jamey Hicks)
X	Fix jbd corrupting console log level		(Vita Samel)
o	Fix 8139too driver with swsuspend		(Peter Osterlund)
X	Fix seq8005 driver				(me)
o	Possible synaptics touchpad fix			(Peter Osterlund)
	| Please report if this helps
o	DVB resync					(Michael Hunold)
X	Fix cyrix mtrr breakage				(Zoltán Böszörményi)
o	ppp async xon/xoff support			(Samuel Thibault)
X	Fix non ISA requestirq in pcmcia		(Taral)
X	First cut at fixing ftape for new locking	(Paulo Andre)
X	Fix typo in kernel/sched docs			(Jasper Spaans)
o	Replace illegal with invalid in the many places	(Steven Cole)
	its wrongly used
X	Fix mtrr printk levels				(me)
X	Fix mtrr in 2.5 missing check for corrupting	(me)
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
X	Remove obsolete nfsv3 xdr comment		(Frank Cusack)
o	Fix problem with NetApp and auth_gss		(Frank Cusack)
o	Fix iphase use of ioremap under locks		(Francois Romieu)
o	Make keyboard/console always enabled for	(Andi Kleen)
	non embedded
X	Update Changes and ver_linux			(Steven Cole)


2.6.0-test1-ac1
	Merge Linus 2.6.0-test1
	Revert bogus changes to 3c574/3c589_cs
	Revert tcic removals (Linus comment is wrong - we know why and
	fixes are out 8))
	Revert Linus broken spelling change (it is separate)
	[Cite: Oxford English Dictionary]
	Revert btaudio change (my fault - btaudio
	memsets the struct)
X	sethostname and friends corrupted their data	(Stephan Maciej)
	on -EFAULT returns
o	Fix exec elf loader bugs/holes			(me)
o	Fix environ race crash				(me)
o	Fix various proc leaks of data			(Solar Designer)
o	Fix new style serial driver leaks of data	(me)
	| Found by Solar Designer, someone needs to fix other old style
	| drivers
X	Fix incorrect credits for ad1980 plugin		(me)
X	Fix license text for Kalhua driver		(me)
X	Fix make rpm					(Nathan Fredrickson)
X	Fix qla1280 corruption				(Arjan van de Ven)
X	Ad1889 clean up fix				(Fracois Romieu)
X	Remove ip2 dead wood				(Adrian Bunk)
o	Remove pcxx dead wood				(Adrian Bunk)
X	Fix watchdog warnings				(Jan Dittmer)
o	Device mapper updates				(Joe Thornber)
X	Update magic numbers table			(Fabian Frederick)
o	Fix logo bitdepth check				(Bob Tracy)
o	Fix sock done handling				(Jamie Lokier)
o	RLIMIT_NPROC fixes				(Neil Brown)
X	Fix xjack dependancies				(Adrian Bunk)
o	Remove dead serial stuff			(Adrian Bunk)
X	Add support for 82801EB/ER TCO timer		(Wim Van Sebroeck)
X	Backport ZoomVideo PCMCIA support		(me)
o	Backport fixes for yenta socket hang		(me)
X	Fix isapnp check_region abuse			(me)
X	Fix the sym53c8xx irq handler types		(me)
X	Fix aha1542 warnings				(me)
o	Remove escaped MOD_INC_USE_COUNT in cs5520	(me)
X	Fix pas16 and qlogicfas DMA warnings		(me)
o	Remove warnings in phonedev			(me)
	| Still need to make it lock the called module
X	Fix up ni65 driver				(me)

2.5.75-ac (never released) differences remaining unmerged
o	Possible sedlbauer fix				(me)
o	WM97xx touchscreen plugins			(Liam Girdwood)
o	CS4281 fixes for new audio (incomplete)		(me)
X	HAL2 OSS driver					(Ladislav Michl)
X	Harmony OSS driver	(Jean-Christoph Vaugeois, Matthieu Delahaye,
				 Helge Deller, Alex deVries)
X	Cyrix Kahlua audio driver			(me)

Stuff on the todo list
	Forward port aacraid fixes
	Forward port 82092 updates
	Check xjack is in sync
	Who broke NCR5380 again, more importantly how this time...
	Final sound polish and commit to mark OSS down as done for 2.6
	Look at the horribly out of date 2.5 DRM layer
	Investigate where some of the framebuffers from 2.4 vanished (eg
		stifb)
	Plip appears short 2.4 fixes
	hfsplus is still 2.4 only too
