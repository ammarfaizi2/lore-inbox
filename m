Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271687AbTHHQbS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 12:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271695AbTHHQbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 12:31:17 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:41423 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S271687AbTHHQaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 12:30:07 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200308081630.h78GU5n28166@devserv.devel.redhat.com>
Subject: Linux 2.4.21-rc1-ac1
To: linux-kernel@vger.kernel.org
Date: Fri, 8 Aug 2003 12:30:05 -0400 (EDT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux 2.4.22-rc1-ac1
o	Fix steal_locks problems			(Herbert Xu)
	| Should have us back in LSB compliance etc
o	Print X_DSDT not DSDT if only one is present	(Alex Williamson)
o	Fix an ultra-obscure journal leak in ext3	(Stepehn Tweedie)
o	Add framework for IDE hotplug			(me)
o	Unshare the file handles for init before	(me)
	exec
o	XAPIC have 8bit fields, also at least one 	(Ernie Petrides)
	vendor seems to have 8bit write, 4bit read!
o	Merge lots more help texts			(Steven Cole)
o	Fix missing brackets on ti pcmcia		(Chip Salzenberg)
o	hwif->hold IDE fix for mediabay			(Benjamin Herrenschmidt)
o	ip2 warning fixes				(Adrian Bunk)
o	tipar warning fix				(Adrian Bunk)
o	amd76x_pm warning fix				(Adrian Bunk)
o	sbc watchdog warning fix			(Adrian Bunk)
o	tp600 warning fix				(Adrian Bunk)
o	firmware loader needs hotplug			(Manuel Estrada Sainz)
o	Fix pci consistent leak in i810_audio		(Leann Ogasawara)

Linux 2.4.22-pre10-ac1
	Just tracking Marcelo - merge pre10
	- Remove bcm4400 now b44 is in
o	Merge ALi5455 updates				(Ni Wei)
o	Merge Cmedia cmpci updates			(C L Tien)
	| Lots of updates but this should get all the newer hardware working
o	Merge ATI Radeon IGP GART support
o	Add VIA CLE266 to AGP tables			(me)
o	Update wolfson driver, move to miscdev		(Liam Girdwood)
o	NFS root fixes					(Herbert Pötzl)
o	CCISS maintainer change and shared IRQ fix	(Mike Miller)
o	PWC updates					(Nemosoft)
o	Merge requeest_firmware back port		(Manuel Estrada Sainz)
o	Fix hd only non modular build			(Jerome Chantelauze)
o	Remove bogus check in siimage			(Kresimir Kukulj, me)
o	Fix softdog non nowayout behaviour		(me)
o	VIA IDE timing check fix			(Jiho)
o	Fix UDMA66 on old pdc202xx with one drive	(Jürgen Stohr)
o	Tdfxfb big endian and memor sizing fixes	(Richard Drummond)
o	Initial SGI Altix IDE driver merge		(Aniket Malatpure)
	| Still scope for further work but this is self contained
o	Further Configure.help updating			(Steven Cole)
o	Use isochronous not isosynchronous		(Geert Uytterhoeven)
o	Fix tiny data leak in old stat			(various)
o	Add help for CONFIG_IEEE1394_OUI_DB		(Adrian Bunk)
o	Further SATA driver updates			(Jeff Garzik)
o	Ensure HAS_TSC is always set to Y or N		(Jan-Benedict Glaw)
o	Fix missing include for ppc32			(Olaf Herring)
o	AMD7xx TCO driver update			(Zwane Mwaikambo)
o	Add more PCI router entries			(Jeff Garzik)
o	Fix cpia __FUNCTION__ warnings			(Michael Buesch)
o	Remove un-needed range checks in cpia		(Michael Buesch)
o	Update i810 watchdog to handle ICH5/ICH5R	(Wim Van Sebroeck)
o	Update promise Configure.help			(Ruth Ivimey-Cook)
o	Fix settrigger compliance with OSS API		(Thomas Sailer)
o	Fix syntax error in PPC64 config check		(Alan Brady)
o	Update required quota tools			(Steven Cole)
o	CPUfreq updates					(Dominik Brodowski)

Linux 2.4.22-pre6-ac1
	Merge to Marcelo 2.4.22-pre6
	- Replaces the -ac O_DIRECT changes with Marcelo style
	- Quota is now as Christoph merged plus the autoload patch
o	Fix the escaped xapic bits. I think we now	(me)
	have it right but acpi=off may be broken
o	Keyboard driver updates for stuck key fix	(Chris Heath)
o	Update scsi blacklists				(Tom Coughlan)
o	Update Maintainers				(OGAWA Hirofumi)
o	Fix usb scanner unplug oops			(Sergey Vlasov)
o	Fix netfilter circular dependancy		(Sérgio Monteiro Basto)
o	Fix a USB memory scribble			(David Brownell)
o	Configure.help updates				(Steven Cole)
o	Fix oom_kill rekilling bug			(Marc-Christian Petersen)
o	Fix cciss idents				(Mike Miller)
o	Fix 5 accidentally removed configure.help bits	(Steven Cole)
o	Fix highpoint crash case			(Wilfried Weissmann)
o	Add late registration of IDE driver hook/debug	(me)
o	Add Wolfson as maintainers for their codecs	(Liam Girdwood)
o	Fix ide-floppy double reporting			(me)
o	Further proc/ptrace/etc stuff			(Solar Designer)
o	The tty procfile can reveal keycounts make	(Solar Designer)
	it root only
o	Add missing -EFAULT checks for sysctl		(Solar Designer)
o	ia32 on ia64 size check				(Solar Designer)

Linux 2.4.22-pre3-ac1
	Resync with Marcelo makes it a lot smaller
o	Fix k7 powernow					(Duncot Bruno)
o	Update DRM driver maintainer info		(Rik Faith)
o	Export acpi_disabled for drivers		(Stelian Pop)
o	Fix duplicate cpu_has				(Mikael Pettersson)
o	Fix x86_64 show_regs				(Mikael Pettersson)
o	Fix yenta hang with PCI serial int		(Russell King)
o	Fix warning in bootsect.S with newer cpp	(Michael Buesch)
o	Fix scsi debug mode10 bug			(Jeff Garzik)
o	Fix vicam build with older gcc			(Margit Schubert-White)
o	Fix sbni build with newer gcc			(Margit Schubert-White)
o	Fix isdn_ppp warnings with newer gcc		(Michael Buesch)
o	Fix nsp scsi warnings				(Michael Buesch)
o	Fix warning in fs/buffer.c			(Michael Buesch)
o	Fix warning in svcsock.c			(Michael Buesch)
o	Quota autoloading				(Jan Kara)
o	Read lapic version correctly			(Venkatesh Pallipadi)
o	Add S/390 qeth driver core		(Utz Bacher, Cornelia Huck, 
						 Frank Pavlic, Andreas Hermann)
o	Add S/390 qdio driver core			(Utz Bacher)
o	Fix negative numbers in Configure		(Mikael Starvik)
o	Add missing configuration help texts		(Steven Cole)
o	Fix cs46xx/i810 audio crash on unload		(Josko Plazonic)
o	Fix bcm4400 with newer binutils			(Adrian Bunk)
o	Update ata-scsi driver				(Jeff Garzik)
o	Add Intellinet USB2 ethernet idents		(David Hollis)
o	Fix & bracketing in mm/filemap.c		(J A Magallon, me)
o	Remove duplicate config.in entries		(Steven Cole)
o	Fix codec register before probe case		(me)
o	Wolfson AC97 touchscreen driver			(Liam Girdwood)
	| Needs an official device id yet...
o	Intelfb updates					(David Dawes)
o	Intelfb makefile fix				(me)
o	Scsi scan race fix				(T Prashanth)
o	Make acpi handle hardware with no smm cmd port	(Jesse Barnes)

Linux 2.4.21-ac4
o	Fix the postfix problem				(Stephen Tweedie)
o	Put in the not so nice ide scsi crash fix	(me)
	| This fixes the first 99% of the problem so its
	| a definite improvement for now
o	Fix exec file handling semantics		(me)
	| Noted by Paul Starzetz
o	Export mmu cr4 flag data for direct render	(Ian Romanick)
o	Resync various bits of missing docs		(Steven Cole)
o	Implement 2.5 like block exclusive for CD	(Arjan van de Ven)
	in 2.4 (some burner like tools want it)
o	Fix nVidia AGP					(Marcelo Penna Guerra)
o	JFS full file system fix			(Dave Kleikamp)
o	Add arch specific code for SH-64 processor	(Paul Mundt)
o	Handle scsi_unregister fail in gdth driver	(Michael Still)
o	Fix clock reporting printks for siimage		(Pablo Martikian)

Linux 2.4.21-ac3
o	Fix an hpt driver bug triggered by the new HPT 	(me)
	BIOS
o	Initial VIA and S3 DRM modules merges		(VIA)
	| These are marked up with some warnings and need
	| a chunk of clean up work yet.
o	btaudio update					(Gerd Knorr)
o	Backport 2.5 ipc/sem.c fix			(Manfred Spraul)
o	Fix scsi_register failure path for aacraid	(Michael Still)
o	First crack at fixing the ide reset oopses	(me)
o	Fix the incompatibility between via audio and	(me)
	esd/gnome desktops

Linux 2.4.21-ac2
o	Fix an HPT37x oops case with 374 and non 33Mhz	(me)
	clock
o	Fix some emu10k1 oopses from the ac97 updates	(me)
o	Fix AF_UNIX dgram select problem		(Krzysztof Halasa)
o	Fix Make xconfig problem		(Edward Macfarlane Smith)
o	Add another new eepro100 ident to eepro100.c	(Tom Alsberg)
o	Fix aacraid new volume crash			(me)
o	Fix math-emu build with gcc 3.3 hopefully	(me)
o	Fix wrong comparisons on some sound drivers	(Adrian Bunk)
	for codec detect
o	Fix problem with eexpress driver		(Shane Shrybman)
o	Remove LNZ reference from Configure.help	(Matthias Andree)
o	Add support for Cirrus PCI/PCMCIA		(Komuro)
o	Allow both Cirrus and 82092 to exist together	(me)
o	Fix a remove race in the 82092 driver		(me)
o	Fix dnotify bug with read/writev		(Zou Pengcheng)
o	SiS IDE update					(Lionel Bouton)
o	Add PCMCIA bus ident to ethtool for pcmcia	(Bill Nottingham)
	devices
o	Backport 2.5 updates to overcommit interface	(Rik van Riel)
o	Synclink driver updates				(Paul Fulghum)
o	Fix z85230 losing frames by waking the queue	(Stefan Tamas)
	too early
o	O_DIRECT race fixes				(Stephen Tweedie)
	| Tweaked a little to merge with XFS. XFS folks should double
	| check these.
o	Allow use of db4 to build aicasm		(J A Magallon)
o	Revert problematic scsi change (fixes ppa/imm)	(ChrisW)
o	Further highpoint raid updates			(Wilfried Weissmann)
o	Fix data direction for start stop scsi command	(Heiko Carstens)
o	Fix a module loader memory leak			(Keith Owens)
o	Fix multiple ircomm bugs			(Jean Tourrilhes)
o	Fix irda qos handling, add tx_window setting	(Jean Tourrilhes)
o	Correct race in IrLMP				(Jean Tourrilhes)
o	Fix an RR/Poll handling error in irlap		(Jean Tourrilhes)
o	Update irda-usb driver				(Jean Tourrilhes)
o	Fix IrIAP leak					(Jean Tourrilhes)
o	Mask C/R bit in irlap connection address	(Jean Tourrilhes)
o	Fix some non modular build errors		(Jean Tourrilhes)
o	Remove duplicated junk from dasd_fba		(Rik van Riel)
o	Fix mac8390 typo				(Etsushi Kato)
o	Fix m68k floppy warnings			(Geert Uytterhoeven)
o	Fix apollo compile				(Geert Uytterhoeven)
o	Update mac sonic driver				(Geert Uytterhoeven)
o	Fix atari pamsnet driver			(Geert Uytterhoeven)
o	Fix mac68k keyboard warning			(Geert Uytterhoeven)
o	Fbcon fixes					(Geert Uytterhoeven)
o	M68K page handling fixes			(Roman Zippel)
o	Use ptrace_check_attach on m68k			(Andreas Schwab)
o	Remove m68k phys/virt fallback			(Roman Zippel)
o	Fix lmc build on some platforms			(Geert Uytterhoeven)
o	Update meye driver				(Stelian Pop)
o	Update sonypi driver				(Stelian Pop)
o	Fix a couple of glitches in the added 1210SA	(Hugo Mills)
	support for siimage
o	Fix llc802.2 leak case				(Oleg Drokin)
o	Add more unexpected apic filtering		(Randy Dunlap)
o	Fix a case where hid rejected some UPS devices	(Vojtech Pavlik)
o	Fix via audio crash on setup			(me)

Linux 2.4.21-ac1
o	Further ehci fixes and updates			(David Brownell)
o	CPUfreq updates					(Dominik Brodowski)
o	Updated DMI blacklists and facility to disable	(Arjan van de Ven)
	APM idling
o	Allow an NFS to specify if d_revalidate is a	(Trond Myklebust)
	stale handle event or not
	| Should fix CODA and VFAT problems
o	Ignore residue on autosense commands in 	(Tony Battersby)
	sym53c8xx_2
o	SiS frame buffer updates			(Tomas Winischhofer)
o	Add Xyratex to scsi list of large/sparse lun	(David Lethe)
o	MPT fusion driver updates			(Pam Delaney)
o	Hopefully fix the Promise SX6000 clash with	(me)
	PDC202xxx IDE drivers when using 20277.
o	Add a framework for plug in ac97 drivers	(me)
o	Fix IRQ handling in speedstep-ich		(Samuel Thibault)
o       Redo the AC97 codec plugin interface            (me)

Linux 2.4.21rc8-ac1
	Sync with Marcelo 2.4.21rc8
o	Fix megaraid tools breakage due to bad fix
o	Add support for Dell XP 4100CX SCSI		(Gregg Lebovitz)
	| Possibly a contender for the longest delay in 
	| patch application ever (2.5 years)
o	Fix force_ac97 printk in nm256 driver		(Douglas Kilpatrick)
o	Fix plip hang on ifdown/ifup			(Stas Sergeev)
o	Two more minor siimage updates			(me)
o	Handle PDC20275 on Promise SX6000		(me)
o	Fix erroneous licensing clash			(Kurt Robideau)
o	DSCC driver updates/reset handling		(Francois Romieu)
o	Add initial support for Adaptec/SII 1210SA	(Hugo Mills, me)
	| Tidied up Hugo's changes so we can cleanly add
	| more idents later
o	Fix missing hid include				(Pete Zaitcev)
o	Driver for AX8817x based USB ethernet		(Tivo, Dave Hollis)
	| Original driver by Tivo, cleanup by Dave Hollis
	| Supports Linksys USB200M, Netgear FA120, Dlink
	| DUB-E100, Hawking UF200
o	Remove bogus printk in AWE driver		(me)
o	Fix init of mp_bus_id table			(Herbert Xu)
o	Fix double iounmap on octagon probe fail	(Francois Romieu)
o	Fix several floppy driver SMP races		(Jens Axboe)
o	Fix a shmem deadlock				(Andrea Arcangeli)
o	Fix ST16654 uart overrun			(Ed Vance, William King)

Linux 2.4.21rc7-ac1
	Sync with Marcelo 2.4.21rc7
o	PC300 updates					(Henrique Gobbi, 
							 Nigel Metheringhma)
o	Fix ide-proc crash with no drivers loaded	(Herbert Xu)
o	Fix pc300 build with new binutils		(Adrian Bunk)
o	Minor | to || in fpu emulator			(Margit Schubert-While)
o	Fix remaining CRC32 build problem with luck	(David Woodhouse)
o	Use pentium3/4 targets with newer gcc		(Margit Schubert-While)
o	Remove DRM id string stuff as in 2.5		(Margit Schubert-While)
o	Merge radeonfb updates for newer radeon		(Margit Schubert-While)
o	Add nokia 5510 to usb-storage			(Markus Gaugusch)
o	Merge hfsplus file system			(Roman Zippel,
							 Brad Boyer, ...)
o	Fix ac97 build on SMP				(Adrian Bunk)
o	Fix pcnet32 unload crash with multiple cards	(Matt Wilson)
o	Make it clear AMD IDE covers Nvidia		(Paolo Ornati)

Linux 2.4.21rc6-ac2
o	Add framework for pci_device_restart error	(me)
	recovery
o	Smarter vesafb ram handling for double		(Thomas Backlund)
	buffering
o	Fix vesafb docs					(Thomas Backlund)
o	Fix ppp_generic error path leak			(Patrick McHardy)
o	Add VIA P4M266 AGP1x/2x/4x support		(Nimrod A Abing)
o	Allow vga16 frame buffer on IA64		(Jeremy Katz)
o	Fix & v && in sysrq.c				(Margit Schubert-While)
o	Remove various bits of old # if 0 in pdc202xx	(Carl-Daniel Hailfinger
							 me)
o	Further hacking on the SI680 driver		(me)
o	Add the Toshiba Piccolo IDE			(me)
o	Update ac97 layer so that it has alloc/release	(me)
o	Make the drivers use the ac97 changes		(me)
o	Fix up drivers not doing ac97 locking		(me)
o	Fix memory leak in forte ac97 handling		(me)
o	Always tune DMA on the SI680 as the BIOS	(me)
	firmware doesn't.

Linux 2.4.21rc6-ac1
	Merge with Marcelo 2.4.21-rc6
o	Finish off the codec->digital operations	(me)
o	Move i810 code into generic digital ops		(me)
o	Make i810_audio use ac97_codec ops properly	(me)
o	Add per card quirk handling to aacraid		(me)
o	Resolve pipe writing to r/o file systems	(Stephen Tweedie)
o	Add missing hidden device check			(Mark Salyzyn)
o	SG fixes					(Douglas Gilbert)
o	Update ACPI to next Intel release		(Bernhard Rosenkraenzer)
o	Fix pcibios code on SH3 for core changes	(Paul Mundt)
o	Resync tlan with Jeff				(Jeff Garzik)
o	Fix solutionengine build			(Paul Mundt)
o	SH build issues fixes				(Paul Mundt)
o	First cut at making modular IDE happy again	(me)

Linux 2.4.21rc5-ac2
o	Backport tlan update and add 64bit support	(me)
o	Make SiS APIC work				(me)
o	Fix incorrect strncmp in sclp driver		(Pete Zaitcev)
o	Fix further cmpci copy/user bugs		(Hollis Blanchard)
o	Update ACPI to newer intel base code		(Bero Rosenkraenzer)
o	Fix a bogus ; in the ACPI code			(Pavel Machek)
o	IDE I/O and DMA state machine fixes		(Alexander Atanasov)
o	Fix gcc 3.3 build of ma600		(Eduardo Pereira Habkost)

Linux 2.4.21rc5-ac1
	Resync with Marcelo 2.4.21-rc5
o	IBM S/390 architecture bug fixes		(Martin Schwidefsky)
o	IBM S/390 DASD driver fixes			(Martin Schwidefsky)
o	IBM S/390 sclp fixes				(Martin Schwidefsky)
o	IBM tape fixes					(Martin Schwidefsky)
o	AGPgart support for SiS651			(Thomas Winischhofer)
o	Fix emulation bug in the mips utsname handling	(Ben Collins)
o	Fix module list race				(Keith Owens)
o	Fixes to CRC32 library and optimisations	(David Woodhouse,
							 Joakim Tjernlund)
o	I/O pause waitqueue fix				(Jens Axboe)
o	Fix typo in ide Config.in			(Carl-Daniel Hailfinger)
o	Fix ac97 to init volume mute bit on volume	(me)
	control lacking codecs
o	Correct vm86 virtualisation of pushf iopl	(Stas Sergeev)
	| Fixes some problems with dos4gw
o	Nvidia AGP support				(someone in Nvidia)
o	Fix gcc 3.3 build of sdla_chdlc		(Eduardo Pereira Habkost)
o	Fix gcc 3.3 build of olympic 		(Eduardo Pereira Habkost)
o	Fix gcc 3.3 build of DECnet		(Eduardo Pereira Habkost)
o	Fix gcc 3.3 build of cs46xx		(Eduardo Pereira Habkost)
o	Report -EFAULT back on /proc/misc		(Daniele Bellucci)
o	Merge S/390 ctrlchar handler fix		(Pete Zaitcev)
o	Add oneshot support to UHCI USB as well		(Pete Zaitcev)
o	Fix type errors in kcopy irq save		(Guy Streeter)
o	Major merge of aacraid updates		(Mark Salyzn, Deanna Bonds)
	| 64bit stuff, raid mode, SATA, other new idents
o	Rewrite the aacraid link list code to		(me)
	be 64bit safe
	| This aacraid is likely to need a bit more debugging yet
	| and also there is work to do on error recovery handling
o	Fix CRC library problem with ksyms		(me)

Linux 2.4.21rc4-ac1
	Resync with Marcelo 2.4.21-rc4
o	Allow setuid core dumps by a sysctl		(me)
	| First test release. Note that you probably want to set
	| the core dumping path to somewhere like /cores/ via sysctl
	| when using this feature. Setuid cores are made root only
	| and owner rw only.

Linux 2.4.21rc2-ac3
o	Possible fix for IDE lost IRQ problem		(Alexander Atanasov)
o	Add VIA KL/KM266 AGP				(Dietrich Radel)
o	Handle older Compaq ACPI * prefix to HID	(Andrew Grover)
o	Add mmio==2 support to the ide-dma layer	(me)
o	Clean up and document the CMD680 driver		(me)
o	Fix the CMD680 resource handling bugs		(me)
o	VIA 8327 IDE support				(Vojtech Pavlik)
o	Update SiS IDE for 655/630SET and oddments	(Lionel Bouton)
o	Fix missing exports for modular XFS		(Bero Rosenkraenzer)
o	Update worst case quota block count for ext3	(Jan Kara)
o	Add CRC32 libraries backport	(David Woodhouse, Duncan Sands)
o	HDLC doc fixes					(Krzysztof Halasa)
o	Use tail -n for the posixly afflicted		(Olaf Hering)
o	Fix wrong use of strstr in reiserfs		(Sam Ravnborg)
o	Correct AMD enable bits				(Vojtech Pavlik)
	| Should fix IDE boot timeout when probing empty AMD device slots
o	Fix netlink compile with gcc 3.3		(Andrew Church)
o	Frame buffer is in bits so fix vesafb 		(Adam Mercer)
o	Make ksoftirqd cpuid match 2.5 (and allow for	(Martin Hicks)
	100 cpus without overflow..)
o	Fix a pcmcia without ISA crash			(Pavel Roskin)
o	Fix cs89x0 set_mac_address handling		(Stefano Fedrigo)
o	Update the ide tags I forgot to do before	(me)
o	Fix a delayed block/xfs problem from a missed	(Christoph Hellwig)
	merge


Linux 2.4.21rc2-ac2
o	Use pid_t for pid in aacraid			(Walter Harms)
o	Prevent user compiling both megaraid drivers in	(Adriank Bunk)
o	Fix missing wolfson codec bits			(me)
o	Add SIS648 AGP					(Grzesiek Wilk)
o	Fix devexit in kahlua audio			(Adrian Bunk)
o	SunRPC timer missing HZ scaling			(Steve Dickson)
o	Fix a bogus kfree in iphase ATM			(Patrick McHardy)
o	Don't clobber SMI APIC routing			(John Stultz)
o	Fix big endian rtl8150				(Geert Uytterhoeven)
o	Fix binfmt_elf leak on error paths		(Oleg Drokin)
o	Handle thread create errors in aacraid		(Walter Harms)
o	Allow a user to mark a disk as for scsi at	(Matan Ziv-Av)
	boot even with ide-scsi is modular

Linux 2.4.21rc2-ac1
	Merge with Marcelo 2.4.21rc2
o	Ensure we do not enable DMA on early SLC82105	(Ben Herrenschmidt)
o	Fix sclp compile				(Rik van Riel)
o	Fix C7000 compile				(Rik van Riel)
o	Fix CMD680/SII clocking problems		(me)
o	C7000 header clean up				(me)
o	Fix IDE setup for old PC202xx raid	(Bartlomiej Zolnierkiewicz)
o	Update Quadrics PCI idents with vendor data	(Daniel Blueman)
o	Update XFS to current XFS			(Christoph Hellwig)
o	Update wolfson codec support with vendor	(Liam Girdwood)
	supplied changes
o	Allow user to override vesa video ram		(Thomas Backlund)
o	Fix ibm hotplug build				(Geller Sandor,
							 Andreas Haumer)
o	Fix ipmi build with ACPI			(Andreas Haumer)

Linux 2.4.21rc1-ac4
o	Fix vesafb over allocation of I/O memory	(Adam Mercer)
	| VESA reports ram on card but that may be banked
	| and is more than we need to map. On 128/256Mb
	| cards we really don't want to have this happen
o	Relaxed AML checking (needed for Toshiba	(Rick Richardson)
	laptops and other stuff built with some old
	buggy AML tools)
o	Fix v110 fill on hisax PCI			(David Woodhouse)
o	Ensure cable id pin setup is correct on hpt ide	(Duncan Laurie)
o	Quirkhandler for serverworks CSB5 IRQ		(Duncan Laurie)
o	Add NFSv3 pathconf/fsinfo support		(Steve Dickson)
o	Fix NFS close/open consistency setting bug	(Shantanu Goel)
o	Fix the mess in ibmphp_ebda			(me)
o	Add Vivitar Vivicam to unusual_devs		(Thomas Rabe)
o	Clean up lots of code that could use mod_timer	(Vinay Nallamothu)
	so that it does (sch_csz, sch_htb, synclink, sdla_x25,
	sdla_fr, sdla_ppp, sdla_chdlc, sch_cbq, mptctl)
o	Allow IDE drivers to reserve interfaces for
	found hotplug controller with no disk		(Ben Herrenschmidt)
o	Intel ICH5 basic SATA support			(Andre Hedrick)
o	Merge some of Greg's ibmphp cleanups		(Greg Kroah-Hartmann)
o	vsprintf fix					(Al Viro)
o	Initial ICH5 audio support			(Martin Schlemmer)
	| Please report any problems
o	Merge new AMI Megaraid driver as megaraid2	(Atul Mukker)
o	Add ALC100P codec				(Ni Wei)

Linux 2.4.21rc1-ac3
o	Fix copy/user handling errors in mpu401,	(me)
	mdc800, eicon, vicam
	| From Stanford checker
o	Fix an i810 error path bug that showed up	(John Stultz)
	in new Macromedia flash player
o	parisc arch code resync				(Joel Soete)
o	Merge big endian sstfb updates			(Joel Soete)
o	Fix compile with no quota again (without a	(me)
	typo this time)
o	Fix missing fc_type_trans			(Andreas Haumer)
o	Fix DRM 4.0 build				(Xosé Vázquez Pérez)
o	Fix SiS746 AGP merge				(Volker Armin Hemmann)
o	Merge XFS core code	(Steve Lord, Christoph Hellwig, and a load 
				 more people)
o	Merge current Intel ACPI
	| Except the mem= bits which neec bootloader resyncs
	| This breaks ipmi but that shouldnt be too hard to clean up
	| and should end up a lot nicer


Linux 2.4.21rc1-ac2
o	Add hwif->rw_disk callout			(me)
	| This allows us to remove the PDC4030 special case
	| and also allows for the 372N clock switch stuff.
o	Add HPT372N clock switcher (needs testing carefully)
o	TDFX framebuffer improvements/fixes		(Jakub Bogusz)
o	Hopefully fix legacy hd only build 		(me)
	|Reported by Jerome Chantelauze but different fix
o	Orinoco updates					(David Gibson)
o	AGP update for Intel 852/855			(David Dawes)
o	Fix leak in rio firmware handler		(Oleg Drokin)
o	Fix leak on aironet4500 error path		(Oleg Drokin)
o	Fix leak in roadrunner exit path		(Oleg Drokin)
o	Use the FAT free cluster hints in Linux		(Björn Stenberg)
o	Update Intermezzo contacts			(Jörn Engel)
o	Add DMI handling for broken PnPBIOS		(me)
o	Fix build without quota support			(Pavel Roskin)
o	Backport 2.5 slab poison improvements		(Faik Uygur)
o	Initial SiS 746 AGP (not for 8x yet)		(Volker Hemmann)
o	CCISS updates (support for 6404/256, cross	(Mike M)
	platform fixes, 64bit DMA
o	Fix the ide unregister deadlock bug		(me)
o	Generic XAPIC support (8 way HT etc)	(Venkatesh Pallipadi,
							Ingo Molnar)
o	A collection of NFS fixes			(Steve Dickson)
o	Fix IDE makefile a bit further			(Christoph Hellwig)
o	Use new ieee1394 code				(Ben Collins)
o	Minimal S/390 fixes to get -ac running ok	(Martin Schwidefsky)
o	Update S/390 cio layer				(Martin Schwidefsky)
o	Update S/390 DASD drivers			(Martin Schwidefsky)
o	Update S/390 31bit emulation			(Martin Schwidefsky)
o	S/390 documentation updates			(Martin Schwidefsky)
o	3215 driver updates				(Martin Schwidefsky)
o	Update S/390 ctc layer				(Martin Schwidefsky)
o	S/390 iucv updates				(Martin Schwidefsky)
o	Replace hwc with backport of 2.5 sclp		(Martin Schwidefsky)
o	Do the same with the 2.4/2.5 S/390 tape		(Martin Schwidefsky)
o	Updates to Serverworks IDE			(Duncan Lane, me)

Linux 2.4.21rc1-ac1
	Merge Marcelo 2.4.21-rc1
	- Drop broken m68k ide change
o	Fix PPC build					(Olaf Hering)
o	Fix up d_path handling				(Christoph Hellwig)
o	Update IPMI					(Corey Minyard)
o	Fix ext3 orphan race				(Ernie Petrides)
o	Update seq_file to match 2.5			(Randy Dunlap)
o	Remove experimental runtime scsi switch for IDE	(me)
	| Fixing it requires major ide register rewriting
o	Fix a deadlock on ide_unregister_subdriver	(Ben Herrenschmidt, me)
o	Fix an ext3 quota deadlock			(Jan Kara)
o	Fix ohci single shot interrupt out		(Frode Isaken)
o	Update summit idents				(James Cleverdon)
o	Clear sense buffer before retrying command	(Alan Stern)
o	Fix 82092 on a PCI bus with no ISA bridge	(David Woodhouse)
o	Fix duplicate pid corner case			(Takayoshi Kochi)
o	Add VIA phy to SiS900 driver			(Pedro A Gracia Fajorda)

Linux 2.4.21pre7-ac2
o	HPT raid support for disk-spanning/initial bits	(Wilfried Weissmann)
	of raid1
o	Cyclades PC300 driver initial merge		(Henrique Gobbi)
o	Fix bigendian use of pegasus driver		(Paul Mackerras)
o	Fix copy/user bugs in zoran drivers		(me)
	|From Stanford checker
o	Fix copy/user bugs in sisfb			(me)
	|From Stanford checker
o	Fix copy/user bugs in intermezzo		(me)
	|From Stanford checker
o	Fix copy/user bug in cmi8330 driver		(me)
	|From Stanford checker
o	Fix copy/user bug in awe sound			(me)
	|From Stanford checker
o	Merge GPL version of UTS Global CLAW driver	(Bob Scardapane)
o	Make cardbus fall back to PCI irq routing if 	(Pavel Roskin)
	needed
o	Fix sign bug in decnet				(Oleg Drokin)
o	Add AZT1008 PnP identifiers to ad1848		(Zwane Mwaikambo)

Linux 2.4.21pre7-ac1
	Merge with Marcelo 2.4
o	Merge memory barrier bits			(Zwane Mwaikambo)
o	Fix ip_conntrack merge after free		(Martin Josefsson)
o	Stop failing sethostname from clearing entire	(Stephan Maciej)
	field
o	Fix Config.in syntax for ADMA-100		(Mark Lord)
o	Remove IDE_DEBUG macro from 2.4 as well		(Alexander Atanasov)
o	In some situatiosn rq->buffer changes under  (Stephan von Krawcyznski)
	us in scsi. Store the idescsi_pc in ->special
	where it probably belongs anyway
o	Arcnet oops fixes				(Herbert Xu)
o	Pmac IDE update					(Ben Herrenschmidt)
o	Jbd compile warnings fixes			(Stephen Tweedie)
o	Dquot lock fix					(Oleg Drokin)
o	I2c fixups					(Greg Kroah-Hartmann)
o	Scsi tape updates				(Kai Makisara)
o	Update DAC960 and Qlogic drivers for Alpha	(Jay Estabrook)
o	Fix non pci build				(Stephane Oullette)
o	Fix non DMA ide build				(Andries Brouwer)
o	Fix PIO boot serverworks IDE problem		(Robert Hentosh,
							 me)
o	Small nfs dentry/dir fix			(Steve Dickson)
o	Allow longer for diagnostic commands in scsi	(Douglas Gilbert)
o	Sunrpc locking fix				(Steve Dickson)
o	Make tty->count atomic				(Jes Sorensen)
o	Update ipmi					(Corey Minyard)
o	Fix multiplex syscall wrong return code		(Ulrich Drepper)
o	M68K IDE updates				(Geert Uytterhoeven)
o	Small quota compatibility fix			(Jan Kara)
o	FPU copy fix 					(Ingo Molnar)
o	MPT Fusion update				(Pam Delaney)
o	SonyPi update					(Stelian Pop)
o	Reiserfs journal fixup				(Oleg Drokin)
	| Sanity test fail on old fs's
o	Fix X.25 crash on unknown facilities		(Tiaan Wessels)
o	Fix iphase module on new binutils		(Adrian Bunk)
o	Fix ad1889 module on new binutils		(Adrian Bunk)
o	Ditto for nsp32, ips, rtl8169
o	SiS frame buffer updates			(Thomas Winischhofer)
o	ndelay for m68k systems				(Geert Uytterhoeven)
o	m68k raw I/O updates				(Geert Uytterhoeven)
o	Fix IDE completion race 		(Jens Axboe, Andrew Morton)
o	m68k needs WANT_PAGE_VIRTUAL except sun 	(Richard Zidlicky)
o	Remove duplicate copy of PROC_CONSOLE		(Geert Uytterhoeven)
o	Fix swapoff crash				(Szabolcs Berecz)
o	Fix is_dumpable on zombies		(Marc-Christian Petersen)
o	Add vicicam to unusual storage devices
o	Update sony unusual device entries		(Hanno Böck)
	

Linux 2.4.21pre5-ac4 (not released generally)
o	Add initial test support for HPT372N		(me)
o	Fall back to PIO if the BIOS got mmio setup	(me)
	wrong for an SI3112/CMD680
	| Still doesnt explain some problems
o	Update amiga floppy driver			(Geert Uytterhoeven)
o	AmigaFB wrong IRQ fix				(Geert Uytterhoeven)
o	Amiga RTC updates				(Kars de Jong)
o	Amiga PCMCIA ethernet cleanups			(Kars de Jong)
o	Fix Amiga isa space mapping			(Kars de Jong)
o	Update apollo MMIO and pseudio MMIO		(Geert Uytterhoeven)
o	Fix bitop abuse in 5380 drivers for m68k	(Geert Uytterhoeven)
o	Fix m68k with recent binutils			(Andreas Schwab)
o	m68k prototype fix				(Geert Uytterhoeven)
o	m68k heartbeat config fix			(Geert Uytterhoeven)
o	Convert m68k cache macros to be inline		(Geert Uytterhoeven)
o	Update m68k VIA stuff				(Ray Knight)
o	Make m68k page size to fix warnings		(Geert Uytterhoeven)
o	Allow mac68k to build with no fb		(Geert Uytterhoeven)
o	Fix m68k network driver warnings		(Geert Uytterhoeven)
o	Backport m68k page_to_phys from 2.5		(Richard Zidlicky)
o	Move m68k low level iomap defines around	(Richard Zidlicky)
o	Update sun3 contact info			(Geert Uytterhoeven)
o	m68k warning fixes for scsi			(Geert Uytterhoeven)
o	Optimised stack check for m68k			(Roman Zippel)
o	M68K spelling fixes				(Steven Cole)
o	Make all sun3 pages as zone 0			(Sam Creasey)
o	Add ioremap for sun3 and use it in drivers	(Sam Creasey)
o	Sun3/3x updates and cleanups			(Sam Creasey)
o	Fix page calculation for first virtual page	(Sam Creasey)
	on sun3
o	Rename sbus structs for sparc compatibility	(Sam Creasey)
o	Update sun3 vectored interrupts			(Sam Creasey)
o	Dont update rtc from clock eveyr 11 mins	(Geert Uytterhoeven)
o	Add Sun3 VME support				(Sam Creasey)
o	ISDN ppp locking fix				(Patrick McHardy)
o	Semtimedop backport				(Mark Fasheh)
o	Fix missing cli in isdn_net			(Patrick McHardy)
o	Handle radeonfb mobility cards reporting	(Hanno Bock)
	no memory
o	Add another broken APM bios			(Arjan van de Ven)
o	Add Centrino IDE support			(Dean Gaudet)
o	Fix ibm hotplug memory leaks 			(Oleg Drokin)
o	Fix xjack memory leaks				(Oleg Drokin)
o	I2O memory leak	fix				(Oleg Drokin)
o	Emu10K memory leak fix				(Oleg Drokin)
o	cpqfc memory leak fix				(Oleg Drokin)
o	dpt_i2o memory leak notes			(Oleg Drokin)
o	Fix -ac build on alpha				(Ivan Kokshaysky)
o	Fix fd leak in initrd				(Pete Zaitcev)
o	Megaraid cleanup/check fix			(Oleg Drokin)
o	sx memory leak fix				(Oleg Drokin)
o	Kobil USB memory leak fix			(Oleg Drokin)
o	USB memory leak fix on hub			(Oleg Drokin)
o	Fix iphase driver null cells bug		(Eric Leblond)
o	Fix non zero offset reads on /proc/cmdline	(Dick Streefland)
o	Fix pdcraid ioctl pass through			(Jens Axboe)
o	Make hdparm report error on cable refusal	(Jens Axboe)
o	Reiserfs warning fix				(Maciej Soltysiak)
o	Fix warning in make_configs			(Maciej Soltysiak)
o	Remove unused variable in ide-proc		(Maciej Soltysiak)
o	CMD640 locking bug fixups			(Alexander Atanasov)
o	General IDE driver resync
o	Add another datafab kecf to the dev list	(Chris Clayton)
o	Fix wrong type for timer in aha152x		(Christoph Hellwig)
o	Avoid IDE hang on SMP when doing DMA->PIO	(Petr Vandrovec)
	changedown on error
o	Fix ide_wait_50ms fencepost error		(Alexander Atanasov)


Linux 2.4.21pre5-ac3
o	Add cpuid for SiS processors (SiS SiS SiS)	(me)
o	Fix basic ADMA100 driver support		(Mark Lord)
o	Fix memory leak on UFS error path		(Oleg Drokin)
o	Fix eepro100 ethtool hang			(Jason Lunz)
o	Fix procfs memory leak				(Kazuto Miyoshi)
o	Forte media driver update			(Martin Petersen)
o	WIN_SET_MAX crashes some old Samsung disks so	(Jens Axboe)
	dont issue it on disks < 32Gb in size
o	Compaq MS1000 may have sparse lun		(Tom Coughlan)
o	Add SiS FB idents for newer chipsets		(Thomas Winischhofer)
o	Fix vsscanf in hex mode				(Kevin Corry)
o	Fix 64bit jiffy cleanness in sis900, shaper,	(Dave Miller)
	dgrs, qlogicfc and tty layer
o	Reiserfs journal overflow fix			(Hans Reiser)
o	PCMCIA oops fix with HostAP			(Pavel Roskin)
o	Handle more panasonic compact USB CD-ROMs	(Go Taniguchi)
o	Extend USB hotplug to handle multi interface	(Go Taniguchi)
	HID devices (eg IBM BladeCenter)
o	Update ALi PCI ident data			(TH Chou)
o	Fix memory leak in ldm error path		(Oleg Drokin)
o	NCPFs ioctl passed wrong parameter		(Oleg Drokin)
o	Fix leak in ircomm core error path		(Oleg Drokin)
o	Make xconfig syntax error fixes			(Andreas Gruenbacher)
o	Fix memory leak in vlanproc exit path		(Oleg Drokin)
o	Fix iphase misaligned skb (I hope)		(me, based on stuff by
							 Eric Leblond)
o	Fix a couple of printk levels in IDE		(Alan Cox)

Linux 2.4.21pre5-ac2
o	Add PCI idents for ALi 1563 to dmfe		(Clear Zhang)
o	Busproc operations now error if unsupported	(me)
o	Make busproc handler return a status
o	Fix IDE reset locking. We don't want an IRQ	(me)
	poking around during a reset while the iface
	state is undefined
o	Remove half baked request clean up code 	(me)
	from ide_do_reset. We require the caller
	cleans up first
o	Add ide_abort functions to abort due to 	(me)
	host not target triggered events
o	Remove a pile of surplus hwgroup checks		(me)
o	Fix the reset ioctl paths to use 		(me)
	ide_abort
o	Fix PCI posting on ide resets			(me)
o	Call the dma_check routine when trying to	(me)
	enable DMA via hdparm
o	Add per driver abort handlers and use them	(me)
o	Forward port 8.0 ALi driver updates from	(me)
	Clear Zhang at ALi

Linux 2.4.21pre5-ac1
o	Merge with 2.4.21pre5
o	Do the final hatchet work on drive->id		(me)
	| IDE drive->id is now always valid so people
	| can no longer get that one wrong. 
o	DRIVER(drive) in IDE != NULL always now		(me)
	| A dummy driver removes a ton of conditions 
	| and a load of bugs
o	Move modem awareness into ac97_codec.c		(me)
	| Fixes CXT66 support I hope
o	Minimal cmedia codec setup/bug stuff		(me)
	| Note these codecs dont yet support AC3 and also
	| don't support volume control. May fix some sis7012
	| laptop setups with luck.
o	Fix mkdep bug causing devlist.h problem with	(Pavel Roskin)
	some versions of make
o	Fix missing mtd Makefile entry			(Adrian Bunk)
o	APIC initialisation fix				(Mikael Pettersson)
o	CCISS update					(Stephen Cameron)
o	USB transport size handling fix			(Alan Stern)
o	Add AGP entry for the VIA EPIA			(John Eckerdal)
o	Add Laneed idents to pegasus usb ethernet	(Go Taniguchi)
o	Add HID workaround for OKI USB keyboard		(Go Taniguchi)
o	Add idents for MTT_TE MN128 USB ethernet	(Go Taniguchi)
o	Add USB quirks for another memorystick		(Go Taniguchi)
o	Some minor typo fixes to keep 2.4/2.5 easier	(Steven Cole)
	to diff
o	Fix several operator and precdence problems	(Norbert Kiesel)
o	cciss error handling unregister fix		(Herbert Xu)
o	Kerneldoc for user access functions		(Jon Foster)
o	Further ALi IDE fixes				(Ivan Kokshaysky)
o	Improved 440GX bios workarounds			(Arjan van de Ven)
	| Thanks to the guys at Intel for hints on this
o	AMD74xx cable detect fixes			(Zoltan Hidvegi,
							 Vojtech Pavlik)
o	io/irq in mpu401 must not be initdata		(Daniel Ritz)
o	Handle shared irq on pcmcia qlogicfas		(Komuro)

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

--
  "... and for $64000 question, could you get yourself vaguely familiar with
		the notion of on-topic posting?"
				-- Al Viro
