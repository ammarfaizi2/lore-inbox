Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262270AbUKQL6r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262270AbUKQL6r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 06:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262265AbUKQL6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 06:58:47 -0500
Received: from hera.kernel.org ([63.209.29.2]:55998 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S262285AbUKQL4T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 06:56:19 -0500
Date: Wed, 17 Nov 2004 03:56:10 -0800
From: Marcelo Tosatti <marcelo@hera.kernel.org>
Message-Id: <200411171156.iAHBuA1E013082@hera.kernel.org>
To: linux-kernel@vger.kernel.org
Subject: linux-2.4.28 released
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

final:

- 2.4.28-rc4 was released as 2.4.28 with no changes.


Summary of changes from v2.4.28-rc3 to v2.4.28-rc4
============================================

Adrian Bunk:
  o [NET]: neigh_for_each must be EXPORT_SYMBOL'ed

David S. Miller:
  o [AF_UNIX]: Serialize dgram read using semaphore just like stream
  o [NET]: Export __neigh_for_each_release to modules
  o [TG3]: Update driver version and reldate

Jakub Jelínek:
  o binfmt_elf: handle p_filesz == 0 on PT_INTERP section

Len Brown:
  o [ACPI] fix NMI during poweroff http://bugzilla.kernel.org/show_bug.cgi?id=1206

Marcelo Tosatti:
  o Changed EXTRAVERSION to -rc4

Michael Chan:
  o [TG3]: 5753 support and a bug fix

Patrick McHardy:
  o [SCTP]: Fix inetaddr notifier chain corruption

Willy Tarreau:
  o aic7xxx aic79xx_osm_pci.c compile fix with -Werror



Summary of changes from v2.4.28-rc2 to v2.4.28-rc3
============================================

Aaron Grothe:
  o [CRYPTO]: Add Anubis support

Chris Wright:
  o binfmt_elf: handle partial reads gracefully

David S. Miller:
  o [TG3]: Use ioremap_nocache()
  o [TG3]: Bump driver version and reldate
  o Cset exclude: davem@nuts.davemloft.net|ChangeSet|20040831000448|00808
  o Cset exclude: pablo@eurodev.net|ChangeSet|20040831000223|00117
  o [ATM]: Put back mistakedly removed LEC procfs code

Herbert Xu:
  o [NET]: Fix tbl->entries race

Len Brown:
  o [ACPI] fix ASUS boot crash http://bugzilla.kernel.org/show_bug.cgi?id=2755
  o [ACPI] fix poweroff regression backport from 2.6 and ACPICA 20040427 http://bugzilla.kernel.org/show_bug.cgi?id=2109

Marcelo Tosatti:
  o Changed EXTRAVERSION to -rc3

Mike Miller:
  o cleans up warnings in 32/64-bit conversions

Mike Waychison:
  o [TG3]: Fix fiber hw autoneg bounces

Patrick McHardy:
  o [PKT_SCHED]: Don't try to destroy builtin qdiscs

Stefan Esser:
  o Improved smbfs client overflow fix

Thomas Graf:
  o [NET]: Fix neighbour/arp build
  o [PKT_SCHED]: break is not enough to stop walking

Trond Myklebust:
  o NFS: Always wake up tasks that are waiting on the sillyrenamed file to complete

Wensong Zhang:
  o [IPVS]: Update version to 1.2.1


Summary of changes from v2.4.28-rc1 to v2.4.28-rc2
============================================

<arnouten:bzzt.net>:
  o [TCP]: Add /proc/net/tcp{,6} layout documentation

<lkml:rtr.ca>:
  o delkin_cb: new carbus IDE driver

<ruber:engr.es>:
  o [CRYPTO]: Add Tnepres cipher support

Aaron Grothe:
  o [CRYPTO]: Put khazad back into tcrypt table

Adrian Bunk:
  o add SCSI_SATA_ULI help text
  o Adrian Bunk CREDITS entry

Andrea Arcangeli:
  o [NET]: Accept should return ENFILE not EMFILE

Chris Wright:
  o compile fix for neighbour scalability backport
  o compile fix for neighbour scalability backport

David S. Miller:
  o [PKT_SCHED]: sch_netem.c needs linux/init.h
  o [AF_UNIX]: Remove spurious len test in unix_mkname
  o [CRYPTO]: Fix typo in Kconfig
  o [TG3]: Update driver version and reldate
  o [AF_PACKET]: Set VM_IO for mmap areas
  o [CRYPTO]: Delete MODULE_ALIAS line

Eric Sandeen:
  o fix for large direct I/O

Greg Banks:
  o [NET]: Fix race between neigh-timer_handler and neigh_event_send

Harald Welte:
  o [NET]: Backport neighbour scalability fixes from 2.6.x
  o [NETFILTER]: fix ipt_ULOG bogus error messages

Ivan Kokshaysky:
  o Alpha: fixes for bootp/bootpz targets

James Morris:
  o [CRYPTO]: Add __init and __initdata to aes.c

Keith Owens:
  o Avoid oops in proc_delete_inode

Len Brown:
  o [ACPI] reserve IOPORTS for ACPI (David Shaohua Li) http://bugzilla.kernel.org/show_bug.cgi?id=2641
  o [ACPI] boot option fixes from 2.6 "acpi_serialize" "acpi_wake_gpes_always_on" "acpi_osi=" http://bugzilla.kernel.org/show_bug.cgi?id=2534
  o set acpi_gbl_leave_wake_gpes_disabled to FALSE for 2.4 because it would take a backport of big 2.6 changes to make this code work and 2.4 doesn't support suspend/resume anyway.
  o [ACPI] Enter ACPI mode earlier Fixes two common boot failures due to buggy SMM BIOS code
  o [ACPI] fix build warnings
  o [ACPI] build fix
  o [ACPI] If BIOS disabled the LAPIC, believe it by default

Maciej W. Rozycki:
  o [NET]: Fix fddi_statistics for 64-bit
  o [IPV4]: Set ARP hw type correctly for BOOTP over FDDI
  o [IPV4]: Permit the official ARP hw type in SIOCSARP for FDDI

Marcelo Tosatti:
  o Jakub Bogusz: missing include in farsync WAN driver
  o mcp: Fix proc_delete_inode oops bug correction typo
  o Urban Widmark: Fix smbfs client overflow
  o Changed EXTRAVERSION to -rc2

Patrick Caulfield:
  o [DECNET]: Mark myself as maintainer

Patrick McHardy:
  o [PKT_SCHED]: Fix netem qlen accounting

Paul Fulghum:
  o serial receive lockup fix
  o usb serial write fix

Pete Zaitcev:
  o USB: update unusual_devs.h

Randy Dunlap:
  o [TG3]: tg3_nvram_read_using_eeprom cannot be __init

Sridhar Samudrala:
  o [SCTP] Adaption layer indication support
  o [SCTP] Update cwnd/ssthresh as per the sctpimpguide modifications
  o [SCTP] When an address is deleted, update any transports that are caching it as a source adddress.
  o [SCTP] Fix HEARTBEAT_ACKs being sent to wrong dest. ip address in a multi-homing scenario after a failback.

Stephen Hemminger:
  o [PKT_SCHED]: netem: Use timer to handle packets not rescheduling

Thomas Graf:
  o [PKT_SCHED]: Remove useless line in cbq_dump_class
  o [PKT_SCHED]: Make rate estimator work on all platforms
  o [PKT_SCHED]: CBQ; Destroy filters before destroying classes
  o [PKT_SCHED]: u32: Remove unused hgenerator field in tc_u_hnode
  o [PKT_SCHED]: Avoid duplicated TCA_STATS TLVs for HTB and HFSC
  o [PKT_SCHED]: Rename TCQ_F_INGRES to TCQ_F_INGRESS
  o filemap.c compile fix

Wensong Zhang:
  o [IPVS]: Fix endian problem on sync message size

Özkan Sezer:
  o 2.6 backport: binfmt_elf memleak fix error handling
  o 2.6 backport: tun sign mishandling



Summary of changes from v2.4.28-pre4 to v2.4.28-rc1
============================================

<chaus:rz.uni-potsdam.de>:
  o Fix bug in PIIX code where DMA could be turned on without proper hw configuration (bugzilla bug #3473)

Bartlomiej Zolnierkiewicz:
  o libata: PCI IDE legacy mode fix
  o [libata] do not memset() SCSI request buf in a get-reference style function
  o [libata piix] Fix PATA UDMA masks

Benjamin Herrenschmidt:
  o Mikael Pettersson: PowerPC 745x coherency fix

Dave Jones:
  o davej CREDITS update

François Romieu:
  o sata_nv: enable hotplug event on successfull init only
  o sata_nv: wrong failure path and leak
  o sata_nv: housekeeping for goto labels

Herbert Xu:
  o Fix hiddev devfs oops

Hugh Dickins:
  o tmpfs: stop negative dentries
  o tmpfs: fix shmem_file_write return value

Jake Moilanen:
  o PPC64 build break

Jeff Garzik:
  o [libata] add hook, and export functions needed for sata2 drivers
  o [libata] add sata_uli driver for ULi (formerly ALi) SATA

Jens Axboe:
  o scsi io completion bug

Maciej W. Rozycki:
  o "console=" parameter ignored

Marcelo Tosatti:
  o Changed EXTRAVERSION to -rc1

Margit Schubert-While:
  o Add prism54 to MAINTAINERS

Paul Fulghum:
  o serial send_break duration fix

Pete Zaitcev:
  o Crash with cat /proc/bus/usb/devices and disconnect

Özkan Sezer:
  o e1000 driver, gcc-3.4 inlining fix


Summary of changes from v2.4.28-pre3 to v2.4.28-pre4
============================================

<ajgrothe:yahoo.com>:
  o [CRYPTO]: Whirlpool algorithm updates
  o [CRYPTO]: Add missing tcrypt part of whirlpool updates

<ananth:broadcom.com>:
  o [libata sata_svw] race condition fix, new device support

<joshk:triplehelix.org>:
  o radeonfb: Fix module unload and red/blue typo
  o hotplug: Don't build cpqphp_proc.o if !PROC_FS

<lesanti:sinectis.com.ar>:
  o fix dcache nr_dentry race

<martin.wilck:fujitsu-siemens.com>:
  o [TG3]: Fix pause handling, we had duplicate flags for the same thing

<michael.waychison:sun.com>:
  o [TG3]: Fix thinko in 5704 fibre hw autoneg code

<peter:pantasys.com>:
  o [IPCONFIG]: Verify DHCPACK packets
  o [IPV4]: Fix DHCPACK checking in ipconfig.c

<tkooda-patch-kernel:devsec.org>:
  o [CRYPTO]: xtea_encrypt() should use XTEA_DELTA instead of TEA_DELTA

<vda:port.imtp.ilyichevsk.odessa.ua>:
  o trivial patch for 2.4: always inline __constant_*

Achim Leubner:
  o gdth update

David S. Miller:
  o [NET]: Kill SCM_CONNECT, never used and unreferenced
  o [TCP]: Just silently ignore ICMP Source Quench messages
  o [TG3]: Recognize all onboard Sun variants, not just 5704
  o [TG3]: Update driver version and reldate
  o [CRYPTO]: Zero out tfm before freeing in crypto_free_tfm()
  o [SPARC64]: Do not log streaming byte hole errors
  o [PKT_SCHED]: sch_netem.c needs linux/init.h
  o [SPARC64]: Disable SBH interrupt properly

David Woodhouse:
  o [NET]: In compat syscall handling, check socket option types correctly

Don Fry:
  o pcnet32: discard oversize rx packets
  o pcnet32: recover after rx hang
  o pcnet32: cleanup IRQ limitation
  o pcnet32: Add HomePNA parameter for 79C978
  o pcnet32: correctly program bcr32

Doug Ledford:
  o RAID1 error handling locking fix

Ganesh Venkatesan:
  o e1000 - ethtool support cleanup
  o e1000 - Enable TSO
  o e1000 - Replace kmalloc with vmalloc for data structures not shared with h/w
  o e1000 - TSO context descriptor setup fixes (in preparation for IPv6 TSO)
  o e1000 - Fix to prevent infinite loop trying to re-establish link while actively communicating
  o e1000 - Condition that determines when to quit polling mode includes work done in Tx path
  o e1000 - Shutdown PHY while bringing the interface down (if WoL not enabled)
  o e1000 - add likely/unlikely to assist branch prediction, other cleanups
  o e1000 - more DPRINTK messages
  o e1000 - suspend/resume fix from alex@zodiac.dasalias.org
  o e1000 - white space corrections
  o e1000 - remove support for advanced TCO features
  o e1000 - Fix MODULE_PARM, module_param and module_param_array usage
  o e1000 - Fix VLAN filter setup errors (while running on PPC)
  o e1000 - Polarity reversal workaround for 10F/10H links
  o e1000 - white space corrections, other cleanups
  o e1000 update - reset default ITR value to 8000

Geert Uytterhoeven:
  o m68k MM off-by-one
  o Atari ST-RAM setup
  o Amiga frame buffer: kill obsolete DMI Resolver code
  o fbdev monochrome lines

Herbert Xu:
  o Backport Via IRQ mask fix

Hideaki Yoshifuji:
  o [IPV6] Fix routing header handling
  o [IPV6] Fix skb allocation size for RST and ACK
  o [IPV6]: Missing ip_rt_put() in SIT error path

Jack Hammer:
  o broken ips update

Jean Delvare:
  o Update Documentation/i2c/writing-clients

Jeff Garzik:
  o [TG3]: Kill all on-chip send BD support code
  o linux/compiler.h: dummy __iomem macro (an sparse annotation)
  o [libata] resync with 2.6.x
  o [libata] remove distinction between MMIO/PIO helper functions
  o [libata] consolidate legacy/native mode init code into helpers
  o [libata] minor comment updates, preparing for iomap merge

Jens Axboe:
  o irq safe gendisk_lock

Linus Torvalds:
  o libata: initial PCI memory annotations

Marcelo Tosatti:
  o Cset exclude: Achim_Leubner@adaptec.com|ChangeSet|20040928105422|00490
  o Mike Miller: cciss typo fix
  o Changed EXTRAVERSION to -pre4

Margit Schubert-While:
  o prism54 Code cleanup
  o prism54 remove module params
  o prism54 add WE17 support
  o prism54 initial WPA support
  o prism54 fix wpa_supplicant frequency parsing
  o prism54 remove TRACE
  o prism54 Bug in timeout scheduling
  o prism54 print firmware version
  o prism54 bug initialization/mgt_commit

Maximilian Attems:
  o menuconfig fix crash due to infinite recursion

Mikael Pettersson:
  o 53c700 scsi driver gcc-3.4 fixes
  o pcmcia mem_op.h gcc-3.4 fixes
  o ATM drivers gcc-3.4 fixes
  o IBM PCI hotplug controller driver gcc-3.4 fixes
  o ISDN drivers gcc-3.4 fixes
  o MTD drivers gcc-3.4 fixes
  o RIVA driver gcc-3.4 fix
  o E100 driver gcc-3.4 fixes
  o PPC32 PReP residual data gcc-3.4 fix
  o matrox framebuffer driver gcc-3.4 fix

Pete Zaitcev:
  o USB drivers gcc-3.4 fixes

Stephen Hemminger:
  o [TCP]: Store congestion algorithm per socket
  o [TCP]: Add vegas style bandwidth info to 2.4.x tcp diag
  o [TCP]: Backport 2.6.x cleanup of westwood code

Thomas Graf:
  o [PKT_SCHED]: Fix slab corruption in cbq_destroy
  o [PKT_SCHED] Report qdisc parent to userspace

Wensong Zhang:
  o [IPVS] add the MAINTAINERS entry




Summary of changes from v2.4.28-pre2 to v2.4.28-pre3
============================================

<achew:nvidia.com>:
  o sata_nv: fix CK804 support
  o i810_audio.c and pci_ids.h: add support for nforce MCP2S,

<ajgrothe:yahoo.com>:
  o [CRYPTO]: Add Whirlpool digest algorithm

<apm:brigitte.dna.fi>:
  o [NETFILTER]: Fix unaligned access in arp_tables.c

<bzolnier:elka.pw.edu.pl>:
  o libata: ata_piix.c PIO fix

<davem:davemloft.net>:
  o LVM ioctl fix - Trying to vfree() nonexistent vm area

<felixb:sgi.com>:
  o [XFS] Removed xfs_iflush_all and all usages of vn_purge, except one in clear_inode path.
  o [XFS] Restored xfs_iflush_all, which is still used to finish reclaims

<ha505:hszk.bme.hu>:
  o [netdrvr fealnx] fix spin_unlock_irqrestore() usage

<ileong:nvidia.com>:
  o [ac97_codec] add new codec

<lcapitulino:conectiva.com.br>:
  o drivers/pci/pci.c NULL pointer fix
  o Fix missing `return NULL' missing in ext3_get_journal()

<mchan:broadcom.com>:
  o [TG3]: Check MAC_STATUS_SIGNAL_DET in serdes polling

<pablo:eurodev.net>:
  o [NETLINK]: Improve sendmsg() behavior of netlink sockets

<pjones:redhat.com>:
  o [SPARC64]: Support 64-bit initrd addresses

<rgooch:safe-mbox.com>:
  o drivers/char/ib700wdt.c ibwdt_ping() fix
  o Syntax fix drivers/media/video/bttv-driver.c

<richm:oldelvet.org.uk>:
  o [SPARC64]: Set LVM fields more consistently in ioctl32.c code

<tharbaugh:lnxi.com>:
  o [netdrvr e1000] disable DITR, which apparently hurts performance

Adrian Bunk:
  o ibmphp_res.c: fix gcc 3.4 compilation
  o lmc_media.c: fix gcc 3.4 compilation
  o ircomm_param.c: fix __FUNCTION__ paste error
  o irlmp.c: fix gcc 3.4 compilation
  o asm-i386/smpboot.h: fix gcc 3.4 compilation
  o dscc4.c: fix gcc 3.4 compilation

Christoph Hellwig:
  o [XFS] Rework freeze/unfreeze infrastructure
  o [XFS] Move all ioctl definitions into a common place for 32bit ioctl translation.
  o [XFS] avoid using pid_t in ioctl ABI
  o [XFS] Fix warnings in xfs_bmap.c
  o [XFS] Remove a readahead page allocation failure warning, this will happen under normal workloads and does not indicate a problem.

Dave Kleikamp:
  o JFS: Trivial: remove dead code
  o JFS: fix memory leak in __invalidate_metapages

David S. Miller:
  o [TIGON3]: Mention that firmware is copyrighted by Broadcom
  o [TG3]: Revamp fibre PHY handling
  o [SPARC64]: Fix PCI IOMMU invalid iopte handling
  o [IPV4]: Fix theoretical loop on SMP in ip_evictor()
  o [IPV6]: ip6_evictor() has same problem as ip_evictor()
  o [TG3]: Remove autoneg handling from fibre_autoneg() unneeded
  o [TG3]: Always set MAC_EVENT_LNKSTATE_CHANGED even when serdes polling
  o Cset exclude: davem@nuts.davemloft.net|ChangeSet|20040817010145|64922
  o [TG3]: Do tg3_netif_start() under lock
  o [TCP]: When fetching srtt from metrics, do not forget to set rtt_seq
  o [TG3]: Disable CIOBE split, as per Broadcom's driver
  o [TG3]: Add 5750 A3 workaround
  o [SPARC64]: Save/restore %asi properly in signal handling
  o [SPARC64]: Remove memcpy Ultra3 PCACHE patching trick
  o [SPARC64]: Use saner local label names in Ultra3 copies
  o [SPARC64]: Revamped memcpy infrastructure
  o [SPARC64]: Update defconfig
  o [SPARC64]: Remove memcpy/bzero symbol usage in sparc64_do_profile
  o [SPARC64]: Fix arg passing to copy_in_user()
  o [MAINTAINERS]: Update my email address
  o [CREDITS]: Update my email and home address
  o [TG3]: Add capacitive coupling support
  o [TG3]: Fix clock control programming on 5705/5750
  o [TG3]: Update driver version and reldate
  o [NETLINK]: Two cleanups

Dean Roehrich:
  o [XFS] Fix lock leak in xfs_free_file_space
  o [XFS] Change DMAPI dm_punch_hole to punch holes, rather than just truncate files.

Douglas Gilbert:
  o scsi_debug update
  o scsi_error.c: break out repeatable error retries when eh mode

Eric Sandeen:
  o [XFS] Add filesystem size limit even when XFS_BIG_BLKNOS is in effect; limited by page cache index size (16T on ia32)
  o [XFS] Code checks to trap access to fsb zero

Glen Overby:
  o [XFS] Permit buffered writes to the real-time subvolume

Jack Hammer:
  o ServeRAID driver (ips) Version 7.10.18

Jason Baron:
  o ppos cleanups

Jeff Garzik:
  o [libata] resync with 2.6 (very minor, mostly cosmetic)

Jeremy Higdon:
  o Fix DMA boundary overflow bug

Krzysztof Halasa:
  o fix for integer overflow in hd6457[02] driver code

Marcelo Tosatti:
  o Fix mm.h typo introduced by s390 changes
  o Changed EXTRAVERSION to -pre3

Margit Schubert-While:
  o prism54 Update to 2.6 status
  o prism54 Bug - Fix frequency reporting

Mikael Pettersson:
  o more gcc34 lvalue fixes
  o drivers/ide/pci/sc1200.c cast-as-lvalue fix

Nathan Scott:
  o [XFS] Documentation updates
  o [XFS] Export sync_buffers routine for filesystems to use
  o [XFS] Revert to using a separate inode for metadata buffers once more
  o [XFS] Remove unneeded escape from printed string.  From Chris Wedgwood
  o [XFS] sparse: annotate source for user pointers.  From Chris Wedgwood
  o [XFS] sparse: annotate quota source for user pointers.  From Chris Wedgwood
  o [XFS] Fix a possible data loss issue after an unaligned unwritten extent write.
  o [XFS] Fix xfs_off_t to be signed, not unsigned; valid warnings emitted after stricter compilation options used by some OSDL folks.
  o [XFS] xfs_Gqm_init cannot fail, dont check return value
  o [XFS] sparse: fix header include order to get cpp macros defined correctly.  From Chris Wedgwood.
  o [XFS] sparse: rework previous mods to fix warnings in DMAPI code
  o [XFS] sparse: fix uses of NULL in place of zero and vice versa
  o [XFS] Fix signed/unsigned issues in xfs_reserve_blocks routine
  o [XFS] Fix accidental reverting of sync write preallocations
  o [XFS] Fix a blocksize-smaller-than-pagesize hang when writing buffers with a shared page.
  o [XFS] Add support for unsetting realtime flag on realtime file which has no extents allocated.
  o [XFS] Remove several macros which are no longer used anywhere
  o [XFS] Use sparse whitespace approach that Al took to be more consistent
  o [XFS] Add a realtime inheritance bit for directory inodes so new files can be automatically created as realtime files.
  o [XFS] Support for default quota limits via the zero dquot (ala grace times)
  o [XFS] Ensure maxagi not updated early during growfs, conflicts with concurrent inode allocations.  Fix from ASANO Masahiro.

Olaf Kirch:
  o [NETFILTER]: Fix pointer deref'ing in ip6t_LOG.c

Patrick McHardy:
  o [PKT_SCHED]: Use double-linked list for dev->qdisc_list
  o [PKT_SCHED]: Fix class leak in CBQ scheduler
  o [NETFILTER]: Flush fragment queue on conntrack unload
  o [NETFILTER]: Fix confusing naming in NAT-helpers
  o [NETFILTER]: Fix deadlock condition in conntrack/nat-helpers

Paul Fulghum:
  o synclinkmp transmit eom fix

Stephen Hemminger:
  o [PKT_SCHED]: Sync netem scheduler with 2.6.x

Timothy Shimmin:
  o [XFS] Fix up handling of SB versionnum when filesystem on disk has newer bit features than the kernel.
  o [XFS] Fix up header length miscalculation for version 1 logs



Summary of changes from v2.4.28-pre1 to v2.4.28-pre2
============================================

<achew:nvidia.com>:
  o [libata sata_nv] support for hardware, bug fixes
  o [libata sata_nv] fix leak on error

<david.martinez:rediris.es>:
  o Update ftape webpage

<linville:tuxdriver.com>:
  o Add IOI Media Bay to SCSI quirk list

<mbroemme:plusserver.de>:
  o Fix kernel oops in nsc-ircc.c

<rainer.weikusat:sncag.com>:
  o bkgoodman@bradgoodman.com: MTD cfi_cmdset_0002.c - Duplicate cleanup in error path

<sezeroz:ttnet.net.tr>:
  o pm3fb and kaweth missing casts
  o ns83820.c warning fixes
  o cpqarray/cciss gcc3.4 inline fixes
  o ieee1394/hisax gcc 3.4 inline fixes
  o radio/video gcc3.4 inline fixes
  o mtd gcc3.4 inline fixes
  o net drivers gcc3.4 inline fixes
  o scsi drivers gcc3.4 inline fixes
  o USB gcc3.4 inline fixes
  o net gcc3.4 inline fixes
  o char gcc3.4 inline fixes
  o filesystems (fs/) gcc3.4 inline fixes
  o intermezzo gcc3.4 inline fixes
  o uninline do_generic_direct_read

<thor:math.tu-berlin.de>:
  o NetMOS 9805 ParPort interface

Adrian Bunk:
  o 2.4.28-pre1: add two SATA Configure.help entries
  o disallow modular BINFMT_ELF

Alan Cox:
  o [libata] improve translation of ATA errors to SCSI sense codes
  o ad1816 sound driver web page and email address update

Andrew Morton:
  o libata build fix

Badari Pulavarty:
  o scsi PHYS_4G merging doesn't work

Bartlomiej Zolnierkiewicz:
  o Fix IDE Triflex hang on boot with two single-channel controllers

Dan Zink:
  o PCI Hotplug: fix potential hang in cpqphp

Daniel Ritz:
  o enable read prefetch on o2micro bridges to fix HDSP
  o fix EnE Cardbus bridges for HDSP

David S. Miller:
  o [SPARC64]: Add missing nop to itlb_base.S

Dely Sy:
  o PCI Hotplug: Fixes for hot-plug drivers in 2.4 kernel

Douglas Gilbert:
  o [libata] fix INQUIRY handling

Gary Hade:
  o PCI Hotplug: change MAINTAINERS

Jeff Garzik:
  o [libata] (cosmetic) sync with 2.6.x
  o [libata] support commands SYNCHRONIZE CACHE, VERIFY, VERIFY(16)
  o [libata] fix PIO data xfer on big endian
  o [libata] ATAPI PIO data xfer
  o [libata] add ioctl infrastructure
  o [libata] fix error recovery reference count and in-recovery flag
  o [ata] remove 'packed' attributed from struct ata_prd

Marcelo Tosatti:
  o Changed EXTRAVERSION to -pre2

Martin Schwidefsky:
  o s390: core changes
  o s390: ibm partition table
  o s390: system tick misaccounting
  o s390: dasd changes
  o s390: ctc fixes
  o s390: iucv net driver fixes
  o s390: qeth network driver fixes

Mikael Pettersson:
  o gcc34 inline failure fixes

Neil Brown:
  o Allow larger NFSd MAXBLKSIZE on architectures with larger PAGE_SIZE
  o Fixed possibly xdr parsing error if write size exceed 2^31
  o Use llseek instead of f_pos= for directory seeking
  o mark NFS/TCP not EXPERIMENTAL

Patrick McHardy:
  o [RBTREE]: Add rb_{first,last,prev,next}
  o [NET_SCHED]: Replace eligible list by rbtree in HFSC scheduler
  o [NET_SCHED]: Replace actlist by rbtrees in HFSC scheduler
  o [NET_SCHED]: O(1) children vtoff adjustment in HFSC scheduler
  o [PKT_SCHED]: Remove unnecessary memsets in packet schedulers

Pete Zaitcev:
  o USB: update unusual_devs.h
  o USB: remove "interrupt, status %x, frame# %i"
  o The Dell's fix for TEAC CD-210PU


Summary of changes from v2.4.27 to v2.4.28-pre1
============================================

<achew:nvidia.com>:
  o [libata] Add NVIDIA SATA driver
  o [ata] fix reversed bit definitions in linux/ata.h
  o [libata] unmap MMIO region _after_ last possible usage

<ajgrothe:yahoo.com>:
  o [CRYPTO]: Add Khazad algorithm

<alanh:fairlite.demon.co.uk>:
  o AGPgart update: Intel i915G support

<castor:3pardata.com>:
  o Add 3PARdata InServ Virtual Volume to SCSI device list

<frank_borich:us.xyratex.com>:
  o Add Xyratex 4200 to SCSI blacklist

<ha505:hszk.bme.hu>:
  o Fix i2o_pci.c warning
  o Extra tokens at #undef in ma600.c
  o Missing enforced type conversion in pc300_tty.c
  o Redefinition before undefinition in pci-pc.c
  o Redefination before undefination in fore200e.c

<jon:oberheide.org>:
  o [CRYPTO]: Email update in crypto/arc4.c

<joshk:triplehelix.org>:
  o [SPARC]: Add missing GPL module license tags to drivers

<mcgrof:ruslug.rutgers.edu>:
  o [wireless] add new prism54 driver

<sergio.gelato:astro.su.se>:
  o libata: fix kunmap() of incorrect page, in PIO data xfer

<sezeroz:ttnet.net.tr>:
  o agpgart: Missing chipset enum entry for i915
  o warning fixes: ULL-fixes
  o warning fixes: befs trivial
  o trivial iph5526.c fixes from 2.6
  o trivial nwflash.c missing -EFAULT retcode
  o backport applicom 2.6 fixes
  o trivial: various "unused" warnings
  o amd76xrom.c unused warning

Adrian Bunk:
  o 2.6.7-mm1: drivers/scsi/hosts.h -> scsi/scsi_host.h
  o update email address of Pedro Roque Marques

Bartlomiej Zolnierkiewicz:
  o DMA mode setup fixes for piix.c/ata_piix.c

Chris Wright:
  o fix possible buffer overflow in panic()

Daniel Ritz:
  o PCI: fix irq routing on acer travelmate 360 laptop

David Dillow:
  o [SPARC64]: Handle SBUS dma allocations larger than 1MB

David S. Miller:
  o [SPARC64]: Document reserved and soft2 bits in PTE
  o [SPARC64]: Reserve a software PTE bit for _PAGE_EXEC
  o [SPARC64]: Non-executable page support
  o [SPARC64]: Duh, s/_PAGE_FILE/_PAGE_EXEC/
  o [SPARC64]: Add CMT register defines
  o [SPARC64]: Kill all this silly inline memcpy handling
  o [SPARC64]: Simplify and optimize ultra3 memory copies
  o [SPARC64]: More entropy in add_timer_randomness

James Morris:
  o [CRYPTO]: Typo in Documentation/Configure.help
  o [CRYPTO]: Typo in crypto/twofish.c
  o [CRYPTO]: Typo in crypto/aes.c
  o [CRYPTO]: Typo in crypto/scatterwalk.c
  o [CRYPTO]: Typo in crypto/blowfish.c
  o [CRYPTO]: Typo in crypto/tcrypt.h

Jeff Garzik:
  o [libata] don't probe from workqueue
  o [libata] PCI IDE DMA code shuffling
  o [libata] PCI IDE command-end/irq-acknowledge cleanup
  o [libata] ->qc_prep hook
  o [libata] Add Intel ICH5/6 driver
  o [IDE] Introduce SATA enable/disable config option
  o [libata ata_piix] disable combined mode
  o [libata/IDE nvidia] shuffle pci ids
  o [libata] move some code around
  o [libata] fix build error, minor cleanups
  o [libata ata_piix] combined mode bug fix; improved ICH6 support
  o [libata sata_sil] Re-fix mod15write bug
  o [libata] add ->qc_issue hook
  o [libata] add ata_queued_cmd completion hook
  o [libata] create, and use, ->irq_clear hook
  o [ata] add ata_ok() inlined helper, and ATA_{DRDY,DF} bit to linux/ata.h
  o [libata] split ATA_QCFLAG_SG into ATA_QCFLAG_{SG,SINGLE}
  o [libata] create, and use aga_sg_init[_one] helpers
  o [libata sata_promise] update driver to use new ->qc_issue hook
  o [libata] transfer mode cleanup
  o [libata] fix completion bug, better debug output
  o [libata] transfer mode bug fixes and type cleanup
  o [libata] pio/dma flag bug fix, and cleanup
  o [libata] convert set-xfer-mode operation to use ata_queued_cmd
  o [libata sata_promise] convert to using packets for non-data taskfiles
  o [libata sata_sx4] deliver non-data taskfiles using Promise packet format
  o [libata] update IDENTIFY DEVICE path to use ata_queued_cmd
  o [libata] export msleep for use in libata drivers
  o [libata] ATAPI work - PIO xfer, completion function
  o [libata ata_piix] make sure AHCI is disabled, if h/w is used by this driver
  o [libata] flags cleanup
  o [libata] ATAPI work - cdb len, new taskfile protocol, cleanups
  o [libata] fix a 2.6-ism that snuck in

Liam Girdwood:
  o Fix unsafe reset in ac97_codec.c, support WM9713, more fixes

Marcelo Tosatti:
  o Herbert Xu: delete zero sized files from BK repository
  o Changed Makefile to 2.4.28-pre1

Martin Devera:
  o [PKT_SCHED]: Fix borrowing fairness in htb

Mikael Pettersson:
  o gcc-3.4 fixes 1/3: fastcall mismatches
  o gcc-3.4 fixes 2/3: bogus lvalues
  o gcc-3.4 fixes 3/3: misc remaining issues

Mike Miller:
  o cciss update [1/5] PCI ID fix for cciss SATA hba
  o cciss update [2/5] fix for 32/64-bit conversions
  o cciss update [3/5] pci_dev->irq fix
  o cciss update [4/5] fix for HP utilities
  o cciss update [5/5] maintainers update for HP drivers

Pat LaVarre:
  o ata_check_bmdma
  o SATAPI despite no data

Pete Zaitcev:
  o David Brownell: Fix uhci-hcd oops

Richard Hitt:
  o s390x: enable ioctl's for UTS global 3270
  o UTS Global Cisco CLAW driver: avoid packets from being lost under heavy load
  o UTS Global Cisco CLAW driver: remove old ifdefs and adds GPL header
  o UTS Global Cisco CLAW driver: Fix 64-bit handling

Ricky Beam:
  o [libata sata_sil] add drive to mod15write quirk list

Rik van Riel:
  o reserved buffers only for PF_MEMALLOC

Sridhar Samudrala:
  o [SCTP] SPARSE cleanup backported from 2.6
  o [SCTP] Set/Get default SCTP_PEER_ADDR_PARAMS for endpoint when associd and peer address are 0.
  o [SCTP] Fix data not being delivered to user in SHUTDOWN_SENT state
  o [SCTP] Fix issues with handling stale cookie error over multihoming associations.
  o [SCTP] Fix missing '+' in the computation of sack chunk size in sctp_sm_pull_sack().
  o [SCTP] Mark chunks as ineligible for fast retransmit after they are retransmitted. Also mark any chunks that could not be fit in the PMTU sized packet as ineligible for fast retransmit.

Tom 'spot' Callaway:
  o [SPARC]: Fix copy_user.S with gcc 3.3

William Lee Irwin III:
  o [SPARC32]: Mark William Lee Irwin III as maintainer
  o Fix OOM killer issues: kill all threads of a process and ignore kernel threads
  o OOM killer: make jiffies comparison wrap safe

