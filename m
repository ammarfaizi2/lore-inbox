Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263357AbTK1S3r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 13:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263388AbTK1S3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 13:29:46 -0500
Received: from hera.kernel.org ([63.209.29.2]:57011 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S263357AbTK1S2B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 13:28:01 -0500
Date: Fri, 28 Nov 2003 10:27:48 -0800
From: Marcelo Tosatti <marcelo@hera.kernel.org>
Message-Id: <200311281827.hASIRmPe022656@hera.kernel.org>
To: linux-kernel@vger.kernel.org
Subject: linux-2.4.23 released
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

final:

- 2.4.23-rc5 was released as 2.4.23 with no changes.

Summary of changes from v2.4.23-rc4 to v2.4.23-rc5
============================================

Andi Kleen:
  o Fix 32bit truncate64 on x86-64

Marcelo Tosatti:
  o Felix Radensky: Remove debugging printk from agpgart
  o Changed EXTRAVERSION to -rc5


Summary of changes from v2.4.23-rc3 to v2.4.23-rc4
============================================

<arekm:pld-linux.org>:
  o Fix modular IDE

<lethal:unusual.internal.linux-sh.org>:
  o sh64: Fixup zImage build for recent ITLB/DTLB changes
  o sh64: Update defconfig
  o sh: SH7751 documentation updates
  o sh/sh64: Clear IRQ_INPROGRESS in setup_irq()
  o sh: Add SH-DSP support

Richard Curnow:
  o sh64: Update MAINTAINERS

Willy Tarreau:
  o fix 2 broken links in bonding documentation


Summary of changes from v2.4.23-rc2 to v2.4.23-rc3
============================================

<amir.noam:intel.com>:
  o [bonding] fix creation of /proc/net/bonding dir

<debian:abeckmann.de>:
  o [SPARC]: Make check_asm.sh not get confused by .section .note.GNU-stack output by newer gcc

<len.brown:intel.com>:
  o [ACPI] "pci=noacpi" -- replace two sets of flags with one: acpi_noirq
  o [ACPI] "pci=noacpi" -- 2.4.23 specific part of previous 2.4.22 fix

<marcelo:logos.cnet>:
  o Changed EXTRAVERSION to -rc3

David Engebretsen:
  o Put autoconsole option at the front of the cmd line
  o Fix comment to reflect correct file name
  o fix byte order in comparison

Ed Vance:
  o Fix ST16C654 UART support broke by ELAN patches

Herbert Xu:
  o [netdrvr tg3] fix BCM5705 pending-RX count (was 64, now 63)

Matthew Wilcox:
  o Fix panic-at-boot

Paul Mackerras:
  o PPC64: Update the _syscallN macros to indicate the correct clobbers
  o PPC64: Ensure we get the correct error_code passed to do_page_fault
  o PPC64: Fix alignment in vmlinux.lds
  o PPC64: Make kernel RAM user-inaccessible on iSeries
  o PPC64: Fix compilation of sys_ppc32.c


Summary of changes from v2.4.23-rc1 to v2.4.23-rc2
============================================

<atul.mukker:lsil.com>:
  o [scsi megaraid2] fix DMA sync to use correct S/G list pointer

<davej:redhat.com>:
  o Correct cmpci fix

<khali:linux-fr.org>:
  o Update I2C maintainers entry

<len.brown:intel.com>:
  o [ACPI] fix CONFIG_HOTPLUG_PCI_ACPI config (Xose Vazquez Perez)
  o [ACPI] If ACPI is disabled by DMI BIOS date, then turn it off completely, including table parsing for HT.
  o [ACPI] In ACPI mode, delay print_IO_APIC() to make its output valid
  o [ACPI] fix poweroff failure ala 2.6 (Ducrot Bruno) http://bugzilla.kernel.org/show_bug.cgi?id=1456
  o [ACPI] fix ACPI/legacy interrupt sharing issue ala 2.6 http://bugzilla.kernel.org/show_bug.cgi?id=1283
  o [ACPI] print_IO_APIC() only after it is actually programmed http://bugzilla.kernel.org/show_bug.cgi?id=1177
  o [ACPI] "acpi_pic_sci=edge" in case platform requires Edge Triggered SCI http://bugzilla.kernel.org/show_bug.cgi?id=1390
  o [ACPI ] pci=acpi ineffective fix from i386 2.6 (Thomas Schlichter) http://bugzilla.kernel.org/show_bug.cgi?id=1219
  o [ACPI] Re-enable IRQ balacning if IOAPIC mode http://bugzilla.kernel.org/show_bug.cgi?id=1440
  o [ACPI] fix x86_64 build errors
  o [ACPI] Maintainer: Andy Grover -> Len Brown
  o [ACPI] fix x86_64 !CONFIG_ACPI build
  o 2.4.23 build x86_64 build fixes
  o i386 build fix from previous cset
  o x86_64 build fix from previous cset
  o [ACPI] sync some i386 ACPI build fixes into x86_64 to fix !CONFIG_ACPI build
  o "pci=noacpi" use pci_disable_acpi() instead of touching use_acpi_pci directly

<livio:ime.usp.br>:
  o Backport inode_hash race fix

<marcelo:logos.cnet>:
  o Exclude broken netfilter hunk: laforge@netfilter.org|ChangeSet|20030904111137|30468
  o Cset exclude: xose@wanadoo.es|ChangeSet|20031115132946|56340
  o Changed EXTRAVERSION to -rc2
  o Cset exclude: davej@redhat.com|ChangeSet|20031114154840|57070

<pmeda:akamai.com>:
  o [netdrvr tulip] fix hashed setup frame code

<xose:wanadoo.es>:
  o pci-irq.c bad PCI ident of 440GX host bridge

Adrian Bunk:
  o fixup after synclink update

Andi Kleen:
  o Readd IORR changes to Nvidia k7 driver
  o Remaining x86-64 updates
  o Add memory clobber to ip_fast_csum

Harald Welte:
  o Netfilter: Sane ip_ct_tcp_timeout_close_wait value

Herbert Xu:
  o [netdrvr tg3] fix tqueue initialization



Summary of changes from v2.4.23-pre9 to v2.4.23-rc1
============================================

<marcelo:logos.cnet>:
  o MAINTAINERS update for HP
  o Backport 2.6 Linus fix for minix corruption problem noted by Konstantin Boldyshev
  o Changed EXTRAVERSION to -rc1

<philipc:snapgear.com>:
  o [netdrvr 8139cp] Fix NAPI race

<pp:ee.oulu.fi>:
  o [netdrvr b44] Fix irq enable/disable; fix oops due to lack of SET_NETDEV_DEV() call

<xose:wanadoo.es>:
  o 2.4.23-pre9 fix for kbuild - hotplug_acpi

Adrian Bunk:
  o fix SOUND_CMPCI Configure.help entry

Andi Kleen:
  o x86-64 update
  o K8 AGP driver updates
  o Make new driver i386 only
  o Fix Documentation.help for K8 AGP driver
  o Add missing nforce3s pci-id
  o Fix TSS limit on x86-64

Andrew Morton:
  o Restore /proc/pid/maps formatting

Dave Kleikamp:
  o JFS: Fix race between link() and unlink()
  o JFS: i_nlink should be checked while holding commit_sem

David S. Miller:
  o [TG3]: Fix bugs in ETHTOOL_SSET introduced by ethtool_ops conversion
  o [TG3]: Bump driver version and release date

David Woodhouse:
  o ilookup() for 2.4
  o JFFS2 garbage collect race fix

Douglas Gilbert:
  o Do not accept negative size's in SG_SET_RESERVED_SIZE

Eric Brower:
  o [SPARC]: Fix _IOC_SIZE() macro when direction is _IOC_NONE

Herbert Xu:
  o Fix BUS_ISA name conflict

Jan Kara:
  o Fix quota accounting bug

John Stultz:
  o Fix x440+ACPI problem
  o Fix cyclone timer (x44x)

Marcel Holtmann:
  o Make firmware loading work builtin

Ralf Bächle:
  o [netdrvr pcnet32] add missing pci_dma_sync_single

Scott Feldman:
  o [e100] sync with 2.6 updates
  o [e1000] sync with 2.6 updates

Stelian Pop:
  o meye driver update



Summary of changes from v2.4.23-pre8 to v2.4.23-pre9
============================================

<achirica:telefonica.net>:
  o Fix compatibily issue with some APs
  o Fix wireless stats locking

<car.busse:gmx.de>:
  o USB: one more digicam for unusual_devs.h

<chrisw:osdl.org>:
  o sysctl core_setuid_ok fix

<dan:reactivated.net>:
  o USB brlvger: Debug code fixes

<dax:gurulabs.com>:
  o USB: Add Handspring Treo 600 ids

<henry.ne:arcor.de>:
  o USB: Update SL811, HC_SL811 driver

<janitor:sternwelten.at>:
  o [NETFILTER]: Add IPCHAINS to MAINTAINERS entry

<kml:patheticgeek.net>:
  o [TCP]: When SYN is set, the window is not scaled

<laurent.ml:linuxfr.org>:
  o [IRDA]: Fix build fallout from gcc-3.3 changes

<len.brown:intel.com>:
  o [ACPI] fix x86_64 build (Jeff Garzik)
  o [ACPI] fix x86_64 build (Jeff Garzik)
  o [ACPI] REVERT acpi_ec_gpe_query(ec) T40 fix that crashed other boxes http://bugme.osdl.org/show_bug.cgi?id=1171
  o [ACPI] REVERT ACPICA-20030918 CONFIG_ACPI_DEBUG printk that caused crash http://bugzilla.kernel.org/show_bug.cgi?id=1341
  o [ACPI] fix x86_64 ACPI build in 2.4.22 by backporting from 2.4.23
  o vsprintf needs PAGE_SIZE from page.h in 2.4

<luca:libero.it>:
  o USB: add W996[87]CF driver

<marcelo:logos.cnet>:
  o Fix Makefile -pre8 typo
  o Cset exclude: 9a4gl@9a0tcp.ampr.org|ChangeSet|20031021055256|28265
  o Changed EXTRAVERSION to -pre9

<tsk:ibakou.com>:
  o [netdrvr 8139too] add pci id

<zzz:anda.ru>:
  o Fix aic7xxx compilation without PCI support

Adrian Bunk:
  o USB: add USB gadget Configure help entries

Alan Stern:
  o USB: fix for earlier unusual_devs.h patch

Andrew Morton:
  o make printk more robust with "null" pointers
  o sis900 skb free fix
  o [netdrvr 3c527] add MODULE_LICENSE tag

Arjan van de Ven:
  o r8169 module license tag
  o fix starfire 64-bit b0rkage

Bart De Schuymer:
  o [NETFILTER]: Fix potential OOPS in ipt_REDIRECT

Ben Collins:
  o IEEE1394 fixes

Dave Kleikamp:
  o JFS: Make sure journal records get flushed to disk
  o JFS: Improved error handing
  o JFS: remove racy, redundant call to block_flushpage

David Brownell:
  o USB: usb ethernet gadget
  o USB: ehci-hcd, misc bugfixes
  o USB: usb "gadget zero" tweaks
  o USB: <linux/usb_ch9.h> updates
  o USB: usb gadget Config.in updates

David S. Miller:
  o [TG3]: Disable/enable timer in suspend/resume
  o Cset exclude: kuznet@ms2.inr.ac.ru|ChangeSet|20031021053209|59468

Greg Kroah-Hartman:
  o USB: fix compiler error in sl811.c
  o USB: fix build bug with usbnet and older versions of gcc

Henning Meier-Geinitz:
  o USB: scanner driver: new device ids (1/3)
  o USB: scanner driver: added USB_CLASS_CDC_DATA (2/3)
  o USB: scanner driver: use static declarations (3/3)

Hideaki Yoshifuji:
  o [IPV6]: Fix bogus semicolon typo in mcast.c

Ian Abbott:
  o USB: ftdi_sio - Perle UltraPort new ids - 1 of 2
  o USB: ftdi_sio - Perle UltraPort new ids - 2 of 2
  o USB: ftdi_sio - version bump 1.3.5

Jay Vosburgh:
  o [bonding] Restore compatibilty with old ifenslave

Jun Komuro:
  o [pcmcia fmvj18x_cs] share interrupts properly for TDK multifunction cards

Linus Torvalds:
  o Kamble, Nitin A: Add a quirk for the Intel ICH-[45] to add special ACPI regions

Maksim Krasnyanskiy:
  o [Bluetooth] Add support for FCon and FCoff flow control commands
  o [Bluetooth] Credit based flow control (CFC) must be disabled by default for compatibility with 1.0b devices. Made CFC a session attribute, introduced CFC states and cleaned up CFC logic.

Marcel Holtmann:
  o [Bluetooth] Always use two ISOC URB's
  o [Bluetooth] Remove USB zero packet option
  o [Bluetooth] Add support for the Digianswer USB devices
  o [Bluetooth] Add support for an old ALPS module

Neil Brown:
  o Fix deadlock problem in lockd

Paul Mackerras:
  o Add load_addr arg to ELF_PLAT_INIT

Rik van Riel:
  o saa7110 typo fix
  o silence warning in reiserfs_ioctl
  o [netdrvr starfire] include asm/io.h

Stelian Pop:
  o sonypi driver update
  o compile mii when using usbnet



Summary of changes from v2.4.23-pre7 to v2.4.23-pre8
============================================

<daniel:deadlock.et.tudelft.nl>:
  o atyfb ibook fix

<gorgo:thunderchild.debian.net>:
  o [NET]: Fix get_random_bytes() call in sunhme.c:get_hme_mac_nonsparc()

<ja:ssi.bg>:
  o [IPV4]: ip_fragment must copy the nfcache field

<len.brown:intel.com>:
  o [ACPI] Summary of changes for ACPICA version 20031002
  o [ACPI] fix acpi_asus module build (Stephen Hemminger)
  o [ACPI] delete descriptions for stale ACPI build options
  o [ACPI] speed up reads from /proc/acpi/ (Shaohua David Li) http://bugme.osdl.org/show_bug.cgi?id=726
  o [ACPI] fix object reference count bug for battery status (Shaohua David Li) http://bugme.osdl.org/show_bug.cgi?id=1038
  o [ACPI] acpi_ec_gpe_query(ec) fix for T40 crash (Shaohua David Li) http://bugme.osdl.org/show_bug.cgi?id=1171
  o [ACPI] correct parameter to acpi_ev_gpe_dispatch() (Shaohua David Li)
  o [ACPI] correct parameter to acpi_ev_gpe_dispatch() take II (Bob Moore)
  o [ACPI] fix !CONFIG_PCI build use X86 ACPI specific version of eisa_set_level_irq() http://bugzilla.kernel.org/show_bug.cgi?id=1390
  o [ACPI] fix use_acpi_pci !CONFIG_PCI build error per 2.6 http://bugzilla.kernel.org/show_bug.cgi?id=1392
  o [ACPI] Broken fan detection prevents booting (Shaohua David Li) http://bugme.osdl.org/show_bug.cgi?id=1185

<lethal:unusual.internal.linux-sh.org>:
  o sh: signal trampoline workaround for SH-4 core bug
  o sh: irq_intc2 updates
  o sh: Add BPS_230400 definition to sh-sci
  o sh64: Add pcibios_scan_all_fns() definition

<marcelo:logos.cnet>:
  o Al Viro: Clear all flags in exec_usermodehelper
  o x86: Clear IRQ_INPROGRESS in setup_irq()
  o MIPS/MIPS64: Clear IRQ_INPROGRESS in setup_irq()
  o Remove parcelfarce email from CREDITS
  o Shantanu Goel: Fix merge mistake in refill_inactive()
  o Changed EXTRAVERSION to -pre8
  o ide-disk.c: Limit disk size to 137GB if LBA48 is not available
  o Jan Niehusmann: Make LBA48 work in pdc202xx_old.c

<mroos:linux.ee>:
  o [SPARC]: Use NR_CPUS for linux_cpus[]

<pp:ee.oulu.fi>:
  o b44 enable interrupts after tx timeout (2.4.23-pre6)

<sheilds:msrl.com>:
  o [SPARC64]: Fix typo in bbc_envctrl.c

<wensong:linux-vs.org>:
  o [IPVS] Fix to set the statistics of dest zero when bound to a new service
  o [IPVS]: Fix ip_vs_ftp to use cp->vaddr because iph->daddr is already mangled

<xose:wanadoo.es>:
  o change sym53c8xx.o to sym53c8xx_2.o in Configure.help

Alexander Viro:
  o Alpha: clear IRQ_INPROGRESS in setup_irq()
  o fix for do_tty_hangup() access of kfreed memory

Bartlomiej Zolnierkiewicz:
  o fix ServerWorks PIO auto-tuning

Chas Williams:
  o [ATM]: rewrite recvmsg to use skb_copy_datagram_iovec
  o [ATM]: remove listenq and backlog_quota from struct atm_vcc
  o [ATM]: cleanup connect
  o [ATM]: eliminate SOCKOPS_WRAPPED
  o [ATM]: move vcc's to global sk-based linked list
  o [ATM]: setsockopt/getsockopt cleanup

David S. Miller:
  o [SPARC64]: Always use sethi+jmpl to reach VISenter{,half}
  o [SPARC64]: Implement force_successful_syscall_return()
  o [NET]: linux/in.h needs linux/socket.h
  o [VLAN]: kfree(skb) --> kfree_skb(skb)
  o [SPARC64]: Update defconfig
  o [SPARC]: Audit inline asm

Eric Brower:
  o [SPARC64]: Fix kernel_thread() return value check in envctrl.c

Hugh Dickins:
  o tmpfs 1/5 LTP ENAMETOOLONG
  o tmpfs 2/5 LTP S_ISGID dir
  o tmpfs 3/5 swapoff/truncate race
  o tmpfs 4/5 getpage/truncate race
  o tmpfs 5/5 writepage/truncate race

Jeff Garzik:
  o [netdrvr xircom_cb] backport 2.6 changes
  o [netdrvr 8139too] add pci id
  o [netdrvr 8139too] another new PCI ID
  o [netdrvr tulip] add pci id

Manfred Spraul:
  o [netdrvr natsemi] fix ring clean

Martin Josefsson:
  o [NETFILTER]: Remove unused destroy callback in ip6t_ipv6header.c, from Maciej Soltysiak

Matt Domsch:
  o Fix megaraid2 compilation problems

Michael Shields:
  o [SPARC64]: Fix watchdog on CP1500/Netra-t1

Mikael Pettersson:
  o APICBASE fix backport from 2.6

Mirko Lindner:
  o sk98lin-2.4: Driver update to version 6.18

Neil Brown:
  o Remove un-necessary locking in lockd

Olaf Hering:
  o [IRDA]: Fix build with gcc-3.4
  o Fix NinjaSCSI compilation

Patrick McHardy:
  o [NETFILTER]: Add size check to ip_nat_mangle_udp_packet

Scott Feldman:
  o ethtool_ops eeprom stuff
  o hang on ZEROCOPY/TSO when hitting no-Tx-resources

Trond Myklebust:
  o Fix a deadlock in the NFS asynchronous write code
  o A request cannot be used as part of the RTO estimation if it gets resent since you don't know whether the server is replying to the first or the second transmission. However we're currently setting the cutoff point to be the timeout of the first transmission.
  o UDP round trip timer fix. Modify Karn's algorithm so that we inherit timeouts from previous requests.
  o Increase the minimum RTO timer value to 1/10 second. This is more in line with what is done for TCP.
  o Fix a stack overflow problem that was noticed by Jeff Garzik by removing some unused readdirplus cruft.
  o Make the client act correctly if the RPC server's asserts that it does not support a given program, version or procedure call.


Summary of changes from v2.4.23-pre6 to v2.4.23-pre7
============================================

<amn3s1a:ono.com>:
  o USB: New unusual_devs.h entry (Minolta DiMAGE E223 Digital Camera)

<baldrick:free.fr>:
  o USB speedtouch: neater sanity check
  o USB: New email address
  o USB speedtouch: bump the version number
  o USB speedtouch: biscuit for Greg
  o USB speedtouch: reduce memory usage
  o USB speedtouch: extra debug messages

<bjorn.helgaas:hp.com>:
  o ia64: Add arch/ia64/drivers subdir, so ski drivers can be under arch/ia64 while still getting their module_inits called late (i.e., simscsi module_init needs to happen after init_scsi).
  o Fix pci_generic_prep_mwi export breakage
  o Backport force_successful_syscall()

<erik:harddisk-recovery.nl>:
  o Change sym53c8xx_2 driver module name

<hunold:linuxtv.org>:
  o Remove bogus Philips SAA7146/DVD decoder info from ioctl-number.txt

<ja:ssi.bg>:
  o [IPV4/IPV6]: Do not modify skb->h.raw until skb is unshared

<jack:ucw.cz>:
  o Fix quota counter overflow

<jan.oravec:6com.sk>:
  o [IPV6]: Deactivate timers properly in ipv6_mc_destroy_dev()

<lucy:innosys.com>:
  o USB: Keyspan USB adapter patches

<marcelo:dmt.cyclades>:
  o Fix missing part of Centrino cache detection change
  o Add TASK_SIZE check to do_brk()

<marcelo:logos.cnet>:
  o Add missing #endif to force_successful_syscall_return change
  o Fix dscc4 net/wan Config.in breakage
  o Fix ACPI config.in breakage
  o Cset exclude: ak@muc.de|ChangeSet|20031005214700|30577
  o Add Megaraid 2 driver
  o Cset exclude: 20030702202648|35018: i82092 update broke existing working setups
  o Fix typo in laptop mode patch
  o Change my mail address in a few places
  o Remove racy optimization from exec_mmap()
  o From -aa tree: Fix potential PPPoE oops
  o Fixup exec_mmap() race fix mess
  o Changed EXTRAVERSION to -pre7
  o Cset exclude: bjorn.helgaas@hp.com|ChangeSet|20031007181555|25551
  o nsp_cs.h: Remove irqreturn_t definition

<mike.miller:hp.com>:
  o cciss update: support new controller

<mirage:kaotik.org>:
  o [NETFILTER]: Add support for mIRC's 'server lookup' DCC address detection to ip_conntrack_irc.c

<pfg:sgi.com>:
  o Altix console driver update

<tommy.christensen:tpack.net>:
  o [VLAN]: Do not modify the data of shared SKBs

<wensong:linux-vs.org>:
  o [IPVS] Fix ip_vs_tunnel_xmit to return NF_DROP when no memory available
  o [IPVS] add strict boundary check in parsing FTP commands

<xose:wanadoo.es>:
  o megaraid2 merge fixes

Adrian Bunk:
  o USB: fix USB_MOUSE help text
  o USB: USB_SERIAL_KEYSPAN_USA49WLC Configure.help entry

Alan Stern:
  o USB: Pad UFI commands to 12 bytes with zeros
  o USB: unusual_devs.h update

Alexander Viro:
  o Cleanup /proc/ioports seqfile conversion
  o attach_mnt() fix

Andi Kleen:
  o x86-64 ACPI compilation fix
  o Disable devfs for x86-64
  o Fix bug on ACPI sysrq poweroff

Andrea Arcangeli:
  o do_proc_readlink failpath

Benjamin Herrenschmidt:
  o kupdated: correctly dequeue SIGSTOP signals

Dave Kleikamp:
  o BUG() in exec_mmap()

David Brownell:
  o USB: usb gadget support for 2.4 (1/5):  api
  o USB: usb gadget support for 2.4 (2/5): net2280
  o USB: usb gadget support for 2.4 (3/5): zero
  o USB: usb gadget support for 2.4 (4/5): ether
  o USB: usb gadget support for 2.4 (5/5): kbuild/kconf

David Hinds:
  o PCMCIA: cleanup i82365 driver

David S. Miller:
  o [NETLINK]: Set socket error on netlink_ack() allocation failure
  o [NET]: Size hh_cache->hh_data[] properly
  o [UDP/TCP]: Fix binding conflict tests wrt. SO_BINDTODEVICE
  o [NET]: Fix userland iproute2 build problems introduced by mcast changes

David T. Hollis:
  o USB: ax8817x support for usbnet and ethtool_ops support

Erik Andersen:
  o fix 2.4.x incorrect argv[0] for init

François Romieu:
  o dscc4: dscc4_init_dummy_skb() returns a pointer
  o dscc4: add comments
  o dscc4: More comments
  o dscc4: Typo, tabs, unneeded include and misc things from 2.6
  o dscc4: misc fixes
  o dscc4: Assorted fixes
  o dscc4: Small fixes
  o dscc4: Workaround for lack of true reset

Geert Uytterhoeven:
  o Minor q40fb fix
  o M68k: Fix asm constraints in switch_to
  o M68K: Q40/Q60 interrupts
  o M68K: Sun-3 SBUS updates
  o Amiga Zorro bus doc updates

Gerd Knorr:
  o v4l i2c modules update
  o bttv driver update
  o bttv documentation update
  o Tuner update
  o videodev update

Greg Kroah-Hartman:
  o USB: unusual device fixup for the Y-E floppy drive
  o USB: add a new pl2303 device id
  o USB: port ipaq fix to 2.4
  o USB: fix up two locking issues in mdc800 and vicam drivers
  o USB: fix up some non-GPL friendly license wording

Harald Welte:
  o [NETFILTER]: Don't call ip_conntrack_put with ip_conntrack_lock held
  o [NETFILTER]: Fix UDP checksum in ip_nat_mangle_udp_packet, remove skb->csum hacks
  o [NETFILTER]: LOCAL_OUT NAT fix
  o [NETFILTER]: Fix SO_ORIGINAL_DST, broken by earlier endianness fixes

Ian Abbott:
  o USB: ftdi_sio - new vid/pid for OCT US101 USB to RS-232 converter

Ivan Kokshaysky:
  o Alpha: backport force_successful_syscall_return()

Jaroslav Kysela:
  o PageReserved memory counting fix

Jens Axboe:
  o laptop mode

Jes Sorensen:
  o Major qla1280 update

Jozsef Kadlecsik:
  o [NETFILTER]: Make conntrack timeouts become sysctls

Matt Domsch:
  o EDD: BIOS Enhanced Disk Drive Services 3.0 support

Oleg Drokin:
  o USB: devio.c memleak on unexpected disconnect
  o fix LVM memleaks

Olof Johansson:
  o Convert /proc/ioports to seqfile

Patrick McHardy:
  o [NETFILTER]: Use pre-built table for TCP flag-check in ipt_unclean

Paul Mackerras:
  o add Configure.help entries

Petr Vandrovec:
  o [IPV4]: Fix deadlock on ip_mc_list->lock

Rik van Riel:
  o page->flags corruption fix
  o page->flags corruption fix documentation

Rusty Russell:
  o [NETFILTER]: LOCAL_OUT NAT fix, part 2

Tom Rini:
  o PPC32: Add a 'uImage' target for U-Boot
  o PPC32: Fix dependancies on uImage
  o PPC32: Fixes to the MPC8xx uart driver, from Joakim Tjernlund <joakim.tjernlund@lumentis.se>
  o PPC32: Always print the processor number in /proc/cpuinfo
  o PPC: Change how we export some Openfirmware device nodes

Yokota Hiroshi:
  o NinjaSCSI driver update


Summary of changes from v2.4.23-pre5 to v2.4.23-pre6
============================================

<dfages:arkoon.net>:
  o [NET]: Fix HW_FLOWCONTROL on SMP

<galak:blarg.somerset.sps.mot.com>:
  o Added "user64" versions of the user access functions that allow modification of 64-bit data.
  o PPC32: Added "user64" versions of the user acess functions that allow modification of 64-bit data.
  o PPC32: Added big-endian cfg_addr access
  o PPC32: Simplified handling of big/little endian pci indirect access

<marcelo:dmt.cyclades>:
  o Dave Jones: Fix cache size of Centrino CPU
  o Changed EXTRAVERSION to -pre6

<moilanen:austin.ibm.com>:
  o Workaround PPC64 PCI scan issue

<mpm:selenic.com>:
  o netif_carrier_* support for tlan

Alexander Viro:
  o Convert /proc/<pid>/maps to seqfile

Andi Kleen:
  o x86-64 merge
  o AGP Updates for K8
  
oo /proc/kcore  fixes for x86-64
  o Add 3GB personality for x86-64
  o Use MTRR in vesafb by default on x86-64
  o Support 32bit uids on x86-64
  o Remove IORR manipulation in agpgart nvidia drivers

Atul Mukker:
  o Update megaraid driver to 1.18k

Chas Williams:
  o [ATM]: [clip] Fix race between modifying entry->vccs and clip_start_xmit()
  o [ATM]: Split atm_ioctl into vcc_ioctl and atm_dev_ioctl
  o [ATM]: Cleanup atm_dev_ioctl a bit (from mitch@sfgoth.com)
  o [ATM]: Implement pppoatm_ioctl_hook for pppoatm
  o [ATM]: Implement br2684_ioctl_hook for br2684
  o [ATM]: [he] Possibly using corrupted structure (from felipewd@terra.com.br)
  o [ATM]: Update link in documentation

Damien Morange:
  o [SCTP] LKSCTP 0.6.9 backport on kernel 2.4 patch #1
  o [SCTP] LKSCTP 0.6.9 backport on kernel 2.4 patch #2
  o [SCTP] LKSCTP 0.6.9 backport on kernel 2.4 patch #3

David S. Miller:
  o [NET]: Increase ethernet tx_queue_len to 1000
  o [IPV4]: Fix route leak in igmp.c
  o [SCTP]: Do not redefine SMTP stat inc macros
  o [SCTP]: Include linux/crypto.h as needed
  o [NET]: Unlink qdiscs in qdisc_destroy even when CONFIG_NET_SCHED is not enabled
  o [IPV4]: In arp_rcv() do not inspect ARP header until packet length and linearity is verified

Harald Welte:
  o [NETFILTER]: Fix ipt_REJECT when used in OUTPUT
  o [NETFILTER]: In ipt_REJECT handle various hooks correctly in route_reverse()

Ivan Kokshaysky:
  o Alpha update

Jamal Hadi Salim:
  o [NET]: Make pfifo_fast actually report statistics

Jeff Garzik:
  o [wireless airo] Fix build

Jens Axboe:
  o cdrom memory leak

John Stultz:
  o Fix boot code overflow with more CPUs than CONFIG_NR_CPUS

Krishna Kumar:
  o [IPV6]: Export ipv6_devconf via netlink

Larry McVoy:
  o Add pre-apply.paranoid trigger from the Linux 2.5 tree

Len Brown:
  o [ACPI] For ThinkPad -- carry on in face of ECDT probe failure (Andi Kleen)
  o [ACPI] ACPI Component Architecture 20030918 (Bob Moore)
  o [ACPI] CONFIG_ACPI is no longer necessary to enable HT if (CONFIG_ACPI || CONFIG_SMP) CONFIG_ACPI_BOOT=y
  o [ACPI] acpi_pci_link_allocate() should stick with irq.active if set.  (Andrew de Quincey) Fixes OSDL #1186 "broken USB" and others
  o [ACPI] acpi4asus-0.24a-0.25-2.4 (Karol Kozimor)
  o [ACPI] acpi4asus-0.25-0.26 (Karol Kozimor)
  o [ACPI] build fix: remove 2nd __exit from asus_acpi.c
  o [ACPI] deal with lack of acpi prt entries gracefully (Jesse Barnes)

Marcelo Tosatti:
  o Removed unused label in page_alloc.c

Matt Porter:
  o PPC32: Fix 44x _PMD_PRESENT bug
  o PPC32: Use CONFIG_PTE_64BIT instead of CONFIG_44x where appropriate
  o 2.4 IBM EMAC updates

Matthew Wilcox:
  o [NETFILTER]: Use net/checksum.h instead of asm/checksum.h

Mike Miller:
  o cciss support more than 8 controllers

Mirko Lindner:
  o sk98lin-2.4: Remove useless configure options
  o sk98lin-2.4: Readme version update

Paul Mundt:
  o sh: shmse updates
  o sh: div64 backport and random cleanups
  o sh: Add bzImage support
  o sh: sh-sci updates
  o [sh64] Add a new configure option + support code to provide a /proc/asids file
  o sh64: Fixup unaligned accesses
  o sh: Interim cache coherency fix for 2-way caches
  o sh64: Fix CONFIG_SH64_USER_MISALIGNED_FIXUP compile error

Scott Feldman:
  o [e1000] cleanup error return codes
  o [e1000] Add PHY master/slave #define override
  o [e1000] add ethtool flow control support
  o [e1000] move static to table from .h to .c
  o [e1000] Turn off ASF support on Fiber nics
  o [e1000] make function out of setting media type
  o [e1000] sync w/ 2.6 e1000 driver
  o [e1000] read correct bit from EEPROM for getting WoL settings
  o [e1000] new 82541/5/6/7 hardware support
  o [e1000] misc whitespace cleanup, changelog
  o [e1000] 82544 PCI-X hang fix + TSO updates

Sean McGoogan:
  o bug fix: preserve EXPEVT across nested interrupts
  o bug fix: ensure FPSCR.PR == FPSCR.SZ == 1 never occurs
  o provide support for SH4-202 chip
  o Addition of support for the SuperH SH4-202 MicroDev CPU Board

Tom Rini:
  o PPC32: Add CONFIG_ADVNACED_OPTIONS to make the kernel more flexible
  o PPC32: Make ISA support a question on CONFIG_ALL_PPC
  o PPC32: Add the D-Box2 MPC8xx board
  o PPC32: Misc changes for the D-Box2
  o PPC32: Fix a multiple definition problem in the bootwrapper
  o PPC32: UART support and configuration updates from Gary Thomas
  o PPC32: Add a potential bugfix to the MPC8xx uart driver, by way of Dan Malek
  o PPC32: Update MPC8xx code so that it uses consistent_alloc
  o PPC32: Fix KGDB on MPC8xx targets with one serial port


Summary of changes from v2.4.23-pre4 to v2.4.23-pre5
============================================

<achirica:telefonica.net>:
  o [wireless airo] Fix MIC support using CryptoAPI

<amir.noam:intel.com>:
  o [bonding 2.4] Get rid of MOD_*_USE_COUNT, and use C99 initializers
  o [bonding 2.4] Backport free_netdev()
  o [bonding 2.4] Backport PDE()
  o [bonding] Convert /proc to seq_file

<bjorn.helgaas:hp.com>:
  o IA64 config help update
  o IA64 460GX gart support
  o IA64 ZX1 gart support

<daniel:deadlock.et.tudelft.nl>:
  o Patch: Fix reported Atyfb problem on Sparc

<len.brown:intel.com>:
  o Extended IRQ resource type for nForce (Andrew de Quincey) Handle BIOS with _CRS that fails (Jun Nakajima)
  o Fix ACPI oops on ThinkPad T32/T40 (Shaohua David Li)
  o support non ACPI compliant SCI over-ride specs (Jun Nakajima)
  o remove ASUS A7V BIOS version 1011 from blacklist (Eric Valette)
  o fix off-by-one error in ioremap() fixes kernel crash in acpi mode: http://bugzilla.kernel.org/show_bug.cgi?id=1085
  o ACPI_CA_VERSION                 0x20030916
  o tables.c.diff
  o from 2.6 acpi_pci_link_get_irq() returns 0 on error, not -ENODEV. (Christophe Saout)
  o exclude acpitable.[ch] from the CONFIG_ACPI_HT_ONLY build
  o [ACPI] delete acpitable.[ch], which used to be just for CONFIG_ACPI_HT_ONLY
  o [ACPI] Fix SCI storm on out of spec boards like Tyan http://bugzilla.kernel.org/show_bug.cgi?id=774
  o [ACPI] acpi_disabled is used after __initdata is freed
  o [ACPI] fix IO-APIC mode SCI storm due to sharing with PCI device (David Shaohua Li) http://bugzilla.kernel.org/show_bug.cgi?id=1165

<liam.girdwood:wolfsonmicro.com>:
  o 2.4.23-pre3 WM97xx touchscreen documentation

<marcelo:logos.cnet>:
  o Liam Girdwood: eliminates pop noises when doing a PM suspend/resume with the WM9712 AC97 codec.
  o Fix ide-scsi initialization lockup (kudos to Alan)
  o Changed EXTRAVERSION to -pre5
  o Fix Andrea VM merge error

<stuart_hayes:dell.com>:
  o Fix ide-tape lock up

Adrian Bunk:
  o add CONFIG_AGP_ATI Configure.help entry

Andi Kleen:
  o Fix x86-64 compatilation for pre4

Andrea Arcangeli:
  o Fix nr_free_buffer_pages()
  o Remove unused code from balance_classzone()

Geert Uytterhoeven:
  o Fixup atyfb changes in -pre4

Harald Welte:
  o [NETFILTER]: Use u16 for port numbers

Jeff Garzik:
  o fix ifdown+ifup
  o [sound i810_audio] sync with 2.5

Jens Axboe:
  o ide-cd capacity "bug"

Marc-Christian Petersen:
  o Fix wrong slash/backslash in ACPI
  o Fix 'head.S:116: warning: extra tokens at end of #endif directive'
  o Missing 'Hermes in TMD7160/NCP130 based PCI adaptor support' config option
  o Fwd: [PATCH 2.4.23-pre1] Menu fixes

Martin K. Petersen:
  o forte sound driver update

Mikael Pettersson:
  o repair mpparse for default MP systems

Neil Brown:
  o Revert broken knfsd change

Oleg Drokin:
  o Update reiserfs configure help

Paul Mackerras:
  o Fix IDE compile on PPC in 2.4.23-pre4
  o PPC32: Fix compile for "Walnut" board.  Patch from David Gibson
  o PPC32: Use nap mode in the idle loop on the PPC970
  o PPC32: Change the ucontext to move the sigmask back where it was

Tom Rini:
  o PPC32: Fix udelay in the PPC boot code for non-16.6 MHz timebases
  o PPC32: Fix another incorrect asm statement
  o PPC32: Fix a rounding error in the bootwrapper udelay

Summary of changes from v2.4.23-pre3 to v2.4.23-pre4
============================================

<adsharma:unix-os.sc.intel.com>:
  o ia64: IA-32 compatibility patch: FP denormal handling

<alex.williamson:hp.com>:
  o ia64: Correct NR_CPUS/cpu_online test order in CMC/CPE polling

<bjorn.helgaas:hp.com>:
  o ia64: Remove partial semtimedop32 stuff from upstream
  o ia64: Merge to newer ACPI CA
  o ia64: sys_ia32.c needs linux/quotacompat.h
  o ia64: tlb.c whitespace cleanup to follow 2.5
  o ia64: make cpu_relax() a barrier to be consistent with 2.5
  o ia64: kernel/acpi.c: Whitespace changes to follow 2.5
  o ia64: MCA: pass GP *physical address* to SAL
  o ia64: minor bugfixes and whitespace cleanup to follow 2.5
  o ia64: MCA: Find correct offset of OEM data (from Keith Owens)
  o ia64: sal.h: Backport spelling and other trivial changes from 2.5
  o ia64: Comment changes to fix "correctable" usage
  o ia64: Fix check for binutils that supports "hint" instructions
  o ia64: Update configs for upstream changes
  o ia64: Use ARRAY_SIZE(), fix formatting, remove static initializers to zero
  o ia64 unwind: (unw_access_ar): initialize struct pt_regs *pt before using it to get AR_CSD & AR_SSD
  o ia64: Update defconfig to new generic config
  o ia64: initialize bootmem early for acpi_table_init()
  o ia64: Use $(CC), not $(AS), when checking for "hint @pause" support in binutils
  o ia64: Clarify ACPI available_cpus handling
  o ia64: TRIVIAL: Remove extraneous '`'
  o ia64: minstate.h: whitespace changes to reduce diffs with 2.5
  o ia64: Fix minstate comments
  o ia64: fix SAVE_RESET so OS INIT handler works again
  o ia64: Remove AIC7XXX driver from ski defconfig
  o 2.4 HCDP early printk support

<chas:nrl.navy.mil>:
  o [ATM]: In atm_getaddr() do not copy_to_user() with locks held

<daniel:deadlock.et.tudelft.nl>:
  o Implement LCD display support in atyfb driver

<eric:lammerts.org>:
  o fix current->user->processes leak in reparent_to_init()

<erikj:subway.americas.sgi.com>:
  o ia64: 9/3/2003 SGI update

<erlend-a:us.his.no>:
  o [CRYPTO]: Add alg. type to /proc/crypto output

<joris:struyve.be>:
  o unusual_devs.h entry

<karlis:mt.lv>:
  o [BRIDGE]: kfree --> kfree_skb

<marcelo:logos.cnet>:
  o Mehmet Ceyran/Alan Cox: Longer i810_audio.c retries
  o aa VM merge: Per-zone watermark changes, add lower_zone_reserve_ratio
  o aa VM merge: page reclaiming logic changes: Kills oom killer
  o aa VM merge: Page accounting helpers changes
  o aa VM merge: tunables
  o aa VM merge: Kill PF_MEMDIE
  o aa VM merge: Fixup page reclaiming changes patch
  o Changed EXTRAVERSION to -pre4
  o Cset exclude: root@macp.eti.br|ChangeSet|20030912113656|10550

<matthewc:cse.unsw.edu.au>:
  o smpboot.c, acpi.c

Alan Cox:
  o Fix ymfpci oops

Alex Williamson:
  o ia64: Use PAL_HALT_LIGHT in cpu_idle
  o ia64: New CMC/CPE polling
  o ia64: Update to CMC/CPE polling
  o ia64: Rename SAL_CALL_SAFE to SAL_CALL_REENTRANT

Arjan van de Ven:
  o LSB compliance fix in mprotect

Arun Sharma:
  o ia64: translate F_GETLK64/F_SETLK64 to F_GETLK/F_SETLK
  o ia64: fix memory leak in sys32_execve path

Chas Williams:
  o [ATM]: If clip isn't a module don't __MOD_DEC_USE_COUNT()
  o [ATM]: #define'ing pci_pool_create() breaks CONFIG_MODVERSION
  o [ATM]: Backport lane/mpoa module locking cleanup from 2.6.x

David Mosberger:
  o ia64: handle_fpu_swa() scaling fix
  o ia64: Backtraces of all processes on INIT, warning cleanup

Greg Kroah-Hartman:
  o USB: fix data toggle problem for pl2303 driver
  o USB: update usb-serial.h with spelling fixes and get and set functions
  o USB: backport some pl2303 B0 fixes
  o USB: fix oops when yanking a usb-serial device from the system with the port still opened
  o USB: fix copy_from_user call in acm.c
  o USB: fix copy_from_user call in aiptek.c
  o USB: fix copy_to_user call in uhci-debug.h
  o USB: fix copy_to_user call in mdc800 driver
  o USB: remove duplicated copy_from_user call in stv680 driver
  o USB: fix copy_to_user calls in vicam driver

Harald Welte:
  o [NETFILTER]: NAT range calculation fix

Jack Steiner:
  o ia64: discontig/NUMA support
  o ia64: Add ia64_imva() and a few more ia64_tpa() uses
  o ia64: add support for non-identity mapped kernels
  o ia64: remove some SN1 remnants, add a bit more SN2 support

Jean Tourrilhes:
  o wireless extension update: 802.11a/802.11g fixes

Jens Axboe:
  o Add NEC iStorage to SCSI blacklist

Keith M. Wesolowski:
  o [SPARC32]: Ignore btfixups in .text.exit

Keith Owens:
  o ia64: Clean up several warnings (no functional change)
  o ia64: Correct typo in UNW_DPRINT() call
  o ia64: Fix more UNW_DPRINT() typos
  o ia64: Delete some generated ia64 files that were being left by make mrproper

Marc-Christian Petersen:
  o Fixup 'make xconfig' problem caused by fetchop Config.in change

Martin Hicks:
  o ia64: max user stack size of main thread configurable via RLIMIT_STACK

Matthew Wilcox:
  o ia64: return PCI domain for pci_controller_num()

Neil Brown:
  o knfsd: Lock client list while detaching locks
  o knfsd: Set d_op when creating a parent directory during nfsd fh->dentry conversion
  o knfsd: lockd fails to purge blocked NLM_LOCKs
  o Fix typo in umem.c
  o knfsd: Make sure nfs/tcp socket only gets closed
  o knfsd: Change name of a #define in nfsd to match 2.6
  o knfsd: Make sure nfsd replies from the address the request was sent to

Oleg Drokin:
  o [2.4] Rocketport driver compile fix

Paul Fulghum:
  o synclink update
  o synclinkmp update
  o synclink_cs update
  o n_hdlc update
  o synclink drivers fixup

Paul Mackerras:
  o PPC32: Handle single-stepped emulated instructions correctly
  o PPC32: Fix for highmem on machines with 64-bit PTEs (e.g. PPC440)
  o PPC32: Simplify VMALLOC_START, make it just a variable
  o PPC32: Fix a typo in the PPC 440GP support
  o PPC32: Fix a bug where TLB entries didn't get execute permission on 40x

Ralf Bächle:
  o avoid glibc conflict

Seth Rohit:
  o ia64: use "hint @pause" in cpu_relax() and spinlock contention
  o ia64: patch to use >256MB purges
  o ia64: Restructure pt_regs and optimize syscall path
  o ia64: Correct .unwabi for PT_REGS_SAVES (should be "3, 'i'")

Stephen Hemminger:
  o [BRIDGE]: Clear hw checksum flags when bridging

Stéphane Eranian:
  o ia64: Fix perfmon usage of rum/srsm and sum/ssm

Tom Rini:
  o PPC32: Add Magic SysRq support to MPC8260 platforms
  o PPC32: Minor bootwrapper fixups

Tony Luck:
  o ia64: cleaning up the INIT code (Backported from 2.5 by Bjorn Helgaas)
  o ia64: Trim granules correctly in efi_memmap_walk()


Summary of changes from v2.4.23-pre2 to v2.4.23-pre3
============================================

<adam:os.inf.tu-dresden.de>:
  o Add kmap_types.h to include/asm-alpha

<cw:sgi.com>:
  o Remove kdb hooks from SGI Altix Console driver
  o SGI fetchop driver

<javier:tudela.mad.ttd.net>:
  o [wireless airo] Build fixes when MIC disabled
  o [wireless airo] PCI detection code fixes
  o [wireless airo] MIC support using CryptoAPI

<marcelo:logos.cnet>:
  o Updated my contact information
  o Change contact information, again
  o Cset exclude: agruen@suse.de|ChangeSet|20030902115108|61891
  o Adrian & Chantal: Unused variable in ip2main.c
  o Changed EXTRAVERSION to -pre3

<ntfs:flatcap.org>:
  o Fix NTFS build warnings

<purna:jcom.home.ne.jp>:
  o [netdrvr] fix skb_padto bugs introduced when skb_padto was introduced

<xose:wanadoo.es>:
  o [TG3]: More missing PCI ids
  o [TG3]: ICH2 needs MBOX write reorder bug workaround too
  o [netdrvr 3c59x] update pci ids

Adrian Bunk:
  o Fix IRQ_NONE clash in SCSI drivers
  o [wireless airo] fix build with gcc 2.95

Andrew Morton:
  o inodes_stat.nr_inodes race fix

David S. Miller:
  o [SPARC]: Fix uniprocessor build
  o [SPARC64]: In sysv IPC translation, mask out IPC_64 as appropriate
  o [IPV6]: Do not BUG() on icmp6 socket contention, just drop
  o [IPV4]: Do not BUG() on icmp_xmit_lock() contention, just drop

Harald Welte:
  o [NETFILTER]: Fix routing key in ipt_MASQUERADE.c

Hirofumi Ogawa:
  o [netdrvr 8139too] remove driver-based poisoning of net_device
  o [netdrvr 8139too] don't start thread when it's not needed

Ivan Kokshaysky:
  o [PCI] update Memory-Write-Invalidate (MWI) transaction support

Jeff Garzik:
  o [TG3]: Remove pci-set-dma-mask casts
  o [netdrvr 8139cp] build TX checksumming code, but default OFF
  o [netdrvr 8139cp] support NAPI on RX path; Ditch RX frag handling
  o [netdrvr 8139cp] update todo list in header
  o [netdrvr 8139cp] remove mentions of RTL8169 (now handled by "r8169")
  o [netdrvr 8139cp] small cleanups
  o [netdrvr 8139cp] fix NAPI bug; remove board_type distinction, not needed
  o [netdrvr 8139cp] bump version
  o [netdrvr 8139cp] stats improvements and fixes
  o [netdrvr 8139too] make features more persistent; fix PCI DAC mode
  o [netdrvr pcmcia] support SIOC[GS]MII{PHY,REG} ioctls
  o [netdrvr 8139too] remove useless board names
  o [ia32] add PCI id for VIA irq router
  o [PCI] fix export of pdev_set_mwi/pci_generic_prep_mwi
  o [BK] ignore auto-generated files lib/{crc32table.h,gen_crc32table}
  o [netdrvr 8139cp] must call NAPI-specific vlan hook
  o [netdrvr 8139cp] PCI MWI cleanup; remove unneeded workaround
  o [netdrvr 8390] new function alloc_ei_netdev()
  o [netdrvr ne2k-pci] allocate netdev+8390 struct using new alloc_ei_netdev()
  o [netdrvr ne2k-pci] sync with 2.5 (100% minor cleanups)
  o [netdrvr ne2k-pci] ethtool_ops support
  o [NET] move netif_* helpers from tg3 driver to linux/netdevice.h
  o [NET] s/blog_dev/backlog_dev/ in process_backlog, net/core/dev.c
  o [netdrvr] ethtool_ops for epic100, fealnx, winbond-840, via-rhine
  o [netdrvr] sync with 2.5: epic100, fealnx, via-rhine, winbond-840
  o [NET] move ethtool_op_set_tx_csum from 8139cp drvr to net/core/ethtool.c, where it belongs.
  o [PCI, ia32] don't assume "c->x86 > 6" applies to non-Intel CPUs when programming PCI cache line size.
  o [netdrvr] add MV-64340 gigabit ethernet driver (MIPS only)
  o [netdrvr 3c515] fix non-modular build
  o Cset exclude: jgarzik@redhat.com|ChangeSet|20030826234629|07076

John Stultz:
  o Convert /proc/interrupts to use seq_file

Krzysztof Halasa:
  o generic HDLC update

Manuel Estrada Sainz:
  o request_firmware() backport to 2.4 kernels

Marc-Christian Petersen:
  o aty128fb: find the video bios on a Latitude C600 (M3) Inspiron 8000 (M4)
  o Update DRI/DRM so XFree v4.3.0 and above works
  o Disable alpha S3 Savage/VIACLE266 DRM support
  o Add missing IRQ_NONE clash fix hunk

Marcel Holtmann:
  o Make request_firmware() compile if hotplug support is disabled
  o Firmware loading depends on hotplug support
  o [Bluetooth] Make use of request_firmware() for the BlueFRITZ! USB driver
  o Make request_firmware() compile cleanly
  o PCI quirk for SMBus bridge on Asus P4 boards

Matthew Wilcox:
  o [ethtool] fix ethtool_get_strings counting bug
  o [netdrvr 8139too] ethtool_ops support

Mirko Lindner:
  o [netdrvr sk98lin] update to driver version 6.17

Paul Mundt:
  o [netdrvr 8139too] fix and pci ids needed for SH platform

Paulo Ornati:
  o small config fix for ISDN

Rob Radez:
  o [SPARC]: gcc-3.3 compile fixes, part 1
  o [SPARC]: gcc-3.3 compile fixes, part 2
  o [SPARC]: gcc-3.3 compile fixes, part 3

Shmulik Hen:
  o [list] backport list_for_each_entry_safe macro from 2.6
  o [netdrvr bonding] fix /proc read function
  o [netdrvr bonding] use linked list to handle multiple bond devices
  o [netdrvr bonding] update credits/version
  o [netdrvr bonding] add another ifenslave.c include
  o [netdrvr bonding] update slave setting propagation
  o [netdrvr bonding] Change monitoring function to use new slave setting propagation
  o [netdrvr bonding] Modes that don't use primary don't use the new prop. code
  o [netdrvr bonding] Decouple promiscuous handling from the multicast mode setting
  o [netdrvr bonding] support for changing HW address and MTU
  o [netdrvr bonding] support for changing MAC addr, MTU in ALB/TLB modes
  o [netdrvr bonding] Consolidate /proc code, add CHANGENAME handler
  o [netdrvr bonding] Enhance netdev notification handling

Stelian Pop:
  o reenable CAPTURE button in sonypi
  o meye driver update



Summary of changes from v2.4.23-pre1 to v2.4.23-pre2
============================================

<cw:sgi.com>:
  o Add SGI IOC4 IDE Driver
  o SGI SN Serial/Console Driver

<davej:redhat.com>:
  o USB: Add Minolta Dimage F300 to unusual_devs

<gaa:ulticom.com>:
  o USB: new ids for io_ti driver

<javier:tudela.mad.ttd.net>:
  o [wireless airo] add support for MIC and latest firmwares

<kevino:asti-usa.com>:
  o USB: bug in EHCI device reset through transaction

<malte.d:gmx.net>:
  o USB: support for Zaurus 750/760 to usbnet.c (2.4.22-pre8) + code cleanup backport from 2.6

<marcelo:logos.cnet>:
  o Changed hch contact information
  o Fix compilation warning in panic.c
  o Delete unused drivers/scsi/aic79xx (now aic7xxx supports it)
  o add sysctl bits for setuid core
  o Changed EXTRAVERSION to -pre2

<masanari.iida:hp.com>:
  o SCSI blacklist HP Va7140

<mike.miller:hp.com>:
  o cciss multi-path failover in md

<mporter:kernel.crashing.org>:
  o PPC32: Add support for the IBM PPC 440 family of processors
  o PPC32: Add support for DMA controllers on PPC 4xx processors

<russell_d_cagle:mindspring.com>:
  o USB: add Garmin iQue support to visor driver

<thomas:winischhofer.net>:
  o sisfb update

<vmlinuz386:yahoo.com.ar>:
  o PCI Hotplug: fix __FUNCTION__ warnings

Alan Cox:
  o remove all the 440gx broken bios stuff
  o replace the pci router logic with working code
  o update INDEX for docs
  o wolfson touchscreen docs
  o amd watchdog update
  o update i8xx watchdog
  o improved extra key bounce fix
  o fix a missing rocket card
  o warning fix
  o fix nowayout handling on softdog
  o fix missing formatting info in ide-cd
  o add open/close methods to ide-default for hotplug
  o move sibyte driver into the right dir
  o Add Intel ICH3 hotplug support
  o siimage: set a sata flag on the hwif so we can do cable det
  o update ide raid for info pointer changes
  o update ide headers for hotplug
  o fix cable detect issue with sata
  o split ide probe code up
  o Add disk hotplug to the IDE core
  o update cpia driver to fix warnings
  o aacraid update
  o wolfson ac97 touchscreen driver
  o ad1889 error handling fixes
  o ALi5455 update
  o cmpci update
  o fix i810 audio leak
  o makefile/config update for sound changes
  o USB audio fixes for OSS API compliance
  o VGA also works on IA64
  o tdfxfb updates for 24/32 and big endian
  o allow setuid core dumps
  o add sysctl number for setuid core
  o Add headers for wolfson codecs
  o Fix the file sharing/initrd bug
  o resend - mm checks have precedence bugs

Alan Stern:
  o USB: More unusual_devs.h entry updates
  o USB: More unusual_devs.h stuff
  o USB: Another unusual_devs.h entry update

Andrea Arcangeli:
  o vmalloc allocations in ipc needs smp initialized

Andrew Morton:
  o fix possible busywait in rtc_read()
  o tty oops fix

Dan Streetman:
  o USB: backport usbfs 'disconnect'

David Brownell:
  o USB: ehci needs a readb() on IDP425 PCI (ARM)
  o USB: ehci-hcd and period=1frame hs interrupts

David S. Miller:
  o [TG3]: Update to irqreturn_t
  o [TG3]: Sync TSO changes from base 2.5.x
  o [TG3]: Merge comment typo fixes from 2.5.x
  o [TG3]: Initial implementation of 5705 support
  o [TG3]: Fix statistics on 5705
  o [TG3]: Do not reset the RX_MAC unless PHY is Serdes
  o [TG3]: More missing PCI IDs
  o [TG3]: Reset PHY more reliably on 570{3,4,5} chips
  o [TG3]: Fix 5788/5901, update TSO code
  o [TG3]: Differentiate between TSO capable and TSO enabled
  o [TG3]: Add {get,set}_tso ethtool_ops support
  o [TG3]: Bump version/reldate
  o [TG3]: Fix tg3_phy_reset_5703_4_5 chip rev test
  o [TG3]: Bump version/reldate
  o [TG3]: More fixes and enhancements

Geert Uytterhoeven:
  o M68k ptrace
  o Isapnp warning
  o fb_cmap and transparency
  o M68k RTC updates
  o Rename ariadne2 to zorro8390
  o M68k mm cleanup
  o M68k free_io_area()
  o M68k invalid vs. illegal
  o Dmasound invalid vs. illegal
  o M68k cpu_relax()
  o dmasound SOUND_PCM_READ_RATE
  o M68k FPU emulator
  o dmasound core fixes
  o lmc_proto.c includes <asm/smp.h>
  o Sonic Ethernet unsafe interrupt

Greg Kroah-Hartman:
  o USB: added support for TIOCM_RI and TIOCM_CD to pl2303 driver and fix stupid bug
  o USB: remove some vendor specific stuff from the pl2303 driver to get other devices to work
  o [TG3]: pci_device_id can not be marked __devinitdata
  o [netdrvr sis900] don't call pci_find_device from irq context
  o USB: fix up a bunch of copyrights that were incorrectly declared
  o PCI hotplug: fix up a bunch of copyrights that were incorrectly declared
  o PCI: add PCI_DEVICE() macro to make pci_device_id tables easier to read
  o PCI: add PCI_DEVICE_CLASS() macro to match PCI_DEVICE() macro

Henning Meier-Geinitz:
  o USB: New vendor/product ids for scanner driver
  o USB: fix check for SCN_MAX_MNR in scanner driver
  o USB: Fix crash when scanners are disconnected while open
  o USB: unlink interrupt URBs in scanner driver

Hirofumi Ogawa:
  o [netdrvr 8139too] lwake unlock fix
  o [netdrvr 8139too] remove unused RxConfigMask
  o [netdrvr 8139too] add more h/w revision ids

Ian Abbott:
  o USB: ftdi_sio - additional pids
  o USB: ftdi_sio - VID/PID for ID TECH IDT1221U USB to RS-232 adapter
  o USB: ftdi_sio - tidy up write bulk callback

James Morris:
  o [TG3]: skb_headlen() cleanup

Jeff Garzik:
  o [TG3]: Detect shared (and screaming) interrupts
  o [TG3]: Convert to using ethtool_ops
  o [TG3]: Bug fixes for 5705 support
  o [TG3]: More 5705 updates
  o [TG3]: More 5705 fixes
  o [TG3]: Another 5705 fix: enable eeprom write prot as needed
  o [TG3]: Only write the on-nic sram addr on non-5705
  o [TG3]: Add 5782 pci id
  o [netdrvr sis900] ethtool_ops support
  o [netdrvr sis900] minor bits from 2.6
  o [netdrvr 8139cp] minor bits from 2.6
  o [netdrvr 8139cp] ethtool_ops support
  o [netdrvr 3c59x] add a piece missed in previous ethtool_ops patch
  o [netdrvr 3c501] ethtool_ops support
  o [netdrvr] ethtool_ops support in 3c503, 3c505, 3c507
  o [netdrvr] ethtool_ops support for 3c515, 3c523, 3c527, and dmfe
  o [netdrvr pcmcia] ethtool_ops for 3c574, 3c589, aironet4500, axnet
  o [NET] add SET_ETHTOOL_OPS back-compat hook
  o [netdrvr pcmcia] use SET_ETHTOOL_OPS in 3c574, 3c589, aironet4500, and axnet
  o [netdrvr pcmcia] ethtool_ops support for several more pcmcia drivers
  o [netdrvr 8139too] minor bits from 2.6
  o [wireless airo] build fixes
  o [scsi] add SCSI opcodes and SAM status codes to scsi/scsi.h

Judd Montgomery:
  o USB: visor.h[c] USB device IDs documentation

Marc-Christian Petersen:
  o DRM menu the right fix

Matthew Wilcox:
  o [netdrvr 3c59x] ethtool_ops support

Nemosoft Unv.:
  o USB: PWC 8.11

Paul Mackerras:
  o PPC32: Add support for DMA mapping on non-cache-coherent machines
  o PPC32: Add the infrastructure to allow for 64-bit PTEs
  o PPC32: Fix typo in arch/ppc/Makefile
  o PPC32: Use CONFIG_IBM_OPENBIOS instead of CONFIG_TREEBOOT
  o PPC32: Add support for the PPC970 processor
  o PPC32: Minor cleanups and fixes for 4xx/BookE systems
  o PPC32: Restructure signal code, new ucontext structure, add swapcontext syscall
  o PPC32: Implement semtimedop system call

Paul Mundt:
  o Add Paul Mundt to CREDITS

Randy Dunlap:
  o add seq_file "single" interfaces

Stefan Becker:
  o USB: acm.c update for new devices

Stefan Rompf:
  o [netdrvr 8139too] use mii_check_media lib function, instead of homebrew MII bitbanging.

Steven Cole:
  o Add 39 Configure.help texts from -ac tree
  o Add six more Configure.help texts from the -ac tree

Tom Rini:
  o PPC32: Change the default behavior of a kernel with KGDB
  o PPC32: Fix KGDB and userland GDB interactions

Willy Tarreau:
  o Fix log buffer length issues


Summary of changes from v2.4.22 to v2.4.23-pre1
============================================

<achirica:telefonica.net>:
  o [netdrvr airo] Missing defines (only for documentation)
  o [netdrvr airo] MAC type changed to unsigned
  o Missing lines for Wireless Extensions 16
  o MIC support with newer firmware
  o Safer unload code
  o Fix adhoc config

<amir.noam:intel.com>:
  o [net] export alloc_netdev
  o [netdrvr bonding] embed stats struct inside bonding private struct

<davej:redhat.com>:
  o [IPV6]: Missing break in switch statement of rawv6_getsockopt()
  o [IPV4]: /proc/net/pnp dumps items marked initdata

<emann:mrv.com>:
  o [VLAN]: Fix OOPS on module removal

<jan.oravec:6com.sk>:
  o [NET]: Set NLM_F_MULTI in answer of RTM_GETADDR dump answer

<jan:zuchhold.com>:
  o [TG3]: Recognize Altima AC1001 device IDs

<javier:tudela.mad.ttd.net>:
  o [wireless airo] Fixes unregistering of PCI cards
  o [wireless airo] Replaces task queues by simpler kernel_thread

<jdewand:redhat.com>:
  o [SPARC64]: Fix cdrom ioctl32 translations

<kambo77:hotmail.com>:
  o [NET]: Fix hang/memleak in pktgen

<kartik_me:hotmail.com>:
  o [CRYPTO]: Add cast5, integration by jmorris@intercode.com.au

<marcelo:logos.cnet>:
  o pcwd.c: fix oops on unload
  o Cset exclude: m.c.p@wolk-project.de|ChangeSet|20030825183254|28555
  o Cset exclude: m.c.p@wolk-project.de|ChangeSet|20030825194257|34486
  o Fix possible IRQ handling SMP race: Kudos to TeJun Huh
  o Changed EXTRAVERSION to -pre1

<matthewn:snapgear.com>:
  o [netdrvr 8139cp] fix h/w vlan offload

<michel:daenzer.net>:
  o [NET]: Make sure interval member of struct tc_estimator is signed

<mmagallo:debian.org>:
  o AGPGART support for Intel 7x05 chipsets (backported from 2.6)

<skewer:terra.com.br>:
  o [NET]: Remove dead comment from dummy.c driver

<sziwan:hell.org.pl>:
  o [netdrvr 8139too] fix resume behavior, by correctly saving/restoring pci state.

<tv:debian.org>:
  o [NET]: Flush hw header caches on NETDEV_CHANGEADDR events

<wensong:linux-vs.org>:
  o [IPV4]: Add IP Virtual Server to 2.4.x

Alexey Kuznetsov:
  o [IPV4]: IP options were not updated while forwarding multicasts
  o [PKT_SCHED]: More reasonable PSCHED_JSCALE for various values of HZ
  o [IPV4]: Fix rt_score() and usage when purging rtcache hash chains

Andi Kleen:
  o Compile fix for ACPI in 2.4.22/x86-64

Anton Blanchard:
  o [NET]: Add missing memory barriors for __LINK_STATE_RX_SCHED handling

Arjan van de Ven:
  o Fix asm constraint bug in arch/i386/kernel/pci-pc.c

Arnaldo Carvalho de Melo:
  o irqreturn_t compatibility with 2.6

Ben Collins:
  o [SPARC64]: In pci_common.c:find_device_prom_node() recognize PCI_DEVICE_ID_SUN_TOMATILLO
  o [SPARC64]: In clock_probe(), treat m5819p just like m5819

Benjamin Herrenschmidt:
  o [NET]: Do not call request_irq with spinlock held in sungem.c

Chas Williams:
  o [ATM]: export try_atm_clip_ops not atm_clip_ops_mutex

Christoph Hellwig:
  o fix copy_namespace()
  o use list_add_tail in buffer_insert_list
  o reserve a sysctl number for XFS (pagebuf)

Dave Kleikamp:
  o JFS: If unicode conversion fails, operation should fail
  o JFS: Make error return codes negative
  o JFS: K&R to ANSI conversions for fs/jfs/jfs_dmap.c and jfs_xtree.c
  o JFS: add nointegrity mount option (Karl Rister)

David S. Miller:
  o [SPARC64]: Add Ultra-IIIi/Jalapeno support
  o [SPARC64]: Add JIO/Tomatillo PCI controller support
  o [SPARC64]: Read processor number correctly on Ultra-IIIi/Jalapeno
  o [SPARC64]: In ISA support, is interrupt-map exists use it
  o [SPARC64]: Finalize TOMATILLO/JIO support, help from bcollins@debian.org
  o [TG3]: Support OBP firmware mac-addresses on sparc64
  o [SPARC64]: Sanitize PCI controller handling to support Tomatillo better
  o [SPARC64]: Pass correct args to data_access_exception() in unaligned.c
  o [SPARC64]: Make sure to reject all PCI DAC dma masks
  o [SPARC64]: In schizo driver, if virtual-dma property exists, respect it
  o [ATM]: Remove -g option from driver directory CFLAGS
  o [SPARC64]: More tomatillo PCI controller fixes
  o [TG3]: More Sun onboard 5704 fixes
  o [TG3]: Only call tg3_init_rings() after hardware has been reset
  o [SPARC64]: Fix AFSR error reporting for Cheetah+/Jalapeno
  o [SPARC64]: Missing cheetah+ ASI defines
  o [SPARC64]: Fix unused variable warnings when using iounmap()
  o [SPARC64]: Do not make sparc_{cpu,fpu}_type a NR_CPUS array
  o [NET]: Export neigh_changeaddr
  o [SPARC64]: Add some missing PCI error reporting
  o [TG3]: Fix AC1001 typo in pci_ids.h
  o [NET]: Include asm/uaccess.h in net/core/ethtool.c

Harald Welte:
  o [NETFILTER]: Backport iptables AH/ESP fixes from 2.6.x
  o [NETFILTER]: Fix uninitialized return in iptables tftp
  o [NETFILTER]: NAT optimization
  o [NETFILTER]: Conntrack optimization (LIST_DELETE)

Hideaki Yoshifuji:
  o [IPV6]: Fix typo in linux/ipv6.h

Ion Badulescu:
  o [netdrvr tulip] add pci id for 3com 3CSOHO100B-TX

Jack Hammer:
  o ServeRAID 6.10 Driver Update

Jeff Garzik:
  o [ia32] Via, Intel cpu capabilities update
  o [hw_random] add combined Intel+AMD+VIA h/w RNG driver
  o [NET]: Backport ethtool_ops from 2.6.x
  o [ia32] mention that X86_VENDOR_ID is tied to NCAPINTS, in a comment in arch/i386/kernel/head.S.

John Stultz:
  o Do not clear SMI pin at bootup
  o Handle clustered XAPIC in set_ioapic_affinity()

Keith M. Wesolowski:
  o [SPARC]: Trap table alignment for HyperSPARC

Krishna Kumar:
  o [IPV6]: Reporting of prefix routes via rtnetlink

Marc-Christian Petersen:
  o Cleanup kmem_cache_reap()
  o Fix initrd with netboot
  o Cleanup DRM submenu
  o Replace bogus and obsolete "#if __SMP__" -> CONFIG_SMP
  o Allow console switching after kernel panic()
  o Unblank console if panic()
  o Handle get_block errors correctly in block_read_full_page()
  o LVM Update v1.0.5 to v1.0.7
  o CONFIG_NR_CPUS
  o Avoid potentially leaking pagetables into the per-cpu queues
  o Proper APIC with HyperThreading

Martin Devera:
  o [NET]: Fix bugs in sch_htb packet scheduler

Mikael Pettersson:
  o [ia32] adjust X86_VENDOR_ID offset in head.S, due to new NCAPINTS
  o 2.4.22 local APIC updates 1/3: remove incorrect blacklist rules
  o 2.4.22 local APIC updates 2/3: add lapic/nolapic options
  o 2.4.22 local APIC updates 3/3: disable APIC_BASE on reboot

Patrick McHardy:
  o [NET]: Fix no_cong_thresh sysctl

Randy Dunlap:
  o [NET]: Audit copy_from_user checks in pktgen

Robert Olsson:
  o [NET]: Remove some debugging from pktgen

Rusty Russell:
  o [NETFILTER]: Fix masquerade routing check, backport to 2.4 by kurd@cp.rtfm.se

Stelian Pop:
  o sonypi driver update
  o meye driver updates

Stephen Hemminger:
  o [BRIDGE]: Mailing list is at osdl.org now
  o [VLAN]: Allow it to compile with VLAN_DEBUG enabled

Willy Tarreau:
  o Fix amd67x_pm.c crash with no chipsets / CONFIG_HOTPLUG
  o make log buffer length selectable

