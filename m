Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbTDDVGB (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 16:06:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbTDDVGB (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 16:06:01 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:43146 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S261290AbTDDVF4 (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 16:05:56 -0500
Date: Fri, 4 Apr 2003 18:15:52 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: lkml <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.21-pre7
Message-ID: <Pine.LNX.4.53L.0304041815110.32674@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


So here goes -pre7. Hopefully the last -pre.

Please try it.


Summary of changes from v2.4.21-pre6 to v2.4.21-pre7 v2.4.2-pre7
============================================

<bergner@cannon.rchland.ibm.com>:
  o PPC64 update

<cramerj@intel.com>:
  o [E1000] Documentation/networking/e1000.txt updates
  o [E1000] Version, copyright, changelog and MAINTAINERS
  o [E1000] Spd/dplx abstraction; eeprom size changes
  o [E1000] IRQ registration fix
  o [E1000] Added 82541 & 82547 support
  o [E1000] Added MII support
  o [E1000] Modulus math removed
  o [E1000] Perform single PCI read per interrupt
  o [E1000] Tx Descriptor cleanup
  o [E1000] Read/Write register macro optimizations
  o [E1000] Compaq to HP branding change
  o [E1000] Whitespace changes
  o [E1000] Added Tx FIFO flush routine
  o [E1000] Added Interrupt Throttle Rate tuning support
  o [E1000] Controller wake-up thru ASF fix
  o [E1000] whitespace fix from previous patches

<green@linuxhacker.ru>:
  o Memleak in KOBIL USB Smart Card Terminal Driver
  o USB: more Edgeport USB Serial Converter driver stuff
  o USB: Memleak in drivers/usb/hub.c::usb_reset_device
  o USB: memleak in Edgeport USB Serial Converter driver

<henning@meier-geinitz.de>:
  o USB: New ids for scanner driver

<jgarzik@pobox.com>:
  o fix e1000 C99 initializer
  o fix pcnet32 multicast fix

<jmcmullan@linuxcare.com>:
  o USB HID: Ignore P5 Data Glove

<lfo@polyad.org>:
  o [SPARC64]: Define IDE MAX_HWIFS like x86

<msdemlei@cl.uni-heidelberg.de>:
  o USB: Patch for DSBR-100 driver

<okurth@gmx.net>:
  o USB: MTU patch for kaweth

Adam Radford <adam@nmt.edu>:
  o 3ware driver update: Backport 2.5 fixes

Adrian Bunk <bunk@fs.tum.de>:
  o trident 1/1 fix operator precedence bug

Alan Cox <alan@lxorguk.ukuu.org.uk>:
  o arm typo fix
  o Update DMI
  o later VIA apic
  o PCI layer bits for 440GX
  o identify SiS 550 SoC
  o warning fix
  o mips config syntax fix
  o iphase fixes
  o update char Config.help
  o fix char Makefile
  o fix mem handling of high areas
  o sx memory leak fix
  o ibm hot plug driver fix
  o resync IDE with -ac
  o small isdn fixe
  o i2o fixes
  o 3c501 typo fix
  o dgrs clean
  o use ulong for timers
  o update pc.ids
  o pcmcia oops fix
  o config syntax for S/390
  o status must be signed
  o add aic79xx to makefile
  o more megaraid fixups
  o dpt_i2o memory leak comments
  o fix pcmcia shared irq on qlogicfas
  o fix time abuse in qlogicfc
  o more AC97 codec support
  o leaks brackets and ;s for audio
  o forte update from maintainer
  o gus fixes
  o make i810_audio use ac97 updates
  o ixj leak fixes
  o aic7xxx updates/aic79xx
  o USB HCD deadlock fix
  o setup bits for intelfb
  o handle radeons that report 0 ram
  o ldm leak fix
  o ufs leak fix
  o Add SIS CPU family ident
  o fix time types for tty
  o HP now owns compaq, maintainers shipft
  o add syskonnect maintainer
  o vlan leak fix
  o irda leak fix

Alan Stern <stern@rowland.harvard.edu>:
  o USB: Belkin Compact Flash card reader fix

Andrew Morton <akpm@digeo.com>:
  o /proc/sysrq-trigger: trigger sysrq functions via

Andries E. Brouwer <andries.brouwer@cwi.nl>:
  o USB: add better sddr09 support

Arjan van de Ven <arjanv@redhat.com>:
  o usb storage horkage fix

Ben Collins <bcollins@debian.org>:
  o [SPARC64]: Add image target and fixup archclean

Brad Hards <bhards@bigpond.net.au>:
  o USB: CDC Ethernet maintainer transfer

Christoph Hellwig <hch@infradead.org>:
  o SGI SCSI blacklist entries for 2.4.21-pre6

Christoph Hellwig <hch@lst.de>:
  o fix drm-4.0 compile failure

David Brownell <david-b@pacbell.net>:
  o USB: ehci-hcd, prink tweaks

David S. Miller <davem@nuts.ninka.net>:
  o [SPARC64]: Use GFP_ATOMIC in request_irq
  o [SPARC64]: Fix interrupt enabling on trap return
  o [SPARC64]: Update defconfig
  o [SPARC64]: Do not define special strip, sparc64-linux-strip is actually normal strip
  o [SPARC64]: Get ALI trident sound working again
  o [SPARC64]: 2 timer handling fixes

David S. Miller <davem@redhat.com>:
  o USB: fix for host controler build

David Woodhouse <dwmw2@infradead.org>:
  o Fix erase suspend for write on Intel flash chips
  o Fix prototype of jffs2_get_ino_cache() to take unsigned argument

Erik Andersen <andersen@codepoet.org>:
  o missing -ac merge in include/linux/ide.h

Greg Kroah-Hartman <greg@kroah.com>:
  o USB: added support for the palm M100
  o USB: Added support for the Sony Clie NZ90V device
  o USB: add support for Treo devices to the visor driver
  o USB: fixup from previous io_ti.c patch
  o USB: added support for Ericsson data cable to pl2303 driver
  o USB: usb-storage bugfix
  o USB: fix up zero packet issues with CDCEther driver

Ivan Kokshaysky <ink@jurassic.park.msu.ru>:
  o alpha: misc cleanups and fixes
  o fix PCI bridge memory sizing

Jay Vosburgh <fubar@us.ibm.com>:
  o [bonding] fixes, cleanups, and minor feature addition

Jeff Garzik <jgarzik@redhat.com>:
  o [netdrvr tg3] fix memleak in DMA test
  o [via-rhine] note that Roger is maintainer, in MAINTAINERS
  o [netdrvr pcnet32] revert to 2.4.19 version
  o [netdrvr pcnet32] fix multicast on big endian

Johannes Erdfelt <johannes@erdfelt.com>:
  o USB: uhci.c 2.4 finish completions in the correct order

Maksim Krasnyanskiy <maxk@qualcomm.com>:
  o [Bluetooth] Use very short disconnect timeout for SCO connections.
  o [Bluetooth] Kill incoming SCO connection when SCO socket is closed.
  o [Bluetooth] Support for SCO (voice) over HCI USB
  o [Bluetooth] Do not submit more than one usb bulk rx request. It crashes uhci.o driver.
  o [Bluetooth] Use atomic allocations in HCI USB functions called under spinlock

Marcel Holtmann <marcel@holtmann.org>:
  o Cset exclude: marcel@holtmann.org|ChangeSet|20030208185812|16161
  o Cset exclude: marcel@holtmann.org|ChangeSet|20030122214259|16085
  o [Bluetooth] Add support for the Ultraport Module from IBM
  o [Bluetooth] Use R1 for default value of pscan_rep_mode
  o [Bluetooth] Add help entry for CONFIG_BLUEZ_USB_SCO

Marcelo Tosatti <marcelo@freak.distro.conectiva>:
  o Changed EXTRAVERSION to -pre7
  o Add missing PCI ID's from -ac merge
  o Add more missing PCI IDS from -ac merge

Matthew Wilcox <willy@debian.org>:
  o Reduce random.c stack usage

Pete Zaitcev <zaitcev@redhat.com>:
  o [SPARC64]: Kill ELF_FLAGS_INIT

Roger Luethi <rl@hellgate.ch>:
  o [via-rhine] fix races
  o [via-rhine] reset logic
  o [via-rhine] changelog

Scott Feldman <scott.feldman@intel.com>:
  o [E100] Update Documentation/networking/e100.txt
  o [E100] Update version(2.2.21-k1), copyright, changelog
  o [E100] spelling corrections from 2.5
  o [E100] Add support for VLAN hw offload
  o [E100] Cleanup #include order
  o [E100] OS already calcs pseudo-hdr [anton@samba.org]
  o [E100] interurpt handler free fix
  o [E100] Validate updates to MAC address
  o [E100] ethtool EEPROM and GSTRINGS fix
  o [E100] ASF wakeup enabled, but only if set in EEPROM
  o [E100] Remove strong branded marketing strings
  o [E100] forced speed/duplex link recover
  o [E100] Honor WOL settings in EEPROM
  o [E1000] Increase default Rx descriptors to 256

Stephen C. Tweedie <sct@redhat.com>:
  o Add less-severe assert-failure form for ext3
  o Fix ext3 panic due to ll_rw_block behaviour after illegal block access
  o Fix duplicate #include in journal.c
  o Fix jbd assert failure on IO error
  o Minor build fix for ext3 (2.4 and 2.5)
  o Throttle ENOMEM warnings more aggressively
  o Fix flushtime ordering on BUF_DIRTY list

Tom Rini <trini@kernel.crashing.org>:
  o PPC32: Pass in the memory size on PReP machines

Wolfgang Muees <wolfgang@iksw-muees.de>:
  o USB: Memory leak in auerswald driver

