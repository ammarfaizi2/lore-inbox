Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263850AbRFRJGF>; Mon, 18 Jun 2001 05:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263851AbRFRJFp>; Mon, 18 Jun 2001 05:05:45 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:46596 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263850AbRFRJFi>; Mon, 18 Jun 2001 05:05:38 -0400
Date: Mon, 18 Jun 2001 10:04:52 +0100
From: Alan Cox <laughing@shared-source.org>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.2.20pre3
Message-ID: <20010618100452.A14622@lightning.swansea.linux.org.uk>
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

