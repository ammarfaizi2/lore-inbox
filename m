Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264588AbRFYOqj>; Mon, 25 Jun 2001 10:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264589AbRFYOq3>; Mon, 25 Jun 2001 10:46:29 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:29966 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264588AbRFYOqT>; Mon, 25 Jun 2001 10:46:19 -0400
Date: Mon, 25 Jun 2001 15:46:02 +0100
From: Alan Cox <laughing@shared-source.org>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.2.20pre6
Message-ID: <20010625154602.A7354@lightning.swansea.linux.org.uk>
Mail-Followup-To: Alan Cox <laughing@shared-source.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linux 2.2 is now firmly into maintainance state. Patches for neat new ideas
belong in 2.4. Generally new drivers belong in 2.4 (possibly in 2.2 as well
after 2.4 shows them stable). Expect me to be very picky on changes to the
core code now. 

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

