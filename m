Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265396AbSKKDjz>; Sun, 10 Nov 2002 22:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265397AbSKKDjz>; Sun, 10 Nov 2002 22:39:55 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:49413 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265396AbSKKDjr>; Sun, 10 Nov 2002 22:39:47 -0500
Date: Sun, 10 Nov 2002 19:46:06 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux v2.5.47
Message-ID: <Pine.LNX.4.44.0211101944030.17742-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I still have stuff pending, but this is what's currently merged. 

		Linus

--

Summary of changes from v2.5.46 to v2.5.47
============================================

<abslucio@terra.com.br>:
  o [NET]: Port 2.4.x pktgen to 2.5.x

<baldrick@wanadoo.fr>:
  o USB: fix typo

<bart.de.schuyer@pandora.be>:
  o [BRIDGE]: Fix help docs

<cloos@lugabout.jhcloos.org>:
  o sbp2.h

<dave@qix.net>:
  o 2.4 drivers_char_random.c fix sample shellscripts

<erik@aarg.net>:
  o USB: added support for Palm Tungsten T devices to visor driver

<fscked@netvisao.pt>:
  o Convert 3c505 net driver to use spinlocks instead of cli/sti

<james_mcmechan@hotmail.com>:
  o added include needed to compile centaur.c for 2.5.46-bk1

<jtyner@cs.ucr.edu>:
  o USB vicam.c: minor fixes

<jung-ik.lee@intel.com>:
  o Patch: 2.5.45 PCI Fixups for PCI HotPlug

<linux@hazard.jcu.cz>:
  o fix do_timer.h compiler warning

<mikal@stillhq.com>:
  o [Trivial Patch] journal_documentation-001

<mzyngier@freesurf.fr>:
  o More znet net driver updates.  Driver now survives plug/unplug of
    cable

<nivedita@w-nivedita.beaverton.ibm.com>:
  o sctp: Added checks for tcp-style sockets to sctp_peeloff() and
    AUTOCLOSE
  o sctp: Added SCTP SNMP MIB infrastructure

<porter@cox.net>:
  o PPC32: Add new arch/ppc/syslib/ directory for "system library" code

<rjweryk@uwo.ca>:
  o Make VT8653 work with AGP
  o Fix ALSA emu10k1 bass control

<sfbest@us.ibm.com>:
  o add missing jfs_acl.h

<sridhar@dyn9-47-18-140.beaverton.ibm.com>:
  o sctp: User initiated ABORT support. (ardelle.fan)
  o [SCTP]: Initial souce address selection support
  o [SCTP]: use dst_pmtu() to get the pmtu

<thchou@ali.com.tw>:
  o Update pci id for ALi chipset series

<vberon@mecano.gme.usherb.ca>:
  o Small fix for Documentation_Changes (2.5)

<yokota@netlab.is.tsukuba.ac.jp>:
  o NinjaSCSI-3R driver patch updated

Adrian Bunk <bunk@fs.tum.de>:
  o Labeled elements are not a GNU extension
  o generic_fillattr() duplicate line. (fwd)

Alan Cox <alan@lxorguk.ukuu.org.uk>:
  o binfmt flat uses zlib
  o final eata polish
  o 2.5.46 - aha1740 update
  o first pass eata-pio updates
  o fd_mcs finish up I hope
  o silly typo fix
  o fix 5380 prototype for biosparam
  o bring ibmmca into line
  o in2000 new_eh and locking fixes
  o tidy the 53c406, kill off old header
  o NCR5380 fix the locking fix fix
  o kill old reset stuff in nsp - it supports new_eh anyway
  o fix qlogicfas pcmcia build
  o u14f/34f build fix
  o printk levels for wd7000
  o first pass over ultrastor.c (still used for u24f)
  o NOMMU update for fs/locks.c
  o update the stat ifdef rule for v850
  o handle buggy PIT, also do delays spec requires
  o use the PIT bug workarounds rather than killing TSC
  o add pit_latch to headers to avoid warnings

Alan Stern <stern@rowland.harvard.edu>:
  o USB storage: use the new transfer_buf() routine

Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>:
  o [NET]: IPSEC updates
  o [IPSEC]: Bug fixes and updates
  o [IPSEC]: Semantic fixes with help from Maxim Giryaev
  o [IPSEC]: Few changes to keep racoon ISAKMP daemon happy
  o [IPSEC] More work
  o [IPSEC]: Fix lockup in xfrm4_dst_check

Andrew Morton <akpm@digeo.com>:
  o `event' removal: core kernel
  o `event' removal: ext2
  o `event' removal: other filesystems
  o `event' removal: kill it
  o fix mod_timer() race
  o timers: initialisers
  o timers: scsi
  o timers: drivers/*
  o timers: input, networking
  o use timer intialiser in workqueues
  o initialise timers in sound/
  o initialize timers under arch/
  o init timers under fs/
  o [NET]: Timer init fixes
  o misc fixes
  o Fix readv/writev return value
  o SMP iowait stats
  o hugetlb: fix zap_hugetlb_resources()
  o hugetlb: remove unlink_vma()
  o hugetlb: internalize hugetlb init
  o hugetlb: remove sysctl.c intrusion
  o hugetlb: remove /proc/ intrusion
  o hugetlb: make private functions static
  o Fix math underflow in disk accounting
  o buffer_head refcounting fixes and cleanup
  o fix page alloc/free accounting
  o remove duplicated disk statistics

Andries E. Brouwer <Andries.Brouwer@cwi.nl>:
  o [TCP] Do not update rcv_nxt until ts_recent is updated

Anton Blanchard <anton@samba.org>:
  o vmlinux.lds init.text -> text.init etc changes and other random
    cleanups
  o ppc64: boot Makefile fixes and remove LVM1 ioctl translation code
  o ppc64: fix cond_syscall so it works instead of oopses
  o ppc64: Add POLLREMOVE
  o ppc64: initramfs fixes
  o ppc64: updates for 2.5.45
  o ppc64: numa updates
  o ppc64: updates from Dave Engebretsen in 2.4
  o ppc64: rework ppc64 hashtable management
  o ppc64: defconfig update
  o fix slab allocator for non zero boot cpu
  o ppc64: small fixes for updates in BK
  o ppc64: defconfig update
  o ppc64: initramfs update
  o ppc64: merge some ioctl32.c changes from sparc64
  o ppc64: fix misc_register usage from Michael Still

Art Haas <ahaas@neosoft.com>:
  o designated initializer patches for fs_devfs
  o C99 designated initializers

Bart De Schuymer <bart.de.schuymer@pandora.be>:
  o net/ipv4/netfilter/ipt_physdev.c: Bug fix in matching
  o [BRIDGE]: Update br-netfilter for dst_pmtu changes

Brad Hards <bhards@bigpond.net.au>:
  o [SCTP]: Remove duplicate include
  o [NETFILTER]: Remove duplicate include

Christoph Hellwig <hch@infradead.org>:
  o read(v)/write(v) fixes

Christoph Hellwig <hch@lab343.munich.sgi.com>:
  o [XFS] Move a couple of routines with knowledge of pagebuf targets,
    block devices, and struct inodes down in with the rest of the
    Linux-specific code.

Christoph Hellwig <hch@lst.de>:
  o [SPARC]: Cleanup scsi driver registration
  o get rid of ->init in osst
  o proper scsi_devicelist handling
  o get rid of global arrays in sr
  o get rid of sg_init
  o allow registering individual HBAs
  o scsi device template cleanups
  o page zero is not mapped on m68knommu
  o ksize of uClinux
  o exec.c uClinux bits
  o mpage.c is missing a include
  o uClinux pgprot bits
  o add a description to flat.h
  o switch over loop.c to ->sendfile

Christoph Hellwig <hch@sgi.com>:
  o fix intermezzo compile failure
  o [XFS] fix jiffies (lbolt) compare
  o [XFS] remove nopkg() alias for ENOSYS
  o [XFS] fix NULL pointer dereference in pagebuf
  o [XFS] remove inode reference cache
  o [XFS] fix kNFSD operation
  o [XFS] more dead code removal
  o [XFS] Don't require ACL helpers for XFS
  o [XFS] Fix up some Kconfig merging issues
  o [XFS] Fix compilation with ACLs enabled
  o export find_trylock_page for XFS

Christopher Hoover <ch@hpl.hp.com>:
  o [PATCH] 2.5.44 sa-1111 ohci hcd

Chuck Lever <cel@citi.umich.edu>:
  o allow nfsroot to mount with TCP
  o too many setattr calls from VFS layer
  o bug in NFSv2 end-of-file read handling
  o remove unused NFS and RPC headers
  o remove unused cl_flags field
  o remove unused NFS cruft
  o remove unused RPC cruft
  o minor TCP connect cleanup
  o use C99 static struct initializers
  o fix jiffies wrap in new RPC RTO estimator
  o RTO estimator cleanup patch

Daisy Chang <daisy@teetime.dynamic.austin.ibm.com>:
  o SCTP - Fix bug #547270.  Retain the order of the retransmission

Dan Streetman <ddstreet@ieee.org>:
  o [patch] set interrupt interval in usbfs

Dave Hollis <dhollis@davehollis.com>:
  o 2.5.45 drivers/net/irda/irda-usb.c Compile Fix

Dave Jones <davej@codemonkey.org.uk>:
  o Use better compiler flags for Cyrix 3
  o revamped machine check exception support

David Brownell <david-b@pacbell.net>:
  o usbtest, Kconfig and misc
  o ohci-hcd, remove oops and

David Hinds <dhinds@sonic.net>:
  o small attribution fixes
  o PCMCIA network driver update
  o more PCMCIA fixes for 2.5
  o PCMCIA updates for 2.5, #4
  o drivers/parport/parport_cs.c compilation problem

David Howells <dhowells@redhat.com>:
  o add missing __exit specifications

David Mosberger <davidm@napali.hpl.hp.com>:
  o let binfmt_misc optionally preserve argv[1]

David S. Miller <davem@nuts.ninka.net>:
  o [IPV4]: Report zero route advmss properly
  o [SPARC64]: Add device mapper translations
  o [NET]: Some missed cases of dst_pmtu conversion
  o [SPARC]: Add POLLREMOVE
  o [SPARC]: Add sys_remap_file_pages syscalls
  o [NET]: Add NET_PKTGEN
  o [SPARC]: Fix typo in ESP changes
  o [SPARC]: Fix typos in QLOGICPTI changes
  o [CRYPTO]: Include kernel.h in crypto.h
  o [NET]: Fix xfrm policy locking
  o [SPARC64]: Translate SO_{SND,RCV}TIMEO socket options
  o [SPARC64]: Handle kernel integer divide by zero properly
  o [AF_KEY]: Convert to/from IPSEC_PROTO_ANY
  o [NET]: XFRM policy bug fixes
  o [SUNZILOG]: uart_event --> uart_write_wakeup
  o [SPARC64]: Add initramfs sections
  o [SPARC]: Add initramfs bits
  o [SCTP]: Convert to xfrm_policy_check
  o [TCP_IPV6]: Remove unused label discard_and_relse
  o [IPSEC]: Export xfrm_policy_list
  o [SPARC64]: Define LDFLAGS_BLOB
  o [IPSEC/CRYPTO]: Allocate work buffers instead of using kstack
  o [NET]: Copy msg_namelen back to user in recv{from,msg} even if it
    is zero
  o [IPSEC]: RAWv4 makes inverted policy check
  o [SPARC64]: Include asm/uaccess.h in asm/elf.h
  o [CRYPTO]: Add in crypto/sha256.c
  o [CRYPTO]: Make sha256.c more palatable to GCCs optimizers

Davide Libenzi <davidel@xmailserver.org>:
  o epoll bits 0.34
  o The epoll saga continues

Dominik Brodowski <linux@brodo.de>:
  o cpufreq: correct initialization on Intel Coppermines

Doug Ledford <dledford@aladin.rdu.redhat.com>:
  o aic7xxx_old: multiple updates and fixes, driver ported to scsi
    mid-layer new error handling scheme

Douglas Gilbert <dougg@torque.net>:
  o sbp2 (ieee1394) for lk2.5.44-bk3
  o Changes
  o Attached is an addition to the patches on this driver that I've
    been posting recently. This one adds:

Edward Peng <edward_peng@dlink.com.tw>:
  o sundance net driver updates
  o dl2k net driver update from vendor

Eric Sandeen <sandeen@sgi.com>:
  o [XFS] Avoid creating attrs for acls which can be stored in the
    standard permission bits, and remove existing attrs if acls are
    reduced to standard permissions.
  o [XFS] pagebuf flags cleanup
  o [XFS] Fix root exec access checks on files with acls
  o [XFS] Remove tabs from printk's
  o [XFS] Prevent a couple transactions from happening on ro mounts
  o [XFS] Be more careful about quota state changes on ro-devices We
    can't allow quota state changes on a read-only device, this would
    kick of a failing transaction & shut down the fs.
  o [XFS] Remove a couple other readonly device change remnants

Greg Kroah-Hartman <greg@kroah.com>:
  o USB: scanner fixes due to changes to USB structures
  o USB: audio fix up for missed debug code
  o PCI: move EXPORT_SYMBOL for the pbus functions to the setup-bus.c
    file
  o PCI Hotplug: removed a compiler warning of a unused variable in the
    cpcihp_generic driver
  o PCI Hotplug: fix compiler warning

Hirokazu Takahashi <taka@valinux.co.jp>:
  o enhance ->sendfile(), allowing kNFSd to use it

Ingo Molnar <mingo@elte.hu>:
  o thread-aware coredumps, 2.5.43-C3

James Bottomley <jejb@mulgrave.(none)>:
  o split sg.c changes out of Christoph Hellwig's template changes

James Morris <jmorris@intercode.com.au>:
  o [CRYPTO]: Cleanups based upon feedback from jgarzik
  o [CRYPTO]: Add crypto_alg_available interface
  o [CRYPTO]: Rework HMAC interface
  o [CRYPTO]: Add SHA256 plus bug fixes
  o [CRYPTO]: Add blowfish algorithm
  o [CRYPTO]: minor updates

Jaroslav Kysela <perex@suse.cz>:
  o ALSA updates

Jean Tourrilhes <jt@hpl.hp.com>:
  o IrDA updates

Jeff Garzik <jgarzik@redhat.com>:
  o Alan snuck in an ugly bandaid into de2104x net driver
  o Remove performance barrier in i810_rng char driver
  o Merge DaveM's cleanup of Broadcom's GPL'd 4401 net driver
  o Use dev_kfree_skb_any not dev_kfree_skb in tg3 net driver function
    tg3_free_rings.
  o Properly terminate b44 net driver's PCI id table (caught by Arjan @
    Red Hat)
  o IrDA updates

Jens Axboe <axboe@suse.de>:
  o ide-cd patchlet
  o soft and hard barriers
  o make 16 the default fifo_batch count
  o enable ide to use bios timings

Jon Grimm <jgrimm@touki.austin.ibm.com>:
  o sctp: header update for new error cause: (13) Protocol Violation
  o sctp: Always respond to ECNE sender. (jgrimm)

Joshua Uziel <uzi@uzix.org>:
  o [SPARC64]: 0x22/0x10 is Ultra-I/spitfire

Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>:
  o kbuild: initramfs updates
  o kbuild: Fix up initramfs, adapt arch/alpha

Linus Torvalds <torvalds@home.transmeta.com>:
  o The crypto auto-load should only be enabled if crypto in enabled
  o Fix floppy timer initialization
  o From Rick Lindsley <ricklind@us.ibm.com>: missing return value in
    sysfs partition code.
  o Avoid compiler warning. [un]likely() wants a boolean, not a pointer
    expression
  o Bit find operations return past the end on failure
  o Avoid gcc warning, and clean up current text address handling (it's
    "current_text_addr()", not the home-brew gcc label magic)

Manfred Spraul <manfred@colorfullife.com>:
  o `i_version' initialization fix
  o remove lock_kernel from fifo_open

Marcus Alanen <maalanen@ra.abo.fi>:
  o block_loop.c kfree error

Matt Domsch <Matt_Domsch@dell.com>:
  o megaraid: remove mega_{reorder,swap}_hosts
  o megaraid: s/pcibios_read_config/pci_read_config
  o megaraid: cleanups so it builds again
  o megaraid: avoid 64/32 division when calculating BIOS CHS
    translation

Matthew Dharm <mdharm-usb@one-eyed-alien.net>:
  o USB storage: move init of residue to a central place
  o USB storage: fix result code checks
  o USB storage: check for abort at higher levels

Matthew Wilcox <willy@debian.org>:
  o [NET]: Cleanup wan/packet ioctls
  o [kbuild]: Use include_config instead of include-config
  o C99 initialisers
  o initramfs support
  o misc updates
  o generic prefetch support in xor.h
  o support non-rt signals >32
  o CONFIG_STACK_GROWSUP

Nathan Scott <nathans@sgi.com>:
  o [XFS] Fix an oversight in the mount option parsing code which would
    result in a kernel panic on certain option strings.
  o [XFS] Fix the handling of the realtime device on the mount path -
    this was broken a few weeks ago with the rework of the target
    device pointer between the xfs_mount and pb_target structures.
  o [XFS] Minor header reorg to get xfs_lrw.h back into line with the
    other linux headers.  Allows us to not repeat the xfs_stratcb
    declaration in several places.  Also rename linvfs_set_inode_ops to
    xfs_set_inodeops since its an auxillary routine not a linvfs
    method.
  o [XFS] Fix compile error from non-DMAPI enabled builds
  o [XFS] Fix xfs_da_node_split handling of dir/attr buffers for
    filesystems built with a directory block size larger than the
    filesystem (and hence attr) blocksize.  This does not affect
    filesystems built with default mkfs.xfs parameters, and only hits
    when a large number of attributes are set on an inode.
  o [XFS] The revalidate routine is now a local, static inline
    elsewhere, so no longer needs to be declared globally here.
  o [XFS] Fix a couple of issues on the error path when dealing with
    external devices (log/realtime).  path_init was missing the
    LOOKUP_POSITIVE flag, so it would fail to tell us if the file
    doesn't exist, there was a spot where we were returning the wrong
    signedness for the code, and when mount is failing, we can call
    into xfs_blkdev_put with a NULL pointer depending on which devices
    were initialised and which weren't.
  o [XFS] Fix compile error with XFS_BIG_FILESYSTEMS set

Neil Brown <neilb@cse.unsw.edu.au>:
  o md: Misc little raid fixes
  o md: Fix assorted raid1 problems
  o md: Fix bug in raid5
  o md: Fix another two bug in raid5
  o kNFSd: Use ->sendpage to send nfsd (and lockd) replies
  o kNFSd: Support zero-copy read for NFSD
  o kNFSd: Make sure final xdr_buf.len is correct on server reply
  o kNFSd: Convert readlink to use a separate page for returning
    symlink contents
  o kNFSd: Make sure svc_process releases response even on error
  o Support latest NVRAM card from micromemory

Patrick Mansfield <patmans@us.ibm.com>:
  o fix 2.5 scsi queue depth setting
  o Re: [PATCH] fix 2.5 scsi queue depth setting

Paul Mackerras <paulus@samba.org>:
  o Update macserial driver
  o Update powermac IDE driver
  o Fix typo in sl82c105.c driver
  o PPC32: Make flush_icache_page a no-op, do the flush in
    update_mmu_cache
  o PPC32: define MAP_POPULATE, MAP_NONBLOCK, POLLREMOVE
  o PPC32: add new syscalls: lookup_dcookie, epoll_*, remap_file_pages
  o PPC32: make the idle loop able to be platform-specific
  o PPC32: Fix up the arch-specific export list
  o PPC32: More sensible arrangement of the sections in vmlinux.lds.S
  o PPC32: Improved support for PReP platforms, forward-ported from 2.4
  o PPC32: Remove powermac SCSI boot disk discovery code
  o PPC32: Remove AFLAGS for arch/ppc/mm/hashtable.o, not needed now
  o PPC32: Define CLONE_UNTRACED for assembler code, fix a too-long
    branch
  o PPC32: Fixes for the Makefiles under arch/ppc/boot
  o PPC32: Increase max kernel size in boot wrapper, fix compile
    warnings
  o The patch below contains some minor updates to the bmac and mace
    ethernet drivers used on powermacs.  The bmac.c change is just to
    remove some compile warnings.  The mace.c change is to move an
    inline function definition to before the point where it is used.
  o Update ADB drivers in 2.5
  o remove obsolete powermac drivers

Pavel Machek <pavel@ucw.cz>:
  o Clean up nbd.c
  o Typo in ide

Pete Zaitcev <zaitcev@redhat.com>:
  o [SPARC]: Update makefiles for current kbuild
  o [SPARC]: Streamlined probing for Zilog
  o [SPARC]: Cleanups and bug fixes

Peter Chubb <peter@chubb.wattle.id.au>:
  o Fix name of discarded section in modules.h

Randy Dunlap <rddunlap@osdl.org>:
  o Fix sscanf("-1", "%d", &i)
  o usb-midi requires SOUND

Richard Gooch <rgooch@atnf.csiro.au>:
  o Removed DEVFS_FL_AUTO_OWNER flag
  o util.c

Richard Henderson <rth@dorothy.sfbay.redhat.com>:
  o Zero UNIQUE on exec
  o Merge bits from entry-rewrite tree
  o Fix single denorm -> double conversion
  o More merging from entry-rewrite tree
  o Fix merge error in do_entArith: don't send SIGFPE on successful
    emulation.  From Ivan.

Rohit Seth <rohit.seth@intel.com>:
  o Broken Hugetlbpage support in 2.5.46

Roman Zippel <zippel@linux-m68k.org>:
  o remove old config tools
  o various kconfig updates
  o kconfig documentation update
  o kconfig update

Russell Cattelan <cattelan@sgi.com>:
  o [XFS] Fix fsx corruption
  o [XFS] narrow down comment

Russell King <rmk@arm.linux.org.uk>:
  o PCI hotplug comment fixes

Russell King <rmk@flint.arm.linux.org.uk>:
  o [MTD] Fix mtdblock.c build error Move spin_unlock_irq() down one
    line.
  o [ARM] Clean up sa1100 hardware specific headers
  o [SERIAL] Fix up ARM serial drivers This cset makes ARM serial
    drivers build.
  o [ARM] Fix typo in arch/arm/mm/Makefile Typo prevented ARM926 cpu
    enabled builds from succeeding.
  o [ARM] Make ARM SCSI drivers build 2.5.46 appears to require
    drivers/scsi/scsi.h to be included before drivers/scsi/hosts.h. 
    Make this happen in the Acorn SCSI drivers.
  o [ARM] Fixes for 2.5.46
  o [SERIAL] serial bits from -ac (from Alan Cox)
  o [MTD] mtdblock devices are called mtdblock%d not mtd%d
  o [ARM] Fix Acorn RISCPC mouse input driver
  o [ARM] Make rpckbd.c compile
  o [ARM] Make ambakmi.c compile
  o [ARM] Update RISC PC and Neponset default configurations
  o [GEN] Update credits + maintainers files for ARM people
  o [MTD] Avoid bad pointer dereferences in mtd partition cmd line
    parsing
  o [ARM] Actually update Neponset default configuration

Rusty Russell <rusty@rustcorp.com.au>:
  o Initializer conversions for drivers/block
  o vmalloc.h needs pgprot_t

Scott Feldman <scott.feldman@intel.com>:
  o e100 net driver: remove driver-isolated flag/lock

Scott Murray <scottm@somanetworks.com>:
  o 2.5.45 CompactPCI driver patches

Stephen Lord <lord@sgi.com>:
  o [XFS] Contributed fix from ASANO Masahiro <masano@tnes.nec.co.jp>.
    In calculating the layout of a log record for a buffer, the linux
    code deals with buffers which are not contiguous in memory - this
    only applies to an inode buffer.
  o [XFS] fix loop termination logic in xfs_sync
  o [XFS] break out the allocator specific parts of the xfs I/O path
    into a separate file, xfs_iomap.c out of xfs_lrw.c. Remove some
    parts
  o [XFS] remove VPURGE
  o [XFS] remove excess vn_remove from the unmount path
  o [XFS] Add XFS_POSIX_ACL to control ACL compilation in xfs

Takayoshi Koshi <t-kouchi@mvf.biglobe.ne.jp>:
  o ACPI PCI hotplug updates

Theodore Ts'o <tytso@snap.thunk.org>:
  o Fix illegal sleep in mbcache
  o Add '.' and '..' entries to be returned by readdir of htree
    directories
  o Check for failed kmalloc() in ext3_htree_store_dirent()
  o Fix ext3 htree rename bug
  o Fix meta_bg compatibility with e2fsprogs 1.30
  o Fix and simplify port of Orlov allocator to ext3

Tim Schmielau <tim@physik3.uni-rostock.de>:
  o move _STK_LIM to <linux_resource.h>

Tom Rini <trini@kernel.crashing.org>:
  o PPC32: Define default settings for advanced config options
  o PPC32: Remove more #ifdefs now that the config defines suitable
    defaults for the advanced kernel config options.

Trond Myklebust <trond.myklebust@fys.uio.no>:
  o Make ->readpages palatable to NFS
  o Convert NFS client to use ->readpages()
  o Fix typo in nfs_readpages
  o Add nfs_writepages & backing_dev
  o Make nfs_find_request() scale
  o add an NFS memory pool
  o slabify the sunrpc layer
  o Lift the 256 outstanding NFS read/write request limit
  o NFS coherency fix

Vitezslav Samel <samel@mail.cz>:
  o fix documentation in include_asm-i386_bitops.h

Zwane Mwaikambo <zwane@holomorphy.com>:
  o do_nmi needs irq_enter/irq_exit lovin'


