Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264938AbTB0Qvn>; Thu, 27 Feb 2003 11:51:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264940AbTB0Qvn>; Thu, 27 Feb 2003 11:51:43 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:5248 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S264938AbTB0Qvi>; Thu, 27 Feb 2003 11:51:38 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200302271701.h1RH1vR08183@devserv.devel.redhat.com>
Subject: Linux 2.4.21-pre4-ac7
To: linux-kernel@vger.kernel.org
Date: Thu, 27 Feb 2003 12:01:57 -0500 (EST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Flushing the pending pile before resynchronizing with Marcelo and 
filling his mailbox with fixes

Linux 2.4.21pre4-ac7
o	Next chunk of DRM merge towards 4.3 codebase
o	Fix ide-scsi deadlock on reset with SMP		(me)
o	Add some sun arrays to the scsi quirks list	(Joel Buckley)
	| They want multilun scanning always
o	Fix skbuff abuse in atm lec			(Chas Williams)
o	Update the ips driver 				(Jack Hammer)
o	Fix intelfb compile on SMP			(Arjan van de Ven)
o	One shot elevator contention fixing cache 	(Stephen Tweedie)
o	Support swapoff from initrd			(Stephen Tweedie)
o	Add another transparent bridge quirk		(Arjan van de Ven)
o	ieee1394 sleep fixes				(Arjan van de Ven)
o	Use 0xff for cpu target				(Arjan van de Ven)
o	kmap leak fix for nfs symlink			(Arjan van de Ven)
o	Fix incorrect kernel/user address handling	(me)
	crash in swapoff (root only)
o	kiovec accelerator				(??)
o	Export symbol needed by ipmi			(Andreas Haumer)
o	Add another 3c59x pci identifier		(Daniel Kopko)
o	Alpha build fix					(Elliot Lee)
o	Add new chips to e100				(Matt Wilson)

Linux 2.4.21pre4-ac6
o	Update IPMI to v18				(Corey Minyard)
o	More intel PIIX identifiers			(Bill Nottingham)
o	Update e100 for new identifiers			(Jeff Garzik)
o	Update Athlon SSE enabler			(Dave Jones)
o	Update auerswald USB isdn driver		(Wolfgang)
o	USB storage updates				(Matthew Dharm)
o	Add tripp idents to the pl2303 usb serial	(John Moses)
o	Add a new ftdi_sio ident			(Philipp G�hring)
o	Remove unused ohci driver field			(Johannes Erdfelt)
o	Fix EHCI abuse of SLAB_KERNEL in interrupt	(Oliver Neukum)
o	Fix dhcp on kaweth				(Oliver Neukum)
o	Fix some wrong idents in the pegasus driver	(Petko Manolov)
o	Fix ipaq name in usbnet				(Carsten)
o	USB macro cleanup				(Joern Engel)
o	Remove proc files in uhci that get stuck
o	Remove wrong comment in ohci/uhci drivers	(Johannes Erdfelt)
o	Roland SC8820 USB midi support			(Andrew Wood)
o	Fix USB naming bug				(Johannes Edrfelt)
o	Add ontrack to the hid ignore list		(Greg Kroah Hartmann)
o	Add tangtop to the hid blacklist		(Greg Kroah Hartmann)
o	USB scanner updates				(Henning Meier-Geinitz)
o	Fix an oom handling bug in sis drm
o	DRM updates for Radeon
	| Flightgear now takes > 2hrs to hang on my R9000
o	Fix various abusers of GFP_KERNEL in USB	(Arjan van de Ven)
o	Fix aic7xxx updates eaten by exclude file	(Sergio Visinoni)
o	Use check_gcc on crusoe				(Stelian Pop)
o	Update sonypi and meye drivers			(Stelian Pop)
o	Make input layer accept jogdial as valid	(Stelian Pop)
o	Intel i8xx framebuffer driver			(David Dawes)

Linux 2.4.21pre4-ac5
o	Fix the AMD ide bug() on boot up
o	Pass device to outbsync so that we can whack	(Ben Herrenschmidt)
	the bridge on weird platforms
o	Default sl82c05 second channel to PIO0		(Ben Herrenschmidt)
o	EHCI speed up fixes				(David Brownell)
o	Assorted cpia fixes				(Duncan Haldane)
o	SSE enable for later Athlon			(Daniel Egger)
o	3com 3c990 driver 				(David Dillow)
o	Fix config syntax error in DRM config		(Andrzej Krzysztofowicz)
o	Update pci-skeleton to fix pad bug in example	(me)
	| Noted by Roger Luethi
o	Supress popping when audio starts on via82cxxx	(Jorg Schuler)
o	Fix reiserfs direct I/O crash			(Oleg Drokin)
o	Allow cramfs initrd				(Christoph Hellwig)
o	Fix error path on dscc wan driver		(me)
o	Fix sign mishandling in epca driver		(me)
o	Fix sign mishandling in mwave driver		(Oleg Drokin)
o	Fix sign mishandling in mpt fusion		(Oleg Drokin)
o	Fix sign mishandling in aacraid			(Oleg Drokin)
o	Fix sign mishandling in tun			(Oleg Drokin, me)

Linux 2.4.21pre4-ac4
o	Attach a fake id struct to old/unprobed drives	(me)
	| Fixes a ton of special casing some of which was
	| buggy.
o	Fix incorrect sign handling in setup-pci noted	(me)
	by Oleg Drokin
o	Fix bogon error returns from init_chipset noted	(me)
	by Oleg Drokin
	| Fixes hpt366 crash on 66Mhz bus
o	Fix mishandling of flash/disk combinations	(me)
o	Fix handling of /proc/ide/*/identify with	(me)
	no driver loaded (band aid for now)
o	Fix IDE hang on rmmod and on poweroff		(me)
o	Fix IDE printk <6> bug				(Henning Schmiedehausen)
o	Radeon no longer needs AGPgart			(James McClain)
o	REPORTING-BUGS typo fix				(Faik Uygur)
o	ndelay() for PPC				(Ben Herrenschmidt)
o	PPC ioflush handling				(Ben Herrenschmidt)
o	PowerMac IDE updates				(Ben Herrenschmidt)
o	8169 missing includes for Alpha build		(Geoffrey Lee)
o	Fix sisfb build on boxes with no MTRR		(Geoffrey Lee)
o	Fix cpqfc build on Alpha			(Geoffrey Lee)
o	Fix forte build on Alpha			(Geoffrey Lee)
o	Add eth_io_copy_and_sum for Alpha		(Geoffrey Lee)
o	Fix bogus semicolon in 8253xtty			(Oleg Drokin)
o	Fix incorrect if in megaraid driver		(Oleg Drokin)
o	Fix sign warning in radio_cadet driver found	(me)
	by Oleg Drokin

Linux 2.4.21pre4-ac3
o	ALi FIFO setup channel fix			(Al Viro)
	| This needs careful testing. Treat -ac3 with a lot of care
	| on ALi platforms and report how it goes
o	Fix the dma waiting overflow			(Ben Herrenschmidt)
o	Fix ATAPI devices on VIA8235			(Vojtech Pavlik)
o	Add ndelay for Alpha				(Ivan kokshaysky)
o	Give ndelay sensible argument names		(Geert Uytterhoeven)
o	Fix pcnet32 big endian filtering		(Marcus Meissner)
o	Fix ordering problem with PCI radeon causing	(Chris Ison)
	DRI hangs
o	Fix C3 gcc compiler flags for newer gcc		(Jeff Garzik)
o	Replace nvidia and amd IDE drivers with new	(Vojtech Pavlik)
	driver
o	Fix missing ; in aicasm_gram.y			(Thibaut VARENE)
o	NCR5380 trivial fix				(Geert Uytterhoeven)
o	Make constants in maxiradio static		(Arnd Bergmann)
o	Fix typos of 'available'			(Alfredo Sanjuan)
o	Fix wrong checks in bttv ioctl code	(Alexandre Pereira Nunes)
o	Fix i2c_ack cris extra ";"
o	Fix JSIOCSBTNMAP extra ";"
o	Fix VIDIOCGTUNER on w9966
o	Fix amd8111e_read_regs
o	Fix smctr_load_node_addr
o	Fix sym53c8xxx extra ";"
o	Fix sym53c8xxx_2 extra ";"
o	Fix cs46xx download area clear
o	Fix hysdn bootup error handling
o	Fix mtd mount error checks
o	Fix dpt_i2o reset error paths
o	Fix a jffs error path handler
o	Fix es1371 error path on register
o	Fix sscape operator precedence
o	Fix copy counting in vrc5477 audio
o	Fix cdu31a oops with data cd			(Mauricio Martinez)
o	Fix ide taskfile if ";" errors			(Oleg Drokin)
o	Add 3com 3c460 to kaweth			(Oliver Neukum)
o	Kaweth length/dhcp fix				(Oliver Neukum)
o	ISD-200 requires IDE				(Olaf Hering)

Linux 2.4.21pre4-ac2
o	Turn on use of ide_execute_command everywhere	(Ross Biro, me)
o	First cut at settings locking for IDE		(me)
o	Add driver for CS5530 Kahlua audio		(me)
o	Fix wrong semicolons in system.h		(Mikael Pettersson)
o	Support root=nbd				(Ben LaHaise)
o	x86 byte order swapping optimisations		(Andi Kleen)
o	PMAC ide updates				(Ben Herrenschmidt)
o	Fix mishandling of nfsroot port= option		(Eric Lammerts)
o	Fix ALi audio on systems with > 2Gb RAM		(Ivan Kokshaysky)
o	Enable generic rtc on PPC boxes			(Geert Uytterhoeven)
o	Fix ide build with gcc 3.3 snapshot		(Olaf Hering)
o	Merge EHCI updates (qh state machine fix etc)	(David Brownell)
o	Fix radio-cadet SMP build			(Adrian Bunk)
o	Starfire updates				(Ion Badulescu)
o	Backport seq_file fix to 2.4			(Eric Sandeen)
o	Fix ext3 crash deleting a single non sparse	(Stephen Tweedie)
	file exceeding 1Tb

Linux 2.4.21pre4-ac1
o	Restore the mmap corner case fix		(Raul)
o	Add sendfile64 to 2.4.x				(Christoph Hellwig)
o	NLM garbage collection hang fix			(Daniel Forrest)
o	Enable kernel side pcigart for radeon		(Michael Danzer)
	| Requires recent XFree and ForcePCIMode
o	Don't bash legacy floppy on x86_64 bootup	(Mikael Petersson)
o	Forward sony joygdial input to input layer	(Stelian Pop)
o	TCP session stall fix				(Alexey Kuznetsov)
o	Ian Nelson has moved				(Ian Nelson)
o	Add unplugged iops ready for hotplug IDE support(me)
o	Add an OUTBSYNC iop for the IDE layer		(Ben Herrenschmidt)
o	Finish the ide_execute_command code		(me)
o	Switch ide-cd to ide_execute_command 		(me)
	| Always good to test stuff on read only devices first 8)
o	Fix IDE masking logic error			(Ross Biro)
o	Fix IDE mishandling of IRQ 0 devices		(me)
o	Fix printk levels on promise drivers		(me)
o	Clean up duplicate mmio ops/printk in siimage	(me)
o	Always set interrupt line with VIA northbridge	(me)
	| Should fix apic mode problems with USB/audio/net on VIA boards
o	Add Diamond technology dt0893 codec		(Thomas Davis)
o	Add IBM 'Ruthless' platform string to summit
o	Don't warn about IRQ when enabling a pure	(me)
	legacy mode IDE class device
o	Clean up radio_cadet locking and other bugs	(me)
o	Fix jiffies mishandling in eata drivers		(Tim Schmielau)
o	Quieten confusing DMA disabled messages		(Tomas Szepe)
o	i830 DRM update port over			(Arjan van de Ven)

Linux 2.4.21pre3-ac5
o	Fix erratic oopsing on 2.4.21pre3-ac*		(Hugh Dickins)
o	Fix an incorrect check in raw.c			(Artur Frycze)
o	Fix highmem IDE DMA				(Jens Axboe)
o	Fix the size of the EDD area			(Kevin Lawton)
o	Remove incorrect ACPI blacklist entry		(Pavel Machek)
o	SCSI memory leak fix				(Justin Gibbs)
o	Fix mmap of vmalloc area in kmem giving wrong	(Tony Dziedzic)
	results
o	Fix date in the microcode driver		(Jonah Sherman)
o	Fix incorrect smc9194 handling of skb_padto	(David McCullough)
o	Fix use of old check_regio function in umc8672	(William Stinson)
o	Remove unused variable in sc1200		(Bob Miller)
o	Perform ide_cs unregister in task context	(Paul Mackerras)
	| This doesn't fix all the bugs yet...
o	Fix bugs in the gx power management code	(Hiroshi Miura)
o	Fix the sl82c105 driver for the new IDE code	(Benjamin Herrenschmidt,
							 Russell King)
o	Remove cacheflush debug printk			(me)
o	Fix IDE paths in docs for new layout		(Karl-Heinz Eischer)
o	Generic RTC driver backport			(Geert Uytterhoeven)
o	HDLC driver updates				(Krzysztof Halasa)
o	AMD8111 random number generator support		(Andi Kleen)
o	Fix crashes on e2100 driver			(me)

Linux 2.4.21pre3-ac4
o	Finish verifying PIIX/ICH drivers versus errata	(me)
o	Fix handling of DMA0 MWDMA on early ICH		(me)
o	Fix compile in kernel for Aurora SIO16		(Adrian Bunk)
o	Clean up various Configure.help bits		(Adrian Bunk)
o	Disallow write combining on 450NX		(me)
o	Ensure rev C0 450NX has restreaming off		(me)
o	Don't do IDE DMA on rev B0 450NX or later	(me)
	450NX without BIOS workarounds for the hang
o	Update Configure.help for HPT IDE		(Adrian Bunk)
o	Fix harmless code error in sb_mixer		(Jeff Garzik)
o	Fix ethernet padding on via-rhine		(Roger Luethi)
o	Add ndelay functionality for x86		(me)
	| Based on Ross Biro's code
o	Add ide_execute_command 			(me)
	| Again based on Ross Biro's changed. Not yet used
	| This will be the new correct way to kick off an 
	| IDE command from non IRQ context
o	Matroxfb compile fix for one option combination	(Petr Vandrovec)

Linux 2.4.21pre3-ac3
o	Address comments on wcache value/issuing	(me)
	cache flush requests
o	Update credits entry for Stelian Pop		(Stelian Pop)
o	Backport some sonypi improvements from 2.5	(Kunihiko IMAI)
o	Fix pdcraid/silraid symbol clash		(Arjan van de Ven)
o	Fix ehci build with older gcc			(Greg Kroah-Hartmann)
o	Fix via 8233/5 hang				(me)
o	Fix non SMP cpufreq build			(Eyal Lebidinsky)
o	Fix sbp2 build with some config options		(Eyal Lebidinsky)
o	Fix ATM build bugs				(Francois Romieu)
o	Fix an ipc/sem.c race				(Bernhard Kaindl)
o	Fix toshiba keyboard double release		(Unknown)
o	CPUFreq updaes/fixes				(Dominik Brodowski)
o	Natsemi Geode/Cyrix MediaGX cpufreq support	(Hiroshi Miura,
							 Zwane Mwaikambo)
o	Add frequency table helpers to CPUfreq		(Dominik Brodowski)

Linux 2.4.21pre3-ac2
o	Fix the dumb bug in skb_pad			(Dave Miller)
o	Confirm some sparc bits are wrong and drop them	(Dave Miller)
o	Remove a wrong additional copyright comment	(Dave Miller)
o	Upgrade IPMI driver to v16			(Corey Minyard)
o	Fix 3c523 compile				(Francois Romieu)
o	Handle newer rpm where -ta is rpmbuild not rpm	(me)
o	Driver for Aurora Sio16 PCI adapter series	(Joachim Martillo)
	(SIO8000P, 16000P, and CPCI)
	| Initial merge
o	Backport Hammer 32bit mtrr/nmi changes		(Andi Kleen)
o	Add the fast IRQ path to via 8233/5 audio	(me)

Linux 2.4.21pre3-ac1
+	Handle battery quirk on the Vaio Z600-RE	(Paul Mitcheson)
*	EHCI USB updates				(David Brownell)
+	IDE Raid support for AMI/SI 'Medley' IDE Raid	(Arjan van de Ven)
+	NVIDIA nForce2 IDE PCI identifiers		(Johannes Deisenhofer,
							 Tim Krieglstein)
*	CPU bitmask truncation fix			(Bjorn Helgaas)
o	HP100 cleanup					(Pavel Machek)
o	Fix initial capslock handling on USB keyboard	(Pete Zaitcev)
+	Update dscc4 driver for new wan			(Francois Romieu)
+	Fix boot on Chaintech 4BEA/4BEA-R and		(Alexander Achenbach)
	Gigabyte 9EJL by handing wacky E820 memory
	reporting
o	SysKonnect driver updates			(Mirko Lindner)
o	Fix memory leak in n_hdlc			(Paul Fulghum)
o	Fix missing mtd dependancy			(Herbert Xu)
+	Clean up ide-tape printk stuff			(Pete Zaitcev)
+	IDE tape fixes					(Pete Zaitcev)
o	Fix size reporting of large disks in scsi	(Andries Brouwer)
+	Fix excessive stack usage in NMI handlers	(Mikael Pettersson)
+	Add support for Epson 785EPX USB printer pcmcia	(Khalid Aziz)
*	Quirk handler to sort out IDE compatibility	(Ivan Kokshaysky)
	mishandling
+	Model 1 is valid for PIV in MP table		(Egenera)
+	Ethernet padding fixes for various drivers	(me)
o	Allow trident codec setup to time out		(Ian Soboroff)
	This can happen with non PM codecs
o	Fix broken documentation link			(Henning Meier-Geinitz)
o	Update video4linux docbook			(William Stimson)
o	Correct kmalloc check in dpt_i2o		(Pablo Menichini)
o	Shrink kmap area to required space only		(Manfred Spraul)
o	Fix irq balancing				(Ben LaHaise)
o	CPUfreq updates					(Dominik Brodowski)
o	Fix typo in pmagb fb				(John Bradford)
o	EDD backport					(Matt Domsch)


REMOVED FOR NOW

-	RMAP

REMOVED FOR GOOD

-	LLC 	(See 2.5)
-	VaryIO  (Never accepted mainstream)
