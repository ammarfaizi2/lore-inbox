Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264039AbUDNNPl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 09:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264212AbUDNNPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 09:15:41 -0400
Received: from hera.kernel.org ([63.209.29.2]:27627 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S264039AbUDNNOm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 09:14:42 -0400
Date: Wed, 14 Apr 2004 06:14:37 -0700
From: Marcelo Tosatti <marcelo@hera.kernel.org>
Message-Id: <200404141314.i3EDEbxv023592@hera.kernel.org>
To: linux-kernel@vger.kernel.org
Subject: linux-2.4.26 released
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

final:

- 2.4.26-rc4 was released as 2.4.26 with no changes.


Summary of changes from v2.4.26-rc3 to v2.4.26-rc4
============================================

<john.l.byrne:hp.com>:
  o do_fork() error path memory leak

Ernie Petrides:
  o fix potential iso9660 symlink overflow

Marcelo Tosatti:
  o Nathan Scott: Export the PPC vmalloc_start and ioremap_bot symbols for modules using VMALLOC_START and VMALLOC_END (XFS uses these, for example)
  o Changed EXTRAVERSION to -rc4


Summary of changes from v2.4.26-rc2 to v2.4.26-rc3
============================================

<joel.becker:oracle.com>:
  o Add Xserve RAID LUN to SCSI whitelist

Andi Kleen:
  o Handle node zero with no memory on x86-64

Andrew Morton:
  o sk_mca multicast fix

Chris Wright:
  o fix load_elf_binary error path on unshare_files error
  o fix another load_elf_binary error path

Dave Kleikamp:
  o JFS: Add lots of missing statics and remove dead code
  o JFS: Prevent hang in __lock_metapage
  o JFS: Fix race in jfs_sync

Ivan Kokshaysky:
  o Herbert Xu: Fix Alpha unaligned stxncpy again

Marcelo Tosatti:
  o Martin Schulze: Improve r128 DRM driver checks
  o Changed EXTRAVERSION to -rc3

Pete Zaitcev:
  o USB update
  o Fix SMP issues with USB-storage/ohci-hcd

Stephen Rothwell:
  o make 2.4 boot when built with gcc 3.4



Summary of changes from v2.4.26-rc1 to v2.4.26-rc2
============================================

<uaca:alumni.uv.es>:
  o [AF_PACKET]: Fix packet_set_ring memleak and remove num frame limit
  o [AF_PACKET]: Add PACKET_MMAP documentation

Andi Kleen:
  o Use correct optimization flag for Nocona on x86-64

Bartlomiej Zolnierkiewicz:
  o ATI IXP IDE support
  o hpt366.c: DMA timeout fix for HPT374

Chas Williams:
  o [ATM]: mpoa_proc warning cleanup (from Willy TARREAU <willy@w.ods.org>)

Christoph Hellwig:
  o [XFS] fix for read/write buffers larger than 2GB on 64 bit platforms
  o [XFS] Fix r/o check in xfs_ioc_space, fix checks on xfs_swapext validity

David S. Miller:
  o [IPV6]: Fix ipv6_skip_exthdr prototype in net/ipv6.h

David Stevens:
  o [IPV4]: Fix IGMPv3 timer initialization when device not 'upped'

Glen Overby:
  o [XFS] Add space for inode and allocation btrees to ITRUNCATE log reservation

Harald Welte:
  o [NETFILTER]: Fix DEBUG compile in ipt_MASQUERADE
  o [NETFILTER]: Fix DELETE_LIST oopses
  o [NETFILTER]: Fix circular conntrack header file dependency

Hideaki Yoshifuji:
  o [CREDITS]: Update my affiliation

Ivan Kokshaysky:
  o Workaround Alpha "gcc3 < 3.3.3" raid1 miscompilation problem

Len Brown:
  o [ACPI] allow building ACPI w/ CMPXCHG when CONFIG_M386=y http://bugzilla.kernel.org/show_bug.cgi?id=2391
  o [ACPI] delete extraneous IRQ->pin mappings below IRQ 16 http://bugzilla.kernel.org/show_bug.cgi?id=2408
  o [ACPI] PCI bridge interrupt fix (David Shaohua Li) http://bugzilla.kernel.org/show_bug.cgi?id=2409
  o [ACPI] Restore PIC-mode SCI default to Level Trigger (David Shaohua Li) http://bugme.osdl.org/show_bug.cgi?id=2382

Marcelo Tosatti:
  o Changed EXTRAVERSION to -rc2

Matt Porter:
  o PPC32: PPC44x updates (fixes and 440GX machine check support)
  o PPC32: Add new PPC44x PVRs

Meelis Roos:
  o SanDisk is flash

Mike Miller:
  o cciss update: support the new MSA30 storage enclosure
  o cciss update: If no device attached we return -ENXIO instead of some bogus numbers

Nathan Scott:
  o [XFS] Remove dup fdatasync/fdatawait call on fsync.  Means we no longer take the iolock here, and readers no longer conflict with concurrent fsync activity.  Kudos to Steve!
  o [XFS] Reinstate some accidentally dropped log IO error injection code
  o [XFS] Fix shortform attr flags botch affecting listxattr - from Andreas Gruenbacher
  o [XFS] Disallow logbufs=0 unless correct config options used, else we panic
  o [XFS] Ensure sb not flushed async on a SYNC_WAIT sync.  Fixed by Bart Samwel

Nathan Straz:
  o [XFS] Fix signed offset overflow when checking writes at end of file

Nivedita Singhvi:
  o [TCP]: Use tcp_tw_put on time-wait sockets
  o [TCP]: IPV6, do not use sock_put() on timewait sockets

Paul Mackerras:
  o [PPC64] Fix && vs. & error noticed by Julie DeWandel

Russell Cattelan:
  o [XFS] Use refile_buffer to not leave clean buffers on the dirty list

Sridhar Samudrala:
  o [SCTP]: Fix xconfig, from Vladislav Yasevich

Timothy Shimmin:
  o [XFS] Modify xfs_iaccess() for CAP_DAC_OVERRIDE and CAP_DAC_READ_SEARCH
  o [XFS] Be explicit in adding in the non-transactional data to the reservation estimate.  We must add in for the worst case of a log stripe taking us the full distance for a log stripe boundary.

Urban Widmark:
  o smbfs transact2 with win9x

Willy Tarreau:
  o [IPV6]: Make skb arg to ipv6_skip_exthdr const


Summary of changes from v2.4.26-pre6 to v2.4.26-rc1
============================================

Chas Williams:
  o [ATM]: [lec] lec_push() races with vcc->proto_data
  o [ATM]: [nicstar] use kernel min/max (by Randy.Dunlap <rddunlap@osdl.org>)

David S. Miller:
  o [IGMP]: Do nothing in ip_mc_down() if ip_mc_up() was not called previously
  o [SPARC64]: Update defconfig

Dmitry Torokhov:
  o [NET_SCHED]: Fix class reporting in TBF qdisc
  o [NET_SCHED]: Trailing whitespace cleanup in TBF scheduler

Jon Oberheide:
  o [CRYPTO]: Remove confusing TODO comment in arc4.c

Julian Anastasov:
  o [IPVS] Fix to update the skb->h.raw after skb reallocation in tunnel_xmit
  o [IPVS] Fix connection rehashing with new cport

Len Brown:
  o [ACPI] PCI interrupt link routing (Luming Yu) use _PRS to determine resource type for _SRS fixes HP Proliant servers http://bugzilla.kernel.org/show_bug.cgi?id=1590
  o [ACPI] proposed fix for non-identity-mapped SCI override http://bugme.osdl.org/show_bug.cgi?id=2366
  o [ACPI] ACPICA 20040326 from Bob Moore
  o [ACPI] Linux specific updates from ACPICA 20040326 "acpi_wake_gpes_always_on" boot flag for old GPE behaviour

Marcel Holtmann:
  o [Bluetooth] Add support for AVM BlueFRITZ! USB v2.0
  o [Bluetooth] Remove non-blocking socket fix

Marcelo Tosatti:
  o Trond: Avoid refile_inode() from putting locked inodes on the dirty list
  o Changed EXTRAVERSION to -rc1

Martin Devera:
  o [NET_SCHED]: HTB scheduler updates

Patrick McHardy:
  o [NET_SCHED]: Fix broken indentation in HFSC scheduler
  o [NET_SCHED]: Fix requeueing in HFSC scheduler
  o [NET_SCHED]: Use queue limit of 1 when tx_queue_len is zero

Sridhar Samudrala:
  o [SCTP] Don't do any ppid byte-order conversions as it is opaque to SCTP
  o [SCTP] Avoid the use of hacking CONFIG_IPV6_SCTP__ option

Stephen Hemminger:
  o [NET_SCHED]: Add packet delay scheduler

Wensong Zhang:
  o [IPVS]: Fix to hold the lock before updating a service


Summary of changes from v2.4.26-pre5 to v2.4.26-pre6
============================================

<davem:nuts.davemloft.net>:
  o [SPARC64]: Update defconfig
  o [SPARC64]: Fix sys32_mount type arg handling

<len.brown:intel.com>:
  o [ACPI] check "maxcpus=N" early -- same as NR_CPUS check
  o [ACPI] clean up acpi_disabled use __initdata on IA64 was a bug since it is referenced by modules.
  o [ACPI] create disable_acpi()
  o [ACPI] fix interrupt behind yenta cardbus bridge (David Shaohua Li) http://bugzilla.kernel.org/show_bug.cgi?id=1564
  o [ACPI] delete POWER_OF_2 array (Pavel Machek)
  o [ACPI]   toshiba_acpi 0.18 from John Belmonte add missing copyin
  o [ACPI] ACPI SCI shall be level/low unless explicit over-ride http://bugzilla.kernel.org/show_bug.cgi?id=1622 add "acpi_sci=edge" and "acpi_sci=high" manual over-ride

<marcelo:logos.cnet>:
  o Avoid readahead from reading last page of file
  o Changed EXTRAVERSION to -pre6

<mlord:pobox.com>:
  o Fix bogus vmalloc() vm_area_free_pages call

Andi Kleen:
  o x86-64 update: simple support for IA32e/EM64T

Daniel Ritz:
  o yenta pcmcia driver: add some cardbus bridges to override lis

Geert Uytterhoeven:
  o Mac baboon warning
  o Amiga Oktagon URL
  o Mac missing include
  o M68k keyboard

Jeff Garzik:
  o [MAINTAINERS] remove defunct linux-via mailing list
  o [scsi] export scsi_finish_command
  o [pci] add a couple of constants

Trond Myklebust:
  o NFS: Make sure that fsync() flushes all pending file data to disk. The current call to nfs_wb_file() will fail to flush out mmapped() dirty pages.
  o NFS: make sure we revalidate attributes on completing a rename(): the server should normally update the ctime...


Summary of changes from v2.4.26-pre4 to v2.4.26-pre5
============================================

<brill:fs.math.uni-frankfurt.de>:
  o USB Storage: unusual_devs.h entry submission

<dledford:build-base.perf.redhat.com>:
  o scsi_lib.c: Fix sg segment recounting
  o Fix various minor compiler warning issues
  o Fix for Red Hat bug #98264, usb reset locking problem
  o sym53c8xx:  Only do SCSI-3 PPR message based negotiations on SCSI-3 devices or SCSI-2 devices that know to set the DT bit in their INQUIRY return data.
  o scsi_scan.c: Correctness fix for scanning of multi-lun devices
  o scsi_scan.c: Add an option for making linux treat offlined devices as online
  o Update the error handler to use mod_timer
  o Don't leak command structs when no device is found

<jamesl:appliedminds.com>:
  o USB: Fixing HID support for non-explicitly specified usages

<michal_dobrzynski:mac.com>:
  o USB: add IRTrans support to ftdi_sio driver

<mlotek:foobar.pl>:
  o USB: another unusual_devs.h change

<not:just.any.name>:
  o USB: Using physical extents instead of logical ones for NEC USB HID gamepads

<pg:futureware.at>:
  o USB: more FTDI-SIO devices

<rene.herman:keyaccess.nl>:
  o 8139too assertions

<ricklind:us.ibm.com>:
  o block layer accounting fix

Alan Stern:
  o USB: fix unneeded SubClass entry in unusual_devs.h

Dave Kleikamp:
  o JFS: zero new log pages, etc

David Brownell:
  o USB Gadget: ethernet gadget locking tweaks
  o USB: EHCI updates (mostly periodic schedule scanning)
  o USB Gadget: make usb gadget strings talk utf-8
  o USB: add "gadget_chips.h"
  o USB: gadget config buffer utilities
  o USB: usb gadget, dualspeed {run,compile}-time flags
  o USB: gadget zero, simplified controller-specific configuration

Don Fry:
  o pcnet32 correct names for changes
  o pcnet32.c oops

Greg Kroah-Hartman:
  o USB: add support for the Aceeca Meazura device to the visor driver

Ian Abbott:
  o USB: ftdi_sio new PIDs and name fix for sysfs

Jeff Garzik:
  o Update pci_ids.h with new Intel PCI ids
  o Add Intel ICH6 irq router
  o Add Intel PCI ids to i810_audio
  o Add Intel PCI ids to IDE (PATA) driver
  o [netdrvr natsemi] Fix RX DMA mapping

Kumar Gala:
  o [PPC32] Modified OCP support so its not IBM specific and added new APIs to allow modification of the device tree before drivers are bound

Len Brown:
  o [ACPI] acpi_wakeup_address - print only when broken
  o [ACPI] global lock macro fixes (Paul Menage, Luming Yu) http://bugzilla.kernel.org/show_bug.cgi?id=1669
  o [ACPI] SMP poweroff (David Shaohua Li) http://bugzilla.kernel.org/show_bug.cgi?id=1141
  o [ACPI] ACPICA 20040311 from Bob Moore
  o [ACPI] add boot parameters "acpi_osi=" and "acpi_serialize" acpi_osi= will disable the _OSI method -- which by default tells the BIOS to behave as if Windows is the OS.

Luca Tettamanti:
  o USB: fix hid-core compile warning

Manfred Spraul:
  o forcedeth update

Marcelo Tosatti:
  o Changed EXTRAVERSION to -pre5

Martin Diehl:
  o USB: fix stack usage in pl2303 driver

Paul Mackerras:
  o [PPC32] Add support for the EP405/EP405PC embedded platforms
  o [PPC32] Avoid prefetching past the end of the source in copy routines
  o [PPC32] Add stabs debug entries to some assembler files
  o [PPC32] Add support for the Redwood 5 and 6 embedded boards

Paulo Marques:
  o USB: usblp.c (Was: usblp_write spins forever after an error)

Per Winkvist:
  o USB Storage: unusual devs fix for Pentax cameras

Pete Zaitcev:
  o USB: Change the USB Maintainer entry
  o USB: fix hid-input problem with BTC keyboards
  o Trivial input.c change: Add missing new line on error case printk()

Petko Manolov:
  o USB: patch for pegasus.h
  o USB: another patch to pegasus.h

Richard Curnow:
  o USB: Fix handling of bounce buffers by rh_call_control

Stelian Pop:
  o sonypi driver update
  o meye driver update

Thomas Chen:
  o USB: fix little bug in io_edgeport.c

Thomas Sailer:
  o USB: OSS audio driver workaround for buggy descriptors


Summary of changes from v2.4.26-pre3 to v2.4.26-pre4
============================================

<colin:gibbsonline.net>:
  o [NET_SCHED]: Use time_after, fixes htb on 64-bit arch

<mlord:pobox.com>:
  o Yet another vmalloc() fixup

<tuncer.ayaz:gmx.de>:
  o [IPVS]: Fix typo in Config.in

Angelo Dell'Aera:
  o [TCP]: Kill westwood bw_sample, set but not used

Bartlomiej Zolnierkiewicz:
  o small cleanup for AMD/nVidia IDE driver
  o IDE AMD/nForce driver update
  o amd74xx.c: fix for !CONFIG_PROCFS
  o fix IDE build for CONFIG_PROC_FS=n
  o new Medley software RAID driver

David S. Miller:
  o [SPARC64]: Handle failed vmalloc_area_pages in module_map correctly
  o [SPARC64]: Update defconfig

Marcel Holtmann:
  o [Bluetooth] Fix race for incoming connections
  o [Bluetooth] Fix error handling for not connected socket
  o [Bluetooth] Fix several copy_to_user() glitches
  o [Bluetooth] Fix non-blocking socket race conditions
  o [Bluetooth] Copy all L2CAP signal frames to the raw sockets
  o [Bluetooth] Send HCI_Reset for some Broadcom dongles

Marcelo Tosatti:
  o Changed EXTRAVERSION to -pre4

Theodore Y. T'so:
  o zerout JBD journal descriptor blocks


Summary of changes from v2.4.26-pre2 to v2.4.26-pre3
============================================

<andikies:t-online.de>:
  o sb16 sample size fix

<dan:geefour.netx4.com>:
  o Updates to the bootloader code due to changes from immap to cpm2
  o Add the RPC/EP 8260 board to the configuration for testing the new cpm2 updates.

<hjm:redhat.com>:
  o Fix LVM snapshot oversized sector calculation

<jbaron:redhat.com>:
  o mremap NULL pointer dereference fix

<mlord:pobox.com>:
  o Fix vmalloc() spinlocking issues introduced by the "error handling fixes"

Adrian Bunk:
  o agpgart_be.c: remove duplicate PCI_DEVICE_ID_SI_651

Andrew Morton:
  o [CRYPTO]: arc4.c compile fix for older gcc's

Arun Sharma:
  o ia64: Fix and optimize sys32_rt_sigtimedwait()

Bjorn Helgaas:
  o ia64: (acpi_hp_csr_space): Export only if CONFIG_ACPI
  o ia64: Tidy up MCA printk's
  o ia64: (desc_abi): Check for Linux ABI # (3) instead of SysV4 ABI # (0)
  o ia64: unwind: Add some UNW_DEBUG stuff and remove KDB bits to follow 2.6
  o ia64: Use __builtin_trap() in BUG() when available
  o ia64: Remove obsolete sigcontext comment

David Mosberger:
  o ia64: Drop copyright notices on header files which are either entirely trivial
  o ia64: Back-port from libunwind: fix off-by-one error in kernel-unwinder
  o ia64: Fix bug in ia64_get_scratch_nat_bits()/ia64_put_scratch_nat_bits()

David S. Miller:
  o [TIGON3]: tg3_phy_copper_begin() tweaks
  o [TIGON3]: Allow MAC address changing even when iface is up
  o [TIGON3]: Always force PHY reset after major hw config changes
  o [TIGON3]: Update driver version and reldate

David Stevens:
  o [IPV4]: Add sysctl for per-socket limit on number of mcast src filters
  o [IPV4/IPV6]: Add sysctl limits for mcast src filters

Grant Grundler:
  o [TIGON3]: Consolidate MMIO write flushing using tg3_f() macro

Keith Owens:
  o ia64: Avoid deadlock when using printk() for MCA and INIT records
  o ia64: Delete all MCA/INIT/etc record printing code, moved to salinfo_decode in user space.
  o ia64: Mark MCA variables and functions static where possible
  o ia64: Delete dead variables and functions from mca.c
  o ia64: Reorder mca.c to remove the need for forward declarations and to consolidate related code.
  o ia64: Synchronize mca.c with 2.6.  White space, comment, #ifdef, etc
  o ia64: MCA, salinfo: calculate irq_safe once and pass it around
  o ia64: Correct "did we recover from MCA" test and move up a level
  o ia64: Periodically check for outstanding MCA or INIT records
  o ia64: remove include/asm-ia64/offset.hs in "make mrproper"
  o ia64: Delete redundant ia64_mca_check_errors
  o ia64: update unwind with 2.6 fixes
  o ia64: add OEM data decode for SGI MCA handler
  o ia64: copy SAL records so we don't drop them when events occur fast

Kumar Gala:
  o [PPC32] imported in CPM 8260_io drivers from linuxppc_2_4_devel tree
  o [PPC32] Added support ADS 8272 board
  o [PPC32] Renamed 8260 CPM handling to CPM2.  This is to allow reuse of CPM2 code between PQ2 and PQ3 devices.  8xx is considered CPM1
  o [PPC32] Renamed 8260 CPM handling to CPM2.  This allows reuse of CPM2 code between PQ2 and PQ3 devices.  8xx is considered CPM1

Marcelo Tosatti:
  o Ogawa Hirofumi: fix FAT over NFSv2
  o Change LAN media MAINTAINERS entry to Orphan
  o Changed EXTRAVERSION to -pre3

Patrick McHardy:
  o [PKT_SCHED]: Fix ipv6 ECN marking in RED scheduler

Thomas Winischhofer:
  o sisfb update

Trond Myklebust:
  o A patch to fix an Oops in the locking code
  o Slight optimization to the NFS writes
  o A patch by Greg Banks that increases the supported NLM cookie size. This is needed in order to work correctly with Apple and FreeBSD clients.
  o A patch by Patrice Dumas that ensures that the server index blocks uniquely by using the client address in addition to the value of the NLM cookie field.
  o A patch by Greg Banks to help fix the "VFS: Busy inodes after unmount." problem that occurs if autofs expires the mountpoint while an NFS sillydelete is still pending.
  o I have a feeling the second race case of your test is that you are interrupting the fcntl(F_SETLK) call while it is on the wire. If you do that, then the server may record the lock as taken, but the client will never receive the reply, and so will not know that it must clean up locks...

Wensong Zhang:
  o [IPVS]: Code tidy up



Summary of changes from v2.4.26-pre1 to v2.4.26-pre2
============================================

<dolbeau:irisa.fr>:
  o Small fix to pm3fb & MAINTAINERS

<i.palsenberg:jdirmedia.nl>:
  o [QLOGIC]: Mark mbox_param[] as static to avoid namespace pollution

<jon:focalhost.com>:
  o [CRYPTO]: Add ARC4 module

<jpk:sgi.com>:
  o [XFS] Merge missing mount stripe-unit/width-alignment check over from IRIX

<mlord:pobox.com>:
  o Fix vmalloc() error handling

Chas Williams:
  o [ATM]: [lec] timer cleanup
  o [ATM]: [lec] send queued packets immediately after path switch

Christoph Hellwig:
  o [XFS] Simplify pagebuf_rele / pagebuf_free
  o [XFS] Stop using sleep_on
  o [XFS] Plug a pagebuf race that got bigger with the recent cleanup
  o [XFS] Fix gcc 3.5 compilation for real
  o [XFS] Fix buffer teardown on _pagebuf_lookup_pages failure
  o [XFS] Remove the lockable/not lockable buffer distinction.  All metada buffers are lockable these days.
  o [XFS] Remove PBF_MAPPABLE
  o [XFS] plug a pagebuf leak
  o [XFS] "backport" d_alloc_anon (this time for real)
  o [XFS] Avoid NULL returns from pagebuf_get
  o [XFS] use generic XFS stats and sysctl infrastructure in pagebuf
  o [XFS] Fix up daemon names
  o [XFS] only lock pagecache pages
  o [XFS] plug race in pagebuf freeing
  o [XFS] kill some dead constants from pagebuf

David S. Miller:
  o [SUNGEM]: At end of RX completion chain, double check OWN bit with completion register
  o [IPV4]: Do not return -EAGAIN on blocking UDP socket, noticed by Olaf Kirch
  o [NET]: Set default socket rmem/wmem values more sanely and consistently
  o [IPV6]: UDPv6 needs recvmsg csum error path fix too, thanks Olaf
  o [SCTP]: Ranem MSECS_TO_JIFFIES to avoid conflict with IRDA
  o [SCTP]: Comment out buggy ipv6 debugging printk
  o [SPARC64]: Update defconfig
  o [SPARC]: Pass a real page into do_mount() a final arg
  o [SPARC]: Update defconfig

David Stevens:
  o [IGMP/MLD]: Verify MSFILTER option length
  o [IGMP/MLD]: Check for numsrc overflow, plus temp buffer tweaks

David Woodhouse:
  o [IPV6]: Init ipv6 before ipv4 if built statically into kernel

Dean Roehrich:
  o [XFS] Change DM_SEM_FLAG to DM_SEM_FLAG_RD

Don Fry:
  o 2.4.25 pcnet32.c SLAB_DEBUG length error fix
  o 2.4.25 pcnet32.c transmit hang fix
  o 2.4.25 pcnet32.c wrong vendor ID fix
  o 2.4.25 pcnet32.c oops in rmmod
  o 2.4.25 pcnet32.c bus master arbitration failure fix
  o 2.4.25 pcnet32.c convert to use netif_msg_*
  o 2.4.25 pcnet32.c change to use ethtool_ops
  o pcnet32.c handle failures in open
  o pcnet32.c another diff error fix
  o pcnet32.c non-mii errors with ethtool
  o pcnet32.c add .remove to pci_driver
  o pcnet32.c adds loopback test
  o pcnet32.c avoid transmit hang for 79C791
  o pcnet32 non-mii link state fix

Eric Sandeen:
  o [XFS] Add switches to make xfs compile when the nptl patch is present
  o [XFS] Remove some dead debug code
  o [XFS] Make more xfs errors trappable with panic_mask
  o [XFS] zero log buffer during initialization at mount time

François Romieu:
  o [netdrvr r8169] fix TX descriptor overflow

Geert Uytterhoeven:
  o [netdrvr tulip] fix up 21041 media selection

Harald Welte:
  o [NETFILTER]: Kill bogus const in list helpers
  o [NETFILTER]: Fix ECN target cloned skb problem
  o [NETFILTER]: Remove unused structure member in NAT, from Patrick McHardy

James Morris:
  o [CRYPTO]: Backport Christophe Saout's 2.6.x scatterlist code extraction

Jean Delvare:
  o Identify Radeon Ya and Yd in radeonfb

Len Brown:
  o ACPI URL update
  o [ACPI] interrupt over-ride for nforce from Maciej W. Rozycki
  o [ACPI] delete unnecessary dmesg lines, fix spelling
  o [ACPI] include CONFIG_ACPI_RELAXED_AML code always add acpi=strict option to disable platform workarounds
  o [ACPI] ACPICA 20040220 from Bob Moore
  o [ACPI] fix ia64 build error (Bjorn Helgaas)

Marcelo Tosatti:
  o devfs: Fix truncation of mount data as 2.6
  o Changed EXTRAVERSION to -pre2

Matthias Andree:
  o [NET]: Export sysctl_optmem_max to modules

Nathan Scott:
  o [XFS] Fix a trivial compiler warning, remove some no-longer-used macros
  o [XFS] Use list_move for moving pagebufs between lists, not list_add/list_del
  o [XFS] Fix compile warning, ensure _pagebuf_lookup_pages return value is inited
  o [XFS] Fix data loss when writing into unwritten extents while memory is being reclaimed
  o [XFS] Remove bogus assert I added during testing of previous unwritten fix
  o [XFS] Add I/O path tracing code, twas useful in diagnosing that last unwritten extent problem
  o [XFS] Use a naming convention here thats more consistent with everything else
  o [XFS] Fix BUG in debug trace code, it was plain wrong for the unmapped page case
  o [XFS] Fix the by-handle attr list interface (used by xfsdump) for security attrs
  o [XFS] Fix length of mount argument path strings, off by one
  o [XFS] release i_sem before going into dmapi queues
  o [XFS] Remove PBF_SYNC buffer flag, unused for some time now
  o [XFS] Sort out some minor differences between trees
  o [XFS] Fix a compiler warning from a redefined symbol

Shmulik Hen:
  o bonding: Add support for HW accel. slaves
  o bonding: Add VLAN support in TLB mode
  o bonding: Add VLAN support in ALB mode

Simon Barber:
  o [NET]: Capture skb->protocol after invoking bridge

Simon Horman:
  o [JHASH]: Make key arg const in jhash()

Sridhar Samudrala:
  o [SCTP] Fix packed attribute usage
  o [SCTP] Fix NIP6 macro to take a ptr to struct in6_addr
  o [SCTP] Fix incorrect INIT process termination with sinit_max_init_timeo

Timothy Shimmin:
  o [XFS] Add XFS_FS_GOINGDOWN interface to xfs
  o [XFS] Fix log recovery case when have v2 log with size >32K and we have a Log Record wrapping around the physical log end. Need to reset the pb size back to what we were using and NOT just 32K.
  o [XFS] Version 2 log fixes - remove l_stripemask and add v2 log stripe padding to ic_roundoff to cater for pad in reservation cursor updates.
  o [XFS] fix up some log debug code for when XFS_LOUD_RECOVERY is turned on

Xose Vazquez Perez:
  o more RTL-8139 clone boards
  o more ne2k-pci clone boards

Yasuyuki Kozakai:
  o [IPV6]: Fix frag hdr parsing in ipv6_skip_exthdr()
  o [IPV6]: Fix ip6_tables TCP/UDP matching when ipv6 ext hdr exists



Summary of changes from v2.4.25 to v2.4.26-pre1
============================================

<amir.noam:intel.com>:
  o bonding cleanup 2.4 - Re-org struct bonding members
  o bonding cleanup 2.4 - Consolidate conditions & statements
  o bonding cleanup 2.4 - Consolidate error handling in all xmit functions
  o bonding cleanup 2.4 - Whitespace cleanup
  o bonding cleanup 2.4 - empty lines cleanup
  o bonding cleanup 2.4 - fix indentations
  o bonding cleanup 2.4 - Code re-org
  o bonding cleanup 2.4 - Fix rejects from previous patches
  o [netdrvr bonding] Cannot remove and re-enslave the original active slave
  o [netdrvr bonding] Releasing the original active slave causes mac address duplication
  o [netdrvr bonding] Add support for slaves that use ethtool_ops
  o [netdrvr bonding] fix build breakage
  o [bonding 2.4] Fix compilation warning in bond_alb.c
  o [bonding 2.4] Use the per-bond value of the bond_mode parameter
  o [bonding 2.4] Save parameters in a per-bond data structure
  o [bonding 2.4] Use the per-bond values of all remaining parameters

<bengen:hilluzination.de>:
  o HiSax I-Talk/I-Surf doesn't work together with kernel isapnp

<buffer:antifork.org>:
  o [TCP]: Add Westwood+ support, off by default

<c-d.hailfinger.kernel.2004:gmx.net>:
  o [2.4] forcedeth network driver

<davem:nuts.davemloft.net>:
  o [TCP]: Put tcp_ prefix on global westwood symbols
  o [TCP]: Coding style fixes to westwood code
  o [TCP]: Kill westwood specific lock, unneeded
  o [TCP]: Kill bogus reference to CONFIG_TCP_WESTWOOD
  o [IPV4]: Pass new forwarding setting to inet_forward_change()
  o [TG3]: Two more PHY bug workaround, plus fix DMA test on big-endian
  o [TG3]: Fix early chip programming in tg3_setup_copper_phy()
  o [TG3]: Bump driver version and reldate
  o [IPVS]: Use '%Z' for size_t types
  o [IPV6]: Fix data type range warning in ndisc.c
  o [TIGON3]: Comment out card RAM validation in tg3_test_dma() for now
  o [TIGON3]: Bump version and reldate

<giuseppe.furlan:systeam.it>:
  o Add Hitachi 9960 storage to SCSI dev list as SPARSELUN|LARGELUN

<grundler:parisc-linux.org>:
  o [TG3]: Reset GRC, if necessary, before DMA test
  o [TG3]: Abstract out mailbox workarounds into tw32_{rx,tw}_mbox()
  o [TG3]: Define MBOX_WRITE_REORDER flag to zero on non-x86

<ja:ssi.bg>:
  o [IPV4]: Add configurable restriction of local IP announcements in ARP requests
  o [IPV4]: Add sophistacated ARP reply control via arp_ignore sysctl

<jhf:rivenstone.net>:
  o [netdrvr sis900] fix multicast

<ken:miriam.com>:
  o [TIGON3]: Add Apple tigon3 PCI device id

<khali:linux-fr.org>:
  o Incorrect SCx200 dependency

<leachbj:bouncycastle.org>:
  o hfsplus alignment fix

<len.brown:intel.com>:
  o [ACPI] CONFIG_ACPI_NUMA depends on CONFIG_IA64
  o [ACPI] revert previous AML param patch for ACPICA update
  o [ACPI] ACPICA 20040211 udpate from Bob Moore

<marcelo:logos.cnet>:
  o Update i386 defconfig
  o Changed EXTRAVERSION to -pre1

<mporter:kernel.crashing.org>:
  o 2.4 ibm_emac driver fixes

<phil.el:wanadoo.fr>:
  o export smp_num_siblings cpu_sibling_map

<tigran:veritas.com>:
  o microcode: fix devfs breakage caused by last updated

<wang:ai.mit.edu>:
  o [wireless] add atmel driver

<wensong:linux-vs.org>:
  o [IPVS]: Remove the superfluous call of waitpid in sync code
  o [IPVS]: Fix to retry to fork kernel_thread when memory is temporarily exhausted
  o [IPVS] tidy up the header files to include

Adrian Bunk:
  o fix two IDE warnings
  o typo: HOSTCCFLAGS instead of HOSTCFLAGS in lib/Makefile

Bartlomiej Zolnierkiewicz:
  o kill recreate_proc_ide_device(),

Ben Collins:
  o IEEE1394/Video1394(r1152): Init d->link list head so failurs are handled properly
  o IEEE1394(r1153): Use vmalloc to allocate sglist array for larger cases

Benjamin Herrenschmidt:
  o [SUNGEM]: Be careful about memory ordering

David Dillow:
  o Support the new 3CR990B cards that require authentication of the runtime firmware image.

Geert Uytterhoeven:
  o Amifb modedb bug

Jeff Garzik:
  o [wireless airo] backport 2.6.x cleanups/minor fixes
  o [wireless airo] fix build breakage
  o [netdrvr sk98lin 1/2] Remove CVS substitution keywords/spam
  o [netdrvr sk98lin 2/2] Remove CVS substitution keywords/spam

Keith Owens:
  o Remove generated files

Manfred Spraul:
  o shrink address space reserved for kmap

Marcel Holtmann:
  o Fix for I4L over CAPI and CMTP

Matt Domsch:
  o fix lib/crc32.c copyright notice

Scott Feldman:
  o e1000 stable sync with 2.6

Shmulik Hen:
  o bonding cleanup 2.4 - Simplify ifenslave
  o bonding cleanup 2.4 - Consolidate prints
  o bonding cleanup 2.4 - death of typedefs
  o bonding cleanup 2.4 - remove dead code
  o bonding cleanup 2.4 - Consolidate timer handling
  o bonding cleanup 2.4 - Fix handling of bond->primary
  o bonding cleanup 2.4 - Remove multicast_mode module param
  o bonding cleanup 2.4 - Fix slave list iteration
  o bonding cleanup 2.4 - Consolidate function declarations
  o bonding cleanup 2.4 - consolidate param names of function params and variables
  o bonding cleanup 2.4 - consolidate return values of functions
  o [netdrvr bonding] trivial - Update comment blocks and version field
  o [IPV4]: Split arp_send into arp_create and arp_xmit
  o [VLAN]: Export VLAN tag get/set functionality
  o [VLAN]: Use VLAN tag set functionality in 8021q module

Sridhar Samudrala:
  o [SCTP] Sync with 2.6.2 SCTP
  o [SCTP] Use __get_free_pages() to allocate ssnmap
  o [SCTP] Fix SCTP_INITMSG set socket option so that a parameter with 0 value will not change its current value.
  o [SCTP] Fix sctp_getladdrs()/sctp_getpaddrs() API so that the port value in the returned addresses is in network byte order.
  o [SCTP] Revert back to use kmalloc() for ssnmap allocs of sizes < 128K
  o Cset exclude: sri@us.ibm.com|ChangeSet|20040216054112|09098
  o Cset include: sri@us.ibm.com|ChangeSet|20040216054112|09098 Cset include: sri@us.ibm.com|ChangeSet|20040213195328|09088 Cset include: sri@us.ibm.com|ChangeSet|20040213011231|09074 Cset include: sri@us.ibm.com|ChangeSet|20040213005510|09081 Cset include: sri@us.ibm.com|ChangeSet|20040213003759|09793
  o [SCTP] Fix syntax errors in net/sctp Config.in

Stelian Pop:
  o Fix meye compilation when HIGHMEM64G is set

Willy Tarreau:
  o fix ACPI poweroff

