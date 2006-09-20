Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751144AbWITEd5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbWITEd5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 00:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbWITEd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 00:33:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63437 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751144AbWITEd4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 00:33:56 -0400
Date: Tue, 19 Sep 2006 21:33:54 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Arrr! Linux 2.6.18
Message-ID: <Pine.LNX.4.64.0609192126070.4388@g5.osdl.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="21872808-1741922205-1158726834=:4388"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--21872808-1741922205-1158726834=:4388
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT


Ahoy!

She's good to go, hoist anchor!

Here's some real booty for all you land-lubbers. 

There's not too many changes, with t'bulk of the patch bein' defconfig 
updates, but the shortlog at the aft of this here email describes the 
details if you care, you scurvy dogs.

Header cleanups, various one-liners, and random other fixes.

		Linus "but you can call me Cap'n"

---

Adrian Bunk:
      Ahoy! Make fs/jffs2/nodelist.c:jffs2_obsolete_node_frag() static
      fs/jffs2/xattr.c: maroon dead code

Al "Bilge rat" Viro:
      [IPV4] fib_trie: missin' ntohl() when callin' fib_semantic_match()

Alexey Dobriyan:
      headers_check: improve #include regexp
      headers_check: clarify error message

Alexey Korolev:
      [MTD] Fixes of performance and stability issues in CFI driver. Arrr!

Cap'n Andrew Morton:
      Blimey! hvc_console suspend fix

Andy Walker:
      [SPARC]: Fix mutimous regression in sys_getdomainname()

Arnaud Patard:
      IPMI: Fix oops on ipmi_msghandler removal for non ipmi systems. Gar!

Artem B. Bityutskiy:
      [MTD] NAND: keelhaul marooned URL in Kconfig

Aubrey Lee:
      [MTD] DEVICES: Fill more device IDs in t'structure of m25p80

Auke Kok:
      e1000: fix bilge-sucking TX timout hang regression for 82542rev3

Ben Dooks:
      [ARM] 3784/1: S3C2413: keelhaul config for MACH_S3C2413/MACH_SMDK2413
      [ARM] 3785/1: S3C2412: Fix idle code as default uses wrong clocks
      [ARM] 3793/1: S3C2412: fix barnacles in wrong serial info struct
      [ARM] 3794/1: S3C24XX: do not defined set_irq_wake when no CONFIG_PM

Benjamin Herrenschmidt:
      [POWERPC] Fix G5 DART (IOMMU) race causin' occasional data corruption

Benjamin LaHaise:
      i386/x86-64: Add core 2 to oprofile

Chas Williams:
      [ATM]: [he] when transmit fails, unmap t'dma regions right smartly
      [ATM]: [he] don't hold t'device lock when upcalling

Chuck Ebbert:
      Kconfig: move CONFIG_EMBEDDED options to submenu. Gar!

Corey Minyard:
      IPMI: keelhaul handlin' of OEM flags

Dale Farnsworth:
      mv643xx_eth: Unmap DMA buffers in receive path

Dan Williams:
      [ARM] 3780/1: Fix iop321 cpuid

Dave Kleikamp:
      [Shiver me timbers] EXT2: Remove superblock lock contention in ext2_statfs

David S. Miller:
      [OPENPROMIO]: Handle current_node bein' NULL correctly. Arrr!

David Woodhouse:
      [MTD NAND] Fix lookup error in nand_get_flash_type()
      [POWERPC] Implement PowerPC futex_atomic_cmpxchg_inatomic(). Arrr!
      headers_check: reduce user-visible noise in <linux/nfs_fs.h>
      headers_check: remove <asm/timex.h> from user export
      headers_check: move inclusion of <linux/linkage.h> in <asm-i386/signal.h>
      headers_check: move kernel-only #includes within <asm-i386/elf.h>
      headers_check: don't expose PFN stuff to userspace in <asm-i386/setup.h>
      headers_check: keelhaul userspace build of asm-mips/page.h
      Fix scurvy 'make headers_check' on biarch architectures
      Fix 'make headers_check' on s390
      Fix 'make headers_check' on ia64
      Fix 'make headers_check' on i386
      Fix 'make headers_check' on x86_64
      Fix 'make headers_check' for Alpha
      headers_check: use a different default directory
      Add headers_check' target to output of 'make help'

Davy Jones:
      Didn't do anything, the scurvy lad. Ahoy!

Eli Cohen:
      IPoIB: Retry failed send-only multicast group joins. Gar!

Frank Pavlic:
      s390: minor s390 network driver fixes
      s390: netiucv driver fixes
      s390: Makefile cleanup
      s390: qeth driver fixes [1/6]
      s390: qeth driver fixes [2/6]
      s390: qeth driver fixes [3/6]
      s390: qeth driver fixes [4/6]
      s390: qeth driver fixes [5/6]
      s390: qeth driver fixes [6/6]

Geert Uytterhoeven:
      Well blow me down, if he didn't fix 'make headers_check' on ia64

Greg KH:
      We can not allow anonymous contributions to t'kernel

Haavard Skinnemoen:
      MTD: Convert Atmel PRI information to AMD format
      MTD: Add lock/unlock operations for Atmel AT49BV6416

Havasi Ferenc:
      [JFFS2][SUMMARY] Fix a bilge-suckin' summary collectin' bug. Arrr!

Herbert Xu:
      [NET]: Drop tx lock in dev_watchdog_up

Håvard Skinnemoen:
      MTD: Fix bug in fixup_convert_atmel_pri

Imre Deak:
      genirq: Fix the typo in IRQ resend smartly, cabin boy!

Ingo Molnar:
      lockdep: double the number of stack-trace entries
      genirq core: keelhaul handle_level_irq()

Ishai Rabinovitz:
      IB/srp: Don't schedule reconnect from srp

James Morris:
      [NETFILTER]: Add secmark headers to header-y

Jeremy Fitzhardinge:
      x86: reserve a boot-loader ID number for Xen

Jon Loeliger:
      [POWERPC] Add new, missin' argument to of_irq_map_raw() for 86xx. Arrr!

Josef 'Jeff' Sipek:
      [MTD] Use SEEK_{SET,CUR,END} instead of hardcoded values in mtdchar lseek()

Josh Triplett:
      Add preprocessed files (*.i) to .gitignore
      Add mixed source and assembly listings (*.lst) to .gitignore
      Add symbol type files (*.symtypes) to .gitignore

Kenneth Lee:
      bug fix for bilge-suckin' in kernel/kmod.c

Kirill Korotaev:
      [NEIGH]: neigh_table_clear() doesn't free stats

Linus "Cap'n" Torvalds:
      x86: save/restore eflags in context switch
      Avast! Belay those mmiocfg heuristics and blacklist changes
      Linux v2.6.18. Arrr!

Matthew Wilcox:
      headers_check: Clean up asm-parisc/page.h for user headers

Michael De Backer:
      alim15x3.c: M5229 (rev c8) support for DMA cd-writer

Michael S. Tsirkin:
      RDMA/cma: Increase t'IB CM retry count in CMA

Mike Miller:
      cciss: version update, new hw

Mohan Kumar M:
      [POWERPC] Fix interrupt clearin' in kdump shutdown sequence

NeilBrown:
      knfsd: Have ext2 reject file handles with bad inode numbers early
      knfsd: Make ext3 reject filehandles referrin' to invalid inode number

Olaf Hering:
      [POWERPC] update prep_defconfig

Oleg Nesterov:
      rcu_do_batch: make ->qlen decrement irq safe

Patrick McHardy:
      [PACKET]: Don't truncate non-linear skbs with mmaped IO
      [NETFILTER]: xt_quota: add missin' module aliases

Paul "Peg leg" Mackerras:
      [POWERPC] Update defconfigs
      [POWERPC] Fix MMIO ops to provide expected barrier behaviour

Ralph Siemsen:
      [ARM] 3815/1: headers_install support for ARM

Remi Denis-Courmont:
      [IPV6]: Accept -1 for IPV6_TCLASS

Richard Purdie:
      MTD: [NAND] Fix t'sharpsl driver after breakage from a core conversion

Roland Dreier:
      [ATM]: linux-atm-general mailin' list is subscribers only

Rolf Eike Beer:
      remove #error on !PCI from pmc551.c

Ross Biro:
      Add a missin' space that prevents buildin' modules that require host programs

Sachin P. Sant:
      [POWERPC] kdump: Support kernels havin' 64k page size. Arrr!

Simon Horman:
      [IPVS]: Document t'ports option to ip_vs_ftp in kernel-parameters.txt
      [IPVS]: auto-help for ip_vs_ftp
      [IPVS]: Make sure ip_vs_ftp ports are valid
      [IPVS]: remove the debug option go ip_vs_ftp

Stefan Richter:
      SCSI: lockdep annotation in scsi_send_eh_cmnd

Stephen Hemminger:
      [TCP]: Turn ABC off. Arrr!
      [BRIDGE]: random extra bytes on STP TCN packet
      [NET]: Mark frame diverter for future removal. Arrr!

Suparna Bhattacharya:
      ext3 sequential read regression fix

Takashi YOSHI:
      MTD: Add Macronix MX29F040 to JEDEC

Takashi YOSHII:
      [MTD] Maps: Add dependency on alternate probe methods to physmap

Tejun Heo:
      libata: ignore CFA signature while sanity-checkin' an ATAPI device

Trond Myklebust:
      NFS: Fix Oopsable condition in nfs_readpage_sync()
      NFSv4: Fix incorrect semaphore release in _nfs4_do_open()
      NFS: Fix nfs_page use after free issues in fs/nfs/write.c

Ulrich Kunitz:
      zd1211rw: Fix of signal strength and quality measurement

Ville Herva:
      block2mtd.c: Make kernel boot command line arguments work (try 4)

Vitaly Wool:
      [MTD] NAND: OOB buffer offset fixups
      [ARM] 3786/1: pnx4008: update defconfig
      MTD NAND: OOB buffer offset fixups

Wong Hoi Sing Edison:
      [TCP] tcp-lp: bug fix for oops in 2.6.18-rc6
      [TCP] tcp-lp: update information to MAINTAINERS

YOSHIFUJI Hideaki:
      [IPV6]: Fix tclass settin' for raw sockets.
      [ATM] CLIP: Do not refer freed skbuff in clip_mkip(). Arrr!

Zoltan Sogor:
      JFFS2: SUMMARY: keelhaul a summary collectin' bug

--21872808-1741922205-1158726834=:4388--
