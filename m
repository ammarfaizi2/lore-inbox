Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318961AbSHEX2V>; Mon, 5 Aug 2002 19:28:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318963AbSHEX2V>; Mon, 5 Aug 2002 19:28:21 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:35090 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S318961AbSHEX1u>; Mon, 5 Aug 2002 19:27:50 -0400
Date: Mon, 5 Aug 2002 19:40:56 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: lkml <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.20-pre1
Message-ID: <Pine.LNX.4.44.0208051938380.6811-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


So here goes -pre1, with a big -ac and x86-64 merges, plus other smaller
stuff.

2.4.20 will be a much faster release cycle than 2.4.19 was.




Summary of changes from v2.4.19 to v2.4.20-pre1
============================================

<jejb@mulgrave.(none)> (02/03/16 1.159.1.1)
	53c700

<achirica@ttd.net> (02/05/31 1.445.1.13)
	airo wireless net driver update:

<rob@osinvestor.com> (02/06/05 1.537.4.1)
	Sparc32 code cleanups.

<rob@osinvestor.com> (02/06/05 1.537.4.2)
	Sparc32 code cleanups.

<davem@nuts.ninka.net> (02/06/07 1.537.4.3)
	Sparc: Fix copy_{to,from}_user return value handling.

<davem@nuts.ninka.net> (02/06/07 1.537.4.4)
	Sparc64: readv/writev SuS compliance fix for sparc32 compat.

<baccala@vger.freesoft.org> (02/06/07 1.537.4.5)
	DBRI driver: Add T7903 doc URL.

<kanojsarcar@yahoo.com> (02/06/07 1.537.4.6)
	Sparc64: Fix module symbols when stack debugging is on.

<jejb@mulgrave.(none)> (02/06/09 1.159.1.2)
	[SCSI 53c700] bux fix in tag starvation, cosmetic cleanup of set_depth

<jejb@mulgrave.(none)> (02/06/09 1.159.1.3)
	[SCSI 53c700] update version to 2.8

<ak@muc.de> (02/06/12 1.537.1.8)
	RTNETLINK: Allow non-root to receive.

<davem@nuts.ninka.net> (02/06/12 1.537.1.9)
	MAINTAINERS: Remove Andi from networking as per his request.

<rusty@rustcorp.com.au> (02/06/12 1.537.1.10)
	ipv4/route.c: Cleanup ip_rt_acct_read

<jgarzik@rum.normnet.org> (02/06/14 1.537.7.1)
	net driver 8139cp updates:

<wstinson@infonie.fr> (02/06/14 1.537.9.1)
	[janitor] update the isicom.c multiport serial driver to

<wstinson@infonie.fr> (02/06/14 1.537.7.3)
	[janitor] update the ray_cs.c PCMCIA client driver for the Raylink wireless LAN card

<wstinson@infonie.fr> (02/06/14 1.537.7.4)
	[janitor] update the ni65 network driver to

<wstinson@infonie.fr> (02/06/14 1.537.7.5)
	[janitor] update the sdlamain Multiprotocol WAN Link Driver to

<wstinson@infonie.fr> (02/06/14 1.537.9.2)
	[janitor] update the DAC960 Driver for Mylex DAC960/AcceleRAID/eXtremeRAID PCI RAID Controllers

<wstinson@infonie.fr> (02/06/14 1.537.7.6)
	[janitor] update the eexpress.c net driver to

<wstinson@infonie.fr> (02/06/14 1.537.7.7)
	[janitor] update the comx-hw-comx wan driver to remove call to check_region and check the status of call to

<wstinson@infonie.fr> (02/06/14 1.537.7.8)
	[janitor] update the eepro Intel EtherExpress Pro/10 device driver to

<wstinson@infonie.fr> (02/06/14 1.537.7.9)
	[janitor] update the atarilance Ethernet driver for VME Lance cards on the Atari to check the result of request_irq and exit in case of error.

<wstinson@infonie.fr> (02/06/14 1.537.7.10)
	[janitor] update the yam hamradio driver to

<jgarzik@rum.normnet.org> (02/06/14 1.537.10.1)
	Support dumping NIC-specific stats in 8139cp net driver

<jes@wildopensource.com> (02/06/15 1.537.1.11)
	Tigon3: Use unsigned type for dest_idx_unmasked in tg3_recycle_rx.

<jes@wildopensource.com> (02/06/15 1.537.1.12)
	Tigon3: MAX_WAIT_CNT is too large.

<edward_peng@dlink.com.tw> (02/06/15 1.537.7.12)
	dl2k gige net driver updates:

<michaelw@foldr.org> (02/06/17 1.537.4.7)
	sparc64: Use SUNW,power-off to power off some Ultra systems.

<ctindel@cup.hp.com> (02/06/18 1.537.1.13)
	drivers/net/bonding.c: Check ethtool then mii ioctl to determine link status.

<davem@nuts.ninka.net> (02/06/18 1.537.1.14)
	NET: Backport 2.5.x NAPI infrastructure to 2.4.x

<davem@nuts.ninka.net> (02/06/19 1.537.1.15)
	Tigon3: On 32-bit just wrap low 32bits of stats if we overflow.

<jgarzik@mandrakesoft.com> (02/06/20 1.537.12.3)
	Add register dumping and NIC-specific stats to 8139too net driver

<jgarzik@mandrakesoft.com> (02/06/20 1.537.12.4)
	Fix 8139too net driver register dump

<wa@almesberger.net> (02/06/21 1.537.1.16)
	include/net/dsfield.h: Remove dead code.

<jmorris@intercode.com.au> (02/06/25 1.537.1.17)
	NETLINK: Add unicast release notifier.

<davem@nuts.ninka.net> (02/06/25 1.537.1.18)
	SunHME: Register IRQ with netdev->name as string.

<davem@nuts.ninka.net> (02/07/11 1.537.1.19)
	Add netif_receive_skb-like interface for VLAN hw accel.

<davem@nuts.ninka.net> (02/07/11 1.537.1.20)
	Tigon3: Add NAPI support.

<kiran@in.ibm.com> (02/07/12 1.537.1.21)
	net/core/dst.c: dst_total only needs to exist if RT_CACHE_DEBUG >= 2

<rml@tech9.net> (02/07/15 1.537.1.22)
	net/socket.c: Kill memory leak in sock_fasync

<uzi@uzix.org> (02/07/16 1.537.4.8)
	SunHME: Make module license visible when not-PCI.

<davem@nuts.ninka.net> (02/07/16 1.537.4.9)
	arch/sparc64/defconfig: Update.

<robert.olsson@data.slu.se> (02/07/18 1.537.1.23)
	PKTGEN: Updates to version 1.2, work mostly from Ben Greear.

<davem@nuts.ninka.net> (02/07/18 1.537.1.24)
	PKTGEN: Use htonl instead of __constant_htonl.

<kuznet@ms2.inr.ac.ru> (02/07/18 1.537.1.25)
	PKT SCHED: Add HTB scheduler by Martin Devera.

<ecd@skynet.be> (02/07/18 1.537.4.10)
	SPARC64: Fix bugs in ioctl32 registration.

<szepe@pinerecords.com> (02/07/18 1.537.4.11)
	SPARC: Dynamically size SRMMU nocache page pool.

<ebrower@resilience.com> (02/07/19 1.537.1.26)
	SK98LIN: Fix oops in procfs handling if no cards probed.

<rob@osinvestor.com> (02/07/19 1.537.4.12)
	SPARC: Minor header file cleanups.

<rob@osinvestor.com> (02/07/19 1.537.4.13)
	floppy.h: Remove unused empty virtual_dma_init.

<robert.olsson@data.slu.se> (02/07/19 1.537.1.27)
	PKTGEN: Update documentation.

<davem@nuts.ninka.net> (02/07/19 1.537.1.28)
	TIGON3: Finish up NAPI implementation.

<davem@nuts.ninka.net> (02/07/19 1.537.1.29)
	PKTGEN: u64 is not necessarily a long long

<davem@nuts.ninka.net> (02/07/19 1.537.1.30)
	HTB PKTSCHED: u64 is not necessarily a long long

<davem@nuts.ninka.net> (02/07/19 1.537.1.31)
	PKTGEN: Fix need_resched for 2.4.x, more u64 printf fixes.

<davem@nuts.ninka.net> (02/07/19 1.537.1.32)
	PKTGEN: More need_resched 2.4.x fixes

<davem@nuts.ninka.net> (02/07/22 1.537.1.33)
	net/ipv4/route.c: Handle large offsets properly in procfs read operation.

<davem@nuts.ninka.net> (02/07/22 1.537.4.14)
	drivers/sbus/char/openprom.c: Verify user len in copyin_string.

<rob@osinvestor.com> (02/07/22 1.537.4.15)
	arch/sparc/config.in: Remove commented out LVM bits.

<davem@nuts.ninka.net> (02/07/30 1.537.4.16)
	Openprom: Cast nagative tests properly.

<davem@nuts.ninka.net> (02/07/30 1.537.4.17)
	OpenPROM: Cast to ssize_t not int.

<davem@nuts.ninka.net> (02/07/30 1.537.4.18)
	OpenPROM: Kill len check, it is pointless.

<davem@nuts.ninka.net> (02/07/31 1.537.4.19)
	OpenPROM: Sigh, put the length overflow check back it is needed.

<rusty@rustcorp.com.au> (02/08/02 1.582.2.84)
	[PATCH] wan/sdla_chdlc.c oops fix

<mauelshagen@sistina.com> (02/08/02 1.582.2.85)
	[PATCH] LVM 1.0.5 driver update for 2.4.19-rc3

<hch@lst.de> (02/08/02 1.582.2.86)
	[PATCH] remove unused label in fs/dnotify.c

<rusty@rustcorp.com.au> (02/08/02 1.582.2.87)
	[PATCH] ip_nat_core.c - fix compiler warning

<rusty@rustcorp.com.au> (02/08/02 1.582.2.88)
	[PATCH] 3c509.c - 1_2

<rusty@rustcorp.com.au> (02/08/02 1.582.2.89)
	[PATCH] 2.4 i_size_high fixup

<rusty@rustcorp.com.au> (02/08/02 1.582.2.90)
	[PATCH] remove agpgart_be.c unused variables

<rusty@rustcorp.com.au> (02/08/02 1.582.2.91)
	[PATCH] namespace.c - compiler warning

<hch@infradead.org> (02/08/02 1.582.2.92)
	[PATCH] small inline assembly fix for gcc 3.1 (ffs)

<szepe@pinerecords.com> (02/08/02 1.582.2.93)
	[PATCH] reserve nocache based on RAM size

<flo@rfc822.org> (02/08/02 1.582.2.94)
	[PATCH] 2.4.19-rc5 cyclades.c one liner

<garloff@suse.de> (02/08/02 1.582.2.95)
	[PATCH] IDE: memset kmalloced gendisk structures

<agrover@groveronline.com> (02/08/02 1.582.2.96)
	[PATCH] Put Intel cache-detection descriptors in a table

<hch@infradead.org> (02/08/02 1.582.2.97)
	[PATCH] proper boot-time messages for P4 Xeon

<bunk@fs.tum.de> (02/08/02 1.582.2.98)
	[PATCH] document that cmd64x.c supports the CMD649 and CMD680

<jo-lkml@suckfuell.net> (02/08/02 1.592)
	[PATCH] Correct locking on IO stats accounting

<willy@w.ods.org> (02/08/03 1.594)
	[PATCH] Reorder TOSHIBA TC35815 in Config.in

<rob@osinvestor.com> (02/08/03 1.595)
	[PATCH] watchdog flags

<kaos@ocs.com.au> (02/08/03 1.596)
	[PATCH] 2.4.19 include/linux/vmalloc.h for highmem

<marcel@holtmann.org> (02/08/03 1.596.2.1)
	[PATCH] Bluetooth Subsystem PC Card drivers update

<felipewd@terra.com.br> (02/08/03 1.596.3.1)
	Add Wake-On-Lan support to 8139cp net driver

<jgarzik@mandrakesoft.com> (02/08/03 1.596.3.2)
	Temporarily disable MTU-change-while-active support in 8139cp

<felipewd@terra.com.br> (02/08/03 1.596.3.3)
	Update 8139cp net driver to enable legacy Rx/TX command register

<felipewd@terra.com.br> (02/08/03 1.596.3.4)
	Add suspend/resume support to 8139cp net driver

<davidm@hpl.hp.com> (02/08/03 1.596.3.5)
	Update eepro100 net drvr to enable rx DMA without causing

<jgarzik@mandrakesoft.com> (02/08/03 1.596.3.6)
	Add Intel e100 net driver.

<jgarzik@mandrakesoft.com> (02/08/03 1.596.3.7)
	Add e1000 gige net driver.

<jgarzik@mandrakesoft.com> (02/08/03 1.596.3.8)
	Move e100 net driver after eepro100, in kernel image link order.

<alan@irongate.swansea.linux.org.uk> (02/08/05 1.601)
	[PATCH] PATCH: 2.4.20-pre1 - parisc specific include files

<alan@irongate.swansea.linux.org.uk> (02/08/05 1.602)
	[PATCH] PATCH: 2.4.20pre1 - parisc gsc bus

<alan@irongate.swansea.linux.org.uk> (02/08/05 1.603)
	[PATCH] PATCH: 2.4.20-pre1 HP HIL drivers

<alan@irongate.swansea.linux.org.uk> (02/08/05 1.604)
	[PATCH] PATCH: Update the MPT fusion drivers to the vendors latest

<alan@irongate.swansea.linux.org.uk> (02/08/05 1.605)
	[PATCH] PATCH: 2.4/2.5 - Fix endianness on 3c503

<alan@irongate.swansea.linux.org.uk> (02/08/05 1.606)
	[PATCH] PATCH: remove unneeded parisc magic in acenic

<alan@irongate.swansea.linux.org.uk> (02/08/05 1.607)
	[PATCH] PATCH: depca update

<alan@irongate.swansea.linux.org.uk> (02/08/05 1.608)
	[PATCH] PATCH: 2.4/2.5 - Fix traps on alpha when using ewrk3

<alan@irongate.swansea.linux.org.uk> (02/08/05 1.609)
	[PATCH] PATCH: fix gcc warnings in baycom_epp

<alan@irongate.swansea.linux.org.uk> (02/08/05 1.610)
	[PATCH] PATCH: 2.4/2.5 Fix endianness in hp-plus

<alan@irongate.swansea.linux.org.uk> (02/08/05 1.611)
	[PATCH] PATCH: fix multiple gcc 3.1 warnings in irda

<alan@irongate.swansea.linux.org.uk> (02/08/05 1.612)
	[PATCH] PATCH: 2.4/2.5 fix endianness on smc boards

<alan@irongate.swansea.linux.org.uk> (02/08/05 1.613)
	[PATCH] PATCH: 2.4/2.5 fix endianness in wd.c

<alan@irongate.swansea.linux.org.uk> (02/08/05 1.614)
	[PATCH] PATCH: 2.4 - move nubus to static inline

<alan@irongate.swansea.linux.org.uk> (02/08/05 1.615)
	[PATCH] PATCH: 2.4 update gsc parallel port - from maintainer

<alan@irongate.swansea.linux.org.uk> (02/08/05 1.616)
	[PATCH] PATCH: update the aacraid driver

<alan@irongate.swansea.linux.org.uk> (02/08/05 1.617)
	[PATCH] PATCH: fix aic7xxx build when PCI=n

<alan@irongate.swansea.linux.org.uk> (02/08/05 1.618)
	[PATCH] PATCH: eata scsi - update from author

<alan@irongate.swansea.linux.org.uk> (02/08/05 1.619)
	[PATCH] PATCH: fix typo in ncr53c8xx

<alan@irongate.swansea.linux.org.uk> (02/08/05 1.620)
	[PATCH] PATCH: u14-34f scsi driver update from author

<alan@irongate.swansea.linux.org.uk> (02/08/05 1.621)
	[PATCH] PATCH: driver for harmony audio

<alan@irongate.swansea.linux.org.uk> (02/08/05 1.622)
	[PATCH] PATCH: trident audio updates

<alan@irongate.swansea.linux.org.uk> (02/08/05 1.623)
	[PATCH] PATCH: fix undefined C in ixj driver

<alan@irongate.swansea.linux.org.uk> (02/08/05 1.624)
	[PATCH] PATCH: fix gcc 3.1 warnings

<alan@irongate.swansea.linux.org.uk> (02/08/05 1.625)
	[PATCH] PATCH: update sti frame buffer

<alan@irongate.swansea.linux.org.uk> (02/08/05 1.626)
	[PATCH] PATCH: pull the rest of sti into a subdirectory and update it

<alan@irongate.swansea.linux.org.uk> (02/08/05 1.627)
	[PATCH] PATCH: Beos file systems (befs)

<alan@irongate.swansea.linux.org.uk> (02/08/05 1.628)
	[PATCH] PATCH: SOM binary load (parisc specific)

<alan@irongate.swansea.linux.org.uk> (02/08/05 1.629)
	[PATCH] PATCH: Add EFI partition support

<alan@irongate.swansea.linux.org.uk> (02/08/05 1.630)
	[PATCH] PATCH: more hp specific include files

<alan@irongate.swansea.linux.org.uk> (02/08/05 1.631)
	[PATCH] PATCH: Fix gcc 3.1 warnings in vlan

<alan@irongate.swansea.linux.org.uk> (02/08/05 1.632)
	[PATCH] PATCH: fix formatting

<alan@irongate.swansea.linux.org.uk> (02/08/05 1.633)
	[PATCH] PATCH: gcc 3.1 warning fixes for generic_serial

<alan@irongate.swansea.linux.org.uk> (02/08/05 1.634)
	[PATCH] PATCH: HP specific drivers

<alan@irongate.swansea.linux.org.uk> (02/08/05 1.635)
	[PATCH] PATCH: fix compiler warning in mxser

<alan@irongate.swansea.linux.org.uk> (02/08/05 1.636)
	[PATCH] PATCH: (resend for 2.4.20-pre1 as asked) synclink pcmcia

<alan@irongate.swansea.linux.org.uk> (02/08/05 1.637)
	[PATCH] PATCH: PDC (parisc bios) console driver

<alan@irongate.swansea.linux.org.uk> (02/08/05 1.638)
	[PATCH] PATCH: fix compiler warnings

<alan@irongate.swansea.linux.org.uk> (02/08/05 1.639)
	[PATCH] PATCH: fix stallion failing to load

<alan@irongate.swansea.linux.org.uk> (02/08/05 1.640)
	[PATCH] PATCH: fix sx driver compile warnings

<alan@irongate.swansea.linux.org.uk> (02/08/05 1.641)
	[PATCH] PATCH: fix standards compliance bugs in the tty layer

<alan@irongate.swansea.linux.org.uk> (02/08/05 1.642)
	[PATCH] PATCH: clean up umem further

<marcelo@plucky.distro.conectiva> (02/08/05 1.643)
	Changed makefile to .20-pre1

<marcelo@plucky.distro.conectiva> (02/08/05 1.644)
	Import patch revert-acenic-change.patch

<ak@muc.de> (02/08/05 1.645)
	[PATCH] AMD 8111 PCI IDS

<ak@muc.de> (02/08/05 1.646)
	[PATCH] AMD 8111 sound support

<ak@muc.de> (02/08/05 1.647)
	[PATCH] x86-64 auto_fs support

<ak@muc.de> (02/08/05 1.648)
	[PATCH] bluetooth flags warning fixes

<ak@muc.de> (02/08/05 1.649)
	[PATCH] cciss interrupt flags warnings

<ak@muc.de> (02/08/05 1.650)
	[PATCH] CONFIG_ISA for drivers/char

<ak@muc.de> (02/08/05 1.651)
	[PATCH] CONFIG_ISA for IDE

<ak@muc.de> (02/08/05 1.652)
	[PATCH] CONFIG_ISA for radio drivers

<ak@muc.de> (02/08/05 1.653)
	[PATCH] Configuration fixes for net drivers

<ak@muc.de> (02/08/05 1.654)
	[PATCH] DRM 64bit fixes

<ak@muc.de> (02/08/05 1.655)
	[PATCH] Early console support for x86-64

<ak@muc.de> (02/08/05 1.656)
	[PATCH] x86-64 ELF format name

<ak@muc.de> (02/08/05 1.657)
	[PATCH] Ftape 64bit/x86-64 fixes

<ak@muc.de> (02/08/05 1.658)
	[PATCH] CONFIG_ISA for i386

<ak@muc.de> (02/08/05 1.659)
	[PATCH] Interrupt flags fixes for IEEE1394

<ak@muc.de> (02/08/05 1.660)
	[PATCH] x86-64 support in ipc/

<ak@muc.de> (02/08/05 1.661)
	[PATCH] 64bit fixes for drivers/isdn

<ak@muc.de> (02/08/05 1.662)
	[PATCH] 64bit fixes for the megaraid driver

<ak@muc.de> (02/08/05 1.663)
	[PATCH] paride interrupt flags fixes

<ak@muc.de> (02/08/05 1.664)
	[PATCH] 64bit warning fixes for PCI

<ak@muc.de> (02/08/05 1.665)
	[PATCH] synclink interrupt flag fixes

<ak@muc.de> (02/08/05 1.666)
	[PATCH] 64bit fixes for drivers/video

<ak@muc.de> (02/08/05 1.667)
	[PATCH] vsyscall/HPET support for x86-64

<ak@muc.de> (02/08/05 1.668)
	[PATCH] 64bit WAN driver fixes

<ak@muc.de> (02/08/05 1.669)
	[PATCH] wavelan 64bit warning

<ak@muc.de> (02/08/05 1.670)
	[PATCH] x86-64 core changes

<pkot@linuxnews.pl> (02/08/05 1.671)
	[PATCH] remove the warning from include/linux/dcache.h

<ak@muc.de> (02/08/05 1.673)
	[PATCH] 64bit dpt driver fixes

<elenstev@mesatop.com> (02/08/05 1.674)
	[PATCH] 2.4.19,

<maxk@qualcomm.com> (02/08/05 1.675)
	[PATCH] core fixes

<maxk@qualcomm.com> (02/08/05 1.676)
	[PATCH] L2CAP fixes

<maxk@qualcomm.com> (02/08/05 1.677)
	[PATCH] SCO fixes

<maxk@qualcomm.com> (02/08/05 1.678)
	[PATCH] HCI USB driver update

<maxk@qualcomm.com> (02/08/05 1.679)
	[PATCH] BNEP support

<Kai.Makisara@kolumbus.fi> (02/08/05 1.680)
	[PATCH] SCSI tape patch for 2.4.19

<marcelo@plucky.distro.conectiva> (02/08/05 1.681)
	Remove NAPI for now

