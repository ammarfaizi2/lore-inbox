Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261641AbTHYLtj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 07:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbTHYLtj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 07:49:39 -0400
Received: from hera.kernel.org ([63.209.29.2]:7838 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261641AbTHYLsb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 07:48:31 -0400
Date: Mon, 25 Aug 2003 04:48:30 -0700
From: Marcelo Tosatti <marcelo@hera.kernel.org>
Message-Id: <200308251148.h7PBmU8B027700@hera.kernel.org>
To: linux-kernel@vger.kernel.org
Subject: linux-2.4.22 released
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

final:

- 2.4.22-rc4 was released as 2.4.22 with no changes.


Summary of changes from v2.4.22-rc3 to v2.4.22-rc4
============================================

<marcelo:logos.cnet>:
  o Fix drivers/net/Config.in -> CONFIG_TC35815
  o Changed EXTRAVERSION to -rc4

Andi Kleen:
  o Fix x86-64 ia32 emulation

Paul Mackerras:
  o PPC32: Make strncpy clear the unused part of the destination
  o PPC32: Make sure various sections get aligned properly by the linker

Ralf Bächle:
  o dep_tristate fix for CONFIG_TC35815


Summary of changes from v2.4.22-rc2 to v2.4.22-rc3
============================================

<len.brown:intel.com>:
  o ACPI update
  o ACPI build fix
  o linux-acpi-2.4.22.patch

<marcelo:logos.cnet>:
  o Cset exclude: jgarzik@redhat.com|ChangeSet|20030706160607|06244
  o Cset exclude: jgarzik@redhat.com|ChangeSet|20030705173225|06246
  o Changed EXTRAVERSION to -rc3
  o Update Makefile: drivers/sgi removed
  o Make the Toshiba TC35815 only selectable on the only system know to actually use it

<markhe:veritas.com>:
  o Wrong assumption in set_bh_page()

<paul.clements:steeleye.com>:
  o nbd: fix race conditions

<steved:redhat.com>:
  o Stop call_decode() from ignorning RPC header errors

Alan Cox:
  o Alan CREDIT/MAINTAINERS update

Andi Kleen:
  o Disable ACPI NUMA support for x86-64
  o Critical x86-64 fixes for 2.4.22-rc
  o [SECURITY] Fix interrupt gates on x86-64

Andrea Arcangeli:
  o Andrea contact information update

Andreas Gruenbacher:
  o More steal_locks fixes: we should be in full LSB compliance now

David S. Miller:
  o [IPV6]: Fix dangling multicast device references

David Stevens:
  o [NET]: Fix IGMPv2/MLDv2 list handling OOPS

Erik Andersen:
  o Fix cdrom error handling

Geert Uytterhoeven:
  o Remove unused label in sunrpc code
  o Update Geert's contact information

Ivan Kokshaysky:
  o alpha: yet another stxncpy fix

Jeff Garzik:
  o fix OOPS in bonding driver, when removing primary slave
  o add a couple pci ids to pci_ids.h

Kai Makisara:
  o Change Kai Makisara's email address

Marcelo Tosatti:
  o Ingo: Fix ptrace swap race
  o Changed HFS maintainer: Roman Zippel is now doing the work

Michal Ostrowski:
  o Fix PPPoE oops on unload

Muli Ben-Yehuda:
  o fix trident.c lockup on module load 2.4.22-rc1

Nathan Scott:
  o Fix 2.4 loop handling of sector size ioctl

Petr Vandrovec:
  o Allow atime updates on ncpfs

Ralf Bächle:
  o Important DEC/MIPS update
  o More MIPS update



Summary of changes from v2.4.22-rc1 to v2.4.22-rc2
============================================

<bjorn.helgaas:hp.com>:
  o HP ZX1 PCI ID update

<khali:linux-fr.org>:
  o i2c-dev ioctl fixes

<marcelo:logos.cnet>:
  o ide.c: Keep hwif->hold flag needed by powermac mbay driver
  o Changed EXTRAVERSION to -rc2

<robn:verdi.et.tudelft.nl>:
  o Do not update fifo timestamps on readonly fses

Alan Cox:
  o ide makefile
  o Promise cable
  o Fix the siimage dma setup bug
  o via ide fix timing bug (as already done in 2.6.0-test)
  o fix bracketing in ti113x pcmcia header
  o remove bogus printk that can spam the logs
  o zero padding in struct on stack
  o get quota version
  o Avoid i810 ICH crashes with MMIO only

Andrew Morton:
  o ext3_read_inode() race fix

Herbert Xu:
  o Fix steal_locks race

Ivan Kokshaysky:
  o alpha: shutdown/reboot fix (Jay Estabrook, me)

Marc-Christian Petersen:
  o Intel ICH5 PCI IDs

Oleg Drokin:
  o reiserfs: fix some issues with extended inode attributes


Summary of changes from v2.4.22-pre10 to v2.4.22-rc1
============================================

<calum.mackay:cdmnet.org>:
  o export the symbol "mmu_cr4_features" for XFree86

<lethal:unusual.internal.linux-sh.org>:
  o sh: Define __flush_icache_all() for SH-3
  o sh: Fix single stepping from looping
  o sh: Add pgprot_nocached() definition
  o sh: Further support for SecureEdge5410 and SH7751R

<marcelo:logos.cnet>:
  o Delete: fs/noquot.c
  o Cset exclude: bunk@fs.tum.de|ChangeSet|20030804201535|32414
  o Changed EXTRAVERSION to -rc1

Adrian Bunk:
  o fix a compile warning in acpi/system.c
  o Fix circular dependency

Benjamin Herrenschmidt:
  o ppc32: Fix PowerMac mediabay driver

Jeff Garzik:
  o devices.txt: rename /dev/intel_rng to /dev/hwrandom
  o [i810_rng] update docs to reflect new /dev name, and new pkg name

Manfred Spraul:
  o fix select() with an xoffed tty

Theodore Y. T'so:
  o Correct 64-bit write system call assignment



Summary of changes from v2.4.22-pre9 to v2.4.22-pre10
============================================

<achirica:telefonica.net>:
  o [wireless airo] sync with 2.6
  o [wireless airo] Simplify dynamic buffer code in Cisco extensions
  o [wireless airo] Update  structs with the new fields in latest firmwares
  o [wireless airo] Make locking "per thread" so it's fully preemptive
  o [wireless airo] Don't sleep when the stats are requested
  o [wireless airo] Don't call MIC functions if the card doesn't support them
  o [wireless airo] Fix small endianness bug
  o [wireless airo] Returns proper status in case of transmission error
  o [wireless airo] Checks for small packets before transmitting them
  o [wireless airo] Return channel in infrastructure mode
  o [wireless airo] Update to wireless extensions 15 (add monitor mode)
  o [wireless airo] Update to wireless extensions 16 (new spy API)
  o [wireless airo] fix Tx race
  o [wireless airo] safer shutdown sequence
  o [wireless airo] eliminate infinite loop
  o [wireless airo] makes the card passive when entering monitor mode
  o [wireless airo] adds support for noise level reporting (if available)

<bjorn.helgaas:hp.com>:
  o trivial 2.4 HCDP documentation/config patch

<herbert:13thfloor.at>:
  o ROOT NFS fixes

<marcelo:logos.cnet>:
  o NMI watchdog documentation for x86-64

<mike.miller:hp.com>:
  o cciss update: author change
  o cciss update: Fix problem with shared IRQs

Adam Radford:
  o 3ware driver update

Adrian Bunk:
  o fix IPMI build error #if CONFIG_ACPI_HT_ONLY

Benjamin Herrenschmidt:
  o ppc32: export hash_table_lock on SMP for MacOnLinux

Dave Kleikamp:
  o JFS: write_super_lockfs should mark superblock clean

Jan Harkes:
  o Coda fixes

Jay Vosburgh:
  o [netdrvr bonding] fix ifenslave ia64 build

Jeff Garzik:
  o [netdrvr] add new broadcom 440x net driver, "b44"

Marc-Christian Petersen:
  o Fix AGPGART problem with 4GB RAM
  o Fix irq handling of IO-APIC edge IRQs on UP
  o MXCSR Handler Unspecified Vulnerability
  o Fix /proc/self security issue
  o Add missing -EFAULT for sysctl

Marcelo Tosatti:
  o Changed EXTRAVERSION to -pre10

Oleg Drokin:
  o reiserfs: fix savelinks for bigendian arches

Petr Vandrovec:
  o ncpfs: Support for clustered NetWare volumes
  o matroxfb: extended support for mplayer

Shmulik Hen:
  o [bonding] fix ifenslave ABI bug
  o [netdrvr bonding] fix ARP monitoring bug

Trond Myklebust:
  o If an RPC request has to be resent due to a timeout, it turns out that call_encode() may cause rq_rcv_buf to be reset despite the fact that a reply might be delivered at any moment by a softirq.
  o If xdr_kmap() fails, we need to ensure that it unmaps all the pages, and returns 0. We don't want to be sending partial RPC requests to the server.

Willy Tarreau:
  o ACPI poweroff fix
  o [netdrvr bonding] fix a typo in the MODULE_PARM_DESC
  o [netdrvr bonding] fix kernel panic when optional feature used



Summary of changes from v2.4.22-pre8 to v2.4.22-pre9
============================================

<jones:ingate.com>:
  o [IGMP]: linux/igmp.h needs asm/byteorder.h

<martin.bene:icomedias.com>:
  o [NETFILTER]: Add missing include to ip_conntrack_core.h

<pp:netppl.fi>:
  o Avoid annoying "can't emulate rawmode" messages with logitech cordless mice

<vherva:niksula.hut.fi>:
  o NMI watchdog documentation

Adrian Bunk:
  o [NETFILTER]: Add missing Configure.help entry for ipt_recent
  o MTD Configure.help cleanups

Andreas Gruenbacher:
  o Fix warning in fs/binfmt_elf.c

Ben Collins:
  o Include param.h for HZ in ieee1394
  o Interim IEEE-1394 fixes

Harald Welte:
  o [NETFILTER]: Fix a bug in the IRC DCC command parser of ip_conntrack_irc

Maciej Soltysiak:
  o [NETFILTER]: Make REJECT target compliant with RFC 1812

Marcelo Tosatti:
  o Changed EXTRAVERSION to -pre9

Neil Brown:
  o knfsd - Convert error code to nfserror code in nfsd_symlink
  o knfsd - BKL is missing in once place in knfsd
  o md -  Resolve problem with refcounting of md arrays

Olof Johansson:
  o [RANDOM]: Fix SMP deadlock in __check_and_rekey()

Patrick McHardy:
  o [NET]: Fix signnedness test in socket filter code
  o [NETFILTER]: Fix problems with iptables MIRROR target
  o [NETFILTER]: Fix issues with iptables REJECT and MIRROR targets wrt. policy routing
  o [NETFILTER]: Fix locking of ipt_helper
  o [NETFILTER]: Drop reference to conntrack after removing confirmed expectation

Tom Rini:
  o PPC32: Allow eth0 and eth1 to work on MPC8xx boards with QS6612 PHYs
  o PPC32: Correctly set intfreq / busfreq on the Motorola 860FADS



Summary of changes from v2.4.22-pre7 to v2.4.22-pre8
============================================

<gorgo:thunderchild.debian.net>:
  o [netdrvr wan] note comx maintainer change, by request

<lethal:unusual.internal.linux-sh.org>:
  o sh64: sh-sci support for SH-5 101/103

<mark.fasheh:oracle.com>:
  o Fix deadlock in journal_create

<taowenhwa:intel.com>:
  o [e100] read skb->len after freeing skb
  o [e100] cu_start: timeout waiting for cu
  o [e100] misc

Andreas Gruenbacher:
  o unshare-files fix breaks file locks

Ben Collins:
  o [SPARC64]: Clear all IRQs at probe time in PCI sabre driver
  o Update IEEE1394 (r1010)

Bhavesh P. Davda:
  o Fix aha152x hangs on pcmcia card eject

Chas Williams:
  o [ATM]: Get config/build dependencies correct

Daniel Ritz:
  o fix ne2k-pci memleak

Marcelo Tosatti:
  o Changed EXTRAVERSION to -pre8

Neil Brown:
  o knfsd:   Only set ->reuse for tcp sockets, not udp

Roger Luethi:
  o via-rhine 1.19: One more Rhine-I fix

Scott Feldman:
  o [netdrvr ethtool] add ethtool TSO get/set
  o [e1000] request_irq() failure resulted in freeing twice
  o [e1000] fix VLAN support on PPC64
  o [e1000] missing Tx cleanup opportunities during intr handling
  o [e1000] alloc_etherdev failure didn't cleanup regions
  o [e1000] ethtool diag cleanup
  o [e1000] h/w workaround for mis-fused parts
  o [e1000] s/int/unsigned int/ for descriptor ring indexes
  o [e1000] misc cleanup



Summary of changes from v2.4.22-pre6 to v2.4.22-pre7
============================================

<ja:ssi.bg>:
  o [IPV4/IPV6]: Fix use-after-free bugs in tunneling drivers

<lethal:unusual.internal.linux-sh.org>:
  o SH Merge
  o SH update

<tgraf:suug.ch>:
  o [NET]: Make {send,recv}msg return EMSGSIZE when msg_iovelen is too big, as per 1003.1
  o [NET]: Return EDESTADDRREQ as appropriate in sendmsg implementations

Alan Cox:
  o add quota autoload
  o typo bits

Ben Collins:
  o [SPARC64]: Fix OBP 4.6+ PCI probing, use pcic_present() consistently
  o Fix ALi15x3 DMA on sparc64 (maybe others)

Benjamin Herrenschmidt:
  o radeonfb: fix artifacts during boot

Chas Williams:
  o [ATM]: Add reference counting to atm_dev
  o [ATM]: Make ATM buildable as a module
  o [ATM]: Eliminate cli, make function names sane in net/atm/lec.c

Christoph Hellwig:
  o vmap() backport

Dave Kleikamp:
  o JFS: Possible trap/data loss when fixing directory index table

David S. Miller:
  o [SUNHME]: Set RXMAX/TXMAX large enough to handle VLAN frames
  o [NET]: Ok, sunhme is VLAN challenged after all
  o [SUNRPC]: Fix compiler warning in svcsock.c
  o [NETFILTER]: Fix build warnings in ipv6 modules, thanks Geert
  o [ATM]: Fix build, missing lec_priv member
  o [ATM]: Fix lec.c warning with bridging disabled
  o [SPARC64]: Fix assumptions about data section ordering and objects ending up in .data vs .bss
  o [SPARC{,64}]: Add barrier() to cpu_relax() for consistency with 2.5.x
  o [SPARC64]: Update defconfig
  o [Bluetooth]: Fix buggy CONFIG_ISDN test in cmtp Config.in
  o [SPARC64]: Do not break out of PCI controller probing loop too early

David Stevens:
  o [IPV4]: Do not sent IGMP leave messages unless IFF_UP

Gerd Knorr:
  o bttv driver update
  o tuner driver update
  o bttv documentation update
  o Update tv card i2c helper modules

Ivan Kokshaysky:
  o typecast bug in sched.c bites reschedule_idle

James Morris:
  o [NETLINK]: Just drop packets for kernel netlink socket with no data_ready handler

Jens Axboe:
  o more iosched work

Maksim Krasnyanskiy:
  o [Bluetooth] CMTP protocol depends on ISDN and ISDN CAPI

Marcel Holtmann:
  o [Bluetooth] Make READ_TRANSMIT_POWER_LEVEL available for normal users
  o [Bluetooth] Support for inquiry with unlimited responses
  o [Bluetooth] Support for AVM BlueFRITZ! USB
  o [Bluetooth] Add l2cap_load() function
  o [Bluetooth] Handle command complete event for inquiry cancel
  o [Bluetooth] Declare the function l2cap_load()
  o [Bluetooth] Update the maintainer entries for the Bluetooth subsystem

Marcelo Tosatti:
  o Changed EXTRAVERSION to -pre7
  o buffer.c: remove unused out_putf label

Mikael Pettersson:
  o clean crc temp files in lib/

Oleg Drokin:
  o Fix link/unlink race. By Chris Mason concurrent link/unlinks can create savelinks for files that still exist, the fix here is to be somewhat smarter about when we change the link count

Paul Mackerras:
  o PPC32: Fix the debug check in kunmap_atomic
  o PPC32: Fix IRQ sense and polarity setting on 405 and 440 cpus

Paul Mundt:
  o sh64: Fix ATM module build
  o sh64: defconfig update
  o sh64: Cayman IRQ handler updates

Roman Zippel:
  o hfs+: update copyright
  o hfs+: remove some smaller files
  o hfs+: volume/permission fixes
  o hfs+: fix rename of links
  o hfs+: check size of inode and sb info
  o hfs+: various cleanups
  o hfs+: link hfsplus before hfs
  o hfs+: export mark_page_accessed
  o hfs+: Makefile update

Tom Rini:
  o PPC32: Add support for the Motorola PowerPlus family of boards
  o PPC32: Remove trailing whitespace in numerous files





Summary of changes from v2.4.22-pre5 to v2.4.22-pre6
============================================

<jack:ucw.cz>:
  o Fix misc quota bugs

<jbourne:hardrock.org>:
  o Add missing break in Apollo P4X400 AGP code

<yinah:couragetech.com.cn>:
  o USB: patch for sl811 usb host controller driver

Adrian Bunk:
  o Configure.help updates from -ac

Alan Cox:
  o fix compile warning
  o clear mp bus array properly
  o add qdio options
  o allow legacy free hw with no smi cmd port
  o run late loaded ide modules
  o fix hpt ide crash, floppy noise
  o warning fixes
  o fix sbni driver
  o fix yenta hang on some laptops
  o qeth/qdio driver layer
  o more warning fixes
  o fix a race in the plugin api for ac97
  o example ac97 plugin codec
  o fix i810 and cs46xx crashes
  o re-enable POST on via audio
  o add intellinet to the usb idents
  o fix vicam with old gcc
  o update intelfb
  o make rep-nop a barrier as in 2.5
  o qdio headers for S/390 and S/390x
  o fix agpgart list
  o use the right function in reiserfs (resend #3)

Alan Stern:
  o USB: Reconcile unusual_devs.h for 2.4 and 2.5
  o USB: Final reconciliation for unusual_devs.h in 2.4
  o USB: Updates for unusual_devs.h
  o USB: Implement US_FL_FIX_CAPACITY for 2.4
  o USB: usb-storage US_FL_FIX_CAPACITY fix

Christoph Hellwig:
  o Fix ext3 quota deadlock

David Brownell:
  o USB: usb_string(), don't use bogus ids
  o USB: usbnet updates

David Glance:
  o USB: Adding DSS-20 SyncStation to ftdi_sio

David S. Miller:
  o [SPARC64]: Port over IPC msg{snd,rcv} compat32 fixes from ia64
  o [SPARC64]: Delete bogus icmpv6 filter translation code
  o [SPARC64]: Fix warning in drivers/sbus/sbus.c build
  o [SPARC64]: Update defconfig
  o [SPARC64]: Fix sys32_rt_sigtimedwait, noticed by Roland McGrath and Jakub Jelinek

David T. Hollis:
  o USB: ax8817x.c - add Intellinet USB 2.0 Ethernet device ids

Eric Brower:
  o [SPARC]: Missing part of 2.5.x interrupt decoders fix backport

Ganesh Varadarajan:
  o USB: more ids for ipaq

Geert Uytterhoeven:
  o kmap_types.h for m68k

Greg Kroah-Hartman:
  o USB: fix up my USB Bluetooth entry to help prevent confusion in the future
  o USB: fix up previous sl811 patch

Marcelo Tosatti:
  o drm_agpsupport.h: Remove ugly comments which used to fix compilation
  o Changed EXTRAVERSION to -pre6
  o Cset exclude: alan@lxorguk.ukuu.org.uk|ChangeSet|20030714130500|09040
  o Cset exclude: alan@lxorguk.ukuu.org.uk|ChangeSet|20030714133559|12582
  o add radeonfb.h

Paul Mundt:
  o sh64: 2-3 pgtable level updates

Trond Myklebust:
  o 2.4.22 NFS O_DIRECT a la mode ->direct_IO2()



Summary of changes from v2.4.22-pre4 to v2.4.22-pre5
============================================

<jcchen:icplus.com.tw>:
  o [netdrvr sundance] increase eeprom read timeout

<mike.miller:hp.com>:
  o cciss: change names and correct subsystem device ID for U320
  o cciss: PCI BAR fix
  o cciss: Fix potential overrun
  o cciss: update version
  o cciss: First part of PCI changes/driver cleanup
  o cciss: Second part of PCI changes/driver cleanup

Andi Kleen:
  o Fix compiling on x86-64

Benjamin Herrenschmidt:
  o radeonfb 0.1.8 + my stuffs

Chris Mason:
  o Fix deadlocks in IO scheduler changes

David Woodhouse:
  o Backport vsprintf/scanf fixes from 2.5.74

Geert Uytterhoeven:
  o Fix adbhid m68k screwup

J. A. Magallon:
  o hfsplus: group Apple FS's and help text

John Stultz:
  o Fix boot crash of x440's in full acpi mode
  o Cleanup x440 acpi fix

Marcelo Tosatti:
  o Changed EXTRAVERSION to -pre5

Petr Vandrovec:
  o Fix matroxfb on PPC64

Tom Rini:
  o An ethernet driver for the IBM PPC 4xx series of machines


Summary of changes from v2.4.22-pre3 to v2.4.22-pre4
============================================

<dtor_core@ameritech.net>:
  o [NET] Attach inner qdiscs to TBF

<lethal@linux-sh.org>:
  o sh64: Add FIOQSIZE definition
  o sh64: Fixup Cayman IRQ reporting
  o sh64: SH-5 PCI updates
  o sh64: Fix privileged insn handling
  o sh64: IDE support

<lode_leroy@hotmail.com>:
  o [IPV4] display bootserver in /proc/net/pnp

<lunz@falooley.org>:
  o [NET] Fix refcounting of dev->promiscuity for af_packet

<m.c.p@wolk-project.de>:
  o [RESEND 5th] Fix oom killer braindamage

<stelian@popies.net>:
  o Export 'acpi_disabled' symbol to modules

Alan Cox <alan@lxorguk.ukuu.org.uk>:
  o Make ACPI work on lots more boxes
  o config for new Nvidia AGP
  o parisc sync up (resend of resend of resend ... 8))
  o AGP update - new intel, add nvidia
  o ebda check in ibm hotplug is insufficient
  o update mpt fusion driver
  o fix the eexpress
  o move sdla to mod_timer
  o add code for missing c7000 driver
  o resend - fix security bits in binfmt_exec/som
  o re-fix printk level for buffer cachehash
  o exec part of security fix
  o fix inverted dnotify
  o fix definition of boot_DT
  o add the new agp modes to the headers
  o kernel/fork helper for exec security fix
  o S/390 CLAW bits
  o fix up z85230 queue wake logic

Benjamin Herrenschmidt <benh@kernel.crashing.org>:
  o ppc32: Fix races in low level adb drivers

Christoph Hellwig <hch@infradead.org>:
  o quota patch breaks kernel build

Christoph Hellwig <hch@lst.de>:
  o new quota code
  o fix Q_SYNC for dev == 0

David S. Miller <davem@nuts.ninka.net>:
  o [SPARC64]: sys_sparc32.c needs linux/quotacompat.h
  o [FS]: Provide unshare_files() declaration and export to modules
  o [SPARC]: SEMTIMEDOP for both Sparc ports

Marcelo Tosatti <marcelo@freak.distro.conectiva>:
  o Cset exclude: rusty@rustcorp.com.au|ChangeSet|20030707182325|08049
  o Remove bogus diff from drivers/char/Config.in
  o Changed EXTRAVERSION to -pre4
  o Cset exclude: hannal@us.ibm.com|ChangeSet|20030707180059|08076
  o Fixes ext3 quota/truncate oops
  o CRIS architecture update
  o Cset exclude: Remove NFS direct IO patches Cset exclude: trond.myklebust@fys.uio.no|ChangeSet|20030708095239|55752
  o Cset exclude: remove NFS direct IO patches Cset exclude: trond.myklebust@fys.uio.no|ChangeSet|20030706143259|16957
  o Add missing fs/quota_v2.c file
  o Comment out VIA_APOLLO_P4X400 handling in drm_agpsupport.h: Alan will fix that up later

Matthew Wilcox <willy@debian.org>:
  o pci_name()

Mikael Pettersson <mikpe@csd.uu.se>:
  o i386 cpufeature.h cleanup + comment

Paul Mackerras <paulus@samba.org>:
  o PPC32: Minor updates to comments and processor register definitions
  o PPC32: Minor boot wrapper cleanups
  o PPC32: Define screen_info if CONFIG_FB is set for the sake of vesafb
  o PPC32: Make __kernel_ino_t be unsigned long like on other architectures

Randy Dunlap <rddunlap@osdl.org>:
  o make profile= doc. clearer

Rusty Russell <rusty@rustcorp.com.au>:
  o Configure.help Polish translation location update
  o unreachable code in drivers_media_video_cpia_pp.c
  o 2.4 drivers_char_random.c fix sample shellscripts
  o trivial patch
  o fix sound doc typos
  o fs_bfs_dir.c unused variables
  o Decision PCCOM4_PCCOM8 serial support for 2.4.19
  o Re: setrlimit incorrectly allows hard limits to exceed
  o fix linewrap in Documentation_ia64_efirtc.txt
  o fix linewrap in Documentation_arm_SA1100_CERF
  o fix linewrap in Documentation_filesystems_befs.txt
  o [2.5 patch] two small MTD fixes
  o 2.4 patch for more debug safety
  o esssolo1.c doesn't free resources correctly

Trond Myklebust <trond.myklebust@fys.uio.no>:
  o Back out some congestion control changes that were causing trouble among other things for the "soft" mount option.




Summary of changes from v2.4.22-pre2 to v2.4.22-pre3
============================================

<abbotti@mev.co.uk>:
  o USB: several ftdi_sio driver patches

<alex_williamson@hp.com[helgaas]>:
  o ia64: Poll for CPEs on all CPUs, improve check for # of CPEs logged
  o ia64: Switch to polling for CMCs if they happen too fast
  o ia64: add wmb in sba_iommu to guarantee IOPDIR updates are visible
  o ia64: fix timer interrupts getting lost

<arun.sharma@intel.com[helgaas]>:
  o ia64: fix IA-32 emulation of msgctl()
  o ia64: define rlim_cur/rlim_max as unsigned
  o ia64: fix IA-32 version of shmctl()
  o ia64: ia32 semctl check for bad command
  o ia64: Patch by Arun Sharma: In the absence of the patch, this system call fails:
  o ia64: Fix SMP FPH handling.  From 2.5 patch by Asit Mallick, David Mosberger, Arun Sharma.
  o ia64: work around race conditions in ia32 support code
  o ia64: IA-32 support patch: msgsnd/msgrcv return value off by 4
  o ia64: IA-32 support patch: munmap should return EINVAL if size == 0
  o ia64: IA-32 support patch: mmap should return ENOMEM

<baldrick@wanadoo.fr>:
  o USB speedtouch: use common CRC library

<bdschuym@pandora.be>:
  o [NETFILTER]: Missing return in arp_packet_match()
  o [NETFILTER]: Add arptables mangle module

<bjorn_helgaas@hp.com[helgaas]>:
  o ia64: Export pm_idle
  o ia64: sys32_sysinfo: update to current struct sysinfo (add totalhigh, freehigh, mem_unit).
  o ia64: Make struct sysinfo32 internal padding explicit
  o ia64: Make CONFIG_SYSCTL control sys32_sysctl as well.  Based on a patch from Peter Chubb.
  o ia64: ia64_fetch_and_add(), xchg(), ia64_cmpxchg(), etc
  o ia64: Update default configs
  o ia64: iosapic: remove find_iosapic duplication
  o ia64: iosapic: simplify ISA IRQ init
  o ia64: iosapic: self-documenting polarity/trigger arguments
  o ia64: iosapic: Remove gratuitous differences with 2.5 (whitespace, C99 initializers, printk levels, etc).
  o ia64: Use printk severity-levels where appropriate
  o ia64: cleanup unwind.c warnings (from David's 2.5 change)
  o ia64: mca.c whitespace changes and dead code removal from 2.5
  o ia64: sba_iommu: whitespace and comment changes to align with 2.5
  o ia64: sba_iommu: prefetch_spill_page alignment with 2.5
  o ia64: sba_iommu: printk text and other trivial changes to align with 2.5
  o io4
  o ia64: sba_iommu: make sure devices are at least 32-bit capable (from 2.5)
  o ia64: sba_iommu: Combine HWP0001 and HWP0004 ACPI claim (from 2.5 changes by Alex Williamson).
  o ia64: sba_iommu: remove workarounds for broken, never released, firmware that didn't program IBASE/IMASK correctly.
  o ia64: remove cpu_is_online local defs, in favor of a 2.5-style cpu_online
  o ia64: Remove unused variable from acpi.c
  o ia64: sba_iommu: fix warning and use old-style ACPI typedef
  o ia64: whitespace and trivial changes in mca.c
  o ia64: palinfo whitespace changes to match 2.5
  o ia64: simplify syscalls with force_successful_syscall_return()
  o ia64: Remove unused acpi_get_addr_space() interface
  o ia64: Wrap pal.h with #ifdef __KERNEL__ to solve userland compilation issues (including <linux/modules.h>).
  o ia64: Don't blindly probe PCI buses (probe only those reported by ACPI)
  o ia64: pci warning for unavailable resources
  o ia64: TLB flushing fixes - don't use smp_call_function in context-switch path.
  o ia64: Disable interrupts during context switch
  o ia64: ptrace whitespace changes to follow 2.5
  o ia64: add hugetlb and cmd649 IDE to configs
  o ia64: Export SAL error records in /proc/sal/{mca,init,cmc,cpe}/{event,data}
  o ia64: Rename EFI systab tags (no spaces, etc, for easier parsing)
  o ia64: Ignore empty address ranges from _CRS to workaround buggy Big Sur firmware.

<chad_smith@hp.com[helgaas]>:
  o ia64: expose pointers from EFI system table in /proc

<chas@cmd.nrl.navy.mil>:
  o [ATM]: remove iovcnt member in struct atm_skb

<chas@cmf.nrl.navy.mil>:
  o [ATM]: Backport HE driver fixes from 2.5.x
  o [ATM]: ixmicro puts esi in different location
  o [ATM]: lock neighbor entry during update in clip.c
  o [ATM]: make sub skb->cb is clear before upcall to network
  o [ATM]: eliminate ATM_PDU_OVHD, ops->free_rx_skb and ops->alloc_tx
  o [ATM]: make clip buildable as a module

<dave@thedillows.org>:
  o Use a non-zero rx_copybreak to avoid charging a full MTU to the socket on tiny packets.
  o Fix misreporting of card type and spurious "already scheduled" messages

<david@csse.uwa.edu.au>:
  o USB: usb-uhci fix for one-shot interrupt problem
  o USB: usb-ohci handling of one-shot interrupt transfers

<davidm@hpl.hp.com[helgaas]>:
  o ia64: For SIGSEGV triggered by NaT page, set si_addr to faulting data address, not the faulting IP.

<davidm@tiger.hpl.hp.com[helgaas]>:
  o ia64: Make ia64_fetch_and_add() simpler to optimize so lib/rwsem.c can be optimized properly.
  o ia64: Implement pcibios_set_mwi() and define HAVE_ARCH_PCI_MWI to ensure that PCI line-size gets programmed properly.  Based
  o ia64; Improve debug output from kernel unwinder.  Based on patch by Keith Owens.  (Ported to 2.4 by Bjorn Helgaas).
  o ia64: In kernel unwinder, replace dump_info_pt() with get_scratch_regs() and reformat to make it fit in 100 columns.
  o ia64: Add unwcheck.sh script contributed by Harish Patil.  It checks the unwind info for consistency (well, just the obvious stuff, but it's a start).
  o ia64: Minor cleanups.  (From 2.5 by Bjorn Helgaas)
  o ia64: Make signal deliver work when the current register frame is incomplete (as a result of a faulting mandatory RSE load).
  o ia64: Correct region_start calculation in kernel unwinder
  o ia64: clean up unneeded test in kernel unwinder
  o ia64: More vmlinux.lds.S cleanups (__start/__end inside sections)
  o ia64: Minor fixes
  o ia64: Two small MCA fixes
  o ia64: Sync itc after interrupts enabled
  o ia64: Sync sys32_ipc() with x86 counter-part
  o ia64: Patch by Arun Sharma: In brl_emu.c, a 64 bit value was being assigned to an int.
  o ia64: Minor whitespace & formatting fixups in asm-ia64/sal.h
  o ia64: Fix SAL processor-log info handling.  Based on patch by Keith Owens.
  o ia64: Manual merge of Keith Owen's patch to avoid deadlock on ia64_sal_mc_rendez().  Also prefix local-variables in SAL macros to avoid name collisions.
  o ia64: dump the min-state area in the MCA INIT platform handler
  o ia64: Update platform INIT handler to print a backtrace
  o ia64: Consolidate backtrace printing in a single routine (ia64_do_show_stack())
  o ia64: fix /proc/.../vm_info memory attributes
  o ia64: Fix printing of memory attributes
  o mca.c
  o ia64: Fix INIT copying of banked registers
  o ia64: ptrace: don't let reading NaT bits for R4-R7 overwrite the value we're intending to write; get_rnat & put_rnat cleanups.
  o ia64: Fix ptrace() RNaT accessors
  o ia64: Fix page-fault handler so it handles not-present translations for region 5 (patch by John Marvin).
  o ia64: Fix unwinder so core-dumps work again.  Without this patch, most scratch-regs came out wrong.
  o ia64: Fixups for GCC v3.3

<davidm@wailua.hpl.hp.com[helgaas]>:
  o ia64: Change struct ia64_fpreg so it will get 16-byte alignment with all ia64 compilers, not just GCC.
  o ia64: Don't output backspaces in palinfo output

<eranian@hpl.hp.com[helgaas]>:
  o ia64: perfmon update to v1.4
  o ia64: perfmon fixes for system-wide monitoring overflow, opcode matcher, and force PMC[89] bit 2 on.
  o ia64: perfmon update
  o ia64: perfmon TLB_* and ALAT event fix

<garyhade@us.ibm.com[helgaas]>:
  o ia64: fix sysinfo(2) memory value truncation for 32-bit apps

<grigouze@noos.fr>:
  o USB: zaurus SL-C700

<james@cobaltmountain.com[helgaas]>:
  o include_asm-ia64_sal.h, typo: the the

<jbarnes@sgi.com[helgaas]>:
  o ia64: ACPI fix for no PCI

<jes@wildopensource.com[helgaas]>:
  o ia64: don't try to synchronize ITCs on ITC_DRIFT platforms

<jgarzik@pobox.com>:
  o fix Via pci irq routing

<jh@sgi.com[helgaas]>:
  o ia64: SGI SN update
  o ia64: SN2 update 030528
  o ia64: SN2 update 030630

<jsm@udlkern.fc.hp.com[helgaas]>:
  o ia64: don't let PTRACE_POKEDATA write the NaT bits of syscall args

<judd@jpilot.org>:
  o USB: visor.h[c] USB device IDs

<kaos@ocs.com.au[helgaas]>:
  o ia64: fix unwinder to call get_scratch_regs() only when really needed

<kaos@sgi.com[helgaas]>:
  o ia64: fix scratch-regs handling in kernel unwinder
  o ia64: unwind.c - allow unw_access_gr(r0)
  o ia64: Trivial stack-size correction in mca.c
  o ia64: mca rendezvous fix
  o ia64: Hold modlist_lock while searching exception tables
  o ia64: Handle SAL rejection of MCA rendezvous timeout value

<kenneth.w.chen@intel.com[helgaas]>:
  o ia64: rwsem using atomic primitive

<kpc-usbdev@gelato.uiuc.edu>:
  o USB: Desknote/ECS UCR-61S2B card reader (2.4.21 patched)

<lethal@linux-sh.org>:
  o SH64 Merge
  o Add SH-5 support to SH-SCI
  o Add SH-5 support to tulip_core
  o Update MAINTAINERS for sh/sh64
  o SH-5 DMAC Support
  o sh64 PCI DMA coherency fixups
  o sh64: Fix SHMBLA compile error
  o sh64: Add an onchip_unmap() to clean up after
  o sh64: tlbmiss handler updates
  o sh64: Don't startup the irq in make_intc_irq()
  o sh64: Add workarounds for cache aliasing issues
  o sh64: Cleanup sleep usage
  o sh64: Fix PTRACE_POKEUSR to ignore changes of privileged
  o sh64: Make memcpy safe on SH5-101 cut2
  o sh64: export more needed symbols
  o sh64: Fixes for Cayman LEDs

<mk@linux-ipv6.org>:
  o [CRYPTO]: Update deflate dependencies

<mkp@mkp.net[helgaas]>:
  o ia64: declare ia64_sal_handler_init non-static

<mort@wildopensource.com[helgaas]>:
  o ia64: print ISR for FPSWA faults
  o ia64: runtime platform detection for 2.5

<richard.curnow@superh.com>:
  o Ensure that the 'unlink' XDR structures are correctly aligned on 64-bit architectures.

<romieu@fr.zoreil.com>:
  o [NETFILTER]: Fix leaks in error paths of ip_recent_ctrl

<rusty@rustcorp.com.au[helgaas]>:
  o Designated initializers for ia64

<schwab@suse.de[helgaas]>:
  o ia64: fix unwinder bug in unw_access_gr()
  o ia64: Fix request_module from ia32 process
  o ia64: make sys32_ptrace() use ptrace_check_attach()

<shemminger@osdl.org>:
  o [BRIDGE]: Ethernet bridge fixes

<shmulik.hen@intel.com>:
  o Fix load balance problem with high UDP Tx stress
  o Fix 802.3ad long fail over with high UDP Tx stress
  o [netdrvr bonding] Fix change active for ALB/TLB

<sv@sw.com.sg[helgaas]>:
  o ia64: improve show_trace_task() portability

<venkatesh.pallipadi@intel.com[helgaas]>:
  o ia64: IA-32 emulation patch: ptrace get_FPREGS bug fix

<will@sowerbutts.com>:
  o USB: Update for the powermate driver to work with newer devices

Adam J. Richter <adam@yggdrasil.com>:
  o [CRYPTO]: Simplify crypto memory allocation

Adrian Bunk <bunk@fs.tum.de>:
  o postfix a constant in efi.h with ULL

Alan Cox <alan@lxorguk.ukuu.org.uk>:
  o [NETFILTER]: Fix nat_helper warnings with gcc 3.3
  o [NET]: Add EDP2 ethernet protocol ID
  o [SPARC]: d_path() can return an error code, must handle it
  o Optimise FAT handling using the prev_free info as DOS does
  o PATH: add hfsplus file system (stands alone)
  o NLS config.in for hfsplus
  o config.in for HFSPLUS
  o makefile for HFSPLUS
  o fix leak in llc 802
  o fix decnet gcc 3.3 build
  o add xapic checking define
  o add the extra cpu bit test flags
  o remove io_apic_modify - this doesnt work on some APICs
  o add the MSR's for IA32 perf ctl
  o fix false sharing of mm info
  o we moved these so this copy can go
  o collated copy of Geerts patches for m68k headers
  o add a flag so we can forbid APM idling
  o add the ide_register_driver defines
  o add EDP2 protocol id
  o update fat docs - we now use the field
  o bring PCI_IDS back into sync
  o add new entry to sisfb types
  o support cramfs initrd
  o add timedop stub for IPC=n
  o assorted module race fixe
  o dont corrupt utsname on failed copy
  o fix make rpm
  o dont idle if forbid_idle set
  o large scale DMI table updates
  o merge long standing reboot fix form -ac
  o fix up semops and return, allow timedop
  o fix error in vm86 fixups
  o add semtimedop to ia64 emu too
  o fix up gcc 3.3 bits
  o copy the right data in mips emulation
  o collected m68k core diffs
  o typo fix
  o fix iphase leak
  o bump cciss to new vendor driver
  o Jens floppy locking fixes
  o add comtrol note in case we need to know in the future
  o & v && fixes in sysrq.c
  o update sonypi driver
  o parisc gsc driver sync
  o fix config.in bits for IDE
  o make IDE modularisable
  o fix ide dma timeout bugs
  o make pnpide module happy
  o Herbert's fix for ide proc oops
  o make pdc4030 module happy
  o add generic support for toshiba piccolo
  o fix hpt speed bits
  o fix promise sx6000 newer board problems
  o clean up older pdc
  o siimage updates, add aar-1210sa
  o SiS IDE updates
  o hptraid updates
  o small setup-pci cleanups
  o d_path can return an error code, must handle it
  o update motion eye drivers
  o fix leak in octagon
  o new 3c59x. plus handle power bits
  o typo fix in atari_pamsnet driver
  o fix ma600 gcc 3.3
  o minor m68k fixes
  o fix leak in aironet4500_cs
  o fix plip hang on ifdown/ifup
  o update sonic
  o update orinoco drivers
  o update pci.ids
  o add cirrus support to i82092
  o fix rsrc manager
  o pci routing for ti cardbus
  o update aacraid
  o aic7xxx allow db4
  o gdth register failure path
  o update scsi tape docs
  o megaraid broke config tools
  o send_diag wants long timeout default
  o let the ide layer fail commands
  o resync scsi blacklist
  o new segate bios string
  o update scsi tape driver
  o remove noise
  o fix copy from user bug in cmpci
  o update AC97 codec core
  o switch cards to new ac97_audio
  o switch i810 to generalised digital out, new ac97
  o ac97 updates
  o fix long standing doc typo
  o update trident, fix printks, new ac97
  o Update via audio - fix problems esd, mpg321
  o update to new ac97_codec
  o core fbcon fixes
  o update vesafb memory handling for big cards
  o update sis fb drivers
  o add semtimedop to x86 headers
  o update ac97 codec headers
  o declare semtimedop function
  o add scripts ready to merge kconfig
  o update cciss docs to match new driver
  o add vram to vesafb docs
  o CMD640 update
  o (new) Turn on the IDE modular stuff in the Makefile
  o (resend) collected semaphore fixes and semtimedop
  o make i810 audio compile

Alex Williamson <alex_williamson@hp.com>:
  o ia64: CMC deadlock fix

Andi Kleen <ak@muc.de>:
  o Personality fixes for x86-64
  o x86-64 merge
  o Support exception-trace sysctl for x86-64
  o non executable stack support for x86-64

Andrew Morton <akpm@digeo.com>:
  o [CRYPTO]: Fix memcpy/memset args

Ben Collins <bcollins@debian.org>:
  o Update IEEE1394 (r972)

Benjamin Herrenschmidt <benh@kernel.crashing.org>:
  o ppc32: support for 750FX rev2 CPU
  o ppc32: Enable use of USB2 on recent G4s
  o ppc32: Update PowerMac motherboard support
  o ppc32: Update swim3 floppy driver
  o ppc32: Add TotalImpact briQ panel driver
  o ppc32: Add a "query" function to core ADB
  o ppc32: Update adbhid driver
  o ppc32: Update battery calculation code & via-pmu
  o ppc32: Minimal ethtool for bmac and mace
  o ppc32: Fix a problem with both gmac and sungem

Bjorn Helgaas <bjorn_helgaas@hp.com>:
  o ia64: chmod +x unwcheck.sh script
  o ia64: iosapic: make pcat_compat system property
  o ia64: iosapic: rationalize __init/__devinit
  o ia64: Export io_space so drivers using legacy I/O ports can insmod
  o ia64: brl_emu.c: use temporary variable to avoid gcc3.1 warning
  o ia64: remove incorrect and redundant "cpu not responding" message
  o ia64: Update configs
  o ia64: pci.c: Trivial changes to follow 2.5
  o ia64: sba_iommu: use seq_file
  o ia64: acpi: handle vendor resources more generically
  o Move UP cpu_online definition to <linux/smp.h>
  o Cset exclude: rohit.seth@intel.com[helgaas]|ChangeSet|20030623203306|58862

Chris Mason <mason@suse.com>:
  o Fix potential IO hangs and increase interactiveness during heavy IO

Christoph Hellwig <hch@lst.de>:
  o [CRYPTO-2.4]: Missing ULL postfixes and statics

David S. Miller <davem@nuts.ninka.net>:
  o [BK]: Add *~ to ignore regexps
  o [CRYPTO]: kunmap does not return a value
  o [CRYPTO]: Build/warning fixups
  o [CRYPTO]: Clean up header file usage
  o [CRYPTO]: Include kernel.h in crypto.h
  o [CRYPTO]: Allocate work buffers instead of using kstack
  o [CRYPTO]: Make sha256.c more palatable to GCCs optimizers
  o [CRYPTO]: internal.h needs init.h
  o [CRYPTO]: Use appropriate defaults if AH/ESP is enabled
  o [CRYPTO-2.4]: Add dummy kmap_types.h header for sparc64
  o [CRYPTO]: Include linux/errno.h as appropriate
  o [CRYPTO-2.4]: module_name does not exist in 2.4.x
  o [CRYPTO-2.4]: const static --> static const
  o [CRYPTO]: deflate.c needs slab.h
  o [CRYPTO-2.4]: Fix condition typos in crypto/Config.in
  o [CRYPTO-2.4]: Emulate module_name semantics correctly to avoid OOPS
  o [CRYPTO-2.4]: Make sure crypto config is before lib config on ia64
  o [NET]: net/bluetooth/cmtp/core.c needs linux/init.h
  o [NET]: Scale DST/ipv6 intervals like we did for ipv4
  o [SPARC64]: Fix build error from OBP parsing patch
  o [SPARC64]: Update defconfig

Erik Andersen <andersen@codepoet.org>:
  o fix 2.4.22-pre broken x86 math-emu

Greg Kroah-Hartman <greg@kroah.com>:
  o USB: remove stupid conversions and use of floating point from aiptek.c
  o USB: 2.4 fix UHCI debug kmalloc() usage
  o USB: add support for 50 baud to io_edgeport.c
  o USB: pl2303: report CTS and DSR status changes to userspace
  o Cset exclude: cweidema@indiana.edu|ChangeSet|20030620002017|05386
  o USB: compiler fixes for previous vicam patches

Hugh Dickins <hugh@veritas.com>:
  o remove shmem info->sem
  o shmem_getpage absorb _locked
  o shmem_getpage read,cache,write
  o shmem truncation swizzled
  o shmem account metablocks
  o shmem_file_write and _read
  o init_tmpfs shm_mnt error
  o shmem whitespace only
  o shmem misc minor mods
  o swapoff loopable tmpfs
  o shmem mount percentile size
  o shmem_removepage replace recalc_inode
  o loop file use highmem
  o madvise_willneed check readpage
  o shmem_file_write precheck_file_write
  o mremap VM_LOCKED move_vma
  o shmem loopable tmpfs [again]

Ivan Kokshaysky <ink@jurassic.park.msu.ru>:
  o alpha: fix generic kernel build (Jay Estabrook)
  o alpha: finalize Sable/Lynx support (Jay Estabrook)

James Morris <jmorris@intercode.com.au>:
  o [CRYPTO]: Add initial crypto api subsystem
  o [CRYPTO]: Cleanups based upon feedback from Rusty and jgarzik
  o [CRYPTO]: Cleanups based upon feedback from Rusty and jgarzik
  o [CRYPTO]: Use try_inc_mod_count and semaphore for alg list
  o [CRYPTO]: Use kmod to try to autoload modules
  o [CRYPTO]: Bug fixes and cleanups
  o [CRYPTO]: More bug fixes and cleanups
  o [CRYPTO]: Add MD4
  o [CRYPTO]: Algorithm lookup API change plus bug fixes
  o [CRYPTO]: Run tcrypt through lindent, plus doc update
  o [CRYPTO]: Assert that interfaces are called on correct cipher type
  o [CRYPTO]: Cleanups and more consistency checks
  o [CRYPTO]: Update to IV get/set interface
  o [CRYPTO]: Add some documentation
  o [CRYPTO]: Fix some credits
  o [CRYPTO]: Cleanups based upon suggestions by Jeff Garzik
  o [CRYPTO]: Uninline some functions to save some bloat
  o [CRYPTO]: Cleanups based upon feedback from jgarzik
  o [CRYPTO]: Add crypto_alg_available interface
  o [CRYPTO]: Rework HMAC interface
  o [CRYPTO]: Add SHA256 plus bug fixes
  o [CRYPTO]: Add blowfish algorithm
  o [CRYPTO]: minor updates
  o [CRYPTO] kstack cleanup (v0.28)
  o [CRYPTO] Add maintainers entry
  o [CRYPTO] Minor doc update
  o [CRYPTO]: Add null algorithms and minor cleanups
  o [CRYPTO]: Kill stray CRYPTO_ALG_TYPE_COMP
  o [CRYPTO]: Add twofish algorithm
  o [CRYPTO]: Add serpent algorithm
  o [CRYPTO]: Documentation update
  o [CRYPTO]: Dont compile procfs stuff if procfs is not enabled
  o [CRYPTO]: Add AES algorithm
  o [CRYPTO]: More credits for AES
  o [CRYPTO]: Add support for SHA-386 and SHA-512
  o [CRYPTO] remove superfluous goto from des module init exception path
  o [CRYPTO] Add AES and MD4 to tcrypto crypto_alg_available() test
  o [CRYPTO]: in/out scatterlist support for ciphers
  o [CRYPTO]: Move km_types out of header
  o [CRYPTO]: Add encrypt_iv() and decrypt_iv() methods
  o [CRYPTO]: Eliminate crypto_tfm.crt_ctx, from Adam Richter
  o [CRYPTO]: Documentation updates
  o [CRYPTO]: Make use of crypto_exit_ops() during crypto_free_tfm()
  o [CRYPTO]: Add Deflate algorithm to crypto API
  o [CRYPTO]: deflate module: workaround zlib bug
  o [CRYPTO]: Fix config dependencies

Jeff Garzik <jgarzik@redhat.com>:
  o [CRYPTO]: Kill accidental double memset
  o [netdrvr 8139too] fix debug printk

Linus Torvalds <torvalds@transmeta.com>:
  o The crypto auto-load should be enabled if crypto is enabled

Marcelo Tosatti <marcelo@freak.distro.conectiva>:
  o Cset exclude: rusty@rustcorp.com.au|ChangeSet|20030625201246|52045
  o Added missing BROKEN_PNP_BIOS declaration
  o Changed EXTRAVERSION to -pre3

Martin Schwidefsky <schwidefsky@de.ibm.com>:
  o s390 base update
  o s390 common i/o layer fixes
  o s390 dasd driver update
  o s390 31 bit compat
  o s390 documentation update
  o Add Configure.help entries for s390 options
  o s390 3215 driver update
  o s390 ctc network driver update
  o s390 iucv network driver
  o s390 defconfigs update
  o console semaphore fix

Matt Domsch <matt_domsch@dell.com>:
  o ia64: efivars fix by Matt Domsch and Peter Chubb

Olaf Hering <olh@suse.de>:
  o missing asm-ppc64/kmap_types.h

Oleg Drokin <green@angband.namesys.com>:
  o reiserfs: Relocated journal support by Edward Shushkin & Vladimir Saveliev
  o reiserfs: speed up large file holes creation
  o reiserfs: Make most of the reiserfs warning messages to print what device they relate to

Oliver Neukum <oliver@neukum.org>:
  o USB: disconnect of v4l devices in 2.4
  o USB: fix to previous vicam patch

Peter Chubb <peter@chubb.wattle.id.au>:
  o ia64: declare test_bit() arg as "const"

Roger Luethi <rl@hellgate.ch>:
  o [netdrvr via-rhine] via-rhine 1.18-rc1: Fix Rhine-I regression

Russell King <rmk@arm.linux.org.uk>:
  o ARM merge part 1 - arch/arm
  o ARM merge part 2 - include/asm-arm
  o ARM merge part 3 - drivers/acorn

Rusty Russell <rusty@rustcorp.com.au>:
  o 2.5.43 export _end

Scott Feldman <scott.feldman@intel.com>:
  o Remove CAP_NET_ADMIN check for SIOCETHTOOL's

Tom Callaway <tcallawa@redhat.com>:
  o [SPARC64]: Fix OBP version parsing on newer systems

Trond Myklebust <trond.myklebust@fys.uio.no>:
  o A patch by Chuck Lever that cleans up the RPC socket slot allocation code.
  o A patch by Chuck Lever with further cleanups of the RPC socket slot allocation code.
  o Another patch by Chuck Lever that ensures that the PG_uptodate bit gets set when the entire page gets written by nfs_writepage_sync()
  o A patch by Patrice Dumas to implement nlmsvc_proc_granted_res
  o A patch by Patrice Dumas to add a check in order to ensure that we really were requesting a blocking lock when we get a reply from the server asking us to block.
  o A patch to ensures that blocks which are not going to time out are placed last on the nlm_block list (problem reported by Olaf Kirch).
  o Add standard spinlocks to protect the socket from being released by one CPU while the other is in a soft interrupt.
  o Fix a race: Ensure that requests retry if the remote server disconnects us while we're inside xprt_transmit().
  o Don't use an RPC child process when reconnecting to a TCP server
  o Ensure that if we need to reconnect the socket, we also resend the entire message.
  o Fix a TCP client corruption problem affecting resent requests
  o Ensure that the lockd clients always use one of the reserved ports
  o Replace buggy version of xdr_shift_buf() with the version from 2.5.x


Summary of changes from v2.4.22-pre1 to v2.4.22-pre2
============================================

<bernie@develer.com>:
  o fix bug in drivers/net/cs89x0.c:set_mac_address()
  o [IPV4]: Trim the includes used in util.c

<cramerj@intel.com>:
  o [e1000] TSO fix
  o [e1000] Added ethtool test ioctl
  o [e1000] Added support for 82546 Quad-port adapter
  o [e1000] Removed strong branded device ids
  o [e1000] Fixed LED coloring on 82541/82547 controllers
  o [e1000] Miscellaneous code cleanup
  o [e1000] Whitespace cleanup

<dean@arctic.org>:
  o [netdrvr tulip] support DM910x chip from ALi

<dlstevens@us.ibm.com>:
  o [IPV{4,6}]: Fix "slow multicast on 2.5.69" bug

<gandalf@wlug.westbo.se>:
  o [NETFILTER]: Really search _backwards_ to find the oldest unreplied connection to evict

<green@linuxhacker.ru>:
  o current bk ipmi build fix

<hadi@shell.cyberus.ca>:
  o [NET]: Fix OOPSes with RSVP

<hall@vdata.com>:
  o [NETFILTER]: Fix two issues in the newnat core, with help from laforge@netfilter.org

<heiko.carstens@de.ibm.com>:
  o sd.c: set data direction to SCSI_DATA_NONE for START_STOP

<jejb@raven.il.steeleye.com>:
  o Add XRAYTEX to SCSI whitelist
  o sd.c: Backport wild spin loop mitigation from 2.5
  o Backport from 2.5: scsi allow devices to restrict start on add

<laforge@netfilter.org>:
  o [NETFILTER]: Cosmetic changes
  o [NETFILTER]: ip{,6}tables enhancement, add new /proc/net files
  o [NETFILTER]: Fix conntrack master_ct refcounting

<linux-kernel@vger.kernel.org>:
  o new eepro100 PDI ID

<marcel@holtmann.org[holtmann]>:
  o [Bluetooth] Add CAPI message transport protocol support

<mgreer@mivsta.com>:
  o PPC32: Fix /proc/sys/kernel/l2cr on newer CPUs

<mort@wildopensource.com>:
  o [NETFILTER]: Fix processor shifts in lockhelp.h

<mulix@mulix.org>:
  o ISDN: [PATCH] memory leak in tpam_queues.c

<oliver@vermuden.neukum.org>:
  o hfs-readonly-fix.diff

<qboosh@pld.org.pl>:
  o [NETFILTER]: Fix ip6tables alignment (64bit archs)
  o [NETFILTER]: Fix endianness bugs in conntrack
  o [NETFILTER]: Fix endianness bugs in ipt_nat

<reeja.john@amd.com>:
  o [netdrvr amd8111e] interrupt coalescing, libmii, bug fixes
  o [netdrvr amd8111e] link against mii lib
  o [netdrvr amd8111e] bug fix: move stats update after irq free

<riel@redhat.com>:
  o [wireless airo] fix end-of-array test

<sfrost@snowman.net>:
  o [NETFILTER]: Add iptables "recent" module

<shmulik.hen@intel.com>:
  o [bonding] ABI versioning
  o [bonding] better 802.3ad mode control, some cleanup
  o [bonding] much improved locking
  o [bonding] support xmit load balancing mode
  o [bonding] add rcv load balancing mode
  o [netdrvr bonding] fix long failover in 802.3ad mode
  o [netdrvr bonding] fix ABI version control problem

<solt@dns.toxicfilms.tv>:
  o [IPV4]: Be more verbose about invalid ICMPs sent to broadcast

<tonyb@cybernetics.com>:
  o make sym53c8xx_2 not reject autosense IWR

<valdis.kletnieks@vt.edu>:
  o [netdrvr typhoon] s/#if/#ifdef/ for a CONFIG_ var

Adrian Bunk <bunk@fs.tum.de>:
  o fix .text.exit error in drivers/net/r8169.c
  o add three ACPI Configure.help entries

Alan Cox <alan@lxorguk.ukuu.org.uk>:
  o [netdrvr tlan] fix 64-bit issues

Andi Kleen <ak@muc.de>:
  o Remove copied inet_aton code in bond_main.c
  o ACPI compile fixes for 2.4.22pre1
  o Don't enable I2O for AMD64

Andrew Morton <akpm@digeo.com>:
  o Additional 3c980 device support

Andy Grover <agrover@groveronline.com>:
  o ACPI: Fix config.in (Jeff Garzik)
  o ACPI: make it so acpismp=force works (reported by Andrew Morton)

Anton Blanchard <anton@samba.org>:
  o [netdrvr 8139cp] enable MWI via pci_set_mwi, rather than manually

Dave Engebretsen <engebret@us.ibm.com>:
  o [netdrvr pcnet32] bug fixes

Dave Kleikamp <shaggy@shaggy.austin.ibm.com>:
  o Update JFS team members in jfs.txt
  o JFS: resize fixes

Douglas Gilbert <dougg@torque.net>:
  o sg driver version 3.1.25

Edward Peng <edward_peng@dlink.com.tw>:
  o [netdrvr via-rhine] fix promisc mode
  o [netdrvr sundance] bug fixes, VLAN support
  o [netdrvr sundance] fix flow control bug
  o [netdrvr sundance] fix another flow control bug

Hideaki Yoshifuji <yoshfuji@linux-ipv6.org>:
  o IPv6 over ARCnet (RFC2497) support, driver part
  o IPv6 over ARCnet (RFC2497) support, IPv6 part

Hugh Dickins <hugh@veritas.com>:
  o remove unsafe BUG() in __remove_inode_page()

Ivan Kokshaysky <ink@jurassic.park.msu.ru>:
  o alpha: Lynx platform support (Jay Estabrook)
  o alpha: initrd fix (Wiedemeier, Jeff)
  o alpha: nautilus poweroff

Jay Vosburgh <fubar@us.ibm.com>:
  o [bonding] small cleanups
  o Bonding 2.4 update patch 1
  o Bonding 2.4 update patch 2
  o Bonding 2.4 update patch 3
  o Bonding 2.4 update patch 4
  o Bonding 2.4 update patch 5
  o Bonding 2.4 update patch 6

Jean Tourrilhes <jt@bougret.hpl.hp.com>:
  o irda: static init fixes
  o irda: Export CRC routine to drivers
  o irda: Mask C/R bit from connection
  o irda-usb driver fixes
  o IrCOMM chat fixes
  o QoS interoperability fixes
  o IrLMP timer race fix
  o Fix IrIAP skb leak
  o irda: Secondary nack code fixes

Jeff Garzik <jgarzik@redhat.com>:
  o [net] store physical device a packet arrives in on
  o [bonding] fix comment to prevent future merge difficulties
  o [bonding] add support for getting slave's speed and duplex via ethtool
  o [bonding] Moved setting slave mac addr, and open, from app to the driver
  o [bonding] move driver into new drivers/net/bonding directory
  o [bonding] move private decls into new drv/net/bonding/bonding.h file
  o [bonding] add support for IEEE 802.3ad Dynamic link aggregation
  o [netdrvr sundance] small cleanups from 2.5
  o Remove duplicate CONFIG_TULIP_MWI entry in Configure.help
  o [netdrvr eepro] update MODULE_AUTHOR per old-author request
  o [netdrvr tlan] backport fixes and cleanups from 2.5
  o [netdrvr] s/init_etherdev/alloc_etherdev/ in code comments, in 8139too and pci-skeleton drivers.
  o [netdrvr 8139too] add comment, whitespace cleanup
  o [netdrvr olympic] fix build with gcc 3.3
  o [netdrvr r8169] use alloc_etherdev (fix race), pci_disable_device
  o [netdrvr r8169] sync with 2.5 (backport whitespace cleanups)
  o [netdrvr amd8111e] remove out-of-tree feature that snuck in
  o [netdrvr] gcc 3.3 cleanups
  o [netdrvr sis900] minor fixes from 2.5

Justin T. Gibbs <gibbs@overdrive.btc.adaptec.com>:
  o Update the aic7xxx driver to 6.2.10 and add the aic79xx driver version 1.1.1
  o Correct building of aicasm
  o Update to aic7xxx version 6.2.22 and aic79xx 1.3.0_ALPHA2
  o Integrate 2.5.X aic7xxx and aic79xx changes
  o Misc driver updates
  o Integrate changes from Christoph Hellwig <hch@infradead.org>
  o Update to aic7xxx version 6.2.24 and aic79xx version 1.3.0_ALPHA5
  o Preface the "asserting atn" diagnostic with controller/target information
  o aic7xxx Driver
  o Aic7xxx Driver
  o Aic7xxx & Aic79xx Drivers Correct 2.5.X declaration for aic_sector_div().
  o Aic7XXX Firmware Assembler
  o Aic7XXX and Aic79XX drivers Use down_interruptable() rather than down() to avoid having our DV threads counted toward the load average.
  o Aic7XXX and Aic79XX drivers
  o Aic79XX and Aic7xxx Drivers
  o Aic7XXX and Aic79XX Drivers
  o Aic7XXX and Aic79xx Drivers
  o aic7xxx/aic79xx firmware assembler
  o aic7xx and aic79xx drivers - Correct several DV issues
  o aic7xxx and aic79xx driver updates
  o Aic7xxx and Aic79xx DV fix
  o Aic79xx Driver Update Enable abort and bus device reset handlers for both legacy and packetized connections.
  o Aic7xxx Driver Update
  o Aic7xxx and Aic79xx Driver Update Force an SDTR after a rejected WDTR if the syncrate is unkonwn.
  o Aic7xxx Driver Update 6.2.28
  o Update Aic7xxx and Aic79xx Driver Documentation
  o Bump aic79xx version number to 1.3.0 now that it has passed functional testing.
  o Aic7xxx Driver Update to verstion 6.2.29
  o Update aic7xxx/Makefile
  o Update aicasm/Makefile so that link specifications are specified after all object files.  This seems to be required in order to link correctly in some cases.
  o Aic79xx Driver Update to 1.3.2
  o Update Aic7xxx to version 6.2.29
  o AICLIB Update
  o Update Aic7xxx driver [Rev 6.2.31]
  o Aic79XX Driver Update [Rev 1.3.5]
  o Change the callback argument for aic brace option parsing to u_long to avoid casting problems with different architectures.
  o Aic7xxx Driver Update (version 6.2.32)
  o Aic79xx Driver Update (version 1.3.6)
  o Complete merge of AC aic7xxx and aic79xx bits
  o Remove the CONFIG_AIC7XXX_ALLOW_MEMIO option.  It has been supplanted by the MEMIO probe/test code.
  o Aic79xx Driver Update
  o Aic7xxx and Aic79xx driver Update
  o Aic7xxx and Aic79xx Driver Update
  o Aic7xxx and Aic79xx driver updates
  o Aic7xxx and Aic79xx driver updates
  o Aic7xxx and Aic79xx driver Update
  o Aic7xxx and Aic79xx Driver Updates
  o Aic7xxx Driver Update
  o Aic79xx Driver Update
  o Use absolute path to drivers/scsi in the aic7xxx Makefile
  o Aic79xx Driver Update
  o Aic79xx Driver Update
  o Aic79xx Driver Upate
  o Remove pre-2.2.X kernel support.  Pre-2.2.X support requires
  o Aic79xx Driver Update
  o Aic7xxx and Aic79xx Driver Updates
  o Update Aic79xx and Aic7xxx Documenation
  o Aic79xx Driver Update (version 1.3.8)
  o Aic7xxx Driver Update (6.2.33)
  o Aic7xxx Driver Update
  o Aic7xxx and Aic79xx Driver Updates
  o Aic7xxx and Aic79xx Driver Update
  o Aic7xxx and Aic79xx Driver Update
  o Aic79XX Driver Update
  o Aic7xxx Driver Update
  o Aic7xxx Driver README update
  o Aic79xx and Aic7xxx Driver Updates
  o Cset exclude: ak@muc.de|ChangeSet|20030508192559|45150 Cset exclude: marcelo@freak.distro.conectiva|ChangeSet|20030507201543|47130 Cset exclude: marcelo@freak.distro.conectiva|ChangeSet|20030507200707|47153
  o Aic7xxx and Aic79xx Updates
  o Aic79xx Update
  o Aic79xx Driver Update
  o Aic7xxx Driver version 6.2.35
  o Aic7xxx Driver Update
  o Aic7xxx and Aic79xx Driver Updated
  o Aic7xxx Driver Update
  o Aic7xxx Driver Update
  o Aic79xx Driver Update
  o Aic7xxx and Aic79xx Driver Updates
  o Bump aic79xx driver version to 1.3.9
  o Aic7xxx Driver Update
  o Aic7xxx Driver Update
  o Aic79xx Driver Update
  o Aic79xx Driver Update
  o Aic7xxx Driver Update
  o Aic7xxx and Aic79xx Driver Update
  o Aic7xxx and Aic79xx driver Update
  o Aic7xxx Driver Update
  o Aic7xxx Driver Update
  o Aic79xx Driver Update
  o Aic7xxx and Aic79xx Driver Update
  o Aic7xxx Driver Update
  o Aic79xx Driver Update
  o Update Aic79xx Readme

Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>:
  o ISDN: Fix Fritz!PCI v2 xmit irq underrun recovery
  o ISDN: Fix bug in ST5481 D-Channel state machine

Karsten Keil <kkeil@suse.de>:
  o ISDN: [PATCH] Fix problem with external hisax drivers

Maksim Krasnyanskiy <maxk@qualcomm.com>:
  o L2CAP config req/rsp handling fixes
  o [Bluetooth] Detect and log error condition when first L2CAP fragment is too long
  o [Bluetooth] RFCOMM must wait for MSC exchange to complete before sending the data
  o [Bluetooth] L2CAP sockets can now set LM_RELIABLE flag and get notification when we detect reliablity problem with the ACL connection.
  o [Bluetooth] Add support for SO_LINGER option to all Bluetooth protocols
  o Bluetooth: RFCOMM must send MSC when DLC was opened by SABM
  o [Bluetooth] Fix RFCOMM C/R and Direction bit handling
  o [Bluetooth] L2CAP qualification spec mandates sending additional config request if we receive config response with unacceptable parameters error code. 

Marcel Holtmann <marcel@holtmann.org>:
  o [Bluetooth] Send the correct values in RPN response
  o [Bluetooth] Handle priority bits in parameter negotiation
  o [Bluetooth] Implement rfcomm_tty_put_char() function
  o [Bluetooth] Send correct RPN response for accepted values
  o [Bluetooth] Set EA bit for V.24 signals parameter
  o [Bluetooth] Handle bit rate in remote port negotiation
  o [Bluetooth] Quirk for devices with no ISOC endpoints

Marcelo Tosatti <marcelo@freak.distro.conectiva>:
  o Changed EXTRAVERSION to -pre2
  o Cset exclude: jamagallon@able.es|ChangeSet|20030620200318|50799

Mark A. Greer <mgreer@mvista.com>:
  o PPC32: Fix the gen550 infrastructure for baud rates other than 9600

Olaf Hering <olh@suse.de>:
  o remove TIOCGDEV from asm/ioctls.h
  o RAID_AUTORUN is a compatible ioctl

Patrick McHardy <kaber@trash.net>:
  o ISDN: [PATCH]  missing cli() in isdn_net.c
  o ISDN: [PATCH] don't unlock lp if there is nothing to unlock
  o ISDN: Add CONFIG_IPPP_FILTER
  o [NETFILTER]: Dont call helpers expectfn() for unconfirmed connections

Paul Mackerras <paulus@samba.org>:
  o PPC32: Update for PPC 4xx TLB and exception handling
  o PPC32: Add a new framework for on-chip peripherals for the IBM 4xx embedded processors.
  o PPC32: Introduce a new config symbol, CONFIG_40x, used for PPC 40x cpus
  o PPC32: Add generic IBM PPC405GP support and use it on the walnut platform
  o PPC32: Update the support for the "Walnut" 405GP platform
  o PPC32: Make debug exceptions usable on 4xx-class processors, and improve trap handling.
  o PPC32: Add support for PPC 405GP interrupt controller
  o PPC32: Extra register and other definitions for the PPC 405GP processor
  o PPC32: Move PC-style serial port definitions out to asm/pc_serial.h
  o PPC32: remove ppc4xx_serial.h, it is no longer used
  o PPC32: Cleanups for PPC 405GP-based systems; add file of OCP ids
  o PPC32: Don't run `checks' program on make zImage
  o PPC32: Add definitions for the UIC interrupt controller on the 405GP processor
  o PPC32: Add support for PCI and time-of-day clock on 405GP-based systems
  o PPC32: Allow for PCI host bridges that need explicit type 1 cycle indication

Randy Dunlap <rddunlap@osdl.org>:
  o unexpected IO-APIC code update

Rusty Russell <rusty@rustcorp.com.au>:
  o [irda] module refcounts for irlan
  o [patch, 2.5] dgrs doesn't free on error path
  o namespace pollution in cosa driver
  o [2.4 patch] fix wavelan_cs compile warning
  o Clear up GFP confusion in rcpci45.c
  o [patch, 2.5] fix errorpath in apne.c
  o Remove naked GFP_DMA from drivers_net_macmace.c
  o namespace pollution in skfddi driver
  o improve signal-to-noise ratio in atm code
  o 2.4.20 wait.h doc typo
  o fs_autofs4_root.c unused variable
  o [TRIVIAL PATCH 2.4] update README file to current
  o fix documentation in include_asm-i386_bitops.h
  o missing headers in i82092.c
  o fix linewrap in Documentation_power_pci.txt
  o include_asm-ia64_sal.h, typo: the the
  o Typos in drivers_s390_net_iucv.h
  o [TRIVIAL PATCH] include_asm-i386_dma.h: wrong lowest DMA
  o redundant declarations (#1_15)
  o add some missing init.h inclusions
  o remove superflous if in wait_kio
  o Squash warning in ppc64 addnote tool
  o fix linewrap in Documentation_filesystems_sysv-fs.txt
  o set b_page to null in fake buffer_head for O_DIRECT
  o fix linewrap in Documentation_pci.txt
  o misc_register audit fix of wdt_pci
  o misc register fix on ds1286
  o reorganize for unreachable code

Sam Ravnborg <sam@mars.ravnborg.org>:
  o [netdrvr sis900] make function headers readable by kernel-doc tool

Scott Feldman <scott.feldman@intel.com>:
  o [netdrvr e1000] add support for NAPI
  o [netdrvr e1000] add TSO support -- disabled
  o 10GbE ethtool support
  o remove ethtool privileged references
  o [e100] Remove "Freeing alive device" warning
  o [e100] move e100_asf_enable under CONFIG_PM to avoid warning
  o [e100] Add ethtool parameter support
  o [e100] Add ethtool cable diag test
  o [e100] Add MDI/MDI-X status to ethtool reg dump
  o [e100] cleanup Tx resources before running ethtool diags
  o [e100] full stop/start on ethtool set speed/duplex/autoneg
  o [e100] fixed stalled stats collection
  o [e100] VLAN configuration was lost after ethtool diags run
  o [e100] use skb_headlen() rather than rolling own
  o [e100] set netdev members before registration
  o [e100] misc

Tom Rini <trini@kernel.crashing.org>:
  o PPC32: Clean up the cpu_idle() code a bit
  o PPC32: Fix a multicast bug in the MPC 8xx / 8260 enet drivers
  o PPC32: Correct the DTLB miss handler on MPC8xx
  o PPC32: Fix a problem with MDIO requests on reset in MPC 8xx enet
  o PPC32: Minor cleanups to the MPC 8xx FEC driver
  o PPC32: Fix a small problem in the 8xx / 8260 uart code
  o PPC32: Important fixes in the MPC8xx FEC and MPC826x enet driver
  o PPC32: Describe when we want to do a CPM reset on MPC8xx
  o Add /proc/sys/kernel/l3cr

Zwane Mwaikambo <zwane@linuxpower.ca>:
  o Remove warning due to comparison in drivers/net/pcnet32.c

Summary of changes from v2.4.21 to v2.4.22-pre1
============================================

<baldrick@wanadoo.fr>:
  o USB: Backport of USB speedtouch driver to 2.4
  o USB speedtouch: move MOD_INC_USE_COUNT
  o USB speedtouch: discard packets for non-existant vcc's
  o USB speedtouch: bump the version number
  o USB speedtouch: crc optimization
  o USB speedtouch: compile fix
  o USB speedtouch: remove trailing semicolon
  o USB speedtouch: trivial whitespace and name changes
  o USB speedtouch: add missing #include
  o USB speedtouch: replace yield()
  o USB speedtouch: add defensive memory barriers
  o USB speedtouch: spin_lock_irqsave -> spin_lock_irq in process context
  o USB speedtouch: spin_lock_irqsave -> spin_lock_irq in tasklets
  o USB speedtouch: verbose debugging
  o USB speedtouch: use optimally sized reconstruction buffers
  o USB speedtouch: send path micro optimizations
  o USB speedtouch: kfree_skb -> dev_kfree_skb
  o USB speedtouch: remove useless NULL pointer checks
  o USB speedtouch: receive path micro optimization
  o USB speedtouch: receive code rewrite
  o USB speedtouch: remove MOD_XXX_USE_COUNT
  o USB speedtouch: set owner fields
  o USB speedtouch: parametrize the module

<bdschuym@pandora.be>:
  o [NETFILTER]: Fix ARPT_INV_MASK in arp_tables.h

<bwheadley@earthlink.net>:
  o USB: Aiptek kernel driver 1.0 for Kernel 2.4

<ccheney@cheney.cx>:
  o USB: vicam.c copyright patches

<chas@cmf.nrl.navy.mil>:
  o [ATM]: Fix foul up in lec driver
  o [ATM]: Add Forerunner HE support

<chas@locutus.cmf.nrl.navy.mil>:
  o [ATM]: Fix excessive stack usage in iphase driver
  o [ATM]: svcs possible race with sigd

<cweidema@indiana.edu>:
  o USB: pentax optio S

<dlstevens@us.ibm.com>:
  o [IGMP]: Backport igmpv3/mld2 support to 2.4.x
  o [IGMP]: Make sock_alloc_send_skb calls non-blocking
  o [IPV4/IPV6]: Make sure SKB has enough space while building IGMP/MLD packets
  o [IPV4/IPV6]: Fix IGMP device refcount leaks, with help from yoshfuji@linux-ipv6.org

<dwmw2@dwmw2.baythorne.internal>:
  o Switch to shared optimised CRC32 functions
  o Add config help for CONFIG_CRC32 (Duncan Sands <baldrick@wanadoo.fr>)
  o Fix CONFIG_CRC32=y when nothing in-kernel uses CRC32 functions by exporting the symbol from kernel/ksyms.c instead of lib/crc32.c, hence forcing lib/crc32.o to get pulled in during the final link.

<engebret@brule.rchland.ibm.com>:
  o [PPC64] Add biarch support and fix zImage builds deps from Matt Wilson
  o [PPC64] Search to the leaves of OF nodes for dma-window property
  o [PPC64] Cleanups & merge to 2.4.21pre7

<hanno@gmx.de>:
  o USB: Patch for Vivicam 355

<henning@meier-geinitz.de>:
  o USB: New vendor/product ids for scanner driver

<hwahl@hwahl.de>:
  o USB:  Patch for Samsung Digimax 410

<james@superbug.demon.co.uk>:
  o USB: Add support for Pentax Still Camera to linux kernel

<jengel@brule.rchland.ibm.com>:
  o update arch/ppc64 and include/asm-ppc64
  o turned off CONFIG_KDB and CONFIG_DUMP

<krkumar@us.ibm.com>:
  o [NET]: Initialize sysctl_table to NULL in neigh_parms_alloc

<kumarkr@us.ibm.com>:
  o [TCP]: Handle NLM_F_ACK in tcp_diag.c

<linux-usb@gemeinhardt.info>:
  o USB: add support for Mello MP3 Player

<nicolas@dupeux.net>:
  o USB: UNUSUAL_DEV for aiptek pocketcam

<olof@austin.ibm.com>:
  o [TCP]: tcp_twkill leaves death row list in inconsistent state over tcp_timewait_kill

<per.winkvist@telia.com>:
  o USB: more unusual_devs.h changes
  o Re: unusual_devs.h patch that was in 2.5.68

<philipp@void.at>:
  o USB: unusual_devs.h patch

<richard.curnow@superh.com>:
  o USB: ehci-hcd.c needs to include <linux/bitops.h>

<shemminger@osdl.org>:
  o [IPV4]: Replace explicit dev->refcount bumps with dev_hold

<smb@smbnet.de>:
  o USB: another usb storage addition

<stewart@inverse.wetlogic.net>:
  o USB: HIDDev uref backport for 2.4?

<thomas@osterried.de>:
  o [AX25]: AX.25 bug fixes

<vinay-rc@naturesoft.net>:
  o [NET]: Use mod_timer in dst.c
  o [PKT_SCHED]: Use mod_timer in sch_cbq.c
  o [PKT_SCHED]: Use mod_timer in sch_csz.c
  o [PKT_SCHED]: Use mod_timer in sch_htb.c

<vsu@altlinux.ru>:
  o USB: HIDDEV / UPS patches

<wahrenbruch@kobil.de>:
  o USB: kobil_sct.c added support for KAAN SIM Reader

<walter.harms@informatik.uni-oldenburg.de>:
  o USB: fixes kernel_thread
  o USB: fixes kernel_thread

Alan Stern <stern@rowland.harvard.edu>:
  o USB: US_SC_DEVICE and US_PR_DEVICE for 2.4

Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>:
  o [ACENIC]: Comment out netif_wake_queue from acenic watchdog
  o [IPV4]: More sane rtcache behavior

Andy Grover <agrover@groveronline.com>:
  o Remove old ACPI drivers
  o Delete acpitable.[ch] since they are no longer needed
  o ACPI interpreter update to latest (20020725)
  o Add ACPI driver files
  o This changeset adds ACPI support to 3 main areas
  o By Herbert Nachtnebel
  o Export acpi_get_firmware_table (Matthew Wilcox)
  o Fix ACPI table parsing (Bjorn Helgaas)
  o remove no-longer applicable comment
  o make "acpi=off" disable table parsing as well as interpreter init
  o update for core release version 20020815
  o Remove no-longer needed files
  o Add support for SLIT/SRAT parsing (Kochi Takayoshi)
  o New file for SLIT/SRAT support (Kochi Takayoshi)
  o ACPI interpreter updates
  o fix conditional (Giridhar Pemmasani)
  o ACPI trivial fixes (Kochi Takayoshi)
  o from 2.5: fix ACPI Config.in breakage (C. Hellwig)
  o Ensure that the ACPI interrupt has the proper trigger and polarity
  o ACPI: Remove unused functions in osl.c (Kochi Takayoshi)
  o ACPI: remove unused kdb and debugger directories
  o ACPI: When using CONFIG_ACPI_HT_ONLY, do not configure IOAPIC and LAPIC NMIs.
  o Toshiba ACPI Extras driver by John Belmonte
  o ACPI: Do not compile functions not used in HT_ONLY mode
  o ACPI: Fix possible sleeping at interrupt context (Matthew Wilcox)
  o ACPI: Blacklist improvements 1) Split blacklist code out into a separate file.
  o ACPI: New blacklist entries (Andi Kleen)
  o ACPI: Add a cmdline switch to disable ACPI PCI config (Andi Kleen)
  o ACPI
  o ACPI: Print the DSDT stats on boot, just like the other ACPI tables
  o ACPI: Interpreter update to 20020918
  o ACPI: Ensure that the ACPI SCI (system control interrupt) is set to active lov, level trigger.
  o ACPI: Make ACPI's use of fixmap use its own fixmap region, instead of the IOAPICs, since that will not be present on UP systems.
  o ACPI: change a non-critical debug message to a more appropriate level
  o ACPI: Replace ACPI_DEBUG with ACPI_DEBUG_OUTPUT in a few places we missed (Dominik Brodowski)
  o ACPI: Make the ACPI SCI interrupt get the right polarity when it is explicitly overridden in the MADT
  o ACPI: Add support for HPET tables (Andi Kleen)
  o Fix reversed logic in blacklist code (Sergio Monteiro Basto)
  o ACPI: IA64 Improvements (David Mosberger)
  o ACPI: Fix thermal management (Pavel Machek) Make thermal trip points R/W (Pavel Machek) Allow handling negative celsius values (Kochi Takayoshi)
  o ACPI: get ifdefs right in HT_ONLY case
  o ACPI: Fix MADT parsing error (Bjoern A. Zeeb)
  o ACPI: Init thermal driver timer before it is used (Knut Neumann)
  o ACPI: Interpreter update to 200201002
  o ACPI: Eliminate use of TARGET_CPUS from ACPI code
  o ACPI: Interpreter update to 200201022 release
  o ACPI: EC update
  o ACPI: Restore ARB_DIS bit after return from S1
  o ACPI: Add needed exports for ACPI-based PCI Hot Plug (J.I. Lee)
  o ACPI: Rename acpi_power_off to acpi_power_off_device (Pavel Machek)
  o ACPI: Remove too-broad blacklist entries
  o ACPI: Use dev->devfn instead of bridge->devfn to determine the pin when trying to derive a device's irq from its parent (Ville Syrjala)
  o ACPI: Add support for GPE1 block defined with no GPE0 block
  o ACPI: Try #2 at fixing the bridge swizzle (Kai Germaschewski)
  o ACPI
  o ACPI: Ensure we con't try to sleep when we shouldn't
  o ACPI: Interpreter update to (20021101)
  o ACPI: Oops, 2.4.x doesn't have in_atomic()
  o ACPI: Turn down debug messages to a tolerable level (Ernst Herzberg)
  o ACPI: Interpreter update to fix mutex wait problem This changes the timeout param around the interpreter to a u16, so that ACPI_WAIT_FOREVER is equivalent to 0xFFFF, the value ASL expects to mean "wait forever".
  o ACPI: Correctly init device struct, permissing proper unloading/reloading (John Cagle)
  o ACPI: Interpreter update to 20021111. Add support for SMBus OpRegions
  o ACPI: Handle module unload/reload properly w.r.t. /proc
  o ACPI: Do not compile code for EC unloading, because it cannot be unloaded atm
  o ACPI: fix debug print levels, and use down() instead of down_interruptible(), and some whitespace.
  o ACPI: Interpreter fixes Fixed memory leak in method argument resolution Fixed Index() operator to work properly with a target operand Fixed attempted double delete in the Index() code Code size improvements Improved debug/error messages and levels Fixed a problem with premature deletion of a buffer object
  o ACPI: Add ec_read and ec_write
  o ACPI: Update to 20021122 Fixed a problem with RefOf and named fields Fixed a protection fault involving Packages with Null/nested packages Fixed GPE initialization to handle a pathological case
  o ACPI: Fix IRQ assignment on Tiger (JI Lee)
  o ACPI: Remove incorrect comment
  o ACPI: Interpreter update to 20021205 Prefix more contants with ACPI_ Fixed a problem causing DSDT image corruption Fixed a problem if a method was called in an object declaration Fixed a problem in the string copy routine Broke out some code into new files Eliminate spurious unused variables warning w.r.t. ACPI_MODULE_NAME Remove unneeded file
  o ACPI: Never return a value from the PCI device's Interrupt Line field if it might be bogus -- return 0 instead.
  o ACPI: Fix check of schedule_task()'s return value (Ducrot Bruno)
  o ACPI: Get fid of progress dots if not in debug mode
  o ACPI: update to 20021212
  o ACPI: Fix oops on module insert/remove (Matthew Tippett)
  o ACPI: remove non-Linux revision on files, and make types more Linux-like
  o ACPI: More cosmetic changes to make the code more Linux-like
  o ACPI: Switch from typedefs to explicit "struct" and "union" usage
  o ACPI: Fix for now-dynamic nature of mp_irqs array (Joerg Prante)
  o ACPI: Expose lid state to userspace (Zdenek OGAR Skalak)
  o ACPI: Make button functions static (Pavel Machek)
  o ACPI: Express state of lid in words, not a number
  o ACPI: Eliminate spawning of thread from timer callback. Use schedule_work for all cases. Thanks to Ingo Oeser, Andrew Morton, and Pavel Machek for their wisdom.
  o ACPI: Update version to 20030109
  o ACPI: Fix acpiphp_glue.c for latest ACPI struct changes (Sergio Visinoni)
  o ACPI: Boot functions don't use cmdline, so don't pass it
  o ACPI: S4BIOS support (Ducrot Bruno)
  o ACPI: Move drivers/acpi/include directory to include/acpi
  o ACPI: Handle P_BLK lengths shorter than 6 more gracefully
  o ACPI: Update to 20030122
  o ACPI: Fix accidentally reverted file
  o ACPI: Fix missing declaration for s4bios support
  o ACPI: optimize for size
  o ACPI: Fix compilation on IA64 (Matthew Wilcox)
  o ACPI: Reduce errorlevel of a debug message (Matthew Wilcox)
  o ACPI: Use extended IRQ resource type when setting IRQs on link devices to more than IRQ 15 (Juan Quintela)
  o ACPI: Properly handle an ISO reassigning the ACPI interrupt. Big thanks to John Stultz.
  o ACPI: Factor common code out of an if/else
  o ACPI: *really* fix ISO SCI override support (thanks again to John Stultz)
  o ACPI: update NUMA maintainer email
  o ACPI: change includes of ACPI headers for new location
  o ACPI: Port mochel's makefile improvements
  o ACPI: Eliminate use of acpi_gpl_gpe_number_info (Matthew Wilcox)
  o ACPI: Support translation attribute (Bjorn Helgaas)
  o ACPI: Add ability to override predefined object values (Ducrot Bruno)
  o ACPI: Decrease size of override's static array, add a define for the length, and print a msg if used
  o ACPI: Fix printk output (Jochen Hein)
  o ACPI: Misc interpreter improvements
  o ACPI: misc sync-ups
  o ACPI: Change license from GPL to dual GPL and BSD-style
  o ACPI: Backport Toshiba driver changes from 2.5 (John Belmonte)
  o ACPI: Do not count processor objects for non-present CPUs
  o ACPI: Revert a change that allowed P_BLK lengths to be 4 or 5. This is causing us to think that some systems support C2 when they really don't.
  o ACPI: Oops, remove 2.5-ism
  o ACPI: Fix derive_pci_id (Ducrot Bruno, Alvaro Lopez)
  o ACPI: Add mem= kernel parameters to allow user to specify reserved and ACPI DATA regions (Pavel Machek)
  o ACPI: Map in entire table before doing the checksum (John Stultz)
  o ACPI: update to 20030228
  o ACPI: Re-enable building w/o CONFIG_PCI (Pavel Machek)
  o ACPI: Fix off by 1 error in C2/3 detection (Ducrot Bruno)
  o ACPI: Interpreter update to 20030321
  o ACPI: Sleep updates (Ducrot Bruno)
  o ACPI: Fix compile warning
  o ACPI: Interpreter update to 20030328
  o ACPI: Interpreter update to 20030418
  o ACPI: Fix link devices on SMP systems (Dan Zink)
  o ACPI: Add missing include
  o ACPI: Update to 20030424
  o ACPI: Allow ":" in OS override string (Ducrot Bruno)
  o ACPI: Interpreter update to 20030509 Changed the subsystem initialization sequence to hold off installation of address space handlers until the hardware has been initialized and the system has entered ACPI mode.  This is because the installation of space handlers can cause _REG methods to be run.  Previously, the _REG methods could potentially be run before ACPI mode was enabled.
  o ACPI: acpi=off also implies drivers should not load (Zdenek Ogar Skalak)
  o ACPI: Update Toshiba driver to 0.15 (John Belmonte)
  o ACPI: Do not reinit ACPI irq entry in ioapic (thanks to Stian Jordet)
  o ACPI: update to 20030522 Found and fixed a reported problem where an AE_NOT_FOUND error occurred occasionally during _BST evaluation.  This turned out to be an Owner ID allocation issue where a called method did not get a new ID assigned to it.  Eventually, (after 64k calls), the Owner ID UINT16 would wraparound so that the ID would be the same as the caller's and the called method would delete the caller's namespace.
  o ACPI: Allow multiple compatible IDS for PnP matching
  o ACPI: Remove extra semicolon (Pavel Machek)
  o ACPI: Trivial name init patch (Bjorn Helgaas)
  o ACPI: Re-add acpitable.c. This makes some people happy I hope, and also (!) cleans up the code a little - a big #ifndef reduction.
  o ACPI: Add ASUS Value-add driver (Karol Kozimor and Julien Lerouge)
  o ACPI: Add missing CONFIG_ACPI_HT_ONLY entry to Configure.help
  o ACPI: Don't oops on echo 5 >sleep, but do shut down uncleanly
  o ACPI: ACPI PCI subdriver support (Matthew Wilcox)
  o ACPI: acpiphp update (Takayoshi Kochi)
  o ACPI: Interpreter update to 20030619

Ben Collins <bcollins@debian.org>:
  o [SPARC64]: Final image strip not to strip too much
  o USB: Happ UGCI added as BADPAD for workaround
  o USB Multi-input quirk
  o USB: fix keyboard leds
  o USB: Actually Fix 2.4 HID input

Dave Hollis <dhollis@davehollis.com>:
  o USB: AX8817X Driver for 2.4 Kernels

David Brownell <david-b@pacbell.net>:
  o USB: ehci i/o watchdog
  o USB: SMP ehci-q.c 1010 BUG()
  o USB: EHCI update for 2.4

David Mosberger <davidm@napali.hpl.hp.com>:
  o [TG3]: Workaround 4g DMA bug more portably

David S. Miller <davem@nuts.ninka.net>:
  o [NET]: Use dump_stack() in neigh_destroy()
  o [ATM]: Fix some CPP pasting in ambassador driver
  o [IPV6]: Remove illogical bug check in fib6_del
  o [IPV4]: Use time_{before,after}() and proper jiffies types in route.c
  o [IPV4]: Two minor errors in jiffies changes
  o [IPV4]: Fix expiration test in rt_check_expire
  o [RTNETLINK]: extern __inline__ --> static inline
  o [TCP]: extern __inline__ --> static inline where appropriate
  o [IPV6]: extern __inline__ --> static inline
  o [SUNHME]: Use PCI config space if hm-rev property does not exist
  o [IPV6]: Memory leak found by stanford checker
  o [NET]: In dst_alloc, do not assume layout of atomic_t
  o [IPV4]: Fix fib_hash performance problems with huge route tables
  o [IPV4]: Use get_order instead of reimplementation
  o [NET]: Kill net/README, out of date and duplicates MAINTAINERS file
  o [SPARC64]: RAID_AUTORUN is a compatible ioctl
  o [SPARC64]: Fix sys_shmat handling for 64-bit binaries
  o [IPV6]: Do not invoke icmpv6_send with uninitialized skb->dev
  o [SPARC64]: Merge sysinfo32 corrections from ppc64 port
  o [IPV6]: Fix igmp6_timer_handler forward declaration
  o [NET]: Fix build failure from recent sunrpc changes
  o [NET]: Size hh_cache->hh_data more appropriately

David Woodhouse <dwmw2@infradead.org>:
  o Fix CONFIG_CRC32=m by make crc32.o export its own symbols again in that case
  o Back-port Jocke's CRC32 optimisations from 2.5
  o Fix export of crc32 symbols when CONFIG_CRC32 != y but something pulls it into the kernel image anyway

Geert Uytterhoeven <geert@linux-m68k.org>:
  o [NET]: asm/smp.h --> linux/smp.h in sch_ingress.c
  o USB: Big endian RTL8150

Greg Kroah-Hartman <greg@kroah.com>:
  o USB: added support for Sony DSC-P8
  o USB: attempt to track down pl2303 oopses on close
  o USB: add comment to storage/unusual_devs.h that specifies how to add new entries
  o USB: fix break control for pl2303 driver
  o USB: pegasus ethtool fixup
  o USB: add error reporting functionality to the pl2303 driver
  o USB: fixup aiptek driver for older compilers
  o USB: clean up extra whitespace in visor.c driver

Hideaki Yoshifuji <yoshfuji@linux-ipv6.org>:
  o [IPV6]: Fix offset in ICMPV6_HDR_FIELD messages
  o [IPV^]: Use correct icmp6 type in ip6_pkt_discard
  o [MAINTAINERS/CREDITS]: Add entries for USAGI hackers
  o [IPV6]: ARCnet support, driver side
  o [IPV6]: ARCnet support, protocol side
  o [IPV6]: Reworked default router selection

J. A. Magallon <jamagallon@able.es>:
  o Allow aicasm to be built with db4-devel

Jeff Garzik <jgarzik@redhat.com>:
  o [ROSE]: Kill kfree of net_device->name

Johannes Erdfelt <johannes@erdfelt.com>:
  o USB: fix 2.4 usbdevfs race

Marcelo Tosatti <marcelo@freak.distro.conectiva>:
  o Changed VERSION to .22
  o Delete autogenerated lib/crc32table.h
  o Added missing "-" to EXTRAVERSION

Martin Devera <devik@cdi.cz>:
  o [NET]: Fix jiffies races in net/sched/sch_htb.c

Neil Brown <neilb@cse.unsw.edu.au>:
  o Handle concurrent failure of two drives in raid5
  o Fix bug in /proc/mdstat
  o Fix the check for execute permissions of parent directories in NFSd
  o kNFSd: SVC sockets don't disable Nagle
  o kNFSd: TCP nfsd connection hangs when partial record header is received
  o kNFSd: Make sure an early close on a nfs/tcp connection is handled properly

Olaf Hering <olh@suse.de>:
  o USB: incorrect ethtool -i driver name
  o USB: incorrect ethtool -i driver name

Pam Delaney <pdelaney@lsil.com>:
  o Critical bug fix for fusion driver

Patrick McHardy <kaber@trash.net>:
  o [PPP] fix memory leak in ioctl error path

Paul Mackerras <paulus@samba.org>:
  o [PPP]: Fix PPP Deflate sequence number checking

Petko Manolov <petkan@users.sourceforge.net>:
  o USB: pegasus patch

Randy Dunlap <rddunlap@osdl.org>:
  o [NET]: Spelling/typo fixes in rtnetlink.h
  o [IPV6]: Fix typos in ip6_fib.c
  o [IPV6]: Use time_after() etc. for comparing jiffies
  o [NET]: add RFC references for Linux SNMP MIBs
  o [NET]: Typo corrections only

Robert Olsson <robert.olsson@data.slu.se>:
  o [IPV4]: Add rtcache hash lookup statistics to rtstat
  o [IPV4]: In rt_intern_hash, reinit all state vars on branch to "restart"

Stephen C. Tweedie <sct@redhat.com>:
  o Fix O_DIRECT races in 2.4

Vojtech Pavlik <vojtech@suse.cz>:
  o USB: Make Olympus cameras work with usb-storage
  o USB: Fix HID logical min/max for 2.4

