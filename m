Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265407AbTFMOl7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 10:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261846AbTFMOl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 10:41:59 -0400
Received: from hera.kernel.org ([63.209.29.2]:37331 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S265407AbTFMOko (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 10:40:44 -0400
Date: Fri, 13 Jun 2003 07:53:33 -0700
From: Marcelo Tosatti <marcelo@hera.kernel.org>
Message-Id: <200306131453.h5DErX47015940@hera.kernel.org>
To: linux-kernel@vger.kernel.org
Subject: linux-2.4.21 released
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

final:

- 2.4.21-rc8 was released as 2.4.21 with no changes.


Summary of changes from v2.4.21-rc7 to v2.4.21-rc8
============================================

Geert Uytterhoeven <geert@linux-m68k.org>:
  o Fix ext2fs warning

Hugh Dickins <hugh@veritas.com>:
  o Fix shmctl(SHM_LOCK/UNLOCK) deadlock

Marcelo Tosatti <marcelo@freak.distro.conectiva>:
  o Backout erroneous kiobuf dcache flush changes Cset exclude: jsun@mvista.com|ChangeSet|20030425203656|60956
  o Changed EXTRAVERSION to -pre8
  o Cset exclude: geert@linux-m68k.org|ChangeSet|20030609201637|12385
  o Cset exclude: geert@linux-m68k.org|ChangeSet|20030609201907|11405
  o Remove bogus license for Rocket driver and change it to GPL


Summary of changes from v2.4.21-rc6 to v2.4.21-rc7
============================================

<ehabkost@conectiva.com.br>:
  o [SPARC]: Export phys_base on sparc32

<jgarzik@pobox.com>:
  o fix olympic driver build

<lethal@linux-sh.org>:
  o Fix Solution Engine 7751 Build
  o Define VM_DATA_DEFAULT_FLAGS for SH

<wesolows@foobazco.org>:
  o [sparc]: Attempt mul/div emulation handling on all cpus

David S. Miller <davem@nuts.ninka.net>:
  o [SPARC]: Fix sys_ipc to return ENOSYS instead of EINVAL as appropriate
  o [SPARC64]: Implement dump_stack in 2.4.x
  o [SPARC64]: Only use power interrupt when button property exists
  o [IPV4/IPV6]: Use Jenkins hash for fragment reassembly handling
  o [IPV6]: Input full addresses into TCP_SYNQ hash function
  o [IPV4]: Add sysctl to control ipfrag_secret_interval
  o [SPARC64]: Fix probe error handling in envctrl.c driver
  o [SPARC64]: Fix probe error handling in bbc_{envctrl,i2c}.c driver
  o [SPARC64]: Fix exploitable holes and bugs in ioctl32 translations

Douglas Gilbert <dougg@torque.net>:
  o sg: Fix side effect introduced by last "off by one" fix

Eric Brower <ebrower@usa.net>:
  o [SPARC]: Refactor AUXIO support

Marcelo Tosatti <marcelo@freak.distro.conectiva>:
  o Changed EXTRAVERSION to -rc7

Pete Zaitcev <zaitcev@redhat.com>:
  o [sparc] Force type in __put_user
  o [SPARC]: Fix gcc-3.x builds

Rob Radez <rob@osinvestor.com>:
  o [sparc]: Fix uninitialized spinlock in SRMMU code
  o [SPARC]: Kill initialize_secondary, unused




Summary of changes from v2.4.21-rc5 to v2.4.21-rc6
============================================

<c-d.hailfinger.kernel.2003@gmx.net>:
  o IDE config.in correctness

Andi Kleen <ak@muc.de>:
  o x86-64 fix for the ioport problem

Andrew Morton <akpm@digeo.com>:
  o Fix IO stalls and deadlocks

Marcelo Tosatti <marcelo@freak.distro.conectiva>:
  o Add missing via82xxx PCI ID
  o Backout erroneous fsync on last opener at close()
  o Changed EXTRAVERSION to -rc6



Summary of changes from v2.4.21-rc4 to v2.4.21-rc5
============================================

Alan Cox <alan@lxorguk.ukuu.org.uk>:
  o 1: (trivial) Fix the formatting of your ide hack
  o 2: =scsi option fails in some cases
  o 3: IDE DMA
  o add the via ide ident
  o fix the siimage mmio stuff

Andi Kleen <ak@muc.de>:
  o Fix 32bit ioctl holes
  o Fix context switch bug on x86-64
  o Prefetch workaround for csum-copy

Benjamin Herrenschmidt <benh@kernel.crashing.org>:
  o PPC Documentation/Configure.help fix

Marcelo Tosatti <marcelo@freak.distro.conectiva>:
  o Changed EXTRAVERSION to -rc5



Summary of changes from v2.4.21-rc3 to v2.4.21-rc4
============================================

<minyard@acm.org>:
  o IPMI fixes

<viro@parcelfarce.linux.theplanet.co.uk>:
  o Fix writing to /dev/console

Barry K. Nathan <barryn@pobox.com>:
  o Correctly fix the ioperm issue

Benjamin Herrenschmidt <benh@kernel.crashing.org>:
  o Update ide/ppc/pmac.c
  o Fix controlfb build with gcc3.3
  o PPC32 Fix warning with ndelay (with patch !)

Marcelo Tosatti <marcelo@freak.distro.conectiva>:
  o Changed EXTRAVERSION to -rc4
  o Cset exclude: c-d.hailfinger.kernel.2003@gmx.net|ChangeSet|20030526190224|33683
  o Really fix xconfig breakage


Summary of changes from v2.4.21-rc2 to v2.4.21-rc3
============================================

<bk@suse.de>:
  o fix unresolved symbol rtnetlink_rcv_skb with gcc-3.3

<riel@redhat.com>:
  o mm/mmap.c address overflow fix

<viro@parcelfarce.linux.theplanet.co.uk>:
  o TIOCCONS fix

Adrian Bunk <bunk@fs.tum.de>:
  o fix sound/kahlua.c .text.exit error
  o fix ips.c .text.exit error
  o Configure.help updates from -ac

Alan Cox <alan@lxorguk.ukuu.org.uk>:
  o fix ipmi screwup
  o IDE config fixes
  o allow rw_disk in IDE to be hooked
  o clean up the pdc4030 to use the new hooks not ifdefs
  o fix modular ide build and other makefile bug
  o correct ALi doc
  o hpt37x
  o add Intel ICH5 Serial ATA
  o fix wrong clocking selection on CMD680/SII3112
  o ensure we dont turn DMA on by accident on early sl82c05
  o fix missing wakeup on hisax pci (breaks v.110)
  o mpt fusion assorted small fixes
  o fix config error
  o resync lasi id (somehow out of sync)
  o vrify_area fix
  o pci id table update
  o add a quirk for the serverworks irq
  o pass the right object to presto
  o merge the kerneldoc for uaccess
  o parisc headers
  o parisc headers 2
  o update IDE headers to match IDE changes
  o extra PCI Ident
  o export fc_type_trans
  o add a hold field to reserve ide slots (needed for PPC)

Andrea Arcangeli <andrea@suse.de>:
  o Fix race between remove_inode_page and prune_icache

Arjan van de Ven <arjanv@redhat.com>:
  o ioperm fix

Marcelo Tosatti <marcelo@freak.distro.conectiva>:
  o Changed EXTRAVERSION to -rc3
  o Cset exclude: alan@lxorguk.ukuu.org.uk|ChangeSet|20030522194932|46894 (wolfson codec upd)

Nicolas Pitre <nico@cam.org>:
  o set_task_state() UP memory barriers

Olaf Hering <olh@suse.de>:
  o 2.4.21-rc2 syntax error in toplevel Makefile

Oleg Drokin <green@angband.namesys.com>:
  o Fix reiserfs options parser, return error if given incorrect options on remount
  o reiserfs: One of the O_DIRECT fixes disabled tail packing by mistake. Enable it again
  o reiserfs: Fix another O_DIRECT vs tails problem. Mostly by Chris Mason
  o reiserfs: Refuse to mount/remount if "alloc=" option had incorect parameter
  o reiserfs: iget4() race fix

Oleg Drokin <green@namesys.com>:
  o [2.4] export balance_dirty

Stephen C. Tweedie <sct@redhat.com>:
  o Fix mmap+IO potential dangling IO in ext3

Tom Rini <trini@kernel.crashing.org>:
  o PPC32: Fix 'make znetboot'.  From Cort Dougan
  o PPC32: Important fixes in the MPC8xx enet driver
  o PPC32: Allow for the RTC IRQ to be board-defined

Vojtech Pavlik <vojtech@suse.cz>:
  o Fix incorrect enablebits for all AMD IDE chips


Summary of changes from v2.4.21-rc1 to v2.4.21-rc2
============================================

<bernhard.kaindl@gmx.de>:
  o Fixup 2.4 ptrace fix

<green@linuxhacker.ru>:
  o Memleak fix for DIGITAL EtherWORKS 3 ethernet driver

<javaman@katamail.com>:
  o explicit support for nVidia nForce

<jgarzik@pobox.com>:
  o tg3 fix
  o fix fealnx build on ia64 and other non-x86

<jsun@mvista.com>:
  o kiobuf flush dcache properly

<laforge@netfilter.org>:
  o [NETFILTER]: Makefile and build fixes
  o [NETFILTER]: Trivial but important state fix for ipt_conntrack

<lucy@innosys.com>:
  o USB: keyspan driver fixes

<mulix@mulix.org>:
  o [NETFILTER]: ip_queue memory leaks

<niv@us.ibm.com>:
  o [AF_UNIX]: Fix max_dgram_qlen procfs permissions

<petrides@redhat.com>:
  o Orphan recovery error path fix

<r.a.mercer@blueyonder.co.uk>:
  o Fix vesafb with large memory

<shemminger@osdl.org>:
  o [BRIDGE]: New maintainership

<torben.mathiasen@hp.com>:
  o PCI Hotplug: cpqphp 66/100/133MHz PCI-X support

Alan Cox <alan@lxorguk.ukuu.org.uk>:
  o fix overrun in cdu31a
  o fix memory leak on rio
  o fix ide smp deadlock on settings sem
  o IDE: if 0 garbage removal
  o add blacklist for barracuda ata iv with CSB5
  o Fix copy_to_user handling in eicon
  o /proc stuff for zoran
  o Fix copy_user handling in z36120
  o Fix arcnet crashes with raw socket
  o fix compile of r8169 with newer binutils
  o fix roadrunner memory leak
  o sis900 needs to know another PHY
  o Fix copy_user handling in cosa
  o fix 82092 crash cases
  o fix time type in aha152x
  o fix cpqfc leak
  o fix ide-scsi retry oops
  o fix nsp32 build with newer binutils
  o fix qlogicisp leaks
  o add another card id
  o fix build with newer binutils
  o Fix copy_to_user handling in awe_wave
  o Fix get_user handling in cmpci
  o small fix for pcm alloc on i810
  o mpu401 copy_to_user handling fix
  o fix a race and a comment in via_audio
  o mdc800 copy_to_user handling fix
  o make pegasus work on big endian
  o Fix copy_to_user handling in vicam
  o make sstfb work bigendian
  o fix lots of tdfxfb bugs
  o handle error case in fs/namespace.c
  o copy kernel not user object in ncpfs
  o fix error cases in procfs
  o more /proc error cases
  o fix the d_path error cases in umsdos
  o remove dead functions
  o header for arcnet fixes
  o new sis fb idents
  o sisfb ipdate
  o fix wrong types in if_shaper
  o put the ide idents back in working order
  o headers for sisfb update
  o kill unneeded ifdefs, add rd/ and root=nbd
  o fix base handling in lib stuff
  o maintainer updates
  o fix wrong type
  o xdr warning (0 - any)
  o fix x.25 parsing
  o update hptraid

Alan Stern <stern@rowland.harvard.edu>:
  o USB: usb storage async unlink error code fix
  o USB: usb-storage fixes

Andi Kleen <ak@muc.de>:
  o Critical fix for x86-64
  o Fix gcc 3.3 build for reverted aic7xxx driver
  o Fix SMP x86-64 kernels on simics
  o Another x86-64 build fix for gcc-3.3-hammer

Ben Collins <bcollins@debian.org>:
  o Fix IEEE1394 locking problems + cleanups
  o More firewire/IEEE1394 fixes
  o Fix highmem_io for sbp2

Benjamin Herrenschmidt <benh@kernel.crashing.org>:
  o Fix PPC build

Christoph Hellwig <hch@lst.de>:
  o add intelfb to Config.in

Dave Kleikamp <shaggy@shaggy.austin.ibm.com>:
  o JFS: Performance improvement
  o JFS: jfs_lookup should check for bad inode returned from iget
  o JFS: Avoid rare deadlock

David S. Miller <davem@nuts.ninka.net>:
  o [NET]: SG without checksum support is illegal
  o [NET]: Fix hashing exploits in ipv4 routing, IP conntrack, and TCP synq

David Woodhouse <dwmw2@infradead.org>:
  o JFFS2: Fix for_each_inode()

Greg Kroah-Hartman <greg@kroah.com>:
  o i2c: bug fix for 2.4.21-rc1
  o IBM PCI Hotplug: fix up a lot of memory allocations and leaks just to figure out a slot name
  o IBM PCI Hotplug: fix up a number of memory leaks on the error path

James Morris <jmorris@intercode.com.au>:
  o [NET]: Cosmetic cleanups of jhash code
  o [IPV4]: Choose new rt_hash_rnd every rt_run_flush

Maksim Krasnyanskiy <maxk@qualcomm.com>:
  o [Bluetooth] Improved RFCOMM TTY buffer management. Don't buffer more data than we have credits for.
  o [Bluetooth] Fix race condition in RFCOMM session and dlc scheduler

Marcel Holtmann <marcel@holtmann.org>:
  o [Bluetooth] Respond correctly to RLS packets
  o [Bluetooth] Fix L2CAP binding to local address

Marcelo Tosatti <marcelo@freak.distro.conectiva>:
  o Avoid is_dumpable() NULL pointer reference
  o aic7xxx: Go back to old aic7xxx (pre3) since the new one lockups some cards on initialization. The new driver (aic79xx) is now a new directory. I know Justin will hate this, but I can't update the aic7xxx to a fully new driver in -rc stage.
  o aic7xxx PCI posting flush fix from Arjan
  o Changed EXTRAVERSION to -rc2

Neil Brown <neilb@cse.unsw.edu.au>:
  o Return correct result for ACCESS(READ) on eXecute-only
  o Update umem driver for newer cards

Patrick McHardy <kaber@trash.net>:
  o [NETFILTER]: Multiple ipt_REJECT fixes

Paul Mackerras <paulus@au1.ibm.com>:
  o update CREDITS

Paul Mackerras <paulus@samba.org>:
  o PPC32: Update the defconfigs
  o PPC32: Compile fix for ppc_ksyms.c - it needs the declaration of __div64_32
  o Fix drivers/video/Config.in

Stelian Pop <stelian.pop@fr.alcove.com>:
  o sonypi fixes

Tom Rini <trini@kernel.crashing.org>:
  o PPC32: Export a missing symbol (__div64_32)


Summary of changes from v2.4.21-pre7 to v2.4.21-rc1
============================================

<alborchers@steinerpoint.com>:
  o USB: patch for oops in io_edgeport.c

<arndt@lin02384n012.mc.schoenewald.de>:
  o USB: Patch against unusual_devs.h to enable Pontis SP600

<baldrick@wanadoo.fr>:
  o USB: uhci bandaid

<bryder@paradise.net.nz>:
  o USB: ftdi_sio update

<bwa@us.ibm.com>:
  o [SCTP/IPV6]: Move sockaddr storage and in6addr_{any,loopback} to generic places

<chas@cmf.nrl.navy.mil>:
  o [ATM]: Make ia64 include ATM driver config

<chas@locutus.cmf.nrl.navy.mil>:
  o [ATM]: Get lec net_device names correct
  o [ATM]: Obsolete some atm_vcc members
  o [ATM]: Fix idt77252/sch_atm/pppoatm compilation
  o [ATM]: cleanup nicstat, suni and idt77105
  o [ATM] nicstar doesnt count all dropped pdus and powerpc fixup
  o [ATM] s/uni driver overwrites 8-/16-bit mode
  o [ATM]: Fix total_len calculation in IPHASE driver
  o [ATM]: Fix IPHASE build with debugging enabled

<dlstevens@us.ibm.com>:
  o [IPV6]: Add anycast support

<gandalf@netfilter.org>:
  o [NETFILTER]: Fix modify-after-free bug in ip_conntrack

<gandalf@wlug.westbo.se>:
  o [NETFILTER]: Fix ipfwadm_core.c compile failure
  o [NETFILTER IPV6]: Fix Makefile typo

<green@linuxhacker.ru>:
  o [VLAN]: Fix memory leak in procfs handling

<henning@meier-geinitz.de>:
  o USB: scanner.c endpoint detection fix

<laforge@netfilter.org>:
  o [NETFILTER]: iptables iptable_mangle LOCAL_IN bugfix
  o [NETFILTER]: ipt_REJECT bugfix for TCP RST packets + asymm. routing

<legoll@free.fr>:
  o USB: New USB serial device ID: Asus A600 PDA cradle

<mb@ozaba.mine.nu>:
  o [NETFILTER]: Add tftp conntrack + NAT support

<mrr@nexthop.com>:
  o [IPV6]: Allow protocol to percolate up into rt6 routing operations

<netfilter@interlinx.bc.ca>:
  o [NETFILTER]: Add amanda conntrack + NAT support

<niv@us.ibm.com>:
  o [TCP]: Missing SNMP stats

<paulm@routefree.com>:
  o [NETFILTER]: ip_conntrack bugfix for LOCAL_NAT and PPTP

<riel@redhat.com>:
  o Fix kunmap_atomic debugging problem

<riel@surriel.com>:
  o [ATM]: Compile fix for net/atm/br2684.c

<soruk@eridani.co.uk>:
  o USB: enable Motorola cellphone USB modems

<swiergot@intersec.pl>:
  o Fix ac97 incomplete headers

<yoshfuji@nuts.ninka.net>:
  o [IPV6]: Use RFC2553 constant variable

Adrian Bunk <bunk@fs.tum.de>:
  o [NF/IPV6]: Remove all ipv6_ext_hdrs from ip6tables
  o [ATM]: Fix IPHASE driver build
  o Fix aic7xxx compilation

Alan Stern <stern@rowland.harvard.edu>:
  o USB: usb-storage START-STOP under Linux 2.4

Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>:
  o [IPV4]: Fix deadlock in IGMP locking
  o [IPV6]: Correct CHECKSUM_HW handling in tcp_v6_send_check

Andi Kleen <ak@muc.de>:
  o x86-64 update

Andreas Dilger <adilger@clusterfs.com>:
  o don't allocate/free blocks in system areas

Andries E. Brouwer <andries.brouwer@cwi.nl>:
  o compilation fix for 2.4.21-pre7
  o Fix SCSI size reporting

Ben Collins <bcollins@debian.org>:
  o IEEE-1394/Firewire update

Benjamin Herrenschmidt <benh@kernel.crashing.org>:
  o PPC32: Do better cache flushes around L2 cache ctrl register changes
  o PPC32: Factor out common code for saving/restore CPU special-purpose registers, used on SMP and for sleep/wakeup.
  o PPC32: Make sure IPI handlers run with interrupts disabled
  o PPC32: Add proper /proc/ide entry for pmac
  o PPC32: Update ide-pmac driver

Christoph Hellwig <hch@lst.de>:
  o [NETFILTER]: 2.4 firewalling compat code removal
  o [NET]: Backport generic fc_type_trans to 2.4

David Brownell <david-b@pacbell.net>:
  o USB: ehci-hcd, minor hardware tweaks
  o USB: usbcore deadlock paranoia
  o USB: CDC Ether fix notifications

David S. Miller <davem@nuts.ninka.net>:
  o [IPV6]: Undo __constant_{n,h}to{n,h}l from anycast patch
  o [SPARC64]: Fix trap stack allocations so gcc-3.x builds work
  o [SCHED]: Some schedulers forget to flush filter list at destroy
  o [PKTSCHED]: Fix double-define of __inline__ et al
  o [IP TUNNEL]: inet_ecn_decapsulate modifies bits in wrong header
  o [PKT_SCHED]: Remove ugly arch ifdefs from generic code
  o [NETFILTER IPV6]: Fix route leak in ip6_route_me_harder

Geert Uytterhoeven <geert@linux-m68k.org>:
  o Amiflop mod_timer()
  o Duplicate PROC_CONSOLE()
  o 2.4 IDE core code for m68k
  o 2.4 IDE driver code for m68k
  o M68k raw I/O updates
  o Generic RTC driver
  o M68k ndelay()
  o M68k needs WANT_PAGE_VIRTUAL

Hideaki Yoshifuji <yoshfuji@linux-ipv6.org>:
  o [IPV6]: Use "const" qualifier
  o [IPV6]: Use ipv6_addr_any() for testing unspecified address
  o [IPV6]: Don't allow multiple instances of the same IPv6 address on an interface
  o [IPV6]: Set noblock to 1 in NDISC sock_alloc_send_skb calls

James Morris <jmorris@intercode.com.au>:
  o [NET]: dst_clone --> dst_hold where appropriate
  o [PKTSCHED]: Kill redefinition of IPPROTO_ESP in sch_sfq.c

Jens Axboe <axboe@suse.de>:
  o Fix ide request races which resulted in corruption

Marcelo Tosatti <marcelo@freak.distro.conectiva>:
  o Cset exclude: mikpe@csd.uu.se|ChangeSet|20030417235935|56567
  o Add missing HPT366 ID
  o Updated EXTRAVERSION to -rc1

Mark A. Greer <mgreer@mvista.com>:
  o PPC32: Add support for SERIAL_IO_PORT ports to the gen550 backend

Mikael Pettersson <mikpe@csd.uu.se>:
  o fix dmi_scan breakage
  o fix APIC bus errors on SMP K7 boxes in UP mode

Oleg Drokin <green@angband.namesys.com>:
  o reiserfs: Fix recenly introduced journal sanity check that breaks replay on old filesystems
  o reiserfs: Fix for journal replay process, to only replay transactions from last mount. By Chris Mason

Oliver Neukum <oliver@neukum.org>:
  o Honour HFS lock bits

Paul Mackerras <paulus@samba.org>:
  o PPC32: Fix the interrupt entry path for POWER3 processors
  o PPC32: Clean up arch/ppc/mm/Makefile a little
  o PPC32: xmon fixes for CHRP, powerbooks, and SMP systems
  o PPC32: fix indentation in include/asm-ppc/bootinfo.h
  o PPC32: Restructure the top-level interrupt handling loop
  o PPC32: Align boot wrapper data segment on page boundary
  o PPC32: Make readb/w/l completely synchronous

Petko Manolov <petkan@users.sourceforge.net>:
  o USB: pegasus link status detection fix

Randy Dunlap <randy.dunlap@verizon.net>:
  o [NET]: typo and comment fixes

Randy Dunlap <rddunlap@osdl.org>:
  o update unexpected IO APIC detection

Rusty Russell <rusty@rustcorp.com.au>:
  o Fix minor NAT parsing issue

Stephen C. Tweedie <sct@redhat.com>:
  o 2.4: Fix for jbd compiler warnings

Tom Rini <trini@kernel.crashing.org>:
  o PPC32: Actually fix KGDB like Mark Greer mentioned
  o PPC32: Remove an option to partically disable the d-cache



Summary of changes from v2.4.21-pre6 to v2.4.21-pre7 
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


Summary of changes from v2.4.21-pre5 to v2.4.21-pre6
============================================

<andre.breiler@null-mx.org>:
  o io_edgeport.c diff to fix endianess bugs

<bde@bwlink.com>:
  o [SPARC64]: Fix ocndition code handling in do_rt_sigreturn

<bergner@vnet.ibm.com>:
  o add ndelay() for ppc64

<blaschke@blaschke3.austin.ibm.com>:
  o JFS: Code cleanup suggested by static analysis tool

<chas@cmf.nrl.navy.mil>:
  o [ATM]: Add MAINTAINERS entry

<chas@locutus.cmf.nrl.navy.mil>:
  o [ATM]: use sock timestamp
  o [ATM]: Use skb_pull instead of direct skb mangling
  o [ATM]: Get minimum frame size right in lec.c
  o [ATM]: Let upper layer k now lec supports multicast
  o [ATM SUNI]: suni_init should not be __init and remove mod inc/dec
  o [ATM FORE200E]: Fix build

<clemens@ladisch.de>:
  o usb-midi.h: fixes for SC-8820/50
  o usb-midi.h: fixes for SC-8820/50

<coughlan@redhat.com>:
  o Update SCSI whitelist in scsi_scan.c

<dale@farnsworth.org>:
  o PPC32: Make the bootloader start at 0x000c for SMP
  o PPC32: Make it easier to hook into the bootloader code
  o PPC32: Allow the bootloader to pass in a board descripter struct

<hadi@cyberus.ca>:
  o [SCHED GRED]: Another bug found by Stanford Checker

<harald@gnumonks.org>:
  o [NETFILTER]: Fix icmp-type all problem in iptables

<henning@meier-geinitz.de>:
  o USB scanner.h, scanner.c: New vendor/product ids
  o USB: New vendor/product ids for scanner driver

<jakub@redhat.com>:
  o [SPARC64]: Fix typo in sparc64_get_context (G7 register is saved wrongly)

<josh@joshisanerd.com>:
  o USB: add KB Gear USB Tablet Driver

<kernel@jsl.com>:
  o Re: Keyspan USB/Serial Drivers for 2.4.20/2.4.21-pre4

<laforge@netfilter.org>:
  o [NETFILTER]: fix NAT ICMP reply translation of inner packet
  o [NETFILTER]: Fix conntrack bug introduced by list_del change
  o [NETFILTER]: Fix typo in ftp conntrack helper
  o [NETFILTER]: Add new ip6tables matches

<lunz@falooley.org>:
  o fix eepro100 SMP deadlock (uninitialized spinlock)

<sri@us.ibm.com>:
  o [IPV4/IPV6]: Fix to avoid overriding TCP/UDP with a new protocol of same type

<weigand@immd1.informatik.uni-erlangen.de>:
  o Fix race on rpc code

Adam Radford <adam@nmt.edu>:
  o 3ware driver update for 2.4.21-pre6

Adrian Bunk <bunk@fs.tum.de>:
  o USB: fix Auerswald compile

Alan Cox <alan@lxorguk.ukuu.org.uk>:
  o New PCI identifiers for ALi 156x ethernet
  o fix a ; in cris eeprom
  o correct handling of VIA PCI and of IDE legacy irq
  o add another transparent bridghe
  o export ndelay for modular ide stuff
  o Enable XMM on more athlons
  o fix ndelay argument name
  o more usercopy documentation
  o fix wacked formatting in x86-64 code
  o enable newly added docs
  o ide doc update
  o update hp framebuffer docs
  o update ipmi doc
  o Add missing EXPORT_SYMBOL for acpi & ipmi
  o epca sign fix
  o add genrtc driver used by multiple ports
  o ipmp updates
  o build genrtc if asked for
  o sign fix in mwave
  o & v && fix for i2c
  o nforce is now in AMD so delete the option
  o new AMD/Nvidia driver
  o remove dead Nvidia driver
  o bogo semicolon fix in joydev
  o fix hysdn brackets
  o fix some radio typos/oddments
  o more radio oddments
  o cpia update
  o fix w9966 tuner bug
  o mptfusion sign handling
  o missing Makefile slot
  o incorrect bracketing
  o e100 updates
  o fix ethernet pad in example driver
  o fix non x86 8169 build
  o another rogue semicolon
  o bracketing fix
  o ips docs update
  o cpqfc fix for non x86
  o dpt_i2o sign fix
  o fix ide-scsi hang on SMP boxes
  o ; fixes
  o ips update
  o wrong bracketing
  o XpressAudio enabler for Cyrix 5520
  o maestro bracketing bug
  o values cannot be init
  o fix large I/O to nec audio
  o bracketing fix in sscape
  o ali5451 is 31bit audio
  o via8233/8235 audio update
  o & v && in acm usb
  o usb hang fix
  o atafb bug in #if 0 code
  o fix logic error in aty128fb
  o typo fix in video headers
  o logic error in radeonfb
  o fix sisfb build on non x86
  o add intelfb driver
  o fix incorrect bracketing in JFFS
  o fix nfs port option on bigendian
  o fix seq_file problems
  o missing defines for alpha
  o faster x86 byteorder code
  o make __ndelay() argument name sane
  o generic rtc support headers for parisc
  o Fix typo in REPORTING-BUGS

Alan Cox <alan@redhat.com>:
  o Fix kmod/ptrace vulnerability

Alan Stern <stern@rowland.harvard.edu>:
  o USB: Patch for auto-sense cmd_len

Andi Kleen <ak@muc.de>:
  o [NET]: Make skbuff.h -W clean, skb_headlen should return unsigned quantity
  o x86-64 update

Ben Collins <bcollins@debian.org>:
  o [IEEE1394] Sync with repo

Benjamin LaHaise <bcrl@redhat.com>:
  o [NET]: Make sure nr_frags is accurate on paged SKB allocation failure

Christoph Hellwig <hch@lst.de>:
  o [NET]: Remove __NO_VERSION__ from networking code
  o backport sys_sendfile64

Christoph Hellwig <hch@sgi.com>:
  o [SPARC]: Add xattr syscalls

Dave Jones <davej@codemonkey.org.uk>:
  o Enable prefetch on P4
  o add missing intel cache descriptor

Dave Kleikamp <shaggy@shaggy.austin.ibm.com>:
  o JFS: Fix hang while flushing outstanding transactions under heavy load
  o JFS: Avoid deadlock when all tblocks are allocated

David Brownell <david-b@pacbell.net>:
  o USB: rename drivers/usb/hcd --> host
  o USB: call hcd->stop() in task context
  o ehci, sync with 2.5 latest

David S. Miller <davem@nuts.ninka.net>:
  o [SPARC64]: Add TCSBRKP ioctl translation, thanks Anton
  o [TCP]: Do not bump backoff too high during 0-window probes
  o [NET]: Fix length in skb_padlen
  o [RANDOM]: Backport 2.5.x ipv4/ipv6 sequence number generation SMP fixes by manfred@colorfullife.com
  o [SPARC64]: Implement STICK synchronization using ia64 port algorithms
  o [NET]: Export skb_pad to modules
  o [SPARC64]: Update defconfig
  o [NETLINK]: Remove buggy and useless rcv queue wakeup tests
  o [IPV6]: Cure typo in ipv6_addr_prefix
  o [IPV{4,6}]: Make icmp_socket per-cpu and simplify locking
  o [NETFILTER]: Fix typo in ipv6 makefile changes
  o [NET]: Fix mismerge, no need to export skb_pad twice
  o [SPARC64]: Make sure we are in irq_enter atomic section during update_process_times
  o [SPARC64]: Kill SPARC64_USE_STICK and use real timer drivers
  o [SPARC64]: Fix timer quotient calcs
  o [SPARC64]: Do not mark timer_ticks_per_usec_quotient static
  o [SPARC64]: Make gettimeofday assembly match tick quotient fixes
  o [SPARC64]: Add Hummingbird STICK support
  o [SPARC64]: Make TICK comparisons wrap-around safe by using jiffies macros
  o [SPARC64]: Sanitize all TICK privileged bit handling in tick drivers
  o [SPARC64]: Clear tick_cmpr ints properly in bootup assembly
  o [SPARC64]: Kill bogus kernel_thread decl

Ganesh Varadarajan <ganesh@vxindia.veritas.com>:
  o USB ipaq.c: add ids for fujitsu loox

Geert Uytterhoeven <geert@linux-m68k.org>:
  o Amiga PCMCIA Ethernet clean up
  o M68k ISA memory for Amiga PCMCIA
  o M68k Apollo I/O updates
  o M68k ifpsp060 updates
  o M68k incorrect prototype
  o Amiga RTC updates
  o Amifb wrong interrupt
  o Atari NCR5380 SCSI: bitops operate on long
  o Convert m68k cache macros to inline functions
  o Mac/m68k VIA updates
  o Allow to disable macfb
  o M68k net warnings
  o M68k heartbeat update
  o M68k config syntax
  o Sun-3 contact update
  o M68k SCSI warnings
  o M68k PAGE_SIZE warnings
  o M68k: optimize stacked irq check
  o Sun-3 memory zones
  o Sun-3 ioremap()
  o M68k page_to_phys
  o Sun-3 first page
  o M68k iomap cleanup
  o Sun-3 SBUS updates
  o Sun-3 vectored interrupts
  o M68k timekeeping update
  o Amiga Zorro SCSI: use z_ioremap()
  o Sun-3/3x updates
  o M68k core spelling fixes
  o Amiflop out-of-bounds array access
  o Sun-3 VME support
  o M68k warnings

Go Taniguchi <go@turbolinux.co.jp>:
  o USB: Another pegasus ID
  o USB: Another kaweth ID
  o USB: Another sony memorystick
  o USB: Multiple interfaces with usb hotplug
  o USB: Another hid-core worksround

Greg Kroah-Hartman <greg@kroah.com>:
  o USB: added support for radio shack device to pl2303 driver
  o USB: add firmware files for two new keyspan devices
  o USB: merge fixup for the scanner driver
  o USB: move the UHCI drivers into drivers/usb/host
  o USB: move the OHCI driver into drivers/usb/host

Hideaki Yoshifuji <yoshfuji@linux-ipv6.org>:
  o [IPV6]: Export ip6_route_me_harder for netfilter and add ipv6_addr_prefix

James Morris <jmorris@intercode.com.au>:
  o [NET]: Clean up sk_filter and make sure it is called when skb->dev is still valid
  o [IPV4]: Fix skb leak in inet_rtm_getroute
  o [IPV6]: Fix skb leak in inet6_rtm_getroute
  o [NET]: Add myself as co-maintainer
  o [NETLINK]: Un-duplicate rcv wakeup logic

Jay Vosburgh <fubar@us.ibm.com>:
  o [BONDING]: Add MAINTAINERS entry

Jeff Garzik <jgarzik@redhat.com>:
  o Via Nehemiah (C3-2) CPU support

John Levon <levon@movementarian.org>:
  o [SUNHME]: Fix bit testing typo

Leigh Brown <leigh@solinno.co.uk>:
  o Updated S3Triofb driver for PPC32

Lennert Buytenhek <buytenh@gnu.org>:
  o [BRIDGE]: handle out-of-ports corner case

Marcel Holtmann <marcel@holtmann.org>:
  o [SPARC64]: Translate AUTOFS_IOC_EXPIRE_MULTI ioctl

Marcelo Tosatti <marcelo@freak.distro.conectiva>:
  o Changed EXTRAVERSION to -pre6

Mark A. Greer <mgreer@mvista.com>:
  o PPC32: Fix a problem with 'next' and 'step' type KGDB commands

Neil Brown <neilb@cse.unsw.edu.au>:
  o md - 1 of 3 - Fix small bug in md.c
  o md - 3 of 3 - Don't check a device size before bd_get in
  o md - 2 of 3 - Convert /proc/mdstat to use seq_file
  o drivers/block/umem.c - new card
  o Fix compile errors/warnings in md

Oleg Drokin <green@angband.namesys.com>:
  o reiserfs: Make balloc[] tails[] and hash[] in super.c static. (Noticed by Arnd Bergmann <arnd@bergmann-dalldorf.de>)
  o reiserfs: gcc 3.3 compile fix from Hubert Mantel <mantel@suse.de>
  o reiserfs: Fix a warning about mismatching types while doing printk
  o reiserfs: Stricter checks for transactions and fs itself during mount

Oleg Drokin <green@namesys.com>:
  o Reiserfs journal overflow fix on large highly fragmented fs

Oliver Neukum <oliver@neukum.name>:
  o USB: work around for a firmware bug of some scanners

Patrick McHardy <kaber@trash.net>:
  o [IPV{4,6}]: lru queue for ip_fragment evictor

Paul Mackerras <paulus@samba.org>:
  o PPC32: Implement kmap_nonblock, add extra argument to kmap_high call
  o PPC32: Add missing break, without which get_user on 8-byte quantities would fail

Pete Zaitcev <zaitcev@redhat.com>:
  o [SPARC]: Add missing newline to kernel OOPS printk
  o [SPARC32/64]: Expand ioctl size field in backwards-compatible way
  o [SPARC]: RTC driver needs to include linux/pci.h
  o Fix initrd initialization

Petr Vandrovec <vandrove@vc.cvut.cz>:
  o Fix matroxfb build
  o Support for matroxfb on HP Vectra

Rob Radez <rob@osinvestor.com>:
  o [SPARC]: kmap_nonblock changes

Rusty Russell <rusty@rustcorp.com.au>:
  o [AF_UNIX] Cleanup forall_unix_sockets
  o [X25]: Fix improper | precendence, pointed out by Joern Engel
  o [ECONET]: Add comment to point out a bug spotted by Joern Engel

Theodore Ts'o <tytso@mit.edu>:
  o Ext2/3: noatime ignored for newly created inodes

Tom Rini <trini@kernel.crashing.org>:
  o PPC32: Export m8xx_cpm_hostalloc on CONFIG_8xx
  o PPC32: Replace 2 inline functions with their normal macro equivalents
  o PPC32: Fix a problem on MPC8xx when CONFIG_USE_MDIO=n
  o PPC32: Backport the code from 2.5 to make do_div handle 64bit
  o PPC32: KGDB is more useful when -g is in the CFLAGS
  o PPC32: Fix some warnings in the MPC8xx FPU emulation code
  o PPC32: Fix some warnings on MPC8xx
  o PPC32: Change some bootloaders to call load_kernel directly
  o PPC32: Add USE_STANDARD_AS_RULE to boot/lib/Makefile
  o PPC32: Fix some warnings on MPC8xx
  o PPC32: Clarify some of the MPC8xx uart code

Trond Myklebust <trond.myklebust@fys.uio.no>:
  o Fix misleading EIO on NFS client
  o Fix unbalanced kunmap() in NFS symlink code


Summary of changes from v2.4.21-pre4 to v2.4.21-pre5
============================================

<ajoshi@kernel.crashing.org>:
  o rivafb 0.9.4 update

<alex_williamson@hp.com[helgaas]>:
  o ia64: fix typo in ia32_support.c

<andrew.wood@ivarch.com>:
  o USB: USB-MIDI support for Roland SC8820

<arun.sharma@intel.com[helgaas]>:
  o ia64: ia32 emulation layer bug fix

<bbosch@iphase.com>:
  o [netdrvr ns83820] big endian fixes

<benh@zion.wanadoo.fr>:
  o Fix a bug in the workaround for closed P2P bridge IO windows which could actually break bridges that didn't need fixing
  o Export atomic_{clear,set}_mask for modules
  o Request Open Firmware to open all "display" devices instead limiting us to the first one. This helps getting all cards properly POSTed
  o Prevent the stack from growing on reads. This works around a problem with the mount syscall calling copy_mount_options() which can trigger a fault via copy_from_user() between the last core VMA and the stack.
  o Properly fixup the Winbond W83C553 IDE on Longtrail and BriQ's so the controller is switched to fully native mode and interrupts are configured properly
  o Fix serial table for BriQ hardware (different base clock) and make sure it works with CONFIG_VT
  o Fix a warning
  o Make sure xmon doesn't try to tap a hash table when none exist
  o Add asm byteswapped 64 bits accessors
  o Rework inline syscall macros, fix clobbers & gcc3.3 (From Franz Sirl)
  o Remove old gross hack that did nothing good

<bergner@vnet.ibm.com>:
  o Remove kdb from PowerPC-64
  o ppc64 updates to 2.4.21-pre4

<bjorn_helgaas@hp.com[helgaas]>:
  o ia64: Add local_irq_set() and save_and_sti()
  o ia64: Use IA64_PSR_I rather than (1UL << 14)
  o ia64: Reverse SGI scatterlist changes so SGI update will apply
  o ia64: Simple ndelay implementation
  o ia64: Add some default configs
  o ia64: whitespace fixes
  o ia64: add infrastructure for multiple IO port spaces
  o ia64: add support for MMIO and IO port spaces from ACPI _CRS
  o ia64: add iomem_resource and ioport_resource allocation
  o ia64: update defconfigs
  o Rename configs

<cniehaus@handhelds.org>:
  o spelling fix for drivers_usb_usbnet.c

<d3august@dtek.chalmers.se>:
  o USB: small uhci bug

<dave@thedillows.org>:
  o The initial release of the driver for the 3Com 3cr990 family

<davidm@tiger.hpl.hp.com[helgaas]>:
  o ia64: For ia32 emulation, do not turn on O_LARGEFILE automatically
  o ia64: Don't risk running past the end of the unwind-table.  Based on a patch by Suresh Siddha.

<davidm@wailua.hpl.hp.com[helgaas]>:
  o ia64: Fix ia64_fls() so it works for all possible 64-bit values

<eranian@frankl.hpl.hp.com[helgaas]>:
  o ia64: new perfmon patch for 2.4.20
  o ia64: perfmon update

<green@linuxhacker.ru>:
  o radio-cadet compile fix

<henning@meier-geinitz.de>:
  o USB scanner.c: Adjust syslog output

<ionut@badula.org>:
  o VLAN support, 64-bit support, bugfixes

<jbarnes@sgi.com>:
  o MAINTAINERS update for 2.4 SN support

<jgarzik@pobox.com>:
  o Fix undefined references for smp + apm

<jh@sgi.com[helgaas]>:
  o ia64: Update SGI SN files

<jochen@scram.de>:
  o [tokenring smctr] fix MAC address input
  o [tokenring madgemc] fix memory leak, add proper refcounting

<kare.sars@lmf.ericsson.se>:
  o [atm nicstar] fix incorrect traffic class assumption

<m.c.p@wolk-project.de>:
  o Speedup 'make dep'

<meissner@suse.de>:
  o [netdrvr pcnet32] fix multicast on big endian

<mikal@stillhq.com>:
  o Handle scsi_register() failure

<p.guehring@futureware.at>:
  o USB: FTDI driver, new id added

<peter@bergner.org>:
  o PPC64 update

<raul@pleyades.net>:
  o mmap.c corner case fix

<sprite@sprite.fr.eu.org>:
  o [SPARC64]: Avoid use of -e option with echo

<stelian@popies.net>:
  o sonypi and input subsystem integration
  o CREDITS update
  o use correct gcc flags when compiling for
  o sonypi driver update
  o make mousedev accept the jogdial
  o meye suspend/resume capabilities

Adrian Bunk <bunk@fs.tum.de>:
  o fix compile error with two IrDA drivers

Alan Cox <alan@lxorguk.ukuu.org.uk>:
  o ACPI apparently wasnt bios
  o fix wrong date in microcode comment
  o add another legitimate P4 type
  o must disallow write combine on 450NX
  o add framework for ndelay (nanoseconds)
  o first block of parisc resend
  o second block of parisc merge
  o third block of parisc merge
  o Ian Nelson moved
  o update videobook docs to avoid check_region
  o docs for IPMI
  o remove dead init call
  o add AMD hammer rng
  o IPMI driver updates
  o keyboard changes
  o fix wrong test in raw driver
  o fix paths for ide
  o clarify hpt37x config
  o fix more ide paths
  o Paul's fix to do ide_cs handling in task context
  o more ide paths
  o fix use of check_region in umc driver
  o more ide comment/doc info updates
  o promise printk cleanups
  o another wrong path
  o IDE printk/cleanup bits
  o fix serverworks paths/docs
  o clean up the siimage driver
  o update sis driver comments/docs/notes
  o update PIIX driver to know about more errata
  o fix winbond driver for new ide
  o more ide doc/comment updates
  o fix ppc ide paths
  o Ide raid updates
  o fix sbp2 compile failure
  o fix unsafe signed wrap check in pcilynx
  o use kbd_refresh_leds to keep USB/base keyboad lights right
  o clean up radio-cadet locking
  o use skb_padto to fix 3c527 padding
  o fix typo in 3c523 fixups
  o fix ethernet padding on 82596
  o fix ethernet padding on ariadne
  o fix ethernet padding on a2065
  o fix ethernet padding on atarilance
  o fix ethernet padding on am79c961a
  o fix ethernet padding on bagetlance
  o fix ethernet padding on declance
  o fix padding on depca
  o fix padding on eepro driver
  o fix padding on eexpress driver
  o fix ethernet padding on fmv18x
  o fix e2100 crash
  o fix ethernet padding on eth16i
  o fix ethernet padding on lasi
  o fix padding on epic100 driver
  o fix ethernet padding on lp486e
  o fix ethernet padding on lancr
  o fix padding on fmvj18x_cs
  o fix ethernet padding on hp100
  o fix ethernet padding on pcmcia/ray_cs
  o fix ethernet padding on xircom
  o fix ethernet padding on r8169
  o fix ethernet padding on seeq8005
  o fix padding on smc9194
  o fix padding on via_rhine
  o fix padding on yellowfin
  o fix padding on znet
  o fix padding on wavelan
  o update pci.ids for syskonnect
  o add 450NX streaming quirk, add via northbridge detect
  o fix dpt_i2o out of memory check
  o fix eata_generic jiffies check
  o document an ICH errata we have to deal with
  o fix sb_mixer handling
  o dont fail on 5451 reset
  o ide.h changes
  o add prototypes for kbdrefresh_leds
  o add skb_padto operation
  o fix ipc/msg race by dropping optimisation out
  o add skb_pad operation
  o copy OUTBSYNC operation too
  o fix the ide irq masking bug Ross found
  o fix confusing extra DMA off messages
  o add but dont yet use ide_execute_comman
  o sk98 driver vendor update

Alan Stern <stern@rowland.harvard.edu>:
  o USB: Patches for the ECONNRESET error (2.4)

Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>:
  o [TCP]: Do not forget data copy while collapsing retransmission queue

Andi Kleen <ak@muc.de>:
  o [IPV4]: Better behavior for NETDEV_CHANGENAME requests
  o x86-64 update
  o Workaround for AMD 8131 bug
  o Fix get_vm_area

Andrea Arcangeli <andrea@suse.de>:
  o xdr nfs highmem deadlock fix

Andrew Morton <akpm@digeo.com>:
  o ia32 syscall compatibility stubs

Andrey Panin <pazke@orbita1.ru>:
  o [netdrvr eepro100] add config option for PIO register read/write

Benjamin Herrenschmidt <benh@kernel.crashing.org>:
  o PPC32: Implement workarounds for errata on recent G3 and G4 cpus

Bjorn Helgaas <bjorn_helgaas@hp.com>:
  o ia64: Delete all SGI SN defconfig files
  o ia64: Dont execute srlz.d needlessly (reported by Chris Ruemmler)
  o ia64: smp_threads_ready: make non-volatile
  o don't swapon mounted devices
  o ia64: Use has_8259 rather than initdata
  o ia64: Really remove ACPI SPCR parsing
  o Cset exclude: eranian@frankl.hpl.hp.com[helgaas]|ChangeSet|20030103231109|26349
  o ia64: fix perfmon typo (PFM_CPU_SYST_WIDE should be PFM_CPUINFO_SYST_WIDE)

Christoph Hellwig <hch@sgi.com>:
  o handle too large vmallocs gracefully

Dave Jones <davej@codemonkey.org.uk>:
  o [netdrvr sunqe] remove incorrect kfree()

Dave Kleikamp <shaggy@shaggy.austin.ibm.com>:
  o JFS: replace ugly JFS debug macros with simpler ones
  o JFS: Minor update in Documentation/filesystems/jfs.txt
  o JFS: implement get_index_page to replace some uses of read_index_page
  o JFS: Add debug code to help catch elusive bug
  o JFS: simplify jfs_err() to avoid parsing bug in gcc-2.95
  o JFS: Fix jfs_sync_fs

David Brownell <david-b@pacbell.net>:
  o USB: ehci-hcd, more hangs gone

David Gibson <david@gibson.dropbear.id.au>:
  o PPC32: Add work-around for erratum #77 on IBM 405 processors
  o Update orinoco driver to 0.13b

David S. Miller <davem@nuts.ninka.net>:
  o [TG3]: Let chip do pseudo-header csum on rx
  o [TG3]: Add device IDs for 5704S/5702a3/5703a3
  o [TG3]: Prevent dropped frames when flow-control is enabled
  o [TG3]: Correct MIN_DMA and ONE_DMA settings in dma_rwctrl
  o [TG3]: Workaround 5701 back-to-back register write bug
  o [TG3]: Add workaround for third-party phy issues
  o [TG3]: Remove anal grc_misc_cfg board IDs check
  o [TG3]: Fix typos in previous changes
  o [TCP]: In tcp_check_req, handle ACKless packets properly
  o [SPARC]: Add ndelay
  o [SPARC]: Add ndelay ksyms export

David Woodhouse <dwmw2@infradead.org>:
  o Export skb_pad() in 2.4.21-pre4

Gerd Knorr <kraxel@bytesex.org>:
  o bttv documentation update
  o tuner module update
  o video4linux i2c modules update
  o bttv update

Gerd Knorr <kraxel@suse.de>:
  o bttv config fix

Greg Kroah-Hartman <greg@kroah.com>:
  o USB: hid blacklist update
  o USB: more hid blacklist items
  o USB: added tripp device id's to pl2303 driver

Ivan Kokshaysky <ink@jurassic.park.msu.ru>:
  o alpha dma fix
  o alpha update

Jay Vosburgh <fubar@us.ibm.com>:
  o [netdrvr 3c59x] move netif_carrier_off() call outside vortex_debug test

Jeff Garzik <jgarzik@mandrakesoft.com>:
  o arch/i386/Makefile: fix Via C3 build flags with gcc 3.<recent>

Jeff Garzik <jgarzik@redhat.com>:
  o [netdrvr tg3] bump version, tidy comments
  o [netdrvr amd8111e] remove stray ';', fixing register dump [#311]
  o [netdrvr tg3] DMA MRM bit only exists on 5700, 5701
  o [netdrvr fc/iphase] correct PCI probe loop-end test logic [#323]
  o [tokenring smctr] remove stray ';' that prevented a loop from working [#312]
  o [ARM] CREDITS, MAINTAINERS, Documentation/arm/* updates
  o [ARM] misc janitorial cleanups for arch/arm/kernel
  o [ARM] misc janitorial cleanups for arch/arm/mach*, arch/arm/mm
  o [ARM] misc janitorial cleanups for include/asm-arm
  o [netdrvr 8390] if ARM, only redefine EI_SHIFT, not I/O macros
  o [netdrvr] add new ARM net drivers cirrus, ether00
  o [netdrvr bmac] Remove unneeded memset()
  o [netdrvr 8139too] add some boards to the list of tested boards
  o [netdrvr tg3] disable 5701 h/w bug workaround during core clock reset
  o [netdrvr tg3] fix NAPI deadlock
  o [netdrvr tg3] bump version to 1.4c / Feb 18
  o [netdrvr tg3] properly synchronize with TX, in tg3_netif_stop
  o [netdrvr tg3] fix TX race in previous code, and another buglet
  o [netdrvr] Update Doc/networking/netdevices.txt with more locking rules

Jens Axboe <axboe@suse.de>:
  o Remove unused node from ide-probe.c
  o Andrea's elevator backmerge patch]

Johannes Erdfelt <johannes@erdfelt.com>:
  o usb_get_driver_np() gives wrong driver name (usb_mouse)
  o USB: OHCI trivial remove unused field
  o USB: 2.4 OHCI trivial comment cleanup

John Stultz <johnstul@us.ibm.com>:
  o Fix target_cpus()

Kurt Garloff <garloff@suse.de>:
  o Handle SCSI recovered errors

Maksim Krasnyanskiy <maxk@qualcomm.com>:
  o [Bluetooth] Add support for vendor specific commands

Marcelo Tosatti <marcelo@freak.distro.conectiva>:
  o Cset exclude: rusty@rustcorp.com.au|ChangeSet|20030224224251|29662
  o Changed EXTRAVERSION to -pre5
  o Define kmap_nonblock() for non highmem

Mark A. Greer <mgreer@mvista.com>:
  o PPC32: Fix our L2 / L3 cache updates for the bootloader

Martin Devera <devik@cdi.cz>:
  o [NET_SCHED]: HTB scheduler updates from Devik

Martin Schwidefsky <schwidefsky@de.ibm.com>:
  o s390 base architecture update
  o xpram driver fix for 64-bit
  o s390 idals.h update

Matthew Wilcox <willy@debian.org>:
  o [wireless airo] call pci_enable_device, pci_set_master where needed

Olaf Hering <olh@suse.de>:
  o ide_fix_driveid unresolved in usb-storage

Oleg Drokin <green@angband.namesys.com>:
  o reiserfs: Fix DIRECT IO interference with tail packing

Oliver Neukum <oliver@neukum.name>:
  o USB: 2.4 ehci uses SLAB_KERNEL in interrupt
  o USB: kaweth length calculation fix
  o USB: new device id for kaweth

Paul Mackerras <paulus@samba.org>:
  o PPC32: Fix the clone syscall, and make exec clear fp and vr registers
  o PPC32: Clean up exception and oops handling
  o PPC32: Tighten up the stack expansion code
  o PPC32: Fix handling of alignment traps on some PPC processors
  o PPC32: Actually use the FP exception mode requested with prctl()
  o PPC32: use the standard __stringify instead of a local version
  o PPC32: Further fixes for the stack expansion code
  o PPC32: add ndelay(), update udelay() to be more accurate and robust
  o PPC32: Minor cleanups in the CHRP platform code
  o PPC32: Allow for RAM not starting at 0, for APUS (and potentially others)
  o PPC32: PReP platform fixes from Hollis Blanchard, Tom Rini, Leigh Brown and others
  o PPC32: Fixes for byte-swapping macros, from Franz Sirl
  o PPC32: PCI fixes.  We can now restrict I/O windows to 16MB or so because this code lets us move the I/O windows of PCI-PCI bridges if necessary.
  o PPC32: Fix copy_from_user to copy as much as possible even when it gets a fault
  o PPC32: Provide a default implementation of ide_init_hwif_ports in asm-ppc/ide.h and use it if there is no platform-specific version.
  o PPC32: fix compilation error in arch/ppc/platforms/pmac_setup.c
  o PPC32: Move some variable declarations related to the MMU hash table to <asm/mmu.h>

Pete Zaitcev <zaitcev@redhat.com>:
  o [SPARC32]: Backport fixes from 2.5.x

Petko Manolov <petkan@users.sourceforge.net>:
  o USB: pegasus update (2.4)

Roger Luethi <rl@hellgate.ch>:
  o [netdrvr via-rhine] trivial bits
  o [netdrvr via-rhine] fix broken tx-underrun handling
  o [netdrvr via-rhine] various duplex-related fixes
  o [netdrvr via-rhine] reset function rewrite
  o [netdrvr via-rhine] bump version, use constant instead of magic number

Rusty Russell <rusty@rustcorp.com.au>:
  o namespace pollution in procfs
  o arch_ia64_sn_io_sn1_pcibr.c, typo: the the
  o misc register audit fix on qtronix
  o duplicate header in drivers_bluetooth_hci_h4.c
  o write with buffer>2GB returns broken errno
  o misc register audit fix on ppc64's nvram.c
  o USB: Clean up some USB macros
  o available spell fixes
  o correct description of Griffin Powermate
  o namespace pollution in eth bridge driver
  o drivers_net_wan_sdla_x25.c, typo: the the
  o es1372.c doesn't free resources correctly
  o Typos in drivers_s390_net_iucv.c
  o i2c ID addition
  o NCR5380 unbalanced curly brace
  o Fix floppy.h's CROSS_64KB()

Scott Feldman <scott.feldman@intel.com>:
  o [netdrvr e100] math fixes and a cleanup

Stephen C. Tweedie <sct@redhat.com>:
  o Fix signed use of i_blocks in ext3 truncate

Tom Rini <trini@kernel.crashing.org>:
  o PPC32: Change the MPC8xx IRQ code so that things are arranged like other systems.
  o PPC32: Enable PCMCIA and a tested wifi card on some MPC8xx targets
  o PPC32: Change the MontaVista copyright / GPL boilerplate to a condensed version.
  o PPC32: Fix an oops on hardware without an RTC in timer_interrupt()
  o PPC32: Fix building of the IBM Spruce platform and !CONFIG_SERIAL
  o PPC32: Fix some gcc-3.x warnings on the IBM Spruce
  o PPC32: Cleanup the boot code to better deal with no console
  o PPC32: Minor KGDB warning fixes
  o PPC32: Add CONFIG_KGDB_CONSOLE to MPC 8xx systems
  o PPC32: MPC8xx KGDB fixes, from Dan Malek
  o PPC32: Add KGDB support for the IBM Spruce platform
  o PPC32: Ask about CONFIG_BOOTX_TEXT in the 'Kernel hacking' menu
  o PPC32: Put reading of PReP/PPCBUG nvram into CONFIG_PPCBUG_NVRAM
  o PPC32: Add support for the Motorola LoPEC platform
  o PPC32: Remove the 'BK Id' tags from files
  o PPC32: Fix SysRq on IBM Spruce

Trond Myklebust <trond.myklebust@fys.uio.no>:
  o Fix XID allocation race in 2.4.21-pre4

Wolfgang Muees <wolfgang@iksw-muees.de>:
  o USB: updated Auerswald driver

Summary of changes from v2.4.21-pre3 to v2.4.21-pre4
============================================

<blueflux@koffein.net>:
  o [IPV4 ROUTE]: Fix some sysctl documentation

<dwmw2@dwmw2.baythorne.internal>:
  o Miscellaneous MTD block driver fixes
  o MTD partitioning updates
  o MTD updates

<filip.sneppe@cronos.be>:
  o [NETFILTER]: ip_conntrack_ftp.c, fixes a typo in a DEBUG statement

<gandalf@wlug.westbo.se>:
  o [NETFILTER]: Fix a locking bug in ip_conntrack_proto_tcp

<ganesh@tuxtop.vxindia.veritas.com>:
  o Added ids for the Dell Axim and Toshiba E740. Thanks to Ian Molton

<georgn@somanetworks.com>:
  o Fix /proc/slabinfo on ARM

<henning@meier-geinitz.de>:
  o scanner.c: remove "magic" number for interface
  o USB scanner driver: updated Configure.help
  o scanner.h, scanner.c: New vendor/product ids for visioneer scanners
  o scanner.c: print user-supplied ids only on start-up
  o scanner.c, scanner.h: Remove PV8630 ioctls
  o scanner.c: endpoint detection cleanup
  o Add maintainer for USB scanner driver
  o scanner.h, scanner.c: maintainer change

<jamie@shareable.org>:
  o [SPARC64]: Fix MAP_GROWSDOWN value, cannot be the same as MAP_LOCKED

<kadlec@blackhole.kfki.hu>:
  o [NETFILTER]: Fix excess logging of reused FTP expectations

<manish@zambeel.com>:
  o [netdrvr tg3] add support for another 5704 board, fix up 5704 phy init

<marcus@ingate.com>:
  o [NETFILTER]: ipt_multiport invert fix

<neilt@slimy.greenend.org.uk>:
  o USB Serial patch

<netfilter@interlinx.bc.ca>:
  o [NETFILTER]: UDP nat helper support

<stelian@popies.net>:
  o sonypi driver update
  o make sonypi use ec_read/ec_write from ACPI patch

<valko@linux.karinthy.hu>:
  o [SPARC64]: Translate IPT_SO_SET_REPLACE socket option for 32-bit apps
  o [SPARC64]: Handle SO_TIMESTAMP properly in compat recvmsg

Adrian Bunk <bunk@fs.tum.de>:
  o remove duplicate entries from Configure.help

Alan Cox <alan@lxorguk.ukuu.org.uk>:
  o allow people to build M686 without PGE kernels
  o more vaio apm blacklist entries
  o mp oops fix
  o MP message improvements
  o remove confusing MP report
  o nmi stack usage
  o fix linux crash on boot with some boarss
  o fix up cx86 docs
  o IPMI driver
  o enable ipmi config
  o fix compile of 4.0 DRM
  o more parisc specific merge bits
  o parisc mux driver (parisc specific)
  o disable taskfile I/O
  o further IDE tape fixes
  o Skip disabled IDE generic controllers
  o Add ide software raid driver for Medley IDE raid
  o add support for Nvidia nForce2 IDE
  o Allow DMA setup on radeon IGP now we think its fixed
  o allow selection of SI raid
  o fix packet padding on 3c501
  o fix packet padding on the 3c505
  o more unusual USB storage devices
  o fix packet padding on the 3c507
  o fix packet padding on the 3c523
  o fix packet padding on the 7990
  o fix packet padding on the 8139too
  o fix 8390 packet padding
  o fix packet padding on at1700
  o fix packet padding on atp
  o fix de600/20 packet padding
  o fix ni5010 packet padding
  o fix ni52 packet padding
  o fix packet padding on ni65
  o fix packet padding on axnet_cs
  o fix padding on sgiseeq
  o fix sk_g16 padding
  o fix sun3_82586 padding
  o fix sun3lance packet padding
  o further dscc4 updates
  o document undocumentend field in SCSI headers
  o fix ad1889 warning - void functions dont return values
  o more unusual USB storage devices
  o ; cut the mount hash table down to a sane size, and fix printk
  o fix casting in pci dma
  o parisc header update
  o fix msdos end markers for compatibility with cameras etc

Andi Kleen <ak@muc.de>:
  o x86-64 update
  o hammer support for i386

Andrea Arcangeli <andrea@suse.de>:
  o O_DIRECT alignment fix

Andrew Morton <akpm@digeo.com>:
  o [SPARC64]: Handle unchanging _TIF_32BIT properly in SET_PERSONALITY
  o sync_supers() race fix
  o Fix ext3 scheduling storm and lockup
  o 3c59x: add 3c920 support
  o fix rare BUG in ext3

Christoph Hellwig <hch@sgi.com>:
  o fix scsi module unload bug
  o cciss/cpqarray/md should use generic BLKGETSIZE
  o properly handle too long pathnames in d_path
  o update bdflush documentation

Dave Engebretsen <engebret@us.ibm.com>:
  o PPC64 update

Dave Kleikamp <shaggy@shaggy.austin.ibm.com>:
  o JFS: Remove invalid warning
  o JFS: Remove COMMIT_Holdlock
  o JFS: add jfs_get_volume_size() back
  o JFS: Clean up flushing outstanding transactions to journal
  o JFS: add sync_fs super_operation

David Brownell <david-b@pacbell.net>:
  o zaurus B500 (sl-5600?) & usbnet
  o usb root hub strings

David Gibson <david@gibson.dropbear.id.au>:
  o Squash warnings in init/do_mounts.c

David S. Miller <davem@nuts.ninka.net>:
  o [USB]: rtl8150.c needs linux/init.h
  o [TCP]: Add tcp_low_latency sysctl
  o [TCP]: Fix typo in TCP_LOW_LATENCY changes

Geert Uytterhoeven <geert@linux-m68k.org>:
  o Amiflop incorrect sti()
  o Atari ACSI exports
  o M68k misc_register audit
  o Mac/m68k config fixes
  o Mac/m68k early startup fixes
  o Mac/m68k Nubus updates
  o Atari NVRAM
  o m68k typo
  o Q40 IRQ typo
  o Replace Mac/m68k NS8390 with daynaport driver
  o init_rootfs() prototype
  o M68k matroxfb
  o register_console() comment typo
  o Mac/m68k NCR5380 SCSI updates

Gerd Knorr <kraxel@bytesex.org>:
  o videodev bugfix
  o add bt832 driver
  o bttv documentation update
  o tuner update
  o i2c tv modules update

Greg Kroah-Hartman <greg@kroah.com>:
  o USB: fix ehci build problem for older versions of gcc
  o USB bluetooth: fix incorrect url in help text
  o USB: Move the scanner ioctls to usb_scanner_ioctl.h to allow access by archs that need it

Harald Welte <laforge@gnumonks.org>:
  o [NETFILTER]: This patch fixes the ULOG target when logging packets without any ethernet header (mac address).

Ivan Kokshaysky <ink@jurassic.park.msu.ru>:
  o alpha update
  o alpha: titan, marvel, srmcons updates

Jeff Garzik <jgarzik@redhat.com>:
  o [netdrvr tg3] s/spin_lock/spin_lock_irqsave/ in tg3_poll and tg3_timer
  o [netdrvr tg3] Better interrupt masking
  o [netdrvr tg3] flush irq-mask reg write before checking hw status block, in tg3_enable_ints.
  o [netdrvr tg3] manage jumbo flag on MTU change when interface is down
  o [netdrvr e100] remove file e100_proc, missed in previous patch (standard stats)
  o [netdrvr tg3] more verbose failures, during initialization

Jens Axboe <axboe@suse.de>:
  o Fix ide highmem scatterlist setup
  o fix CONFIG_IDE_DMA_ONLYDISK
  o IDE: Do not call bh_phys() on buffers with invalid b_page

John Stultz <johnstul@us.ibm.com>:
  o Compensate lost ticks in x440s

Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>:
  o ISDN: Remove unfinished driver
  o ISDN: Improve DTMF detection
  o ISDN: Fix HiSax/ISAR fax handling bug
  o ISDN: Add locking for list access
  o ISDN: Add ISDN side support for Auerswald USB ISDN support
  o ISDN: Small HiSax cleanups

Khalid Aziz <khalid_aziz@hp.com>:
  o Avoid ide-scsi from starting DMA too soon

Marcel Holtmann <marcel@holtmann.org>:
  o [Bluetooth] Make READ_VOICE_SETTING available for normal users
  o [Bluetooth] Replace info message about SCO MTU with BT_DBG
  o [Bluetooth] Remove wrong check for size value in rfcomm_wmalloc()

Marcelo Tosatti <marcelo@freak.distro.conectiva>:
  o Changed EXTRAVERSION to -pre4

Olaf Hering <olh@suse.de>:
  o autofs compat for ppc

Oleg Drokin <green@angband.namesys.com>:
  o reiserfs: iput deadlock fix - do not call iput() from inside of transaction

Patrick McHardy <kaber@trash.net>:
  o [NETFILTER]: Fix ipt_REJECT udp checksums
  o [NETFILTER]: Fix incremental TCP checksum in ECN module
  o [PPP]: Handle filtering drops correctly

Paul Gortmaker <p_gortmaker@yahoo.com>:
  o Fix wildcards in RTC alarm settings

Paul Mackerras <paulus@samba.org>:
  o add prctls for FP exception control

Petr Vandrovec <vandrove@vc.cvut.cz>:
  o Fix non-G450/G550 build of matroxfb

Randy Dunlap <randy.dunlap@verizon.net>:
  o usb-skeleton MINOR_BASE change

Richard Henderson <rth@dot.sfbay.redhat.com>:
  o [ALPHA] Add debugging access (core and ptrace) to the PAL unique value.

Robert Olsson <robert.olsson@data.slu.se>:
  o [NAPI]: Discuss some more issues in driver HOWTO

Scott Feldman <scott.feldman@intel.com>:
  o [netdrvr e100] Sync 2.4.x driver with 2.5.x driver
  o [netdrvr e100] udelay a better way
  o [netdrvr e100] standardize nic-specific stats output
  o [netdrvr e100] fix TxDescriptor bit setting
  o [netdrvr e1000] allocate ethtool eeprom buffer dynamically, rather than a large static allocation on the stack
  o [netdrvr e1000] remove /proc support
  o [netdrvr e1000] Add ethtool GSTATS support

Simon Evans <spse@secret.org.uk>:
  o USB: Backport konicawc driver to 2.4

Tom Callaway <tcallawa@redhat.com>:
  o [SUNLANCE]: Add missing asm/machine.h include for sun4 builds
  o [SPARC64]: Add USB scanner ioctls to 32-bit compat table

Trond Myklebust <trond.myklebust@fys.uio.no>:
  o Fix Oopsable NFS condition in 2.4.21-preX

Vojtech Pavlik <vojtech@suse.cz>:
  o Fix the JSIOCGABSMAP et al ioctls in joydev.c
  o Add new devices support to I-Force driver

Summary of changes from v2.4.21-pre2 to v2.4.21-pre3
============================================

<bdschuym@pandora.be>:
  o [BRIDGE]: new_nbp runs under rwlock so needs to use GFP_ATOMIC

<bero@arklinux.org>:
  o AGP support for VIA P4X333 boards

<ganesh@tuxtop.vxindia.veritas.com>:
  o USB ipaq driver update

<greearb@candelatech.com>:
  o [VLAN]: Quiet some printks and free devices/groups correctly

<hadi@cyberus.ca>:
  o [SCH_GRED]: Array overflow fixes, found by Stanford checker

<henning@meier-geinitz.de>:
  o scanner.h: add/fix vendor/product ids
  o scanner.c: silence noisy debug message
  o scanner.c: Support for devices with only one bulk-in endpoint
  o scanner.c: Accept scanners with more than one interface
  o [PATCH 2.4.21-pre1] scanner.c: Use first altsetting in probe_scanner()
  o scanner.c: fix race in ioctl_scanner()
  o USB scanner driver: updated documentation

<joergprante@netcologne.de>:
  o [2.4.21-pre2] scx200 build fix

<krkumar@us.ibm.com>:
  o [IPV6]: Missing in6_dev_put in router discovery

<mark@hal9000.dyndns.org>:
  o Update ov511 to version 1.63. This is a backport of the 2.5 driver,

<oliver@oenone.homelinux.org>:
  o USB kaweth bugfix

<petkan@rakia.hell.org>:
  o a new device added and assign proper vendor id to the Netgear adapter
  o USB pegasus update
  o USB rtl8150 update
  o Petkan's email address change

Alan Cox <alan@lxorguk.ukuu.org.uk>:
  o fix legacy hd
  o various minor noise merges
  o update Pavel credits
  o via audio updates to add 8233/8235 support
  o motorola timeport is comms class but doesnt use comms class
  o support 24bit and multichannel audio stuff in usb-audio
  o use MUX ident for pdc console
  o bring wan drivers into line with 2.5
  o matroxfb updates
  o documentation only merge - add docbook documentation to jbd
  o fix suprises in arm defines
  o defines/protection oddments for x86
  o add CON_BOOT flaga
  o kstat changes for PA risc
  o matroxfb update header
  o update iphase ATM driver
  o 3964 trivial optimisation
  o arcnet pci updates
  o eepro100: more boxes care about alignment
  o scsi dup id bug
  o isd200 to new style IDE
  o USB workaround for ALi OHCI oddments
  o Fix memory leak in fs layer
  o DRM must enable device to get its IRQ
  o drm ensure memory initialized
  o another DRM backport of a memory clear
  o x86-64 needs the same page twiddles as x86-32 for DRM AGP
  o email change in DRM
  o email change in drm - 2
  o journalling header changes (docs only)
  o removepage callback
  o wrong include order
  o fix i810 oops
  o fix mplayer. realplayer and friends on via8233/8235
  o IDE driver for Compaq Triflex IDE
  o fix ALi audio handling for 6 channel, fixes audio in RadeonIGP
  o config entry for triflex ide
  o corename patch from -ac
  o bring APM up to date
  o Fix the "controller but no drives" IDE problem
  o trivial ide oddments

Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>:
  o [IPV6]: Check for NULL return from __in6_dev_get

Andreas Dilger <adilger@clusterfs.com>:
  o 2.4 ext3 ino_t removal

Andrew Morton <akpm@digeo.com>:
  o remove dead function swap_count()
  o fix buffer_head.b_state race

Arnaldo Carvalho de Melo <acme@conectiva.com.br>:
  o Fix token ring SMP lockups

Bart De Schuymer <bart.de.schuymer@pandora.be>:
  o [IP_TABLES]: Fix locking comments

Bjorn Helgaas <bjorn_helgaas@hp.com>:
  o Fix CPU bitmask truncation (1 of 2)
  o Fix CPU bitmask truncation (2 of 2)

Chad N. Tindel <ctindel@cup.hp.com>:
  o [BONDING]: Update to version 2.4.20-20021210

Dave Jones <davej@codemonkey.org.uk>:
  o Work around BIOS problem with recent Athlons

David Brownell <david-b@pacbell.net>:
  o ehci updates

David S. Miller <davem@nuts.ninka.net>:
  o net/ipv6/netfilter/ip6table_mangle.c: Fix bogus cast
  o [ip-sysctl.txt]: Clarify conf/*/ behavior
  o [IPV4]: Report zero route advmss properly
  o [NET]: Copy msg_namelen back to user in recv{from,msg} even if it is zero
  o [VLAN]: remove vlan_devices[] entries properly
  o [IPV6]: Fix merge error
  o [IPV6]: Kill unused variable in igmp6_leave_group
  o [TCP]: Add FRTO sysctl entry

Greg Kroah-Hartman <greg@kroah.com>:
  o USB scanner: stop managing our module reference count, and let the VFS do it

Harald Welte <laforge@gnumonks.org>:
  o [NETFILTER] Add IP unused bit check to ipt_unclean.c, from Maciej Soltysiak

Hideaki Yoshifuji <yoshfuji@linux-ipv6.org>:
  o net/ipv6/addrconf.c: Use prefix of 64 for link-local addresses
  o net/ipv6/mcast.c: Several MLD fixes
  o [IPV6]: Add IPV6_V6ONLY socket option support
  o [IPV6]: Add ICMP6 rate limit sysctl
  o [IPV6]: Split ndisc_rcv into helper functions
  o [IPV6]: Avoid garbage sin6_scope_id for MSG_ERRQUEUE messages
  o [IPV6]: Fix for refined IPV6 address validation timer
  o [IPV6]: Fix Length of Authentication Extension Header

Hugh Dickins <hugh@veritas.com>:
  o tmpfs read hang

Jean Tourrilhes <jt@bougret.hpl.hp.com>:
  o IrLMP basic socket scheduler
  o donauboe IrDA driver

Jeff Garzik <jgarzik@redhat.com>:
  o [netdrvr mii] fix ugly lack of useful bit masking
  o [netdrvr] add AMD-8111 ethernet driver (yet another PCI lance)
  o [netdrvr eepro100] new pci id
  o [netdrvr de4x5] fix uninitializer timer
  o [netdrvr e1000] sync up with 2.5.x e1000 driver
  o [netdrver e1000] wol updates
  o [netdrvr e1000] restore VLAN settings after resume
  o [netdrvr e1000] small cleanups and fixes
  o [netdrvr e100] sync up with 2.5.x e100 driver
  o [netdrvr e100] Bug fix: system panic in watchdog when repeating ifdown, rmmod, insmod
  o [netdrvr e100] Bug fix: enable/disable WOL based on EEPROM settings
  o [netdrvr e100] fix ethtool/mii interface up/down issues
  o [netdrvr e100] better debugging for command failures/timeouts
  o [netdrvr e100] changelog/whitespace updates, small fixes

Maksim Krasnyanskiy <maxk@qualcomm.com>:
  o Remove old BNEP ioctls. These are internal. Only one app is supposed to use them, so there is no compatibility problem.
  o Move Bluetooth ioctls after USB and other stuff in sparc64/ioctl32.c

Marcel Holtmann <marcel@holtmann.org>:
  o [Bluetooth] Convert dlci and channel variables to u8
  o [Bluetooth] Add some COMPATIBLE_IOCTL for SPARC64

Marcelo Tosatti <marcelo@conectiva.com.br>:
  o Fix ide-tape unload issue

Marcelo Tosatti <marcelo@freak.distro.conectiva>:
  o Add removepage callback
  o Cset exclude: alan@lxorguk.ukuu.org.uk|ChangeSet|20030102230329|26122 "add hwclock ioctls"
  o Changed EXTRAVERSION to -pre3
  o Fix typo in Apollo P4X400 support patch
  o Revert broken drivers/ieee1394/Makefile changes

Mark W. McClelland <mark@alpha.dyndns.org>:
  o USB ov511: Convert to new V4L 1 interface

Mikael Pettersson <mikpe@csd.uu.se>:
  o Fix ide-scsi ref count bug in 2.4.20-pre2

Neil Brown <neilb@cse.unsw.edu.au>:
  o Remove irrelevant warning in sunrpc code
  o Avoid oops when NFSD decodes enourmous filehandle
  o Set BH_Locked when accessing MD superblocks

Pasi Sarolahti <sarolaht@cs.helsinki.fi>:
  o [TCP]: Add F-RTO support

Paul Mackerras <paulus@samba.org>:
  o PPC32: More OpenPIC updates, to openpic_init and openpic_init_nmi_irq
  o PPC32: fix the compile with IDE
  o PPC32: Provide a more general way to handle cascaded interrupts
  o PPC32: Provide finer control over IRQ sense and polarity for OpenPIC interrupts.
  o PPC32: Evaluate physical addresses correctly from Open Firmware device tree when we have non-transparent PCI bridges.
  o PPC32: remove the unimplemented iopl, vm86 and modify_ldt syscalls
  o PPC32: Update all the defconfigs

Randy Dunlap <rddunlap@osdl.org>:
  o usb semaphore lock in 2.4.20-rc1 (since 2.4.13)

Simon Evans <spse@secret.org.uk>:
  o 2.4.20 usbvideo cleanups 1/4
  o 2.4.20 usbvideo cleanups 2/4
  o 2.4.20 usbvideo cleanups 3/4
  o 2.4.20 usbvideo cleanups 4/4
  o 2.4.20 usbvideo fixes from 2.5  1/5
  o 2.4.20 usbvideo fixes from 2.5  2/5
  o 2.4.20 usbvideo fixes from 2.5  3/5
  o 2.4.20 usbvideo fixes from 2.5  4/5
  o 2.4.20 usbvideo fixes from 2.5  5/5

Thomas Sailer <sailer@scs.ch>:
  o Fix oopsable bug in OSS PCI sound drivers

Tom Rini <trini@kernel.crashing.org>:
  o PPC32: Add support to the OpenPIC code to allow the controller to be in serial mode.
  o PPC32: Change the OpenPIC initalization logic so that it no longer needs to know where the NMI irq is.
  o PPC32: Remove an unused parameter to openpic_init()
  o PPC32: Make progress messages for OpenPIC matters consistent
  o PPC32: Merge i8259_irq() (using the int-ack feature) and i8259_poll() (poll for IRQ) into one function, i8259_irq().
  o PPC32: Remove a special case for hardware with an OpenPIC and i8259 where we must call use the int-ack for cascaded IRQs and not poll.
  o PPC32: Remove extra __KERNEL__ checks in some headers, as well as adding /* __KERNEL__ */ to the #endif of others.
  o PPC32: Fix a problem in the bootloader/wrapper where we might
  o PPC32: Fix some 'prep' machines which are not true PRePs, and can safely poll for interrupts on the i8259.
  o PPC32: Add explicit parens around arguments used in macros in include/asm-ppc/page.h
  o PPC32: Fix a delay which could occur when booting on machines without an RTC.
  o PPC32: Move IRQ sense and polarity masks to <asm/irq.h>

Vojtech Pavlik <vojtech@suse.cz>:
  o Workaround (ide-timing.h) for many ATAPI CD/DVD-ROMs and burners


Summary of changes from v2.4.21-pre1 to v2.4.21-pre2
============================================

<agruen@suse.de>:
  o ia64: Extended Attribute VFS syscalls

<alex_williamson@hp.com[helgaas]>:
  o ia64: If no CPE interrupt, poll periodically for CPEs

<bjorn_helgaas@hp.com[helgaas]>:
  o ia64: Fix race between TLB purges and reload_context
  o ia64: Avoid holding tasklist_lock across routines that do IPIs (such as flush_tlb_all())
  o ia64: Avoid holding task lock while calling access_process_vm()
  o ia64: Update defconfig with 2.4.20 defaults, build in ext3
  o ia64: Move simeth, simserial, simscsi back to drivers/ for init ordering
  o ia64: break trap: die_if_kernel only if break value is 0
  o ia64: Alternate signal stack fix.  Patch from David Mosberger

<davidm@tiger.hpl.hp.com[helgaas]>:
  o ia64: Some formatting cleanups
  o ia64: Patch by Venkatesh Pallipadi to fix IA-32 signal handling to restore instruction and data pointers.
  o ia64: Fix unaligned memory access handler

<eranian@frankl.hpl.hp.com>:
  o ia64: perfmon update

<eranian@frankl.hpl.hp.com[helgaas]>:
  o ia64: perfmon: This patch adds

<grundym@us.ibm.com>:
  o 2.4.21-pre1 compile fixes for s390(x)

<jkt@helius.com>:
  o uhci corruption on usb_submit_urb when already -EINPROGRESS

<jsm@udlkern.fc.hp.com>:
  o ia64: Preserve f11-f15 around calls into firmware
  o ia64: Use virtual mem map automatically if >1GB gap found

<kernel@steeleye.com>:
  o Fix NULL pointer dereference in ide.c

<kuba@mareimbrium.org>:
  o USB: ftdi-sio update

<m.c.p@wolk-project.de>:
  o Eliminate warning in drivers/usb/hc_sl811.c

<marekm@amelek.gda.pl>:
  o Datafab KECF-USB / Sagatek DCS-CF / Simpletech UCF-100

<mikael.starvik@axis.com>:
  o CRIS architecture update for 2.4.21

<mlocke@mvista.com>:
  o serial.c fix: ELAN fix breaks others

<nobita@t-online.de>:
  o support for Sony Cybershot F717 digital camera / usb-storage

<petkan@mastika.dce.bg>:
  o set_mac_address is now added to the driver.  thanks to Orjan Friberg <orjan.friberg@axis.com>

<petkan@rakia.dce.bg>:
  o USB: pegasus: the data for the control requests is now stored in DMA able memory

<stelian@popies.net>:
  o usbnet typo

<venkatesh.pallipadi@intel.com[helgaas]>:
  o ia64: Save/Restore of IA32 fpstate in sigcontext
  o ia64: Clearing of exception status before calling IA32 user signal handler
  o ia64: IA-32 ptrace: xmm reg support, fpstate 'tag' fix, fp TOS fix

<wahrenbruch@kobil.de>:
  o USB: add kobil_sct driver
  o USB: kobil_sct driver bugfix

<willy@fc.hp.com>:
  o ia64: Remove support for HP prototypes
  o ia64: Discard *.text.exit and *.data.exit sections
  o ia64: ACPI tidy-up

Alan Cox <alan@lxorguk.ukuu.org.uk>:
  o IDE changes for CRIS
  o ppc structure mangling for ide
  o Add NS32 author to CREDITS
  o Add NinjaSCSI author to CREDITS
  o ide config tweaks
  o ninja 32 help
  o config for beos fs
  o pcigame now does ali5451
  o clean drm object
  o fix pci game double unregister
  o update serial_cs from pcmcia updates
  o update parisc gsc/hil drivers
  o ad scx200 i2c drivers
  o typo in ide config
  o fix port types to be long for IDE iops, fix ppc mess
  o ide-tape driver updates
  o fix u32->ulong for IDE bars
  o fix ali u32->ulong on bars also fix oops on boot with xmeta
  o ; more ide fixes for ulong
  o fix hpt, print message when we abort due to overclocking
  o more ide u32->ulong
  o clean up u32/ulong/mmio etc on siimage (DaveM)
  o final bits of ide pci driver fixup
  o add sf16fmr2 driver
  o fix sign bug in pms
  o make the cache line printk nicer and < 80 cols
  o config for ninja32 scsi
  o further cpqfcts fixes
  o fix section clash in in2000
  o makefile for NSP32
  o comment purpose of a blacklist entry
  o ad1889 audio driver
  o makefile for ad1889
  o midibuf data loss fixes
  o fix cirrus driver for 7548
  o add hppa fbmem rule
  o update parisc st driver
  o ugly but signed wrap isnt defined
  o make alpha use generic iops
  o more idea headers
  o the generic iops
  o x86 uses generic ios
  o bring mode ide headers back into line
  o make ia64 macro in/out safer
  o parisc ide bits
  o bring parisc system_irqsave into sync
  o bring ppc irq bits into sync
  o ide update bits for sparc
  o default iops for x86-64
  o arcnet header update
  o update core IDE to reflect ulong port
  o interrupt.h might need system.h
  o tidy misc.h
  o reserve value used in 2.5
  o reserve ident for the sf16
  o pcmcia id/header updates
  o maintainer updates
  o ide setup-pci u32->ulong for dma base
  o AGP Gart setup

Alan Cox <alan@redhat.com>:
  o SIS5513 fixes

Alex Williamson <alex_williamson@hp.com>:
  o ia64: Fix potential MCA and silent data corruption in HP zx1 IOMMU driver.

Andreas Schwab <schwab@suse.de>:
  o ia64: Add missing symbol exports for modules
  o ia64: Remove many warnings

Andrew Morton <akpm@digeo.com>:
  o ext3 deadlock fix
  o ext3 use-after-free bugfix

Arjan van de Ven <arjanv@redhat.com>:
  o USB pwc deadlock fixes

Ben Collins <bcollins@debian.org>:
  o Linux1394 Firewire

Bjorn Helgaas <bjorn_helgaas@hp.com>:
  o ia64: Reserve syscall numbers 1238-1242 for AIO
  o ia64: If more than NR_CPUS found, ignore the extras
  o ia64: Move simeth, simserial, simscsi to arch/ia64/hp/sim
  o ia64: Rename ia64_alloc_irq to ia64_alloc_vector
  o ia64: Print EFI call status in hex, not decimal
  o ia64: Remove McKinley A-step config stuff
  o ia64: Sync with pcibios_enable_device interface change
  o Remove include/asm-ia64/offsets.h
  o ia64: Add PCI_DMA_BUS_IS_PHYS definition
  o ia64: support scatterlist page/offset in sba_iommu.c
  o ia64: Remove obsolete McKinley A0 workaround
  o ia64: Reserve hugetlb syscall numbers
  o ia64: Optimize load/save FPU (Fenghua Yu, Intel)
  o ia64: more scatterlist page/offset cleanup
  o ia64: Scan PCI buses 0-255 (not 0-254)
  o ia64: Skip blind PCI probe when root bridges are reported by ACPI
  o ia64: Detect HP ZX1 AGP bridge via ACPI instead of the old, unmaintainable "fake PCI device" scheme.
  o ia64: Restore "fake PCI device" support, for XFree86.  This is intended to go away in 2.5.x.
  o ia64: Rename __flush_tlb_all() to local_flush_tlb_all()
  o ia64: Make flush_tlb_mm() work for multi-threaded address-spaces on SMP machines
  o ia64: Fix ACPI_ACQUIRE_GLOBAL_LOCK and ACPI_RELEASE_GLOBAL_LOCK
  o ia64: Fix efi_memmap_walk() to work with more complicated memory maps
  o ia64: Make mremap() work properly when returning "negative" addresses
  o ia64: Workaround for old toolchain (__get_user() in perfmon)
  o ia64: Include vendor/function ID for "Unknown" IOCs
  o ia64: Fix typo in unaligned memory access handler (no functional change)
  o joydev: fix HZ->millisecond transformation
  o Remove bogus AGP/DRM assumptions

Charles White <charles.white@hp.com>:
  o cpqfc fixes

Christoph Hellwig <hch@sgi.com>:
  o CREDITS update
  o fix small style error in arch/i386/config.in

David Brownell <david-b@pacbell.net>:
  o remove CONFIG_USB_LONG_TIMEOUT
  o usbnet:  framing, sync with 2.5

David Mosberger <davidm@tiger.hpl.hp.com>:
  o ia64: Fix I/O macros in asm-ia64/io.h.  Based on patch by Andreas Schwab
  o ia64: Fix x86 struct ipc_kludge (reported by R Sreelatha, fix proposed by Dave Miller).
  o ia64: Fix return path of signal delivery for sigaltstack() case
  o ia64: Fix narrow window during which signal could be delivered with only the memory stack switched over to the alternate signal stack.
  o ia64: Fix edge-triggered IRQ handling.  See Linus's 2.5 cset 1.611 for details
  o ia64: Create dummy file include/asm-ia64/mc146818rtc.h since ide-geometry.c continues to insist on it.
  o ia64: Fix EFI runtime callbacks so they cannot corrupt fp regs
  o ia64: Make it easier to set a breakpoint in the Ski simulator right before starting the kernel (based on patch by Peter Chubb).

Greg Kroah-Hartman <greg@kroah.com>:
  o tipar: fix #include so the driver can compile
  o Dynamic MP_BUSSES and IRQ_SOURCES for 2.4.21-pre1
  o Fix minor code formatting issue on mpparse.c
  o USB: pwc driver: fix compile time warning
  o USB: uhci: fix formatting problem with last patch

J.I. Lee <jung-ik.lee@intel.com>:
  o ia64: PCI hotplug changes for 2.5.39 or later

James Bottomley <james.bottomley@steeleye.com>:
  o Backport of nbd update from 2.5.50

Jean Tourrilhes <jt@bougret.hpl.hp.com>:
  o IrTTP partial rewrite (credit fixes, races)
  o IrDA dongle locking context fix
  o LSAP socket close fixes
  o simultaneour IrNET connect race fix
  o SMC driver region fixes
  o return under spinlock fixes (Stanford checker)
  o Wireless Extension v15 : private command improvements

Jeff Garzik <jgarzik@redhat.com>:
  o [NET] support IPv6 over token ring (from lkml)
  o [netdrvr tg3] a fix, a cleanup, and an optimization

Jenna S. Hall <jenna.s.hall@intel.com>:
  o ia64: Minor MCA bugfixes

Jens Axboe <axboe@suse.de>:
  o cciss driver update
  o cpqarray driver update

John Stultz <johnstul@us.ibm.com>:
  o Fix gettimeofday for Summit based systems

Kenneth W. Chen <kenneth.w.chen@intel.com>:
  o ia64: Change memcpy to return dest address

Manfred Spraul <manfred@colorfullife.com>:
  o sys_poll SuS compliance fix

Marcelo Tosatti <marcelo@freak.distro.conectiva>:
  o Cset exclude: rusty@rustcorp.com.au|ChangeSet|20021217162617|02721
  o Cset exclude: Charles.White@hp.com|ChangeSet|20021217174320|03728
  o Cset exclude: bjorn_helgaas@hp.com|ChangeSet|20021217162948|02321
  o Changed EXTRAVERSION to -pre2

Matt Domsch <matt_domsch@dell.com>:
  o megaraid 1.18f

Matthew Wilcox <willy@debian.org>:
  o Add pci_bus_*() API for 2.4 [1/2]
  o Convert acpiphp to pci_bus_*() API [2/2]

Neil Brown <neilb@cse.unsw.edu.au>:
  o kNFSd - 1 of 7 - Release rpc response when dropping
  o knfsd - Revalidate inodes after filehandle and name lookup in nfsd
  o knfsd - Use correct value for max size for readlink response
  o knfsd - Fix problem with lockd grace period checking
  o knfsd - Ease increasing the max block size for NFS replies
  o knfs - Correct some error codes returned in nfsfh.c
  o MD - avoid races by never no releasing rdev->sb for faulty devices
  o Remove some inappropriate MD_BUG calls when hot_removing
  o Avoid buffer cache when doing IO of RAID superblock

Nemosoft Unv. <nemosoft@smcc.demon.nl>:
  o USB: PWC 8.10 for 2.4.20

Romain Lievin <rlievin@free.fr>:
  o Add tipar char driver

Rusty Russell <rusty@rustcorp.com.au>:
  o fs_reiserfs_fix_node.c, typo: resourses
  o arch_ppc_mm_tlb.c, typo: the the
  o typo: include_linux_pci_ids.h s_DEVIDE_DEVICE
  o 2.5: kconfig missing EXPERIMENTAL (14_14)
  o 2.5: kconfig spurious bool default value (3_3)
  o tiny kmem_cache_destroy doc tweak
  o Labeled elements are not a GNU extension
  o drivers_s390_block_dasd_3990_erp.c, typo: becaus(e),
  o arch_sh_kernel_irq_intc2.c, typo: the the
  o net_irda_irlmp_event.c, typos: the the, whish
  o drivers_block_ll_rw_blk.c, typo: the the
  o include_asm-ppc_semaphore.h, typo: the the
  o remove emacs settings
  o Wrong module name in help file. (fwd)
  o drivers_s390_block_dasd.c, typo: the the, capitalization
  o 2.5: kconfig choice default value
  o arch_ia64_sn_io_sn2_pcibr_pcibr_config.c, typo: the the
  o [Trivial Patch] scsi_register-006
  o [Trivial Patch] Fix misc_register()
  o Fix confusing comment
  o [patch 2.5] at1700 trivial
  o Check for misc_register() return code in wdt285
  o duplicate header in drivers_ieee1394_sbp2.c
  o drivers_net_bonding.c, typo: the the
  o backward ext3 endianness conversion
  o duplicate header in drivers_pcmcia_sa1100_generic.c
  o drivers_net_tulip_interrupt.c, typo: the the
  o arch_i386_kernel_smpboot.c, typo: wierd
  o Typo in linux_arch_i386_mm_init.c
  o Fix path in
  o drivers_isdn_isdn_ppp.c, typo: the the
  o Documentation_networking_bonding.txt, typo: the the
  o Documentation_cciss.txt, typo: the the
  o Documentation_watchdog-api.txt, typo: the the
  o drivers_sound_dmasound_dmasound_core.c, typo: wierd
  o drivers_md_lvm.c, typo: the the
  o update comments in ip_tables.c
  o include_asm-alpha_mmzone.h, typo: the the
  o silence invalidate_bdev() a bit
  o Remove duplicated entry in agpgart_be initialization table
  o include_asm-ia64_sn_alenlist.h, typo: the the
  o Fix request_region handling in epca
  o Domsch zip code change
  o sis900 doesn't free resources
  o Fix misc_register() error handling in nvram.c driver
  o 2.4.19 Documentation_Configure.help CONFIG_FB_TRIDENT
  o Remove reference to timer_exit() from kernel-locking.tmpl,
  o misc_register audit fixes on i2o_config

Stéphane Eranian <eranian@hpl.hp.com>:
  o ia64: Fix perfmon error path missing unlock
  o ia64: Fix perfmon error path leaks

Takayoshi Kouchi <t-kouchi@mvf.biglobe.ne.jp>:
  o ia64: Fix iosapic debug code
  o ia64: ACPI CRS cleanup

Tom Rini <trini@kernel.crashing.org>:
  o Correct the behavior of the int verb in scripts/Configure

Trond Myklebust <trond.myklebust@fys.uio.no>:
  o Fix possible SMP race in nfs_sync_page()
  o Fix accounting error in /proc/net/rpc/nfs
  o Disable Nagle algorithm for NFS over TCP


Summary of changes from v2.4.20 to v2.4.21-pre1
============================================

<baldrick@wanadoo.fr>:
  o usbdevfs: finalize urbs on interface release
  o usbdevfs: finalize urbs on interface release
  o usbdevfs: more list cleanups

<chris@qwirx.com>:
  o [SPARC]: Add missing iounmap to display7seg driver

<dana.lacoste@peregrine.com>:
  o RATOC USB-60 patch

<eranian@frankl.hpl.hp.com>:
  o efirtc update

<erik@aarg.net>:
  o USB: added support for Palm Tungsten T devices to visor driver

<ganesh@tuxtop.vxindia.veritas.com>:
  o USB ipaq: brown paper bag bug - uninitialized spinlock fixed
  o USB ipaq: added support for insmod options to specify vendor/product id

<gronkin@nerdvana.com>:
  o [netdrvr tulip] new pci id

<henning@meier-geinitz.de>:
  o [PATCH 2.4.20-rc1] scanner.h: add/fix vendor/product ids

<m.c.p@wolk-project.de>:
  o ide-scsi update to new IDE
  o Remove IDE init calls from blk_dev_init (IDE merge)
  o Add missing system.h bits (IDE merge)

<marcel@holtmann.org[holtmann]>:
  o [Bluetooth] Add RFCOMM protocol support
  o [Bluetooth] UART driver update
  o [Bluetooth] Add HCI UART PC Card driver
  o [Bluetooth] Add BCSP TXCRC option

<nicolas.mailhot@laposte.net>:
  o AGP support for VIA KT400

<oliver@oenone.homelinux.org>:
  o use of unplugged scanner oops fix

<petkan@tequila.dce.bg>:
  o USB: pegasus: the kmalloc/kfree crap removed from [get|set]_registers();

<plcl@telefonica.net>:
  o usb-midi patch for 2.4.20-pre11

<srompf@isg.de>:
  o [netdrvr starfire] add netif_carrier_{on,off} calls

<stelian@popies.net>:
  o sonypi driver update
  o meye driver update
  o export pci symbols for pcmcia modules

<tvrtko@net4u.hr>:
  o usb-uhci, fixed memory leak with one-shot interrupt transfers

<will@sowerbutts.com>:
  o USB: add USB powermate driver

<wstinson@wanadoo.fr>:
  o [netdrvr de620] remove unneeded, and ifdef'd out, check_region call

Adam Kropelin <akropel1@rochester.rr.com>:
  o [netdrvr ewrk3] fix and enable ethtool phys-id ioctl
  o [netdrvr ewrk3] allow user to change MAC address via SIOCSIFHWADDR

Adrian Bunk <bunk@fs.tum.de>:
  o CONFIG_AGP_AMD_8151 Configure.help entry
  o Fix pcmcia_net link error

Alan Cox <alan@lxorguk.ukuu.org.uk>:
  o ppc stuff for new ide layer
  o update mousedriver docs as in 2.5
  o bring loop device up to date
  o parisc mux console config
  o add scx200 drivers
  o work around ALi magick chipset hangs with video capture
  o fix cyclades resource handling
  o vendor update for mpt fusion
  o pcmcia networking updates
  o lanstreamer updates
  o pcmcia parport update
  o new pci ids
  o reserve some I/O ports on the ATI radeon IGP
  o new pci idents
  o pcmcia core updates from David Hinds
  o backport 2.5 advansys off by one fix
  o ac IDE merge
  o t128 compile fix if non modular
  o core code for new nsp32 driver
  o fix ac97 string formatting errors
  o fix mad16 bugs
  o some laptops need longer delay
  o make cdcether work
  o latest i810 audio update
  o BeOS fs updates
  o fix off by one in module loader rename of module
  o work around 8253 timer funnies
  o ensure memcpy_to/from_io don't prefetch
  o Sort out the tachyon driver

Andrew Morton <akpm@digeo.com>:
  o Fix for the ext3 data=journal unmount problem

Arnaldo Carvalho de Melo <acme@conectiva.com.br>:
  o Add support for JTEC FA8101 USB to Ethernet device

Charles White <charles.white@hp.com>:
  o Add support for the SA641, SA642 and SA6400 controllers

Christoph Hellwig <hch@lst.de>:
  o small sd error handling fix
  o update scsi largelun blacklist
  o make flock Posix 2001 compatible

Christoph Hellwig <hch@sgi.com>:
  o cleanup b_inode usage and fix onstack inode abuse
  o backport 2.5 inode allocation changes
  o fix memory leak in sd.c

Dave Jones <davej@suse.de>:
  o Intel cache handling fixes

Dave Kleikamp <shaggy@shaggy.austin.ibm.com>:
  o Add more statistics to /proc/fs/jfs/ to help with performance tuning
  o JFS: Avoid writing partial log pages for lazy transactions
  o JFS: forced metadata pages were not being flushed to disk
  o jfs_clear_inode should skip bad inodes instead of choking on them
  o JFS: Move index table out of directory inode's address space
  o JFS: Fix off-by one error when symlink size == 256 bytes
  o JFS: flush pending commit records to journal during unmount
  o jfs_truncate needs to call block_truncate_page

David Brownell <david-b@pacbell.net>:
  o usbnet talks to Zaurus

David Brownell <dbrownell@users.sourceforge.net>:
  o USB:  USB 2.0 controller and hubs bugfixes

David S. Miller <davem@nuts.ninka.net>:
  o [SPARC]: Ignore SIGURG if not caught
  o [SPARC]: NR_IRQS is off by one
  o [SPARC64]: Fix dnotify_parent call in do_readv_writev32
  o [SPARC64]: Add some missing semicolons newer gcc warns about
  o [SPARC64]: Add -finline-limit=100000 to CFLAGS if gcc supports it
  o [SPARC64]: Clobber register l1 in switch_to if gcc >= 3.0
  o [SPARC]: Synchronize MAINTAINERS entry with 2.5.x
  o [SPARC]: Fix dependency on previous NR_IRQS value
  o [SPARC64]: Export __flush_dcache_range
  o [SPARC64]: Update defconfig
  o [SPARC]: Implement local_irq_set
  o [SPARC64]: Fix read_pil_and_sti

Edward Peng <edward_peng@dlink.com.tw>:
  o dl2k net driver update from vendor
  o [netdrvr dl2k] only read 0x100 through 0x150 statistics registers if mem mapping

Eric Brower <ebrower@usa.net>:
  o [SPARC]: Make APC idle a boot time cmdline option

Greg Kroah-Hartman <greg@kroah.com>:
  o Cset exclude: acme@conectiva.com.br|ChangeSet|20021011180213|25533
  o USB: added support for Clie NX60 device
  o removed vicamurbs.h
  o USB: added Palm Tungsten W support

Ivan Kokshaysky <ink@jurassic.park.msu.ru>:
  o alpha: alcor and sable fixes
  o alpha misc fixes
  o alpha initrd fix
  o asm-alpha/regdef.h
  o alpha __stxncpy fixes
  o Fixup Alpha IDE PCI

Jeff Garzik <jgarzik@redhat.com>:
  o Add 00-INDEX file describing contents of Documentation/BK-usage directory
  o Small clarification in BK kernel howto
  o In several drivers, use pci_[gs]et_drvdata instead of directly referencing struct pci_dev::driver_data.
  o [net drivers] update hamachi and starfire to use MII lib
  o Update my email address
  o Remove performance barrier in i810_rng char driver
  o [netdrvr bmac] remove init_timer call that was erroneously removed
  o [netdrvr fealnx] remove bogus line due to patch error
  o [netdrvr] add "r8169", a new Realtek 8169 gigabit ethernet driver
  o [netdrvr r8169] large style cleanup
  o [netdrvr r8169] minor functional cleanups and bug fixes
  o Handle internal proc_register failure in proc_symlink, proc_mknod, proc_mkdir, and create_proc_entry.
  o [netdrvr] Make a special section in drivers/net/Makefile for
  o [netdrvr sunhme] remove memset in init, alloc_etherdev does it for us
  o [netdrvr] fix Stanford checker buffer overflows in ni52, 3c523 (rarely if ever would be hit)
  o [netdrvr 3c515] fix unlikely buffer overrun when >8 adapters present
  o [netdrvr] zap PCI_VPD_ADDR constants from skfp, sk98lin drivers
  o [netdrvr r8169] use pci_[gs]et_drvdata instead of pdev->driver_data
  o Clarify locking/context docs for network interfaces, in Documentation/networking/netdevices.txt.

Joe Burks <joe@wavicle.org>:
  o Vicam patch against 2.4.20-pre9

John Stultz <johnstul@us.ibm.com>:
  o Summit chipset support: Clustered apic tweaks
  o Summit chipset support: Logical/Physical apicid additions
  o Summit chipset support: CLUSTERED_APIC_XAPIC switches
  o Summit chipset support: CONFIG_X86_SUMMIT, auto-detection, cleanup

Juan Quintela <quintela@mandrakesoft.com>:
  o Fix journalling api documentation

Kent Yoder <key@austin.ibm.com>:
  o [netdrvr lanstreamer] a fix and a feature addition

Maksim Krasnyanskiy <maxk@qualcomm.com>:
  o RFCOMM TTY fixes
  o BNEP fixes
  o HCI UART fixes
  o Fix typo in hci_usb_open() (MAX_BULK_TX -> MAX_BULK_RX)
  o Fix L2CAP client/server PSM clash
  o Fix hci_dev_get_list() for big endian machines
  o Ordinary users are not allowed to use raw L2CAP sockets
  o BNEP extension headers handling fix

Manfred Spraul <manfred@colorfullife.com>:
  o [netdrvr 8139too] skb_copy_and_csum_dev use allows us to enable the NETIF_F_HIGHDMA feature.

Marcel Holtmann <marcel@holtmann.org>:
  o [Bluetooth] Module description cleanup for BNEP
  o [Bluetooth] Config cleanup for BNEP
  o [Bluetooth] Add HCI id for Bluetooth PCI cards
  o [Bluetooth] Support for suspend/resume interface for HCI devices
  o [Bluetooth] Fix typo in role change event size
  o [Bluetooth] Cosmetic changes to the config files
  o [Bluetooth] Initialize hardware broadcast
  o [Bluetooth] Check for signals while waiting for DLC
  o [Bluetooth] Fix operator precedence for modem status
  o [Bluetooth] Don't do wakeup if protocol is not set
  o [Bluetooth] Fix some bits of the modem status handling
  o [Bluetooth] Free skbs with kfree_skb() instead of kfree()
  o [Bluetooth] Fix another operator precedence for modem status
  o [Bluetooth] Update help entry for CONFIG_BLUEZ
  o [Bluetooth] The function l2cap_do_connect() should be static
  o [Bluetooth] Don't use %d notation for non devfs name field of tty_driver
  o Disable bluetooth.o if Bluetooth subsystem is used

Marcelo Tosatti <marcelo@freak.distro.conectiva>:
  o megaraid driver update
  o Update gdth driver
  o Cset exclude: akpm@digeo.com|ChangeSet|20021202135530|52474
  o Backout wrong change of gdth update
  o Cset exclude: khalid_aziz@hp.com|ChangeSet|20021129142249|58780
  o Add missing x86 system.h bits from IDE -ac merge
  o Changed EXTRAVERSION to -pre1
  o Cset exclude: raul@pleyades.net|ChangeSet|20021210155107|09736
  o Cset exclude: hch@lst.de|ChangeSet|20021210165533|06540

Matt Domsch <matt_domsch@dell.com>:
  o aacraid Dell PERC 320/DC support

Matthew Wilcox <willy@debian.org>:
  o update lasi_82596 net driver to use spinlock instead of cli/sti
  o Add PCI-X register definitions

Olaf Hering <olh@suse.de>:
  o minor fixes for compile warnings in 2.4.20pre11 , usb-2.4 tree

Pete Zaitcev <zaitcev@redhat.com>:
  o [SPARC]: Clobber l3 in context switch
  o [SPARC]: kill NR_IRQS + 1 stuff

Randy Dunlap <randy.dunlap@verizon.net>:
  o USB: use time_before() to compare times
  o tiglusb timeouts

Randy Dunlap <rddunlap@osdl.org>:
  o USB requires MIDI

Richard Henderson <rth@dorothy.sfbay.redhat.com>:
  o [ALPHA] Add local_irq_set
  o [ALPHA] Fix asm clobber problem diagnosed by current gcc 3.3 snap
  o CREDITS

Rob Radez <rob@osinvestor.com>:
  o [SPARC]: Fix loop terminator in iommu_get_scsi_sgl_pflush

Roger Luethi <rl@hellgate.ch>:
  o [netdrvr ns83820] fix oops in ioctl, and initialize dev->priv to prevent such slipups again
  o [netdrvr via-rhine] version bump, C99 initializers
  o [netdrvr via-rhine] fix up strange C99 notation in previous patch

Rolf Eike Beer <eike@bilbo.math.uni-mannheim.de>:
  o Kill unneeded declaration from drivers/scsi/sim710.h

Romain Lievin <rlievin@free.fr>:
  o USB: tiglusb sync with 2.5

Scott Feldman <scott.feldman@intel.com>:
  o e100 net driver: remove driver-isolated flag/lock

Takayoshi Kouchi <t-kouchi@mvf.biglobe.ne.jp>:
  o ACPI PCI hotplug updates

Tim Waugh <twaugh@redhat.com>:
  o 2.4.20: fix aladdin card hang

