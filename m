Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318874AbSHLXbg>; Mon, 12 Aug 2002 19:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318875AbSHLXbg>; Mon, 12 Aug 2002 19:31:36 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:522 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S318874AbSHLXba> convert rfc822-to-8bit; Mon, 12 Aug 2002 19:31:30 -0400
Date: Mon, 12 Aug 2002 19:45:18 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: lkml <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.20-pre2
Message-ID: <Pine.LNX.4.44.0208121943150.3382-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi,

Here goes -pre2.


Summary of changes from v2.4.20-pre1 to v2.4.20-pre2
============================================

<aaron.baranoff@tsc.tdk.com>:
  o Add pci id to tulip net driver

<alan@irongate.swansea.linux.org.uk>:
  o VLAN: Fix gcc-3.1 warnings

<antoine@ausone.whoknows>:
  o Add pci id to tulip net driver

<arndb@de.ibm.com>:
  o 1/18 s390 architecture core updates

<celso@bulma.net>:
  o Pass 'unsigned long' not 'long' as argument to save_flags, in several old net drivers

<ctindel@cup.hp.com>:
  o drivers/net/bonding.c: Handle non-ETHTOOL devices more correctly

<davem@hera.kernel.org>:
  o x.patch

<dent@cosy.sbg.ac.at>:
  o include/net/tcp.h: Kill redundant declaration

<driver@huey.jpl.nasa.gov>:
  o Fix spelling in natsemi net driver

<fbl@conectiva.com.br>:
  o Fix MODULE_DESCRIPTION of olympic and pss drivers

<gnb@alphalink.com.au>:
  o drivers/sbus/char/Config.in: Avoid using ARCH
  o drivers/sbus/char/Config.in: Avoid using ARCH
  o Update net driver Config.in texts to indicate their dependency
  o Mark drivers/net/Config.in entries that depends on CONFIG_OBSOLETE with "(OBSOLETE)" text.

<green@angband.namesys.com>:
  o Many files
  o reiserfs_fs.h, namei.c, bitmap.c
  o Configure.help, Config.in
  o tail_conversion.c, namei.c
  o inode.c
  o reiserfs_fs.h, namei.c, journal.c
  o Many files

<hch@lst.de>:
  o dump_stack()
  o backport yield() and conditional reschedule changes from
  o small VM updates from -aa (1/5)
  o small VM updates from -aa (2/5)
  o small VM updates from -aa (4/5)
  o small VM updates from -aa (5/5)
  o use slab for kiobufs and allocate it's bhs dynamically
  o add missing prototype to arch/i386/kernel/setup.c
  o i386 stackoverflow checker
  o Re: [PATCH] small VM updates from -aa (3/5)
  o conditionally re-enable per-disk stats, convert to seq_file
  o for_each_pgdat/for_each_zone
  o implement kmem_cache_size()
  o advanced f00f bug detection & workaround
  o cure the leftovers of the CONFIG_ISA / X86_64 patch
  o use for_each_pgdat in try_to_free_pages_nozone
  o __set_64bit needs lock prefix
  o minor VM changes from -aa (2/3)
  o minor VM changes from -aa (3/3)

<ica2_ts@csv.ica.uni-stuttgart.de>:
  o net/ipv4/ipconfig.c: [TRIVIAL] fix a typo
  o include/linux/netdevice.h: [TRIVIAL] Use ___cacheline_aligned
  o include/net/tcp.h: [TRIVIAL] Use ___cacheline_aligned

<irohlfs@irohlfs.de>:
  o Add pci id to orinoco wireless net driver

<jackson@realtek.com.tw>:
  o Fix typos in 8139cp net driver RxProto{TCP,UDP} constants

<james@cobaltmountain.com>:
  o net/ipv4/tcp.c: Fix comment typo
  o arch/sparc64/kernel/time.c: Fix comment typo
  o net/sched/sch_ingress.c: [TRIVIAL] Fix debugging printk typo

<jgarzik@tout.normnet.org>:
  o e1000 net driver cleanups

<keithu@parl.clemson.edu>:
  o Get hamachi net driver RX working again

<khc@pm.waw.pl>:
  o Fix epic100 net driver

<maalanen@ra.abo.fi>:
  o Fix use of pointer after kfree(), in au1000_eth net driver

<mw@microdata-pos.de>:
  o Update old eepro net driver

<otaylor@redhat.com>:
  o Yet another new tulip pci id

<sabala@students.uiuc.edu>:
  o Add Conexant LANfinity support to tulip net driver

<steve@gw.chygwyn.com>:
  o [DECNET]: Fix route device refcounting
  o DECnet bug fix

<th122948@scl1.sfbay.sun.com>:
  o Natsemi ethernet driver fixes
  o Natsemi ethernet fixes
  o Lindent drivers/char/nvram.c in anticipation of more patching
  o clean up 'return (x);' style stuff into 'return x' in nvram.c

<thockin@freakshow.cobalt.com>:
  o Fix a typo, so people can have clean logs.  Sheesh :)

<willy@debian.org>:
  o Remove inappropriate use of set_bit in dl2k gige net driver

<willy@w.ods.org>:
  o APM fix for 2.4.20pre1

<wilsonc@abocom.com.tw>:
  o Add two pci ids to 8139too net driver

Alan Cox <alan@lxorguk.ukuu.org.uk>:
  o fix compile problem with multiquad
  o add befs to the list of fs docs
  o parisc doc stuff
  o janitorials on copy_user
  o fix cyclades warning
  o fix up the formatting in Config.in add HP stuff
  o update Makefile for drivers/char for HP bits
  o add author tags to tosh driver
  o fix warnings
  o pcxx janitorials
  o fix wrong bracketing
  o fix formatting the x86_64 people borked
  o ; yet another missing sign check
  o update drivers/Makefile for hp
  o remove unneeded parisc special case
  o undo formatting mess from x86_64, correct list a bit
  o fixup depca, fix a missing sign check
  o fixup e100,e1000
  o switch ne2100 to static not extern inline
  o add new ids to hp driver, plus alignment stuff
  o fix compile warning
  o arch/parisc
  o remove bogus x86_64 junk
  o update lasi driver
  o fix warnings
  o remove bogus x86_64isms, fix warnings
  o fix warning
  o remove unused bits
  o update HP lasi scsi driver
  o fix pas16 command option parsing
  o typo
  o HP fixes for sym2 - approved by maintainer
  o HP Zalon scsi driver
  o fix warning in bin2hex
  o missing semaphore drop on error path
  o update framebuffer fbcon logic for HP
  o fbmem for hp
  o video Makefile for HP
  o fix warning in pm3
  o befs uses NLS
  o ATM warning fixes

Andrew Morton <akpm@zip.com.au>:
  o Fix set_page_dirty race

Ben Collins <bcollins@debian.org>:
  o Ignore Subversion RCS files

Brad Hards <bhards@bigpond.net.au>:
  o Remove unneeded #includes from 3c359, sbni, and sdla_ft1 net drivers

Christoph Hellwig <hch@infradead.org>:
  o Clean up eepro100 net driver update from David M-T

David S. Miller <davem@nuts.ninka.net>:
  o IPv4: Fix MSG_DONTWAIT behavior on output fragmentation
  o VLAN dev: Fix hard_start_xmit return values
  o [NETFILTER]: Add some new iptables modules. (from laforge@gnumonks.com)
  o include/linux/netdevice.h: Define HAVE_NETDEV_POLL

David Woodhouse <dwmw2@infradead.org>:
  o linux-2.4.19-pre10-shared-zlib
  o Trivial JFFS2 oops fix

Eric Sandeen <sandeen@sgi.com>:
  o Fix printk, remove dead prototype in rcpci45 net driver
  o Fix warning in ppp_generic
  o Remove unused var and unused func from ali-ircc IrDA driver

Gerd Knorr <kraxel@bytesex.org>:
  o btaudio driver update
  o gemtek radio driver fix
  o video4linux i2c audio modules update
  o bttv documentation update
  o video4linux tuner update
  o bttv driver update

Greg Kroah-Hartman <greg@kroah.com>:
  o USB pl2303 driver
  o USB: usb.h cleanups, typedef removed for iso packets, and whitespace changes
  o USB: removed urb_t typedef
  o USB: removed the devrequest typedef
  o USB: added TI edgeport usb to serial driver
  o USB: added new host controller driver for HC_SL811 devices
  o USB: added aiptek driver
  o USB: added tiglusb driver
  o USB: added usb-midi driver
  o USB: added new drivers to the build
  o USB: bluetooth fixes for usb typedef cleanups
  o ACPI PCI Hotplug driver update
  o IBM PCI Hotplug driver update

Harald Welte <laforge@gnumonks.org>:
  o net/ipv4/netfilter/ip_nat_core.c: Fix memory leak on unload
  o [IP_{CONNTRACK,NAT}_{IRC,FTP}] Handle helper registration failure properly
  o [NETFILTER]: Backport newnat infrastructure to 2.4.x
  o [NETFILTER]: REJECT packet should not inherit nfmark of original packet
  o [NETFILTER]: Two functions which should be static in ipt_ah.c are not
  o [NETFILTER]: Allow owner match module match process names
  o include/linux/kernel.h: Define HIPQUAD correctly on little-endian

Jean Tourrilhes <jt@bougret.hpl.hp.com>:
  o New Wireless Extension API - part2
  o wavelan_cs update (v23)
  o Fix dev->trans_start in wavelan
  o ir240_trivial_fixes-3.diff
  o ir240_sys_max_tx-2.diff
  o ir240_irnet_disc_ind_again.diff
  o ir240_discovery_fixes.diff
  o IrDA NSC driver add new chip
  o IrDA irtty bugfixes
  o IrDA: Make discovery expiry work properly for non default period
  o Add new IrDA dongle drivers

Jeff Garzik <jgarzik@mandrakesoft.com>:
  o Add e100 and e1000 net driver docs
  o Merge spelling fixes from Rusty's "trivial" patch collection
  o Update 3c509 net driver to move MODULE_LICENSE outside all ifdefs
  o Include linux/bitops in e100 net driver, it uses ffs() (Noticed by DaveM)
  o Update 8139too net driver to make new rx-reset method the default
  o Fix mistake in 8139too net driver Config.in entry
  o Proper support for RTL8139 rev K in 8139too net driver
  o Release 8139too net driver version 0.9.26
  o Fix TX checksumming in 8139cp net driver (the feature is still ifdef'd out by default, however)
  o Add 64-bit DMA support to 8139cp net driver

Jens Axboe <axboe@suse.de>:
  o Add block IO directly from highmem support
  o ext3 __FUNCTION__ usage in 2.4
  o sr scatter oops

Jürgen E. Fischer <fischer@linux-buechse.de>:
  o Fix AHA152X problem

Marcelo Tosatti <marcelo@plucky.distro.conectiva>:
  o Import patch revert-x8664-config-change.patch
  o Remove duplicate MAINTAINERS entry
  o Import patch revert-wrong-kconfig-syncbanner
  o Changed EXTRAVERSION to pre2
  o Add missing bracket missing in hch's __free_pages_ok() patch

Neil Brown <neilb@cse.unsw.edu.au>:
  o knfsd - 1/19 - Tidy up code in nfsd_lookup
  o knfsd - 2/19 - Tidyup init/exit of nfsd module
  o knfsd - 3/19 - Support fsid=<number> export option to be
  o 1 of 11 - Claim semaphore for ->lookup call
  o 2 of 11 - Change sunrpc to use more list.h lists
  o 3 of 11 - Get sunrpc to use module_init properly
  o 4 of 11 - Tidy up SMP locking for svc_sock
  o 5 of 11 - Detect and close tcp connections that we cannot
  o 6 of 11 - Close idle rpc/tcp sockets
  o 7 of 11 - Cope with short read when reading length of
  o 8 of 11 - Make sure there is alway adequate sndbuf space
  o 9 of 11 - Limit number of active tcp connections to an RPC
  o 10 of 11 - Allow  SO_REUSEADDR for NFS sockets

Olaf Hering <olh@suse.de>:
  o drivers/macintosh only on ppc32

Paul Mackerras <paulus@samba.org>:
  o PPC32: Start moving files to their new locations
  o PPC32: adjustments to correspond with the new locations of files
  o PPC32: more include and Makefile fixes

Pavel Machek <pavel@ucw.cz>:
  o Remove unnecessary prototypes in eepro100 net driver

pavel@janik.cz <Pavel@Janik.cz>:
  o Probe port 0x240 too, in eexpress net driver

Petr Vandrovec <vandrove@vc.cvut.cz>:
  o ncpfs reports ESTALE in 2.4.19

Rob Radez <rob@osinvestor.com>:
  o SPARC: Get sun4c working again
  o Documentation/Configure.help: CONFIG_SPARCAUDIO_DBRI applies to LX systems too

Russell King <rmk@arm.linux.org.uk>:
  o if_ether.h: Use packed attribute where necessary
  o ip6_tables.c: Uncomment debugging printf

Rusty Russell <rusty@rustcorp.com.au>:
  o warning cleanup for drivers/video/sstfb.c
  o TRIVIAL EPERM -> EACCESS
  o documentation typos in
  o header cleanup - arch_ppc64_kernel_htab.c
  o cure gcc3 warning in arch_i386_kernel_apm.c
  o Fix type of compute_loop_size()
  o Re: header cleanup - drivers_net_wan_sdla_ft1.c
  o header cleanup - drivers_net_wan_sbni.c
  o make awe_wave use struct isapnp_device_id
  o explicit signed char cast in i386 spin_is_locked
  o 40) request_region check, 31-40
  o 2.5: kconfig synchronise banners (6_16)
  o Typo in linux_arch_i386_kernel_apic.c
  o cure compiler warnings in arch_i386_kernel_setup.c
  o [PATCH][trivial] silence disable_ide_dma warning in
  o header cleanup - drivers_bluetooth_hci_ldisc.c
  o fix "inline" placement in serial.c
  o warning cleanup for drivers_media_video_zr36067.c
  o silence APIC errors a bit
  o warning cleanup for drivers_atm_atmtcp.c
  o warning cleanup for drivers_message_i2o_i2o_pci.c
  o Typo in arch_mips_dec_wbflush.c
  o Typo in linux_fs_partitions_msdos.c
  o Trivial Patch to sched.h for
  o Maxium inline patch is 40 kilobytes, not kilobits
  o 2.5: kconfig use of $ARCH (1_12)
  o Fix conflicting md_cpu_has_mmx definitions
  o Fix typo in mm_slab.c
  o Typo in linux_arch_i386_kernel_smp.c
  o Typo in linux_include_asm-cris_pgtable.h
  o 2.5: kconfig spurious bool default value (1_3)
  o Typo in linux_arch_mips64_kernel_irq.c
  o redundant declarations (#10_15)
  o Typo in linux_kernel_pm.c
  o 2.5: kconfig synchronise banners 3
  o Typos in linux_arch_i386_kernel_io_apic.c
  o 2.5: kconfig missing EXPERIMENTAL (1_14)
  o 2.5: kconfig use of $ARCH (2_12)
  o 2.5: kconfig synchronise banners (4_16)
  o 25) request_region check, 21-30
  o Typo in linux_arch_i386_kernel_mpparse.c
  o redundant declarations (#11_15)
  o 2.5: kconfig missing EXPERIMENTAL (3_14)
  o 2.5: kconfig use of $ARCH (6_12)
  o Typo in linux_include_asm-m68k_mac_via.h
  o Typo in linux_net_sunrpc_xprt.c
  o 2.5: kconfig synchronise banners 2 (2_3)
  o 2.5: kconfig missing EXPERIMENTAL 2 (5_7)
  o Typo in linux_include_linux_raid_md_k.h
  o [patch, 2.4] cs4232.c doesn't kfree on error path
  o 2.5: kconfig synchronise banners (8_16)
  o Typos in linux_drivers_mtd_devices_blkmtd.c
  o Typos in Documentation_video4linux_meye.txt (2.4.19-rc1)
  o ipc_ statics
  o correct inaccurate comment regarding zone_table's usage
  o 2.5: kconfig synchronise banners (16_16)
  o Typo in linux_include_asm-sh_pgtable-2level.h
  o Typo in linux_include_linux_brlock.h
  o drm_mga bitops -> long fix
  o Typo in linux_arch_mips64_math-emu_ieee754.c
  o Typo in linux_net_unix_af_unix.c
  o 2.5: kconfig use of $ARCH (7_12)
  o Typo in linux_kernel_fork.c
  o 2.5: kconfig missing EXPERIMENTAL 2 (6_7)
  o Typo in linux_arch_ppc64_kernel_pSeries_pci.c
  o redundant declarations (#8_15)
  o 2.5: kconfig synchronise banners (11_16)
  o 2.5: kconfig use of $ARCH (9_12)
  o Typo in linux_net_sched_sch_ingress.c
  o 2.5: kconfig use of $ARCH (8_12)
  o 2.5: kconfig missing EXPERIMENTAL (9_14)
  o 2.5: kconfig use of $ARCH (12_12)
  o Typo in linux_net_ipv4_tcp.c
  o Typos in linux_mm_highmem.c
  o ia64 incorrect field name in message
  o 2.5: kconfig missing EXPERIMENTAL (6_14)
  o Typo in linux_arch_i386_kernel_setup.c
  o 2.5: kconfig synchronise banners (14_16)
  o Typo in linux_drivers_media_video_pms.c
  o 2.5: kconfig EXPERIMENTAL misformed
  o 2.5: kconfig use of $ARCH (4_12)
  o Fix typo in net_ipv4_ipconfig.c
  o 2.5: kconfig missing EXPERIMENTAL (12_14)
  o Typo in linux_arch_ia64_sn_fakeprom_README
  o Typo in linux_fs_pipe.c
  o Typo in linux_drivers_isdn_isdn_ppp.c
  o Typo in linux_drivers_sound_cs4232.c
  o Typo in linux_drivers_ide_ide-geometry.c
  o kerneldoc: In kernel-hacking describe designated
  o 2.5: kconfig sychronise banners (2_16)
  o Use proper ____cacheline_aligned define in
  o 2.5: kconfig use of $ARCH (11_12)
  o 2.5: kconfig use of $ARCH (10_12)
  o 2.5: kconfig synchronise banners (5_16)
  o 2.5: kconfig missing EXPERIMENTAL 2 (2_7)
  o 2.5: kconfig synchronise banners (1_16)
  o Typo in linux_arch_sparc64_kernel_time.c
  o 2.5: kconfig synchronise banners (3_16)
  o 2.5: kconfig missing EXPERIMENTAL 2 (1_7)

Tom Rini <trini@kernel.crashing.org>:
  o PPC32: Remove arch/ppc/kernel/local_irq.h as well as move some headers to include/asm-ppc
  o PPC32: Change pcibios_assign_all_busses into a marco
  o PPC32: Don't report the TAU feature on any of the MPC745x CPUs, as it's not supported
  o PPC32: Move arch/ppc/kernel/ppc_asm.h to include/asm-ppc/ppc_asm.h
  o PPC32: Have arch/ppc/kernel/ptrace.c point to 'COPYING' instead of 'README.legal'



