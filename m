Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272631AbRIKXCT>; Tue, 11 Sep 2001 19:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272632AbRIKXCA>; Tue, 11 Sep 2001 19:02:00 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:23560 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272631AbRIKXB6>; Tue, 11 Sep 2001 19:01:58 -0400
Subject: Linux 2.2.20pre10
To: linux-kernel@vger.kernel.org
Date: Wed, 12 Sep 2001 00:06:41 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-Id: <E15gwc5-0003VR-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you know any reason this should not be 2.2.20 final now is a very very
good time to say. I intend to call this patch 2.2.20 in a week or so barring
any last minute problems. Please save anything but actual bugfixes for
2.2.21.

2.2.20pre10
o	Update the gdth driver				(Achim Leubner)
o	Fix prelink elf loading in 2.2			(Jakub Jelinek)
o	2.2 lockd fixes when talking to HP/UX		(Trond Myklebust)
o	3ware driver update				(Adam Radford)
o	hysdn driver update				(Kai Germaschewski)
o	Backport via rhine fixes			(Dennis Bjorklund)
o	NFS client fixes		(Trond Myklebust, Ion Badulescu,
					 Jim Castleberry, Crag I Hagan.
					 Adrian Drzewiecki)
o	Blacklist TEAC PD-1 to single lun		(Wojtek Pilorz)
o	Fix null request_mode return 			(David Woodhouse)
o	Update credits entry				(Fernando Fuganti)
o	Fix sparc build with newer binutils		(Andreas Jaeger)
o	Starfire update					(Ion Badulescu)
o	Remove dead USB files				(Greg Kroah-Hartmann)
o	Fix isdn mppp crash case			(Kai Germaschewski)
o	Fix eicon driver				(Kai Germaschewski)
o	More pci idents					(Andreas Tobler)
o	Typo fix					(Eli Carter)
o	Remove ^M's from some data files		(Greg Kroah-Hartmann)
o	64bit cleanups for isdn				(Kai Germaschewski)
o	Update isdn certificates			(Kai Germaschewski)
o	Mac update for sysrq				(Ben Herrenschmidt)

2.2.20pre9
o	Document ip_always_defrag in proc.txt		(Brett Eldrige)
o	Update S/390 asm for newer gcc			(Ulrich Weigand
o	Update S/390 documentation			 Carsten Otte
o	Update s390 dump too				  and co)
o	Update s/390 dasd to match 2.4
o	Backport s/390 tape driver from 2.4
o	FDDI bits for s/390
o	Updates for newer pmac laptops			(Tom Rini)
o	AMD760MP support				(Johannes Erdfelt)
o	Fix PPC oops on media change			(Tom Rini)
o	Fix some weird but valid input combinations	(Tom Rini)
	on PPC
o	Add additional checks to irc dcc masquerade	(Juanjo Ciarlante,
							 Michal Zalewski)
o	Update 2.2 ISDN maintainer			(Kai Germaschewski)
o	Fix 3c505 with > 16Mb of RAM			(Paul)
o	Bring USB into sync with 2.4.7			(Greg Kroah-Hartmann)

2.2.20pre8
o	Merge DRM fixes from 2.4.7 tree			(me)
o	Merge sbpcd fixes from 2.4.7 tree
o	Merge moxa buffer length check
o	Merge bttv clip length check
o	Merge aha2920 shared irq from 2.4.7 tree
o	Merge MTWEOF fix from 2.4.6 tree
o	Merge serverworks AGP from 2.4.6 tree
o	Merge sbc60xxx watchdog fixes from 2.4.6
o	Merge lapbether fixes from 2.4.6
o	Merge bpqether fixes from 2.4.6
o	Merge scc fixes from 2.4.6
o	Merge lmc memory leak fixes from 2.4.6
o	Merge sm_wss fixes from 2.4.6
o	Resync AGP support with 2.4.6
o	Merge epca fixes from 2.4.5
o	Merge riscom8 fixes from 2.4.5
o	Merge softdog fixes from 2.4.5
o	Merge specialix fixes from 2.4.5
o	Merge wdt/wdt_pci fixes from 2.4.5
o	ISDN cisco hdlc fixes				(Kai Germaschewski)
o	ISDN timer fixes				(Kai Germaschewski)
o	isdn minor control change backport		(Kai Germaschewski)
o	Backport ELCR MP 1.1 config/PCI routing stuff	(John William)
o	Backport isdn ppp fixes from 2.4		(Kai Germaschewski)
o	Backport isdn_tty fixes from 2.4		(Kai Germaschewski)
o	eicon cleanups					(Armin Schindler)
	| Armin can you double check the clashes were ok
o	Fix an ntfs oops				(Anton Altaparmakov)
o	Fix arp null neighbour buglet			(Dave Miller)
o	Update sparc version strings, pci fixups	(Dave Miller)
o	Define CONFIG_X86 in 2.2 as well as 2.4		(Herbert Xu)
o	Configure.help cleanups				(Steven Cole)
o	Add MODE_SELECT_10 to qlogic fc table		(Jeff Andre)
o	Remove dead oldproc variable			(Dave Miller)
o	Update starfire driver for 2.2			(Ion Badulescu)
o	8139too driver update				(Jens David)
o	Assorted race fixes for binfmt loaders		(Al Viro)
o	Update Alpha support for older boxes		(Jay Estabrook)
o	ISDN bsdcomp/ppp compression fixes		(Kai Germaschewski)

2.2.20pre7
o	Merge rose buffer management fixes		(Jean-Paul Roubelat)
o	Configure.help updates				(Steven Cole)
o	Add Steven Cole to credits			(Steven Cole)
o	Update kbuild list info				(Michael Chastain)
o	Fix slab.c doc typo				(Piotr Kasprzyk)
o	Lengthen parport probe timeout			(Jean-Luc Coulon)
o	Fix vm86 cleanup				(Stas Sergeev)
o	Fix 8139too build bug				(Jürgen Zimmermann)
o	Fix slow 8139too performance			(Oleg Makarenko)
o	Sparc64 exec fixes				(Solar Designer)

2.2.20pre6
o	Merge all the pending ISDN updates		(Kai Germaschewski)
	| These are sizable changes and want a good testing
o	Fix sg deadlock bug as per 2.4			(Douglas Gilbert)
o	Count socket/pipe in quota inode use		(Paul Menage)
o	Fix some missing configuration help texts	(Steven Cole)
o	Fix Rik van Riel's credits entry		(Rik van Riel)
o	Mark xtime as volatile in extern definition	(various people)
o	Fix open error return checks			(Andries Brouwer)

2.2.20pre5
o	Fix a patch generation error, replaces 2.2.20pre4 which is
	wrong on ad1848

2.2.20pre4
o	Fix small corruption bug in 82596		(Andries Brouwer)
o	Fix usb printer probing				(Pete Zaitcev)
o	Fix swapon/procfs race				(Paul Menage)
o	Handle ide dma bug in the CS5530		(Mark Lord)
o	Backport 2.4 ipv6 neighbour discovery changes	(Dave Miller)
o	FIx sock_wmalloc error handling			(Dave Miller)
o	Enter quickack mode for out of window TCP data	(Andi Kleen)
o	Fix Established v SYN-ACK TCP state error	(Alexey Kuznetsov)
o	Sparc updates, ptrace changes etc		(Dave Miller)
o	Fix wrong printk in vdolive masq		(Keitaro Yosimura)
o	Fix core dump handling bugs in 2.2		(Al Viro)
o	Update hdlc and synclink drivers		(Paul Fulghum)
o	Update netlink help texts			(Magnus Damm)
o	Fix rtl8139 keeping files open			(Andrew Morton)
o	Further sk98 driver updates. fix wrong license	(Mirko Lindner)
	text in files
o	Jonathan Woithe has moved			(Jonathan Woithe)
o	Update cpqarray driver				(Charles White)
o	Update cciss driver				(Charles White)
o	Don't delete directories on an fs that reports	(Ingo Oeser)
	then 0 size when doing distclean
o	Add support for the 2.4 boot extensions to 2.2	(H Peter Anvin)
o	Fix nfs cache locking corruption on SMP		(Craig Hagan)
o	Add missing check to cdrom readaudio ioctl	(Jani Jaakkola)
o	Fix refclock build with newer gcc		(Jari Ruusu)
o	koi8-r fixes					(Andy Rysin)
o	Spelling fixes for documentation		(Andries Brouwer)

2.2.20pre3
o	FPU/ptrace corruption fixes			(Victor Zandy)
o	Resync belkin usb serial with 2.4		(Greg Kroah-Hartmann)
o	Resync digiport usb serial with 2.4		(Greg Kroah-Hartmann)
o	Rsync empeg usb serial with 2.4			(Greg Kroah-Hartmann)
o	Resync ftdi_sio against 2.4			(Greg Kroah-Hartmann)
o	Bring keyscan usb back into line with 2.4	(Greg Kroah-Hartmann)
o	Resync keyspan_pda usb with 2.4			(Greg Kroah-Hartmann)
o	Resync omninet usb with 2.4.5			(Greg Kroah-Hartmann)
o	Resync usb-serial driver with 2.4.5		(Greg Kroah-Hartmann)
o	Resync visor usb driver with 2.4.5		(Greg Kroah-Hartmann)
o	Rsync whiteheat driver with 2.4.5		(Greg Kroah-Hartmann)
o	Add edgeport USB serial				(Greg Kroah-Hartmann)
o	Add mct_u232 USB serial				(Greg Kroah-Hartmann)
o	Update usb storage device list		(Stas Bekman, Kaz Sasayma)
o	Bring usb acm driver into line with 2.4.5	(Greg Kroah-Hartmann)
o	Bring bluetooth driver into line with 2.4.5	(Greg Kroah-Hartmann)
o	Bring dabusb driver into line with 2.4.5	(Greg Kroah-Hartmann)
o	Bring usb dc2xx driver into line with 2.4.5	(Greg Kroah-Hartmann)
o	Bring mdc800 usb driver into line with 2.4.5	(Greg Kroah-Hartmann)
o	Bring rio driver into line with 2.4.5		(Greg Kroah-Hartmann)
o	Bring USB scanner drivers into line with 2.4.5	(Greg Kroah-Hartmann)
o	Update ov511 driver to match 2.4.5		(Greg Kroah-Hartmann)
o	Update PCIIOC ioctls (esp for sparc)		(Dave Miller)
o	General sparc bugfixes				(Dave Miller)
o	Fix possible oops in fbmem ioctls		(Dave Miller)
o	Fix reboot/halt bug on "Alcor" Alpha boxes	(Tom Vier)
o	Update osst driver 				(Willem Riede)
o	Fix syncppp negotiation bug			(Bob Dunlop)
o	SMBfs bug fixes from 2.4 series			(Urban Widmark)
o	3ware IDE raid driver updates			(Adam Radford)
o	Fix incorrect use of bitops on non long types	(Dave Miller)
o	Fix reboot/halt bug on 'Miata' Alpha boxes	(Tom Vier)
o	Update Tim Waugh's contact info			(Tim Waugh)
o	Add TIOCGSERIAL to sun serial on PCI sparc32	(Lars Kellogg-Stedman)
o	ov511 check user data more carefully		(Marc McClelland)
o	Fix netif_wake_queue compatibility macro	(Andi Kleen)

2.2.20pre2
o	Fix ip_decrease_ttl as per 2.4			(Dave Miller)
o	Fix tcp retransmit state bug			(Alexey Kuznetsov)
o	Fix a few obscure sparc tree bugs		(Dave Miller)
o	Fix fb /proc bug and OF fb name size bug	(Segher Boessenkool)
o	Fix complie with CONFIG_INTEL_RNG=y		(Andrzej Krzysztofowicz)
o	Fix rio driver when HZ!=100			(Andrzej Krzysztofowicz)
o	Stop 3c509 grabbing other EISA boards		(Andrzej Krzysztofowicz)
o	Remove surplus defines for root= names		(Andrzej Krzysztofowicz)
o	Revert pre1 APIC change

2.2.20pre1
o	Fix SMP deadlock in NFS				(Trond Myklebust)
o	Fix missing printk in bluesmoke handler		(me)
o	Fix sparc64 nfs					(Dave Miller)
o	Update io_apic code to avoid breaking dual	(Johannes Erdfelt)
	Athlon 760MP
o	Fix includes bugs in toshiba driver		(Justin Keene,
							 Greg Kroah-Hartmann)
o	Fix wanpipe cross compile			(Phil Blundell)
o	AGPGART copy_from_user fix			(Dawson Engler)
o	Fix alpha resource setup error			(Allan Frank)
o	Eicon driver updates				(Armind Schindler)
o	PC300 driver update				(Daniela Squassoni)
o	Show lock owner on flocks			(Jim Mintha)
o	Update cciss driver to 1.0.3			(Charles White)
o	Backport cciss/cpqarray security fixes		(me)
o	Update i810 random number generator		(Jeff Garzik)
o	Update sk98 driver				(Mirko Lindner)
o	Update sis900 ethernet driver			(Hui-Fen Hsu)
o	Fix checklist glitch in make menuconfig		(Moritz Schulte)
o	Update synclink driver				(Paul Fulghum)
o	Update advansys scsi driver			(Bob Frey)
o	Ver_linux fixes for 2.2				(Steven Cole)
o	Bring 2.2 back into line with the master ISDN	(Kai Germaschewski)
o	Whiteheat usb driver update			(Greg Kroah-Hartmann)
o	Fix via_rhine byte counters			(Adam Lackorzynski)
o	Fix modem control on rio serial			(Rogier Wolff)
o	Add more Iomega Zip to the usb storage list	(Wim Coekaerts)
o	Add ZF Micro watchdog 				(Fernando Fuganti)

