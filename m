Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750792AbWHKES7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbWHKES7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 00:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbWHKES7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 00:18:59 -0400
Received: from hera.kernel.org ([140.211.167.34]:34705 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1750792AbWHKES6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 00:18:58 -0400
Date: Fri, 11 Aug 2006 04:18:52 GMT
From: Marcelo Tosatti <marcelo@hera.kernel.org>
Message-Id: <200608110418.k7B4IqDn017355@hera.kernel.org>
To: linux-kernel@vger.kernel.org
Subject: linux-2.4.33 released
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

final:

- 2.4.33-rc3 was released as 2.4.33 with no changes.

Summary of changes from v2.4.33-rc2 to v2.4.33-rc3
============================================

Andreas Haumer:
      [PATCH-2.4] Typo in cdrom.c

Kirill Korotaev:
      EXT3: ext3 block bitmap leakage

Marcelo Tosatti:
      Change VERSION to 2.4.33-rc3

Willy Tarreau:
      ethtool: two oopses in ethtool_set_coalesce() and ethtool_set_pauseparam()


Summary of changes from v2.4.33-rc1 to v2.4.33-rc2
============================================

Marcelo Tosatti:
      Change VERSION to v2.4.33-rc2

Mikael Pettersson:
      [PATCH 2.4.33-rc1] repair __ide_dma_no_op breakage

Solar Designer:
      [NETFILTER]: Fix do_add_counters race, possible oops or info leak (CVE-2006-0039)

Vlad Yasevich:
      [SCTP]: Validate the parameter length in HB-ACK chunk. (CVE-2006-1857)
      [SCTP]: Respect the real chunk length when walking parameters. (CVE-2006-1858)

Willy Tarreau:
      Fix vfs_unlink/NFS NULL pointer dereference
      range checking for sleep states sent to /proc/acpi/sleep


Summary of changes from v2.4.33-pre3 to v2.4.33-rc1
============================================

Jean Delvare:
      scx200_acb: Fix resource name use after free
      i2c: Delete 2 out-of-date, colliding ioctl defines

Jesper Juhl:
      fix mem-leak in netfilter

Kirill Korotaev:
      [NETFILTER]: Fix possible overflow in netfilters do_replace()

Marcelo Tosatti:
      Contact information update
      Vadim Egorov: ext3 link/unlink race
      Fix vfs_unlink issue introduced by link/unlink race correction
      Merge master.kernel.org:/.../davem/net-2.4
      Update VERSION to v2.4.33-rc1

Olaf Kirch:
      smbfs chroot issue (CVE-2006-1864)

Patrick McHardy:
      [NETFILTER]: SNMP NAT: fix memory corruption

Pradeep Vincent:
      Neighbour Cache (ARP) State machine bug Fixed

Sergei Shtylyov:
      AMD Au1xx0: fix ethernet TX stats

Shaun Tancheff:
      USB: Gadget RNDIS fix alloc bug. (buffer overflow)

Sridhar Samudrala:
      [SCTP]: Fix state table entries for chunks received in CLOSED state. (CVE-2006-2271)
      [SCTP]: Fix panic's when receiving fragmented SCTP control chunks. (CVE-2006-2272)

Stephen Hemminger:
      [IPV4]: ip_route_input panic fix (CVE-2006-1525)

Theodore Ts'o:
      Fix memory leak when the ext3's journal file is corrupted

Vladislav Yasevich:
      [SCTP]: Prevent possible infinite recursion with multiple bundled DATA. (CVE-2006-2274)

Willy TARREAU:
      fix /proc/partitions display with USB-FDD geometry
      Merge branch 'origin'
      fix /proc/partitions display with USB-FDD geometry
      ext2: update inode ctime on rename()
      bonding: remove a warning with gcc 3
      block: remove the annoying 'blk: queue %p I/O limit %luMb' messages
      scripts : ver_linux does not report recent binutils version
      3c59x: reload EEPROM values at rmmod for needy cards
      netdrv: fix b44 loading after bcm4400
      netdrv: b44 driver must ignore carrier lost errors
      drm: gcc complains that print_heap() in radeon_mem.c is not used.
      ide: trying to enable DMA may cause an oops
      Merge branch 'updates'
      JBD: avoid panic on corrupted journal superblock (from akpm)

Willy Tarreau:
      forcedeth update to 0.50


Summary of changes from v2.4.33-pre2 to v2.4.33-pre3
============================================

Andi Kleen:
      x86_64: Check for bad elf entry address.
      Always check that RIPs are canonical during signal handling
      x86-64: Always check that RIPs are canonical during signal handling (update)
      i386/x86-64: Fix x87 information leak between processes

Craig Brind:
      via-rhine: zero pad short packets on Rhine I ethernet cards

David S. Miller:
      ip_queue: Fix wrong skb->len == nlmsg_len assumption

Hugh Dickins:
      fix shm mprotect (CVE-2006-1524)

Jeff Layton:
      2.4 nfs cache consistency problem with mmap'ed files

Jesse Brandeburg:
      build fix: auto_fs4 changes broke ppc64 build

Marcelo Tosatti:
      Merge http://w.ods.org/kernel/2.4/linux-2.4-upstream
      Change VERSION to v2.4.33-pre3
      Fix printk length modifier of NFS mmap consistency patch

Marek Szuba:
      quota_v2 module taints the kernel (missing licence)

Marin Mitov:
      DRM: drm_stub_open() range checking

Mika Kukkonen:
      VLAN: Add two missing checks to vlan_ioctl_handler()

Pavel Kankovsky:
      Fix small information leak in SO_ORIGINAL_DST and getname()

Stefan-W. Hahn:
      Corrected faulty syntax in drivers/input/Config.in

Stephen Rothwell:
      PPC64: fix sys_rt_sigreturn() return type

Willy TARREAU:
      e1000: Fix mii-tool access to setting speed and duplex


Summary of changes from v2.4.33-pre1 to v2.4.33-pre2
============================================

Adrian Bunk:
      document that gcc 4 is not supported

dann frazier:
      proc_pid_cmdline() race fix (CAN-2004-1058)

David S. Miller:
      [SPARC]: Fix compile failures in math-emu.

Guennadi Liakhovetski:
      usb-uhci.c: wrong sign comparison in status check

Horms:
      [PATCH, 2.4] wan sdla: fix probable security hole
      orinoco: CVE-2005-3180: Information leakage due to incorrect padding

Jacek Lipkowski:
      make 2.4.32 work on i486 again

Jesse Brandeburg:
      e1000: fix BUG reported due to calling msec_delay in irq context

Marcelo Tosatti:
      Alpha: fix recursive inlining failure in pci_iommu.c
      Merge http://w.ods.org/kernel/2.4/linux-2.4-upstream
      Change VERSION to 2.4.33-pre2

ODonnell, Michael:
      PATCH: hash-table corruption in bond_alb.c

Pete Zaitcev:
      usbserial: using int for CPU flags is incorrect on x86_64

Rik van Riel:
      fix overflow in inode.c

Steven J. Hathaway:
      SAMSUNG CD-ROM SC-140 fails on DMA

Vincent Fortier:
      Documentation error 2.4.x aic7xxx

Willy Tarreau:
      Merge branch 'master' of /data/projets/git/linux/linux-2.4
      Merge branch 'master' of /data/projets/git/linux/linux-2.4


Summary of changes from v2.4.32 to v2.4.33-pre1
============================================

Adrian Bunk:
      airo.c/airo_cs.c: correct prototypes
      drivers/scsi/dpt_i2o.c: fix a NULL pointer dereference

Akira Tsukamoto:
      fix for clock running too fast
      ide: add recent ATI IXP300/400 PATA support

Chris Ross:
      Don't panic on IDE DMA errors

dann frazier:
      Backport of CVE-2005-2709 fix

Dave Anderson:
      x86-64: user code panics kernel in exec.c (CVE-2005-2708)

David S. Miller:
      [SPARC64]: Fix trap state reading for instruction_access_exception.
      [SPARC64]: Do not call winfix_dax blindly
      [SPARC64]: Revamp Spitfire error trap handling.
      [SPARC64]: More fully work around Spitfire Errata 51.
      [IPV6] mcast: IPV6 side of IGMP DoS fix.

David Stevens:
      [IGMP]: workaround for IGMP v1/v2 bug

Horms:
      local denial-of-service with file lease

Jeff Garzik:
      [libata] resync with kernel 2.6.13
      [libata sata_sx4] trim trailing whitespace
      [libata] resync with 2.6.14
      [libata] resync with 2.6.15-rc3
      [libata] fix build
      [libata] fix potential oops in pdev_printk() compat helper

Karl Magnus Kolstoe:
      add Pioneer DRM-624X to drivers/scsi/scsi_scan.c

Konstantin Khorenko:
      sis900: come alive after temporary memory shortage

Krzysztof Strasburger:
      NFS server as a module with -mregparm=3

Linus Torvalds:
      Fix ptrace self-attach rule (2.6 backport)

Maciej W. Rozycki:
      fs/smbfs/proc.c: fix data corruption in smb_proc_setattr_unix()

Marcelo Tosatti:
      Revert broken sis900 update
      Merge http://w.ods.org/kernel/2.4/linux-2.4-upstream
      Change VERSION to 2.4.33-pre1
      Merge master.kernel.org:/.../davem/net-2.4

Marcus Meissner:
      Fix sendmsg overflow (CVE-2005-2490)

NeilBrown:
      dcache: avoid race when updating nr_unused count of unused dentries

Nick Warne:
      Reintroduction i386 CONFIG_DUMMY_KEYB option

Pete Zaitcev:
      usb: ehci in 2.4 with async_unlink

Vasily Averin:
      sis900: come alive after temporary memory shortage (fixed version)
      aic7xxx: reset handler selects a wrong command

Vijay Sampath:
      MTD: kernel stuck in tight loop occasionally on flash access

Willy Tarreau:
      IPv6: small fix for ip6_mc_msfilter
      Fix SATA update KM_IRQ issue with highmem

Yan Zheng:
      IPv6: fix refcnt of struct ip6_flowlabel

