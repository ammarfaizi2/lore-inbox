Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266892AbUBRNkK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 08:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266894AbUBRNkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 08:40:10 -0500
Received: from hera.kernel.org ([63.209.29.2]:44446 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S266892AbUBRNiE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 08:38:04 -0500
Date: Wed, 18 Feb 2004 05:37:54 -0800
From: Marcelo Tosatti <marcelo@hera.kernel.org>
Message-Id: <200402181337.i1IDbsXU010467@hera.kernel.org>
To: linux-kernel@vger.kernel.org
Subject: linux-2.4.25 released
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

final:

- 2.4.25-rc4 was released as 2.4.25 with no changes.


Summary of changes from v2.4.25-rc3 to v2.4.25-rc4
============================================

<davem:nuts.davemloft.net>:
  o [SPARC64]: Fix build with sysctl disabled

<marcelo:logos.cnet>:
  o Changed EXTRAVERSION to -rc4

Andrea Arcangeli:
  o Return proper do_munmap() error code

Hideaki Yoshifuji:
  o [NETFILTER]: Better verification of TCP header len in ip{,6}_tables.c


Summary of changes from v2.4.25-rc2 to v2.4.25-rc3
============================================

<brazilnut:us.ibm.com>:
  o [NET]: Fix ethtool oops if device support get but not set ringparam

<emoore:lsil.com>:
  o MPT Fusion: fix IOCTL interface on ia64/x86-64

<kas:informatics.muni.cz>:
  o [NET]: Do not send negative 2nd arg to skb_put()

<marcelo:logos.cnet>:
  o Changed EXTRAVERSION to -rc3
  o Cset exclude: sri@us.ibm.com|ChangeSet|20040213195328|09088
  o Cset exclude: sri@us.ibm.com|ChangeSet|20040213011231|09074
  o Cset exclude: sri@us.ibm.com|ChangeSet|20040213005510|09081
  o Cset exclude: sri@us.ibm.com|ChangeSet|20040213003759|09793
  o revert 2.6 sctp sync, readd sla1.h, sla1.c, hashdriver.c, adler32.c

<miguel:cetuc.puc-rio.br>:
  o [NET_SCHED]: Fix slot leakage in SFQ scheduler

<quade:hsnr.de>:
  o Warn if negative size is passed to [v]snprintf

Chas Williams:
  o [ATM]: prevent userspace compilation errors with glibc-kernheaders
  o [ATM]: [he] unconditionalize extra pci reads to flush posted writes

Herbert Xu:
  o off-by-one kmalloc in ntfs


Summary of changes from v2.4.25-rc1 to v2.4.25-rc2
============================================

<brad:wasp.net.au>:
  o backport 2.6.x yenta detection fix

<davem:nuts.davemloft.net>:
  o [IPV4]: Use same sysctl number for IGMP version forcing as 2.6.x
  o [SPARC64]: Fix exception remaining length calcs in VIS copy routines

<john:neggie.net>:
  o toshiba_acpi 0.17 from John Belmonte

<khali:linux-fr.org>:
  o Small i2c maintainer correction

<len.brown:intel.com>:
  o [ACPI] proposed fix for AML parameter passing from Bob Moore http://bugzilla.kernel.org/show_bug.cgi?id=1766
  o [ACPI] proposed fix for AML parameter passing from Bob Moore http://bugzilla.kernel.org/show_bug.cgi?id=1766
  o [ACPI] fix IA64 build warning from Martin Hicks

<macro:ds2.pg.dga.pl>:
  o [NET]: Fix comment typo in net/socket.c

<marcelo:logos.cnet>:
  o Changed EXTRAVERSION to -rc2

<shaggy:kleikamp.dyn.webahead.ibm.com>:
  o JFS: rename should update mtime on source and target directories
  o JFS: Threads should exit with complete_and_exit

<sziwan:hell.org.pl>:
  o acpi4asus update from Karol 'sziwan' Kozimor

Adrian Bunk:
  o Fix amd7930_fn.c compilation with CONFIG_HOTPLUG=n

Alan Cox:
  o sstfb oops fix

Andrew Morton:
  o Improper handling of %c in vsscanf

Geert Uytterhoeven:
  o Fix fs/inode.c warning if !HIGHMEM

Keith Owens:
  o [XFS] No need to have xfs in mod-subdirs in the fs/Makefile anymore

Paul Mackerras:
  o [PPC64] Two small fixes for hvc_console (the hypervisor virtual console)



Summary of changes from v2.4.25-pre8 to v2.4.25-rc1
============================================

<chrisw:osdl.org>:
  o Verify interpreter arch

<davej:redhat.com>:
  o fix agpgart warning

<davem:nuts.davemloft.net>:
  o [IRDA]: Mark driver init/exit funcs static where possible
  o [SPARC64]: Fix TUNSETIFF ioctl compat, it takes an ifreq ptr not an int
  o [TG3]: Bump version and reldate
  o [SPARC64}: Fix ultra-III and later support of new-style SILO booting

<grundler:parisc-linux.org>:
  o [TG3]: Fix DMA test failures
  o [TG3]: Only fetch NVRAM_CMD reg if TG3_FLAG_NVRAM

<jlcooke:certainkey.com>:
  o [CRYPTO]: Help gcc optimize sha256/sha512 better

<jmorris:redhat.com>:
  o [CRYPTO]: Make padding[] array static in sha{256,512}_final()
  o Zero last byte of mount option page

<marcelo:logos.cnet>:
  o Changed EXTRAVERSION to -rc1

<rml:ximian.com>:
  o Fix sys_readahead(): Count free pages on maximum ra size calculation

Adrian Bunk:
  o fix a compile warning in amd76x_pm.c
  o fix a compile warning in tipar.c
  o fix a compile warning in InterMezzo file.c

Ben Collins:
  o [SPARC64]: Add comment for HdrS ver 0x201
  o [SPARC64]: Add header for section boundary references
  o [SPARC64]: Changes to accomodate booting from non-phys_base memory

Chas Williams:
  o [ATM]: [idt77252] fix dma_addr_t type error with CONFIG_HIGHMEM64G=y (by "Randy.Dunlap" <rddunlap@osdl.org>)
  o [ATM]: [clip] check return code from kmem_cache_create (by "Randy.Dunlap" <rddunlap@osdl.org>)

Christoph Hellwig:
  o [XFS] Small ktrace fixes
  o [XFS] Don't fail pagebuf allocations

David Brownell:
  o usb/gadget/file_storage.c doesn't compile with gcc 2.95

David S. Miller:
  o [DECNET]: Fix filling in of header length field
  o [CREDITS]: Update Bjorn Ekwall's address

David Stevens:
  o [IPV4]: Add per-device sysctl to force IGMP version
  o [IPV4]: Fix IGMP device reference counting

Harald Welte:
  o [NETFILTER]: Fix ipt_conntrack/ipt_state module refcounting
  o [NETFILTER]: Really fix ipt_state/ipt_conntrack refcounting

Herbert Xu:
  o invalid kfree in ntfs_printcb

Luca Tettamanti:
  o Fix ac97_plugin_ad1980.c compilation warning
  o Fix aha1542.c compilation warning
  o Fix cpqfcTSi2c.c compilation warning
  o IEEE1394(r1123): Fix compile warning
  o Fix amd7930_fn.h compilation warning
  o Fix drivers/net/wan/8253x/crc32.c compilation warning
  o Fix vac-serial.c compilation warning

Mirko Lindner:
  o sk98lin: Reset Xmac when stopping the port

Nathan Scott:
  o [XFS] Remove xfsidbg debugger interfaces, not useful without kdb
  o [XFS] Fix a warning from some gcc variants after recent flags botch
  o [XFS] Add the security extended attributes namespace
  o [XFS] Remove no-longer-needed debug symbol exports

Patrick McHardy:
  o [NET_SCHED]: Add HFSC packet scheduler

Russell Cattelan:
  o [XFS] Christoph has signed over copyrights
  o [XFS] Move bits around to better manage common code.  No functional change
  o [XFS] Remove non 2.4 ifdefs from the linux-2.4 dir

Rusty Russell:
  o [NETFILTER]: ipt_limit fix for HZ=1000

Scott Feldman:
  o e100 sync with 2.6


Summary of changes from v2.4.25-pre7 to v2.4.25-pre8
============================================

<drb:med.co.nz>:
  o USB Storage: patch to unusual_devs.h for Pentax Optio 330GS camera

<emoore:lsil.com>:
  o SCSI fusion driver update - version 2.05.11.01

<felipe_alfaro:linuxmail.org>:
  o USB Storage: unusual_devs.h patch for Trumpion MP3 player

<francis.wiran:hp.com>:
  o cpqarray update

<khali:linux-fr.org>:
  o Fix bus reset in i2c-philips-par

<ladis:linux-mips.org>:
  o fix console_cmdline to match declaration

<len.brown:intel.com>:
  o [ACPI] ACPICA 20040116 from Bob Moore
  o [ACPI] move zero initialized data to .bss from Jes Sorensen
  o [ACPI] handle system with NULL DSDT and valid XDSDT from ia64 via Alex Williamson

<marcelo:logos.cnet>:
  o Dave Jones: Fix XFS misplaced "!" (not)
  o Cset exclude: johnstul@us.ibm.com|ChangeSet|20031206183542|49434
  o Add missing drivers/video/it8181fb.c (IT8181 framebuffer driver)
  o Changed EXTRAVERSION to -pre8
  o PC300: check copy_to_user() return value

<michael.krauth:web.de>:
  o USB: unusual-devs.h Patch for Kyocera Finecam L3

<rth:kanga.twiddle.home>:
  o [ALPHA] Tidy ELF_HWCAP and ELF_PLATFORM

<steve:navaho.co.uk>:
  o ALIM7101 watchdog honour NOWAYOUT flag

<tritol:trilogic.cz>:
  o USB: unusual_devs entry for Netac USB-CF

<urban.widmark:enlight.net>:
  o smbfs: struct with smb_ functions (1/3)
  o smbfs: CIFS Unix Extensions (2/3)
  o smbfs: Large File Support (3/3)

<xose:wanadoo.es>:
  o [netdrvr ns83820] s/PREPARE_TQUEUE/INIT_TQUEUE/

<yuasa:hh.iij4u.or.jp>:
  o Added PCI device ID for it8181fb

Adrian Bunk:
  o fix via-ircc.c .text.exit error
  o small hptraid.c fix
  o pc300_drv.c: mark a function pointer as __devexit_p

Alan Stern:
  o USB storage: unusual_devs.h change
  o USB Storage: another unneeded unusual_devs entry
  o USB Storage: another unusual_devs entry
  o USB Storage: unusual_devs.h update

Andi Kleen:
  o x86-64 merge

Arnaud Quette:
  o USB: disable hiddev support for MGE UPSs

Ben Collins:
  o [SPARC64]: Add CONFIG_DEBUG_BOOTMEM option
  o [SPARC64]: Correctly mask the physical address for remapping the kernel TLB's
  o [SPARC/SBUS/FLASH]: Fix some "unused var" warnings

Chas Williams:
  o [ATM]: [horizon] avoid warning about limited range of data type

David Brownell:
  o USB gadget: <linux/usb_gadget.h> updates [1/7]
  o USB gadget: add file_storage gadget driver [2/7]
  o USB gadget: add goku_udc (Toshiba TC86C001) [3/7]
  o USB gadget: gadget build/config updates [4/7]
  o USB gadget: gadget zero driver updates [5/7]
  o USB gadget: ethernet gadget updates [6/7]
  o USB gadget: net2280 controller driver updates [7/7]
  o USB: EHCI support on MIPS
  o USB: ehci update:  1/3, misc
  o USB: ehci update:  2/3, microframe scanning
  o USB:  ehci update:  3/3, highspeed iso rewrite

David S. Miller:
  o [SPARC64]: Fix double patch in head.S

David Stevens:
  o [MULTICAST]: multicast loop with include filters fix

David T. Hollis:
  o USB: Remove standalone AX8817x driver
  o USB: Remove standalone AX8817x  driver Config.in entry

Greg Kroah-Hartman:
  o USB: add test for B4000000 to ir-usb driver to fix build issue on some archs
  o USB: add support for the Clie PEG-TJ25 device

Herbert Xu:
  o USB Storage: revert freecom dvd-rw fx-50 usb-ide patch

Hirofumi Ogawa:
  o [netdrvr 8139cp] fix NAPI race

Jeff Garzik:
  o [tokenring olympic] use memset_io to fix certain platforms

Krzysztof Halasa:
  o warning fix: remove unused do_gettimeoffset_cyclone() when !CONFIG_X86_SUMMIT
  o Remove dead CONFIG_BLK_DEV_IDE_MODES

Mikael Pettersson:
  o 2.4.25-pre7 load_LDT() bug in setup.c

Oliver Neukum:
  o USB: memory allocations in storage code path for 2.4
  o USB: 2.4 memory deadlock avoidance

Pete Zaitcev:
  o USB: Patch for usb-storage in 2.4
  o USB: fix 2.4 usbdevfs race

Randy Dunlap:
  o repair scsi/pcmcia modules so that they can build by only including scsi_module.c for non-PCMCIA builds

Rusty Russell:
  o Add 2.6 module_param() compatibility macros

Stephen Hemminger:
  o Make xircom cardbus handle shared irq

Wolfgang Muees:
  o USB: auerswald driver: add a new device



Summary of changes from v2.4.25-pre6 to v2.4.25-pre7
============================================

<alex.williamson:hp.com>:
  o ia64: sba_iommu update
  o ia64: sba_iommu: use memparse, long double

<bjorn.helgaas:hp.com>:
  o ia64: work around a menuconfig bug
  o ia64: Fix system type selection to workaround menuconfig bug (select "HP", get "HP-simulator").
  o ia64: Fix broken merge (remove mmu_gathers[] defn)
  o ia64: Skip zero-length resources in PCI root bridge _CRS
  o ia64: sba_iommu: print note about reserving IOVA space for agpgart
  o ia64: Export acpi_hp_csr_space() for modular agpgart
  o ia64: Add acpi_register_irq() interface

<grundler:parisc-linux.org>:
  o obmouse driver for HP OB600 C/CT laptop

<jet:gyve.org>:
  o Fix hfs oops

<marcelo:logos.cnet>:
  o Changed EXTRAVERSION to -pre7

Adrian Bunk:
  o simplify PARPORT_PC_PCMCIA dependencies

Arun Sharma:
  o ia64: ia32 sigaltstack() fix

Atul Mukker:
  o megaraid2 update

Bjorn Helgaas:
  o ia64 HP iommu: add "sx1000" detection (no functional change)

Dave Kleikamp:
  o JFS: Avoid segfault when dirty inodes are written on readonly mount
  o JFS: Creating large xattr lists may cause BUG

Dean Roehrich:
  o [XFS] In xfs_bulkstat, we need to do the readahead loop always

Eric Sandeen:
  o [XFS] Fix for large allocation groups, so that extent sizes will not overflow pagebuf lengths.

Hirofumi Ogawa:
  o FAT: Support large partition (> 128GB)

Jack Steiner:
  o ia64: fix ia64_ctx.lock deadlock

Keith Owens:
  o ia64: fix deadlock in ia64_mca_cmc_int_caller()
  o ia64: Avoid double clear of CMC/CPE records

Manfred Spraul:
  o ldt optimization

Martin Hicks:
  o ia64: Move mmu_gathers[] to local_cpu_data on ia64 (only ia64-specific bits)

Matthew Wilcox:
  o ia64: Add generic RAID xor routines with prefetch

Petr Vandrovec:
  o Deep stack usage in ncpfs

Ralf Bächle:
  o MIPS updates
  o MIPS/DECstation video drivers update
  o Turbochannel driver updates

Rik van Riel:
  o some more fixes for fs/inode.c inode reclaiming changes

Seth Rohit:
  o ia64: hugetlb support (ia64-specific parts)

Stéphane Eranian:
  o ia64: Fix PFM_WRITE_PMCS failure in system-wide mode when PMC12 is zero

Tom Rini:
  o PPC32: Fix finding the MAC address on Motorola MBX860
  o PPC32: Fix the todc definitions for mc146818

Tony Luck:
  o ia64: enable recovery from TLB errors



Summary of changes from v2.4.25-pre5 to v2.4.25-pre6
============================================

<jmorris:redhat.com>:
  o [CRYPTO]: Clean up tcrypt module and allow it to be unloaded

<kartik_me:hotmail.com>:
  o [CRYPTO]: Add CAST6 (CAST-256) algorithm

<marcelo:logos.cnet>:
  o Changed EXTRAVERSION to -pre6

<my:utfors.se>:
  o [CRYPTO]: Move ivsize from algorithm to tfm

Andi Kleen:
  o x86-64 update

Chas Williams:
  o [ATM]: br2684 incorrectly handles frames recvd with FCS (by Alex Zeffertt <ajz@cambridgebroadband.com>)
  o [ATM]: [nicstar] convert to new style pci module (by "Jorge Boncompte [DTI2]" <jorge@dti2.net>)
  o [ATM]: better behavior for sendmsg/recvmsg during async closes
  o [ATM]: refcount atm sockets

David S. Miller:
  o [SPARC64]: In early bootup, BUG() if cannot find TLB entry for remapping
  o [SPARC64]: Disable PCI ROM address OBP sanity check for now
  o [IPV4]: Print correct source addr in invalid ICMP msgs, from Dennis Jorgensen

David Stevens:
  o [IPV4/IPV6]: In MLD, add new filter first, then delete old one

David Woodhouse:
  o Do not leave inodes with stale waitqueue on slab cache

Harald Welte:
  o [NETFILTER]: Add config help texts for IP_NF_ARP{TABLES,FILTER}

Jean Tourrilhes:
  o NSC '39x support
  o VIA IrDA driver

Kurt Garloff:
  o [NETFILTER]: Align nulldevname properly in ip_tables

Marcel Holtmann:
  o [Bluetooth] Use R2 for default value of pscan_rep_mode
  o [Bluetooth] Set disconnect timer for incoming ACL links
  o [Bluetooth] Start inquiry if cache is empty
  o [Bluetooth] Change maintainer role of the Bluetooth subsystem


Summary of changes from v2.4.25-pre4 to v2.4.25-pre5
============================================

<bjorn.helgaas:hp.com>:
  o ia64 Configure.help update

<davej:redhat.com>:
  o Add AGP support for Radeon IGP 345M

<jack:ucw.cz>:
  o Fix ext3/quota deadlock

<khali:linux-fr.org>:
  o i2c cleanups: Config.in
  o i2c cleanup: saa7146.h should include i2c-old.h, not i2c.h
  o i2c cleanup: i2c-core fixes

<len.brown:intel.com>:
  o [ACPI] fix smpboot.c mis-merge http://bugzilla.kernel.org/show_bug.cgi?id=1706

<marcelo:logos.cnet>:
  o Cset exclude: rtjohnso@eecs.berkeley.edu|ChangeSet|20040109135735|05388
  o Fix microcode update compilation error
  o Fix Makefile typo

<moilanen:austin.ibm.com>:
  o [PPC64] Improved NVRAM handling
  o [PPC64] Buffer error log entries in NVRAM

<nitin.a.kamble:intel.com>:
  o microcode update

<rtjohnso:eecs.berkeley.edu>:
  o USB ioctl fixes (vicam.c, w9968cf.c)

<sfr:au1.ibm.com>:
  o [PPC64] Fix a compile warning that becomes an error with gcc 3.4

<thomas:winischhofer.net>:
  o SiS Framebuffer driver update

<xose:wanadoo.es>:
  o ips SCSI driver update

Adrian Bunk:
  o fix CONFIG_DS1742 Config.in entry
  o remove REPORT_LUNS from cpqfcTSstructs.h
  o disallow modular CONFIG_COMX

Alan Cox:
  o Fix USB hangs
  o Minimal fix for the R128 drivers

Bartlomiej Zolnierkiewicz:
  o create /proc/ide/hdX/capacity only once

Ben Collins:
  o [IEEE1394]: Fix bug in updating configrom

David Engebretsen:
  o [PPC64] Distribute processing of hypervisor events over all processors

David Woodhouse:
  o Fix SMP deadlock in __wait_on_freeing_inode() (introduced during 2.4.23)

Hugh Dickins:
  o tmpfs readdir does not update dir atime

Paul Mackerras:
  o [PPC64] Remove some unnecessary code from arch/ppc64/kernel/prom.c
  o [PPC64] Make /dev/sda3 the default root device (rather than sda2)
  o [PPC64] Add functions to update and manage flash ROM under Linux on pSeries
  o [PPC64] Update defconfig and the example configs

Pete Zaitcev:
  o Unhork ymfpci broken by hasty janitors

Rik van Riel:
  o Reclaim inodes with highmem pages when low on memory

Tom Rini:
  o PPC32: Add support for the CPCI-405 board
  o PPC32: Fix cross-compilation from Solaris or Cygwin
  o PPC32: s/CONFIG_SMC2_UART/CONFIG_8xx_SMC2/g to match the code


Summary of changes from v2.4.24-pre3 to v2.4.25-pre4
============================================

<bjorn.helgaas:hp.com>:
  o Fix 2.4 EFI RTC oops

<lethal:unusual.internal.linux-sh.org>:
  o sh/sh64: Add CONFIG_OOM_KILLER entries
  o sh: Add EXPEVT to pt_regs
  o sh64: Add dma.o to export-objs
  o sh64: shwdt updates

<marcelo.tosatti:cyclades.com>:
  o Andrea Arcangeli: malicious users of mremap() syscall can gain priviledges

<marcelo:logos.cnet>:
  o Harald Welte: Fix ipchains MASQUERADE oops
  o Change EXTRAVERSION to 2.4.24-rc1
  o Cset exclude: bjorn.helgaas@hp.com|ChangeSet|20031218183339|13120
  o Cset exclude: trini@mvista.com|ChangeSet|20031210203050|36304
  o Cset exclude: jt@bougret.hpl.hp.com|ChangeSet|20031213132008|01226
  o Cset exclude: laforge@netfilter.org|ChangeSet|20031204183256|31723
  o Change Makefile to 2.4.24-rc1

<trini:mvista.com>:
  o /dev/rtc can leak parts of kernel memory to unpriviledged users

David Engebretsen:
  o [PPC64] Store and use the ibm,phandle device-tree property from OF
  o [PPC64] Export Logical Partitioning config data to userspace

David S. Miller:
  o [TG3]: Update version and reldate

Erik Andersen:
  o fix broken 2.4.x rt_sigprocmask error handling

François Romieu:
  o [TG3]: Fix bogus return value in tg3_init_one()

Herbert Xu:
  o Handle j_commit_interval == 0

Hollis Blanchard:
  o [PPC64] Recognize new-style device-tree nodes for virtual terminals

Jean Tourrilhes:
  o IrDA kernel log buster

Kai Makisara:
  o SCSI tape bug fix (variable block mode,

Linus Torvalds:
  o Daniel Tram Lux: IDE timeout race fix

Martin Schwidefsky:
  o S390 base fixes
  o S390 common i/o layer fixes
  o S390: 31 bit compat bug fixes
  o S390: ctc network driver update
  o S390: xpram device driver
  o S390: DASD update

Oleg Drokin:
  o Fix megaraid leak survived by latest update

Olof Johansson:
  o [PPC64] Rename some RTAS-specific constants to avoid name clashes

Paul Mackerras:
  o [PPC64] Remove references to KDB since it isn't in the official tree
  o [PPC64] Fix compilation with CONFIG_SMP=n
  o [PPC64] Add include/asm-ppc64/iSeries/vio.h which was missed before
  o [PPC64] Add support for the VMX (aka Altivec) unit on the PPC970
  o [PPC64] Add CPU feature bits to indicate presence of breakpoint registers
  o [PPC64] Fix a few compile warnings and remove some dead code
  o [PPC64] Fix a bug in starting kernel threads
  o [PPC64] Set ELF_HWCAP to something useful: a bitmap of CPU features
  o [PPC64] Fix for periodic interrupts on iSeries with shared processors
  o [PPC64] Cope with slow RTC chips
  o [PPC64] Better handling of machine checks
  o [PPC64] Don't create /proc/rtas files for unimplemented services
  o [PPC64] Fix up bug in setting up the firmware features bitmap
  o [PPC64] Fix a compile error introduced with some recent changes

Theodore Y. T'so:
  o EXT2/3 Updates: Reclaim pages in truncate
  o EXT2/3 Updates: 2.6 EA symlink compatibility
  o EXT2/3 Updates: forward-compatibility: online resizing
  o EXT2/3 Updates: Allow filesystems with expanded inodes to be mounted

Tom Rini:
  o PPC32: Add support for the OpenPIC register set to be in BE mode
  o PPC32: Fix the floppy driver, on CONFIG_NOT_COHERENT_CACHE
  o PPC32: Fix a typo in two files
  o PPC32: Fix memory detection of PReP machines with OF

Willem Riede:
  o OnStream tape driver update


Summary of changes from v2.4.24-pre2 to v2.4.24-pre3
============================================

<khali:linux-fr.org>:
  o i2c cleanup: Fix dependancies between the various SCx200 drivers
  o i2c cleanup: Remove old compatibility code
  o i2c cleanup: documentation

<marcelo:logos.cnet>:
  o Changed EXTRAVERSION to -pre3
  o Cset exclude: marcelo@logos.cnet|ChangeSet|20031228201456|00847
  o Cset exclude: marcelo@logos.cnet|ChangeSet|20031228200956|00864
  o Cset exclude: marcelo@logos.cnet|ChangeSet|20031231111415|59075

<mfedyk:matchmail.com>:
  o Use "%u" when printing extended /proc/partitions statistics
  o extended stats correction: Field rd_ios can be negative

<mgalgoci:redhat.com>:
  o Trivial SubmittingDrivers fix

<nuno:itsari.org>:
  o Ulrich Drepper: fix 'noexec' behaviour

<waltabbyh:comcast.net>:
  o Fix pdcraid geometry detection

<xose:wanadoo.es>:
  o LVM 1.0.8 update

Adrian Bunk:
  o dep_tristate wants 3 arguments (fwd)

Alan Cox:
  o 2.4 zr36120 missing dependancies

Bart De Schuymer:
  o [BRIDGE]: Fix loopback over bridge port

David S. Miller:
  o [SPARC64]: On Sabre, only access PCI controller config space specially
  o [SPARC64]: Update defconfig

Eyal Lebedinsky:
  o Fix cciss build problem

Hideaki Yoshifuji:
  o [NET]: Fix mis-spellings in net/core/neighbour.c

James McMechan:
  o Fix tmpfs dcache oops

Keith M. Wesolowski:
  o [SPARC32]: Add myself as maintainer

Krzysztof Halasa:
  o Goramo PCI200SYN sync card driver
  o Generic HDLC cleanup

Michael Hunold:
  o change two annoying messages from fb drivers (clgenfb and hgafb)

Patrick McHardy:
  o [PKT_SCHED]: Fix module refcount and mem leaks in classful qdiscs
  o [PKT_SCHED]: Remove backlog accounting from TBF, pass limit to default inner bfifo qdisc only

Ralf Bächle:
  o de4x5 EISA fix

Tom Rini:
  o PPC32: Two warning fixes, from Geert Uytterhoeven <geert@linux-m68k.org>
  o PPC32: Remove ASYNC_SKIP_TEST from all of our serial flags
  o PPC32: Add a watchdog driver for MPC8xx machines
  o PPC32: Add a CONFIG_OOM_KILLER entry
  o PPC32: Fix dependancies on the bootwrapper ld script
  o PPC32: Fix a warning on 'make zImage' for a number of platforms
  o PPC32: Add support for the Motorola Sandpoint X3 (all revs)
  o PPC32: Add support for the Motorola PRPMC750
  o PPC32: Fix the mkprep util to work correctly on Solaris 8
  o PPC32: Fix znetboot and znetboot.initrd Original patch from Eugene Surovegin <ebs@ebshome.net>, with a few more changes from myself.


Summary of changes from v2.4.24-pre1 to v2.4.24-pre2
============================================

<achirica:telefonica.net>:
  o [wireless airo] Fix PCI registration
  o [wireless airo] Delay MIC activation to prevent Oops

<alexander:all-2.com>:
  o USB storage: patch for unusual_devs.h

<berentsen:sent5.uni-duisburg.de>:
  o USB storage: Minolta Dimage S414 usb patch

<bjorn.helgaas:hp.com>:
  o Fix 2.4 EFI RTC oops
  o 2.4 IA64 DRM interface changes

<boutcher:us.ibm.com>:
  o [PPC64] Set the ASR correctly for ISTAR and PULSAR processors

<dancy:dancysoft.com>:
  o USB: add TIOCMIWAIT support to pl2303 driver

<daniela:cyclades.com>:
  o Add Cyclades PC300 driver

<engebret:au1.ibm.com>:
  o [PPC64] Add some more definitions needed for SMT support
  o [PPC64] Add support for shared processors on partitioned systems
  o [PPC64] Modify spinlocks to be more efficient on shared processors
  o [PPC64] Add a /proc interface to control SMT configuration settings

<fello:libero.it>:
  o USB storage: patch for Fujifilm EX-20

<khali:linux-fr.org>:
  o i2c core cleanups
  o i2c documentation
  o i2c printk fixes
  o Remove sa1100 unused header

<krishnakumar:naturesoft.net>:
  o [netdrvr 8139too] support netif_msg_* interface

<len.brown:intel.com>:
  o [ACPI]  fix xconfig failure (Matt Wilcox) http://bugzilla.kernel.org/show_bug.cgi?id=1568
  o [ACPI] handle sparse APIC-IDs in the face of reduced NR_CPUS
  o [ACPI] add warning to thermal shutdown (Pavel Machek)
  o [ACPI] change hard-coded IO width to programmable width (Shaohua David Li) http://bugzilla.kernel.org/show_bug.cgi?id=1349
  o [ACPI] set APIC ACPI SCI OVR default to level/low http://bugzilla.kernel.org/show_bug.cgi?id=1351
  o [ACPI] revert two fixes in preparation for ACPICA merge
  o [ACPI] update Linux to ACPICA 20031029 (Bob Moore)
  o [ACPI] Update Linux to ACPICA 20031203 (Bob Moore)
  o [ACPI] delete old _TRA code formerly used just by IA64. (Bjorn Helgaas) The current approach is to walk the _CRS in pcibios_scan_root() using acpi_walk_resources(). 
  o [ACPI] set acpi_disabled=1 on failure for clean /proc http://bugzilla.kernel.org/show_bug.cgi?id=991

<linas:us.ibm.com>:
  o [PPC64] Use the correct functions to access user memory in proc file routines

<luca.risolia:studio.unibo.it>:
  o USB: W996[87]CF driver update

<marcelo:logos.cnet>:
  o Ernie Petrides: Fix __alloc_pages PF_MEMDIE handling
  o page_alloc.c: Fix typo
  o Changed EXTRAVERSION to -pre2

<marr:flex.com>:
  o USB: MCT-U232 Patch for cts

<mbp:samba.org>:
  o USB storage: add unusual storage device entry for Minolta DiMAGE

<mikem:beardog.cca.cpqcorp.net>:
  o cciss update part 1
  o cciss update part 2
  o cciss update part 3: enable prefetch on i386

<moilanen:us.ibm.com>:
  o [PPC64] Cope with unknown PCI host bridges when running under hypervisor

<per.winkvist:uk.com>:
  o USB storage: Make Pentax Optio S4 work

<petkan:nucleusys.com>:
  o USB: pegasus driver update

<stephane.galles:free.fr>:
  o USB storage: patch for Kyocera S5 camera

<t-kochi:bq.jp.nec.com>:
  o duplicate PID fix

<tchen:on-go.com>:
  o USB: fix bug when errors happen in ioedgeport driver
  o USB: fix io_edgeport driver alignment issues

<trini:mvista.com>:
  o Fix rtc leak

<_nessuno_:katamail.com>:
  o USB storage: Medion 6047 Digital Camera

Adrian Bunk:
  o Ask for CONFIG_INDYDOG only on mips
  o fix two pcmcia/cardbus.c compile warnings

Alan Stern:
  o USB storage: unusual_devs.h entry revision
  o USB storage: Another unusual_devs.h update
  o USB storage: Unusual_devs.h addition

Benjamin Herrenschmidt:
  o [PPC64] Clean up arch/ppc64/kernel/head.S a bit; fix bug on iSeries

Chuck Lever:
  o NFS O_DIRECT offset wrap bug

David Dillow:
  o Bug fixes

David Engebretsen:
  o PPC64: Use r13 to point to a per-processor data area rather than current
  o [PPC64] Makefile fixes: use $(CC), -fno-zero-initialized-in-bss
  o [PPC64] Boot wrapper improvements
  o [PPC64] Fix save_flags/restore_flags on iSeries
  o [PPC64] Fix setting/clearing of the RI (recoverable interrupt) bit
  o [PPC64] Rework IRQ code so we can handle systems with large IRQ numbers
  o [PPC64] Add support for SMT (multi-threaded) processors

David Hinds:
  o Re: UPD: "do_IRQ: near stack overflow" when inserting CF disk
  o fix PCMCIA interrupt allocation
  o fix PCMCIA memory resource management bug
  o fix logging levels for yenta socket driver

David S. Miller:
  o [SPARC32]: Fix build after asm/system.h include was added to linux/spinlock.h

Eric Brower:
  o [SPARC64]: SUNW,lombus device has nonstandard ebus child regs too

Eric Sandeen:
  o [XFS] Update xfs_showargs to reflect all current mount options

Greg Kroah-Hartman:
  o USB: add support for Protego devices to ftdi_sio driver
  o USB: add support for another pl2303 device
  o USB: add support for Sony UX50 device to visor driver

Henning Meier-Geinitz:
  o USB: scanner driver: new device ids

Herbert Xu:
  o USB Storage: freecom dvd-rw fx-50 usb-ide patch

Jean Tourrilhes:
  o IrDA kernel log buster

Jeff Garzik:
  o [netdrvr natsemi] backport 2.6 fixes and cleanups
  o [netdrvr starfire] remove duplicate include

Marcel Holtmann:
  o User level driver support for input subsystem
  o [Bluetooth] Update HCI security filter
  o [Bluetooth] Support inquiry results with RSSI
  o [Bluetooth] Remove copy of sockfd_lookup()
  o [Bluetooth] Cosmetic cleanup of the HCI USB driver
  o Fix LED's for input subsystem keyboards
  o Add Bluetooth to the bus types of the input subsystem

Matt Domsch:
  o EDD: move DISK80_SIG_BUFFER to 0x2cc in empty_zero_page
  o zero-page.txt: note 0x228 as in use by unknown

Mirko Lindner:
  o sk98lin-2.4: Kernel Update to Driver Version v6.21
  o sk98lin-2.4: Readme Update to Driver Version v6.21
  o sk98lin-2.4: Configure.help Update to Driver Version
  o sk98lin-2.4: pci.ids Update to Driver Version v6.21

Nathan Scott:
  o [XFS] No need to initialise struct xfs_trans field to null after a zalloc
  o [XFS] Remove some spurious double semi-colons
  o [XFS] Fix async pagebuf I/O tracing at the bottom of pagebuf_get
  o [XFS] Fix a small pagebuf memory leak and keep track of slab pages ourselves
  o [XFS] Fix an XFS release_page case where unwritten extents may cause I/O incorrectly
  o [XFS] Should not add comments right before checkin - add closing comment delimiter
  o [XFS] Cleanup bdevname conditional code in xfs_buf headers
  o [XFS] Remove some unnecessary conditional refcache code
  o [XFS] Remove some unnecessary kernel-version conditional code
  o [XFS] Rework some casts and use of sector_t in some address_space operations
  o [XFS] Remove some kernel-version macros around old I/O path code
  o [XFS] Rework some extended attributes code to make it more easily extended
  o [XFS] Remove the partial support for the Large Block Device patch from XFS
  o [XFS] Remove remaining conditional code for the Large Block Device patch

Neil Brown:
  o Fix RAID1 blocksize check

Olof Johansson:
  o [PPC64] Fix smp_call_function so we don't crash if an IPI is very late
  o [PPC64] Make sure we don't take a segment miss in a critical region
  o [PPC64] Better default port, irq and flag settings for ttyS2/3

Paul Mackerras:
  o [PPC64] Make sure the user stack pointer is 16-byte aligned on signal delivery
  o [PPC64] Fix stack expansion bug
  o [PPC64] Fix compile error in arch/ppc64/kernel/pmc.c
  o [PPC64] Fix and extend 32-bit syscall emulation code
  o [PPC64] Add some hypervisor call functions, rename HSC to HVSC
  o [PPC64] Add virtual I/O infrastructure for pSeries and iSeries
  o [PPC64] Fix a page-crossing bug in HvCall_writeLogBuffer
  o [PPC64] Fixes for the TCE (DMA mapping table) code

Pete Zaitcev:
  o USB: Backport of printer 2.6=>2.4

Ralf Bächle:
  o Undo accidental deletion of MWave config bits
  o Update generic MIPS code
  o Add support for PMC Sierra Yosemite eval board
  o Update code for NEC VR41xx systems
  o Alchemy updates
  o Update defconfigs
  o Update MIPS evaluation board support
  o SGI IP22 updates
  o Sibyte build fixes and defconfig updates
  o NEC DDB updates
  o DEC updates
  o Update MIPS char drivers
  o PMAG-AA fb driver update
  o EV96100 cleanup
  o PI1 parport driver fixes
  o Remove bitrotten MIPS bits in char/misc.c
  o Initialize ioc3_timer before use
  o de4x5 EISA fix
  o Pass LDFLAGS to all linker invocations

Steven Cole:
  o update scripts/ver_linux  for xfsprogs




Summary of changes from v2.4.23 to v2.4.24-pre1
============================================

<alex.williamson:hp.com>:
  o ia64: make hpzx1 fake pci device safer

<aspicht:arkeia.com>:
  o ac97_plugin_ad1980 fixes

<bjorn.helgaas:hp.com>:
  o ia64: Remove platform_pci_enable_device() machine vector and synchronize sba_iommu.c with 2.5.
  o ia64: Bail out of SBA init function if no IOC found.  Avoids spurious (but harmless) "No IOC for PCI Bus 0000:00 in ACPI" messages when booting generic kernel on non-ZX1 hardware.
  o ia64: Clear corrected errors (CMCs and CPEs) in the kernel
  o ia64: The "HP_ZX1" kernel works on sx1000-based machines as well as zx1-based ones, so make the descriptions a little more generic.
  o ia64: add kmap_types.h to make crypto, etc compile.  (This is just a dummy file from 2.6 and shouldn't ever be used.)
  o ia64: fix EFI memory map trimming
  o Cset exclude: kaos@sgi.com[helgaas]|ChangeSet|20031030215302|13517
  o ia64: update default configs

<cattelan:lupo.thebarn.com>:
  o Gone dmapi

<cattelan:naboo.americas.sgi.com>:
  o [XFS] switch xfs to use linux imode flags internally

<cattelan:naboo.eagan>:
  o Import changeset

<galak:blarg.somerset.sps.mot.com>:
  o [SERIAL] Make the Startech & 16552D UART detection 'more correct'

<iod00d:hp.com>:
  o ia64: put xor functions in .S file (backported from 2.6)

<jsm:fc.hp.com>:
  o ia64: fix show_mem() panic

<kolya:mit.edu>:
  o [NET]: Allow SOMAXCONN to be adjusted via sysctl

<kyle:engsoc.carleton.ca>:
  o ia64: Don't print anything for unimplemented syscalls

<marcelo:logos.cnet>:
  o Ernie Petrides: Readd exec_mmap() fastpath with correct locking
  o Readd the OOM killer as configurable option, defaulted to off

<nathans:bruce.melbourne.sgi.com>:
  o [XFS] Remove some unused pagebuf source and header files
  o Fix utimes(2) and immutable/append-only files.  Originally by Ethan Benson
  o Remove some unused macros and related comment from the XFS quota header
  o Add a process flag to identify a process performing a transaction
  o Support for delayed allocation.  Used by XFS and backported from 2.6
  o Provide a simple try-lock based dirty page flushing routine
  o Provide an iget variant without unlocking the inode and without the read_inode call (iget_locked).  Used by XFS and backported from 2.6.
  o Export several kernel symbols used by the XFS filesystem
  o Add XFS documentation and incorporate XFS into the kernel build

<pavlin:icir.org>:
  o [RTNETLINK]: Add RTPROT_XORP

<pp:ee.oulu.fi>:
  o 2.4 lacks dummy SET_NETDEV_DEV

<tes:sgi.com>:
  o [XFS] pv=892598; rv=nathans@sgi.com; Change xlog_verify_iclog() to use idx as zero based instead

<wessmith:sgi.com>:
  o [XFS] Work around gcc 2.96 bug in _lsn_cmp

<xose:wanadoo.es>:
  o [TG3]: Add new device IDs

Adam Radford:
  o 3ware driver update for 2.4.23-bk2

Arun Sharma:
  o ia64: MINSIGSTKSZ on ia32
  o ia64: CONFIG_IA32_SUPPORT can only be static, not a module
  o ia64: make strace of ia32 processes work again
  o ia64: Don't mix user/kernel pointers in 32-bit stat/statfs emulation

Ben Greear:
  o [VLAN]: Add GET_VLAN_REALDEV_NAME_CMD and GET_VLAN_VID_CMD

Chris Mason:
  o From -aa tree: Fix end_buffer_io_kiobuf() locking

Chuck Lever:
  o Make readahead last page of file

David Hinds:
  o update/bugfix for pcnet_cs driver

David Mosberger:
  o ia64: In <asm-ia64/param.h>, do not include <linux/config.h> outside the #ifdef __KERNEL__ bracket.  Doing so pollutes the user- level namespace.  Bug report & proposed fix by GOTO Masanori.
  o ia64: Control /proc/bus/mckinley/zx1 via separate SBA_PROC_FS macro and turn SBA_PROC_FS off by default (it's too much of a scalability bottleneck).
  o ia64: Mark access_ok() as likely to succeed (as is done in x86 tree)
  o ia64: Fix efi_mem_type() and efi_mem_attributes() to avoid potential underflows.  In my case, the underflows occurred with the first memory descriptor which got trimmed down to a size of 0.
  o ia64: Fix a alternate-signal-stack bug which could corrupt RNaT bits when bspstore happened to point to an RNaT-slot.
  o ia64: Fix a bug in sigtramp() which corrupted ar.rnat when unwinding across a signal trampoline (in user space).  Reported by Laurent Morichetti.

David S. Miller:
  o [TCP]: Put Alexey's -EAGAIN change back in with Linus's fix on top
  o [NETLINK]: Initialize nl_pad in getname and recvmsg, noticed by Uli Drepper
  o [PACKET]: In packet_recvmsg(), test correct flags for MSG_TRUNC handling
  o [PACKET]: Revert MSG_TRUNC change, the original behavior was intentional
  o [NET]: In sock_queue_rcv_skb(), do not deref skb->len after it is queued to the socket
  o [PPPOE]: Do not leak SKB if sock_queue_rcv_skb() fails
  o [ECONET]: Do not leak SKBs if ec_queue_packet() fails
  o [SPARC64]: Fix non-modular build of FFB drm driver
  o [VLAN]: Kill build warning due to missing declarations
  o [TG3]: Do not drop existing GRC_MODE_HOST_STACKUP when writing to GRC_MODE
  o [TG3]: Do not set RX_MODE_KEEP_VLAN_TAG when ASF is enabled
  o [TG3]: Clear on-chip stats/status block after resetting flow-through queues
  o [TG3]: Update version and release date
  o [TG3]: Update to latest non-5705 TSO firmware
  o [SPARC]: Add CONFIG_OOM_KILLER entries

David Stevens:
  o [IPV6]: Fix UDP socket selection for multicast
  o [IPV6]: Fix milliseconds to jiffies conversion in multicast code
  o [IPV6]: In multicast code, set MAF_TIMER_RUNNING when timer is set
  o [IPV6]: In igmp6_group_queried, fix address check to comply with RFC2710

Dean Roehrich:
  o [XFS] fix some ia64 warnings in dmapi_xfs.c
  o [XFS] Change dm_send_namesp_event to take vnode ptrs rather than bhv ptrs
  o [XFS] Change dm_send_mount_event to use vnode ptrs rather than bhv ptrs
  o [XFS] Change dm_send_destroy_event to use vnode ptrs rather than bhv ptrs
  o [XFS] Make dm_send_data_event use vp rather than bhv
  o [XFS] Implement dm_get_bulkall
  o [XFS] Remove duplicate FILP_DELAY_FLAG macro
  o [XFS] dm_path_to_handle returns errnos with sign flipped

Eric Sandeen:
  o [XFS] Re-work xfs stats macros to support per-cpu data
  o [XFS] remove doubly-included header files
  o [XFS] Re-work pagebuf stats macros to help support per-cpu data
  o [XFS] Update sysctls - use ints, not ulongs, and show pagebuf values in jiffies like everybody else
  o [XFS] Allow full 32 bits in sector number when XFS_BIG_BLKNOS not set
  o [XFS] Add a stack trace to _xfs_force_shutdown
  o [XFS] Fix test for large sector_t when finding max file offset
  o [XFS] Use i_size_read/i_size_write semantics from 2.6 kernel to reduce 2.4/2.6 differences in xfs
  o [XFS] Use buffer head flag set/clear routines as in 2.6 kernel to reduce 2.4/2.6 differences in xfs
  o [XFS] Remove a nested transaction in xfs_dm_punch_hole
  o [XFS] BH_Sync added in 2.4.22, put an #ifdef in for now so this still works on older kernels.
  o [XFS] Fix a few sysctls - values are all ints, but sysctl table was setting up for longs.
  o [XFS] Fix the pb stats clear handler, value is int but handler was using ulong

Geert Uytterhoeven:
  o [NET]: Fix atm/br2684 build with procfs disabled
  o Atyfb on Mach64 GX or Atari
  o 2.4.23 ext3 warning
  o M68k RMW accesses
  o Zorro include guard
  o M68k cache mode
  o Mac ADB IOP fix
  o M68k symbol exports
  o Mac89x0 Ethernet
  o Mac ESP SCSI setup
  o Macfb setup
  o Mac ADB
  o ncr53c7xx SCSI
  o Amiga debug fix
  o Amiga Gayle E-Matrix 530 IDE
  o Amiga NCR53c710 SCSI
  o Mac II VIA
  o M68k asm/system.h
  o M68k extern inline
  o M68k Documentation
  o Amiga Buddha/CatWeasel IDE
  o NCR53C9x SCSI inline
  o Genrtc warning
  o Mac SCSI
  o Mac extern
  o Amiga Gayle IDE cleanup
  o MAINTAINERS vger.rutgers.edu

Glen Overby:
  o [XFS] A problem was found with the debug code in xlog_state_do_callback.  At the end of processing all log buffers that can be processed, there is a (debug only) double-check to make sure that log buffers with completed I/O don't get marooned when the function completes.  The check only needs to go to the first buffer that will cause an I/O completion, that has not completed.  The loop doesn't stop a WANT_SYNC state buffer is found, but it should.
  o [XFS] xfs_dir2_node_addname_int had reminants of an old block placement algorithm in it.  The old algorithm appeared to look for the first place to put a new data block, and thus a new freespace block (this is where the 'foundindex' variable came from).  However, new space in a directory is always added at the lowest file offset as determined by the extent list.  So this stuff is never used.

Harald Welte:
  o [NETFILTER]: Fix ip_queue_maxlen sysctl
  o [NETFILTER]: Kill extraneous memset()s in nat/conntrack TFTP code
  o [NETFILTER]: Fix ipchains MASQUERADE oops
  o [IPV6]: Do not bypass netfilter for MLD/IGMP messages

Herbert Xu:
  o [SCTP]: Fix sm.h/sctp.h header include loop

Hideaki Yoshifuji:
  o [CRYPTO]: crypto_alg_lookup() should fail when passed a NULL name

Jesse Barnes:
  o ia64: protect PAL mapping printk with EFI_DEBUG

John Stultz:
  o Always make TSC available via get_cycles() when TSC is present

Jozsef Kadlecsik:
  o [NETFILTER]: Use list macros instead of reimplementation
  o [NETFILTER]: Avoid order n^2 lookup of whole conntrack hash in ip_ct_selective_cleanup()

Keith Owens:
  o ia64: fix offsets.h generation bootstrap problem
  o ia64: mca_asm.h documentation fixes
  o ia64: Trivial fixes for correct field type in formats.  prfunc_t does not include attribute format so gcc does not pick these up automatically.
  o ia64: salinfo.c cleanup and race removal
  o ia64: print header from INIT records
  o ia64: fix comment typo (sal.h)
  o ia64: Clean up kernel salinfo state checking
  o ia64: Add the ability for user space salinfo to ask kernel salinfo and/or the prom to decode the oem data sections of SAL records.
  o ia64: Update PAL_MC_ERROR_INFO structures for SDM 2.1
  o ia64: sync salinfo.c with 2.6 (suser -> capable, use standard macros)

Khalid Aziz:
  o ia64: do_settimeofday: fix compensation for lost ticks

Kochi Takayoshi:
  o ia64: initialize bootmem later, since acpi_table_init() doesn't need it
  o ia64: don't access per-CPU data of off-line CPUs

Krishna Kumar:
  o [IPV6]: Fix ref count bug in MLDv2, test idec->dead instead of IFF_UP

Linus Torvalds:
  o Fix x86 kernel page fault error codes

Matt Domsch:
  o EDD: read disk80 MBR signature, export through edd module
  o EDD: s/DISKSIG_BUFFER/DISK80_SIG_BUFFER so it compiles

Matthew Wilcox:
  o Remove broken file lock accounting

Mikael Pettersson:
  o fix some DRM43 warnings
  o fix reboot/no_idt bug

Mikael Starvik:
  o CRIS architecture update

Mikulas Patocka:
  o from -aa tree: Fix potential fsync() race condition

Nathan Scott:
  o [XFS] Fix up the default ACL inherit case, in the presence of failure during applying the default ACL (eg. from ENOSPC)
  o [XFS] Fix a compiler warning, sync_fs returns a value
  o [XFS] Fix a race condition in async pagebuf IO completion, by moving blk queue manipulation down into pagebuf.  Fix some busted comments in page_buf.h, use a more descriptive name for __pagebuf_iorequest
  o [XFS] Use the rounded down size value for all growfs calculations, else the last AG can be updated incorrectly
  o [XFS] Fix a harmless typo - we were using a pagebuf flag not a bmap flag here; fortunately they have the same value (2)
  o [XFS] Tweak last dabuf fix, suggested by Steve, no longer uses bitfields but uchars instead
  o [XFS] Fix a case where we could issue an unwritten extent buffer for IO without it being locked - an instant BUG trigger in the block layer
  o [XFS] Alternate, cleaner fix for the ENOSPC/ACL lookup problem
  o [XFS] Automatically set logbsize for larger stripe units
  o [XFS] Add inode64 mount option; fix case where growfs can push 32 bit inodes into 64 bit space accidentally - both changes originally from IRIX
  o [XFS] Fix races between O_DIRECT and fcntl with F_SETFL flag on the XFS IO path
  o [XFS] DMAPI changes required by direct IO/fcntl setfl interaction races
  o [XFS] Separate the big filesystems macro out into separate big inums and blknos macros.  Also fix the check for too-large filesystems in the process
  o [XFS] Undo last mod, checked in against wrong bug number with wrong change message
  o [XFS] Separate the big filesystems macro out into separate big inums and blknos macros; fix the check for too-large filesystems in the process
  o [XFS] Implement several additional inode flags - immutable, append-only, etc; contributed by Ethan Benson
  o [XFS] Some tweaks to the additional inode flags, suggested by Ethan
  o [XFS] Accidentally switched some debug code off, reenable it
  o [XFS] Allow syncing the types header up more easily with userspace
  o [XFS] Make debug code _exactly_ how it used to be to save on tree merging
  o [XFS] Change writepage code so that we mark a page uptodate if all of its buffers are uptodate, and we are not doing a partial page write
  o [XFS] Remove xfs_attr_fetch.c - the one routine was a copy of another, so instead of fixing a bug in two places I merged the two routines
  o [XFS] Use the same name for a function here as in the 2.5/2.6 tree
  o [XFS] Use xfs_dev_t size rather than dev_t size in xfs_attr_fork initialization
  o [XFS] Rename _inode_init_once to __inode_init_once to follow the kernel naming convention a bit more closely
  o [XFS] Fix a broken interaction between a buffered read into an unwritten extent and a direct write
  o [XFS] Clean up inode revalidation code slightly
  o [XFS] Fix up pointers in diagnostics, print using %p not %x for 64 bit platforms
  o [XFS] Rename pagebuf debug option (ie. pagebuf tracing) into a generic XFS tracing option for the other XFS trace code to use too (once fixed)
  o [XFS] Fix compiler warning after change to xfs_ioctl interface
  o [XFS] Use an xfs_ino_t to hold the result of inode extraction from a handle, not a possibly 32-bit number
  o [XFS] final round of code cleanup, now using 3-clause-bsd in these headers
  o [XFS] Fix inode btree lookup code precision problem with large allocation groups
  o [XFS] Add some IO path tracing, move inval_cached_pages to a better home to help
  o [XFS] Fix ktrace code - dont build unilaterally, and do earlier init for pagebuf use
  o [XFS] Fix log tracing code so it is independent of DEBUG like other traces
  o [XFS] Add back xfsidbg tracing code, remove ktrace<->debug dependency
  o [XFS] Fix build fallout from reordering xfsidbg headers for tracing fixes
  o [XFS] Rename the vnode tracing macro to be consistent with the other trace code
  o [XFS] Enable tracing in the quota code if requested
  o [XFS] Fix exports for tracing symbol access in idbg code
  o [XFS] When tracing extended attribute calls, only access the buffer when it exists
  o [XFS] Fix build with tracing enabled, couple of portability macros, move externs into headers
  o [XFS] Enable the tracing options in XFS Makefiles
  o [XFS] Fix compile warning on 64 bit platforms
  o [XFS] Fix compiler warning when building on 2.4.21 kernels
  o [XFS] Dont build objects which are not linked into the kernel ever
  o [XFS] Dump the pagebuf locked field for debugging purposes
  o [XFS] Fix warnings when tracing enabled on 64 bit platforms
  o [XFS] Fix pagebuf page locking problems for blocksizes smaller than the pagesize
  o [XFS] Fix a supplemental issue introduced by the last small blocksize locking fix; this would manifest itself as a second unlock_page call on an already unlocked page
  o [XFS] Fix a deadlock while writing when low on free space
  o [XFS] Remove some spurious 2.4/2.6 differences in support code
  o [XFS] Fix sign on a pagebuf error variable, backport from 2.6 tree
  o [XFS] Fix an infinite writepage loop under a combination of low free space, and racing write/unlink calls to the same file
  o [XFS] Enable pagebuf lock tracking via debug
  o [XFS] Backport a couple of debugging changes from the 2.6 code base
  o [XFS] Backport minor 2.6 changes to the iomap interface to keep code more in sync
  o [XFS] Backport an unmerged bug fix from the 2.6 code base - if probe_unmapped_page fails while walking down the unmapped page list, do not attempt to probe the last page as well just return
  o [XFS] Backport an unmerged bug fix from the 2.6 code base - only submit a convert_page page for IO if startio is set
  o [XFS] Backport some trivial changes from the 2.6 code base - page uptodate flag macro name changes
  o [XFS] Move Linux-version specific code out of xfs_iomap.c so that it can become part of the XFS core code
  o [XFS] Seperate the NFS reference cache code out from xfs_rw.c to simplify management of different kernel versions
  o [XFS] Remove assertion that we do not hold a lock - no lock ownership state available
  o [XFS] Merge page_buf_locking routines in with the rest of page_buf
  o [XFS] Change pagebuf to use the same ktrace implementation as XFS, instead of reinventing that wheel
  o [XFS] Trivial/whitespace changes to sync up different trees a bit
  o [XFS] Switch to using the BSD qsort implementation
  o [XFS] Fix a build error in some debug code
  o [XFS] Fix build fallout from refcache reorganisation
  o [XFS] Move the stack trace wrapper into a kernel-version-specific location
  o [XFS] Switch from using dev_t to xfs_buftarg_t for representing the devices underneath XFS
  o [XFS] Merge find_next_zero_bit casting fixes back from 2.6 code
  o [XFS] Use iomap abstraction consistently
  o [XFS] Abstract sendfile operation out, supporting multiple kernels more easily
  o [XFS] Use xfs_statfs type to statfs operation, to support multiple kernels more easily
  o [XFS] Switch debug quota code to use xfs_buftarg interface instead of dev_t
  o [XFS] Abstract out the current_time interface use from quota to support multiple kernel versions
  o [XFS] Fix some incorrect debug code after buftarg changes
  o [XFS] Use a kmem shaking interface for 2.4 which is much more like the 2.6 one
  o [XFS] Convert to revised kmem shake interface
  o [XFS] Update the way we hook into the generic direct IO code so we share more code.  This means we no longer need to dup remove_suid within xfs_write_clear_setuid
  o [XFS] Add the noikeep mount option, make ikeep the default for now
  o [XFS] Use vnode timespec modifiers for atime/mtime/ctime, keeps last code hunk in sync
  o [XFS] Prevent log ktrace code from sleeping in an invalid context
  o [XFS] Fix comment in xfs_rename.c

Neil Brown:
  o Make root a special case for per-user process limits
  o Honour SUN NFSv2 hack for "set times to server time
  o Drop module count if lockd reclaimer thread failed to start

Patrick McHardy:
  o [NET SCHED]: Adjust qlen when grafting in multiple qdiscs
  o [NET SCHED]: Reset q.qlen in tbf_reset instead of purging an unused queue
  o [NET SCHED]: Fix queue limits in multiple qdiscs
  o [NETFILTER]: Fix various issues with the amanda conntrack+NAT helpers
  o [NETFILTER]: Fix expectation evict order
  o [NETFILTER]: Export conntrack bucket count via read-only sysctl

Ralf Bächle:
  o MIPS Configure.help updates
  o Update MIPS MAINTAINERS entries
  o Update generic MIPS code
  o mips64 updates
  o AMD Alchemy updates
  o Remove support for compressed EV-64120 kernels
  o Add support for Momentum Ocelot C and Jaguar ATX
  o Add VINO and Indycam drivers
  o Update SGI IP22 support
  o Update RM200 C support
  o Update support for Lasat boards
  o Update for NEC VR41xx systems
  o Update TX4927 code
  o MIPS char driver update
  o Update Origin code
  o MIPS video driver updates
  o Update Atlas, Malta and SEAD boards
  o Update sgiwd93 driver
  o Sibyte updates
  o Update JMR3927 support
  o SGI I2C driver
  o NEC DDB updates
  o ITE updates
  o Galileo boards
  o DEC updates
  o Update Jazz
  o Update HP Laserjet
  o Update Ocelot defconfig
  o Update Cobalt defconfig file
  o Update Philips Nino defconfig
  o ARC library updates
  o Update NEC Osprey defconfig
  o Add GT-064011/GT-64111 PCI ID
  o Fix VRc5477 remove method declaration
  o Add two new NEC PCI IDs
  o Probe SGI partitions earlier
  o Add Pete Popov to CREDITS
  o Add IP22 parallel port driver
  o New PCMCIA drivers
  o Include <asm/system.h> into spinlock.h
  o Add more MIPS bits in <linux/elf.h>
  o MIPS ioaddr_t is 32-bit
  o Remove remaining drivers/sgi bits
  o Cleanup lk201-map.c
  o No stone-age compat stuff for MIPS
  o Supply default values to rtc.c
  o Misc MIPS video bits
  o MIPS network driver updates

Russell Cattelan:
  o [XFS] Fix some inconsistent types
  o [XFS] Rework pagebuf_delwri_flush to be list safe
  o [XFS] Fix one more fsid_t type
  o [XFS] Clean up fsid_t abuses in dmapi
  o [XFS] Since we now have embeding trees and XFS has to support LBS which typically 1 version back from the XFS TOT tree add support  for 2.4.22 with and #if KERNEL_VERSION
  o [XFS] Fix from Christoph
  o [XFS] IRIX sets KM_SLEEP to 0 but the support routines sets KM_SLEEP to 1
  o [XFS] Fix remount,ro path
  o [XFS] move the iomap data structures out of pagebuf
  o [XFS] Add new file ... missed in orginal checkin

Rusty Russell:
  o [NETFILTER]: Do not flush MASQ if IP did not change

Stephen Hemminger:
  o [NETFILTER]: Trivial -- Get rid of warnings in netfilter if /proc is not configured on

Stephen Lord:
  o [XFS] do not put 0x in front of a decimal number, its confusing
  o [XFS] fix up xfs_lowbit's use of ffs
  o [XFS] fix build for gcc 3.2
  o [XFS] Make xfs_ichgtime call mark_inode_dirty_sync instead of mark_inode_dirty makes the just the inode look dirty, and not the inode and the data.
  o [XFS] remove an impossible code path from mkdir and link paths, spotted by Al Viro.
  o [XFS] Switch pagebuf hashing to be based on the block_device address rather than the dev_t. Should give better distribution.
  o [XFS] remove dead function xfs_trans_iput
  o [XFS] Close some holes in the metadata flush logic used during unmount, make sure we have no pending I/O completion calls for metadata, and that we only keep hold of metadata buffers for I/O completion if we want to. Still not perfect, but better than it was.
  o [XFS] When calculating the number of pages to probe for an unwritten extent, use the size of the extent, not the page count of the pagebuf which is initialized to zero.
  o [XFS] Rework how xfs and the linux generic I/O code interoperate again to deal with deadlock issues between the i_sem and i_alloc_sem and the xfs IO lock.
  o [XFS] move unwritten extent conversion for O_DIRECT into the write thread and out of the I/O completion threads. This scales better.
  o [XFS] Code cleanup
  o [XFS] small cleanup
  o [XFS] fix the previous change which compiled by fluke, the conditional use of the i_alloc_sem was wrong. No actual change in the generated code for 2.4.22, there will be for older kernels though.
  o [XFS] fix up error unlock paths in xfs_write
  o [XFS] Implement deletion of inode clusters in XFS
  o [XFS] cleanup uio use some more
  o [XFS] remove FINVIS from xfs, instead use a seperate file ops vector for files which are opened for invisible I/O.

Steven Cole:
  o 2.4.23 update Documentation/Changes for quota-tools

Stéphane Eranian:
  o ia64: perfmon-1 inheritance bugfix

Tom Rini:
  o PPC32: Convert all bootwrappers that use OpenFirmware to use the same code
  o PPC32: Allow for the commandline to be pulled from OF on PReP
  o PPC32: Backport some warning fixes to arch/ppc/boot/prep/vreset.c
  o PPC32: Finish support for pinning TLB entries on MPC8xx
  o PPC32: Workaround some errata on the MPC74xx line
  o PPC32: Updates for the IBM 750FX processor
  o PPC32: Don't fudge the MAC address on EP8260's
  o PPC32: Add a cputable entry for the Motorola MPC8280
  o PPC32: gcc-3.4 build fixes from Olaf Hering <olh@suse.de>
  o PPC32: Print the correct ammount of memory not covered by BATs
  o PPC32: Update an errata on the MPC745x line
  o Fix PPC compilation

Tony Luck:
  o ia64: infinite loop in ia64_mca_wakeup_ipi_wait
  o ia64: fix register numbers in MCA save/restore
  o ia64: Another MCA fix

Ville Nuorvala:
  o [IPV6]: Verify nlmsg_len in rt6_dump_route()

William Lee Irwin III:
  o Fixup smb_boot_cpus(): Fix HT detection bug
  o out_of_memory() locking
  o fix 2.4 BLK_BOUNCE_ANY



