Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311834AbSDDWuy>; Thu, 4 Apr 2002 17:50:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311839AbSDDWuk>; Thu, 4 Apr 2002 17:50:40 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:15351
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S311834AbSDDWuU>; Thu, 4 Apr 2002 17:50:20 -0500
Date: Thu, 4 Apr 2002 14:52:21 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.8-pre1
Message-ID: <20020404225221.GF961@matchmail.com>
Mail-Followup-To: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0204031714080.12444-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And here's the summarized changelog.

It's just made with this[1], but it still ends up being about half the size
of the origional changelog. :(

[1]
#!/bin/sh

egrep -iA1 '\([0-9]{2}[/][0-9]{2}[/][0-9]{2}.*\..*\)'|sed 's/--$//'


<jes@wildopensource.com> (02/03/15 1.473.4.15)
	acenic net driver update:

<kai.reichert@udo.edu> (02/03/18 1.538)
	USB printer driver

<paschal@rcsis.com> (02/03/18 1.539)
	USB printer driver

<david-b@pacbell.net> (02/03/18 1.540)
	USB hcd.c, non-HS periodic transfers

<david-b@pacbell.net> (02/03/18 1.541)
	USB mem flags nonpoisonous

<david-b@pacbell.net> (02/03/18 1.542)
	USB

<david-b@pacbell.net> (02/03/18 1.543)
	USB

<david-b@pacbell.net> (02/03/18 1.544)
	USB echi and Intel ICH

<davem@nuts.ninka.net> (02/03/18 1.537.1.1)
	On sparc{,64}, use ptrace_check_attach instead of

<davem@nuts.ninka.net> (02/03/18 1.537.1.2)
	In Sparc{,64} signal handling, tsk->p_pptr --> tsk->parent

<davem@nuts.ninka.net> (02/03/18 1.537.2.1)
	Fix build error on non-x86.

<david-b@pacbell.net> (02/03/18 1.545)
	This updates linux/Documentation/usb/proc_usb_info.txt to:

<johannes@erdfelt.com> (02/03/18 1.546)
	[PATCH] uhci.c 2.4.19-pre3 kmem_cache_alloc flags

<johannes@erdfelt.com> (02/03/18 1.547)
	[PATCH] uhci.c 2.4.19-pre3 erroneous completion callback

<johannes@erdfelt.com> (02/03/18 1.548)
	[PATCH] uhci.c 2.4.19-pre3 interrupt deadlock

<ganesh@tuxtop.vxindia.veritas.com> (02/03/19 1.549)
	USB ipaq driver

<david-b@pacbell.net> (02/03/19 1.550)
	USB usbfs periodic endpoint/bandwidth reporting

<greg@kroah.com> (02/03/19 1.551)
	USB proc_usb_info.txt

<davem@nuts.ninka.net> (02/03/19 1.537.1.3)
	Update sparc64 defconfig.

<davem@nuts.ninka.net> (02/03/19 1.537.2.2)
	Netfilter enhancement from Harald Welte and Netfilter team.

<oliver@oenone.homelinux.org> (02/03/19 1.552)
	USB hpusbscsi driver

<kuznet@ms2.inr.ac.ru> (02/03/19 1.537.2.3)
	Remove obsolete confusing instructions on tcp_max_syn_backlog

<kuznet@ms2.inr.ac.ru> (02/03/19 1.537.2.4)
	Make pkt_sched.h:PSCHED_TDIFF_SAFE behave sane when measuring

<kuznet@ms2.inr.ac.ru> (02/03/19 1.537.2.5)
	Remove unused field from TCP struct open_request.

<kuznet@ms2.inr.ac.ru> (02/03/19 1.537.2.6)
	Do not fail creating _new_ NOARP entry with EPERM.

<kuznet@ms2.inr.ac.ru> (02/03/19 1.537.2.7)
	Old bug in skbuff.c, found by someone, but was lost.

<kuznet@ms2.inr.ac.ru> (02/03/19 1.537.2.8)
	IPv4 FIB routing fixes:

<kuznet@ms2.inr.ac.ru> (02/03/19 1.537.2.9)
	In IPv4 ICMP:

<kuznet@ms2.inr.ac.ru> (02/03/19 1.537.2.10)
	Fix for ipv4 tunnel devices:

<kuznet@ms2.inr.ac.ru> (02/03/19 1.537.2.11)
	IP input fixes:

<kuznet@ms2.inr.ac.ru> (02/03/19 1.537.2.12)
	Terrible bug in ipv4/route.c, mis-sized ip_rt_acct leads to

<kuznet@ms2.inr.ac.ru> (02/03/19 1.537.2.13)
	TCP Input fixes:

<kuznet@ms2.inr.ac.ru> (02/03/19 1.537.2.14)
	UDP fixes:

<kuznet@ms2.inr.ac.ru> (02/03/19 1.537.2.15)
	IPV6 addrconf exploit fix:

<kuznet@ms2.inr.ac.ru> (02/03/19 1.537.2.16)
	IPv6 neighbour discovery fixes:

<kuznet@ms2.inr.ac.ru> (02/03/19 1.537.2.17)
	TCP ipv6 fixes:

<kuznet@ms2.inr.ac.ru> (02/03/19 1.537.2.18)
	Port of 2.2.x AF_PACKET bug fix.

<kuznet@ms2.inr.ac.ru> (02/03/19 1.537.2.19)
	Fix bug in sch_prio.c where wrong handle was

<kuznet@ms2.inr.ac.ru> (02/03/19 1.537.2.20)
	In sch_sfq.c, allow to descrease length of queue

<kuznet@ms2.inr.ac.ru> (02/03/19 1.537.2.21)
	Add new sysctl, medium_id, to devinet.

<kuznet@ms2.inr.ac.ru> (02/03/19 1.537.2.22)
	Allow to bind to an already in use local port

<davem@nuts.ninka.net> (02/03/19 1.537.2.23)
	Fix mis-merge of TCP_LAST_ACK fix.

<davem@nuts.ninka.net> (02/03/19 1.537.2.24)
	Update port-allocation changes to coincide with struct sock

<davem@nuts.ninka.net> (02/03/19 1.537.2.25)
	Update port-allocation changes to coincide with struct sock

<davem@nuts.ninka.net> (02/03/19 1.537.2.26)
	Kill unused local var in af_inet.c:inet_stream_connect

<kanojsarcar@yahoo.com> (02/03/19 1.537.1.4)
	Move VPTE_BASE_foo definitions to common

<eli.kupermann@intel.com> (02/03/20 1.537.3.2)
	e100 net driver update:

<jgarzik@mandrakesoft.com> (02/03/20 1.537.3.3)
	Merge ethtool initiate-nic-self-test ioctl, and support for it in e100 net drvr.

<adilger@clusterfs.com> (02/03/20 1.537.4.1)
	Add three scripts for BK users, to Documentation/BK-usage:

<tvignaud@mandrakesoft.com> (02/03/20 1.537.4.2)
	Remove silly overdependency on Perl 5.6.1 in BK helper scripts.

<jgarzik@mandrakesoft.com> (02/03/20 1.537.3.4)
	Add support file e100_test to e100 net driver.  Missed in earlier merge.

<jgarzik@mandrakesoft.com> (02/03/20 1.537.3.5)
	Merge dl2k gigabit ethernet driver update vendor:

<jgarzik@mandrakesoft.com> (02/03/20 1.537.3.6)
	Merge orinoco_plx wireless driver pci ids from 2.4.x.

<jgarzik@mandrakesoft.com> (02/03/20 1.537.4.3)
	Update rocketport serial driver:

<jgarzik@mandrakesoft.com> (02/03/20 1.537.4.4)
	Add two AC97 codec ids to old OSS ac97_codec driver.

<k.kasprzak@box43.pl> (02/03/20 1.537.3.7)
	de620 net driver janitor fixes:

<silicon@falcon.sch.bme.hu> (02/03/20 1.537.4.5)
	Update munish WAN driver to not kfree memory multiple times.

<wstinson@infonie.fr> (02/03/20 1.537.4.6)
	Fix DocBook documentation for ALSA merge,

<jgarzik@mandrakesoft.com> (02/03/20 1.537.3.8)
	Revert epic100 net driver power sequence "fix", it broke some boards.

<davem@nuts.ninka.net> (02/03/20 1.537.2.27)
	Fix reverse logic in checking sock_writeable return

<davem@nuts.ninka.net> (02/03/20 1.537.1.5)
	In sparc64/ebus, handle machines with both RIO and

<greg@kroah.com> (02/03/20 1.551.1.1)
	USB hub

<davem@nuts.ninka.net> (02/03/20 1.537.1.6)
	On sparc64 Schizo PCI controllers, there is no inofixup

<davem@nuts.ninka.net> (02/03/20 1.537.1.7)
	On sparc64, handle assigning ROM and non-standard resources

<davem@nuts.ninka.net> (02/03/20 1.537.1.8)
	In Sun GEM/HME drivers, if OpenBoot firmware is not

<davem@nuts.ninka.net> (02/03/20 1.537.1.9)
	Model Sparc64 pci_assign_resource more closely to the

<davem@nuts.ninka.net> (02/03/21 1.537.1.10)
	Merge 2.4.x Sun GEM/HME net driver fixes.

<davem@nuts.ninka.net> (02/03/21 1.537.1.11)
	Remove debugging printk while probing MAC address.

<davem@nuts.ninka.net> (02/03/21 1.537.1.12)
	Sun HME/GEM driver probing cleanups.

<greg@kroah.com> (02/03/21 1.554)
	USB visor driver

<greg@kroah.com> (02/03/21 1.555)
	USB serial driver core

<greg@kroah.com> (02/03/21 1.556)
	USB serial drivers

<oliver@oenone.homelinux.org> (02/03/21 1.557)
	USB kaweth driver

<davem@nuts.ninka.net> (02/03/21 1.537.2.28)
	Add missing KERN_foo printk specifiers to networking.

<uzi@uzix.org> (02/03/21 1.537.1.13)
	Merge 2.4.x VGER sparc32 changes into 2.5.x

<laforge@gnumonks.org> (02/03/21 1.537.2.29)
	Add configure Configure.help message and

<wstinson@infonie.fr> (02/03/21 1.537.1.14)
	Remove explicit initialization of static vars to zero

<cruault@724.com> (02/03/21 1.537.2.30)
	Make sure outgoing ICMP and TCP resets

<davem@nuts.ninka.net> (02/03/21 1.537.1.15)
	Move bootstr_valid/bootstr_buf back into .data section.

<davem@nuts.ninka.net> (02/03/22 1.537.2.31)
	Code (and commentary) in SYN-RECEIVED processing

<petkan@mastika.> (02/03/22 1.558)
	USB pegasus driver

<petkan@mastika.> (02/03/22 1.559)
	USB

<davem@nuts.ninka.net> (02/03/22 1.537.2.32)
	Bump TcpPassiveOpens when tcp_create_openreq_child succeeds.

<stewart@inverse.wetlogic.net> (02/03/22 1.560)
	[PATCH] Re: [PATCH] hiddev code and docs cleanup

<greg@kroah.com> (02/03/23 1.561)
	USB visor driver

<johannes@erdfelt.com> (02/03/25 1.562)
	[PATCH] 2.4.19-pre3 uhci.c zero packet

<davem@nuts.ninka.net> (02/03/25 1.537.1.16)
	Merge 2.4.x sparc64 PCI IRQ routing fixes into 2.5

<uzi@uzix.org> (02/03/25 1.537.1.17)
	Sparc32 cleanups.

<david-b@pacbell.net> (02/03/26 1.563)
	USB ohci-hcd update

<petkan@mastika.lnxw.com> (02/03/26 1.564)
	USB pegasus driver

<davem@nuts.ninka.net> (02/03/26 1.537.1.18)
	Do the slot mapping adjustment to PROM interrupt

<davem@nuts.ninka.net> (02/03/26 1.537.2.33)
	Fix device list locking.

<laforge@gnumonks.org> (02/03/26 1.537.2.34)
	Big netfilter newnat patch for 2.5.7:

<davem@nuts.ninka.net> (02/03/26 1.537.1.19)
	SunHME driver updates:

<johannes@erdfelt.com> (02/03/27 1.565)
	[PATCH] USB uhci bugfix

<david-b@pacbell.net> (02/03/27 1.566)
	USB ohci-hcd driver update

<david-b@pacbell.net> (02/03/27 1.567)
	USB core sanity check

<davem@nuts.ninka.net> (02/03/27 1.537.2.35)
	Tigon3 net driver fixes:

<davem@nuts.ninka.net> (02/03/27 1.537.1.20)
	In SBUS probing, handle empty SBUS correctly.

<greg@kroah.com> (02/03/27 1.568)
	USB serial console support added

<davem@nuts.ninka.net> (02/03/27 1.537.2.36)
	Tigon3 net driver bug fix:

<greg@kroah.com> (02/03/28 1.569)
	USB serial config.in changes

<greg@kroah.com> (02/03/28 1.570)
	USB uhci bug fix.

<greg@kroah.com> (02/03/28 1.571)
	USB io_edgeport driver update

<ganesh@veritas.com> (02/03/28 1.572)
	USB serial core

<david-b@pacbell.net> (02/03/28 1.573)
	USB audio driver

<david-b@pacbell.net> (02/03/28 1.574)
	USB hcd driver updates

<stewart@wetlogic.net> (02/03/28 1.575)
	USB hiddev interface

<davem@nuts.ninka.net> (02/03/28 1.537.1.21)
	Sparc SBUS fix: Make for_all_sbusdev work with an empty SBUS.

<davem@nuts.ninka.net> (02/03/30 1.537.2.37)
	net/core/sock.c needs linux/tcp.h to get at TCP state macros.

<spse@secret.org.uk> (02/04/01 1.576)
	[PATCH] Update to konicawc driver

<viro@math.psu.edu> (02/04/02 1.537.5.1)
	[PATCH] initrd issue

<dalecki@evision-ventures.com> (02/04/02 1.537.5.2)
	[PATCH] 2.5.7 IDE 23

<dalecki@evision-ventures.com> (02/04/02 1.537.5.3)
	[PATCH] 2.5.7 IDE 24

<dalecki@evision-ventures.com> (02/04/02 1.537.5.4)
	[PATCH] 2.5.7 IDE 25

<dalecki@evision-ventures.com> (02/04/02 1.537.5.5)
	[PATCH] 2.5.7 IDE 26

<dalecki@evision-ventures.com> (02/04/02 1.537.5.6)
	[PATCH] 2.5.7 IDE 27

<dalecki@evision-ventures.com> (02/04/02 1.537.5.7)
	[PATCH] 2.5.7 IDE 28a

<akpm@zip.com.au> (02/04/02 1.537.5.8)
	[PATCH] ext2_fill_super breakage

<viro@math.psu.edu> (02/04/02 1.537.1.24)
	[PATCH] romfs inode allocation

<viro@math.psu.edu> (02/04/02 1.537.1.25)
	[PATCH] conditional system call cleanup

<viro@math.psu.edu> (02/04/02 1.537.1.26)
	[PATCH] minixfs cleanups (1/4)

<viro@math.psu.edu> (02/04/02 1.537.1.27)
	[PATCH] minixfs cleanups (2/4)

<viro@math.psu.edu> (02/04/02 1.537.1.28)
	[PATCH] minixfs cleanups (3/4)

<viro@math.psu.edu> (02/04/02 1.537.1.29)
	[PATCH] minixfs cleanups (4/4)

<viro@math.psu.edu> (02/04/02 1.537.1.30)
	[PATCH] set_blocksize() in JFS

<viro@math.psu.edu> (02/04/02 1.537.1.31)
	[PATCH] hfs compile fix

<viro@math.psu.edu> (02/04/02 1.537.1.32)
	[PATCH] restoring block size upon umount

<viro@math.psu.edu> (02/04/02 1.537.1.33)
	[PATCH] fsync_bdev() conversion

<viro@math.psu.edu> (02/04/02 1.537.1.34)
	[PATCH] brw_kiovec() converted to struct block_device *

<torvalds@penguin.transmeta.com> (02/04/02 1.537.1.35)
	update version and defconfig

<davem@nuts.ninka.net> (02/04/02 1.537.2.38)
	In tcp_v4_send_reset, use inet_sk to get at

<haveblue@us.ibm.com> (02/04/03 1.537.1.37)
	[PATCH] BKL reduction in do_exit

<davej@suse.de> (02/04/03 1.537.1.38)
	[PATCH] Hyperthreading binfmt.

<davej@suse.de> (02/04/03 1.537.1.39)
	[PATCH] fix broken asm constraint

<greg@kroah.com> (02/04/03 1.537.1.40)
	[PATCH] small fix for mpparse.c

<davej@suse.de> (02/04/03 1.537.1.41)
	[PATCH] AGPGART capability handling cleanup

<davej@suse.de> (02/04/03 1.537.1.42)
	[PATCH] EFI GUID partition table support.

<davej@suse.de> (02/04/03 1.537.1.43)
	[PATCH] about locations of various sound files.

<davej@suse.de> (02/04/03 1.537.1.44)
	[PATCH] Support for ITE interrupt router

<adam@nmt.edu> (02/04/03 1.537.1.45)
	[PATCH] 3ware driver update for 2.5.8-pre1

<davej@suse.de> (02/04/03 1.537.1.46)
	[PATCH] watchdog API documentation.

<davej@suse.de> (02/04/03 1.537.1.47)
	[PATCH] eicon driver was sleeping with lock held.

<davej@suse.de> (02/04/03 1.537.1.48)
	[PATCH] extra codepage support.

<davej@suse.de> (02/04/03 1.537.1.49)
	[PATCH] AMD ELAN support.

<davej@suse.de> (02/04/03 1.537.1.50)
	[PATCH] Cyrix irq router tweak

<davej@suse.de> (02/04/03 1.537.1.51)
	[PATCH] Cyclades driver region cleanup

<davej@suse.de> (02/04/03 1.537.1.52)
	[PATCH] Various completion users.

<davej@suse.de> (02/04/03 1.537.1.53)
	[PATCH] Document an errata workaround in apic code.

<davej@suse.de> (02/04/03 1.537.1.54)
	[PATCH] faster update_atime.

<davej@suse.de> (02/04/03 1.537.1.55)
	[PATCH] DMI scanner update.

<davej@suse.de> (02/04/03 1.537.1.56)
	[PATCH] AMD Elan uses slightly different clock freq

<davej@suse.de> (02/04/03 1.537.1.57)
	[PATCH] export rbtree routines for modules.

<davej@suse.de> (02/04/03 1.537.1.58)
	[PATCH] Detect get_block() errors in block_read_full_page()

<davej@suse.de> (02/04/03 1.537.1.59)
	[PATCH] add AMD Elan resources.

<davej@suse.de> (02/04/03 1.537.1.60)
	[PATCH] Extra cards support for MOXA driver

<davej@suse.de> (02/04/03 1.537.1.61)
	[PATCH] faster kiobuf init.

<davej@suse.de> (02/04/03 1.537.1.62)
	[PATCH] Fix up broken do while macros.

<davej@suse.de> (02/04/03 1.537.1.63)
	[PATCH] document new address space operations.

<davej@suse.de> (02/04/03 1.537.1.64)
	[PATCH] fix up broken comment delimiters.

<davej@suse.de> (02/04/03 1.537.1.65)
	[PATCH] proc race on task_struct->sig

<davej@suse.de> (02/04/03 1.537.1.66)
	[PATCH] silence DVD_INVALIDATE_AGID output.

<davej@suse.de> (02/04/03 1.537.1.67)
	[PATCH] Simple boot flag specification support.

<davej@suse.de> (02/04/03 1.537.1.68)
	[PATCH] sonypi driver update from 2.4

<davej@suse.de> (02/04/03 1.537.1.69)
	[PATCH] group #include's together in x86 ioremap.c

<davej@suse.de> (02/04/03 1.537.1.70)
	[PATCH] Gameport patch for drivers/sound/mad16.c

<davej@suse.de> (02/04/03 1.537.1.71)
	[PATCH] CREDITS updates

<davej@suse.de> (02/04/03 1.537.1.72)
	[PATCH] Various typo fixes.

<davej@suse.de> (02/04/03 1.537.1.73)
	[PATCH] region handling cleanups for tpqic02

<davej@suse.de> (02/04/03 1.537.1.74)
	[PATCH] UDF write support problem in 2.5.7

<davej@suse.de> (02/04/03 1.537.1.75)
	[PATCH] unnecessary includes.

<davej@suse.de> (02/04/03 1.537.1.76)
	[PATCH] Update file list in INDEX

<davej@suse.de> (02/04/03 1.537.1.77)
	[PATCH] PCI IDS update.

<davej@suse.de> (02/04/03 1.537.1.78)
	[PATCH] Update bigphysarea URL

<davej@suse.de> (02/04/03 1.537.1.79)
	[PATCH] watchdog nowayout for i810-tco

<davej@suse.de> (02/04/03 1.537.1.80)
	[PATCH] videodev fixups / generic usercopy helper

<davej@suse.de> (02/04/03 1.537.1.81)
	[PATCH] watchdog nowayout for acquirewdt

<davej@suse.de> (02/04/03 1.537.1.82)
	[PATCH] printk levels for vme_scc driver

<davej@suse.de> (02/04/03 1.537.1.83)
	[PATCH] watchdog nowayout for eurotechwdt

<davej@suse.de> (02/04/03 1.537.1.84)
	[PATCH] watchdog nowayout for ib700wdt

<davej@suse.de> (02/04/03 1.537.1.85)
	[PATCH] more then enough typos.

<davej@suse.de> (02/04/03 1.537.1.86)
	[PATCH] remove dead comment

<davej@suse.de> (02/04/03 1.537.1.87)
	[PATCH] __init/__exit does nothing in prototypes

<davej@suse.de> (02/04/03 1.537.1.88)
	[PATCH] reiserfs tools update.

<davej@suse.de> (02/04/03 1.537.1.89)
	[PATCH] Remove guess from bttv docs.

<davej@suse.de> (02/04/03 1.537.1.90)
	[PATCH] More verbosity in VIA tweak

<davej@suse.de> (02/04/03 1.537.1.91)
	[PATCH] watchdog nowayout for advantechwdt

<davej@suse.de> (02/04/03 1.537.1.92)
	[PATCH] updated documentation for w9966 driver.

<davej@suse.de> (02/04/03 1.537.1.93)
	[PATCH] extra sanity checks for mempool

<davej@suse.de> (02/04/03 1.537.1.94)
	[PATCH] khttpd logs wrong debug message on leaving function.

<davej@suse.de> (02/04/03 1.537.1.95)
	[PATCH] nbd compile fix.

<davej@suse.de> (02/04/03 1.537.1.96)
	[PATCH] strtok -> strsep in adfs

<davej@suse.de> (02/04/03 1.537.1.97)
	[PATCH] remove workaround for old binutils.

<davej@suse.de> (02/04/03 1.537.1.98)
	[PATCH] remove bogus return from mtrr driver.

<davej@suse.de> (02/04/03 1.537.1.99)
	[PATCH] strtok->strsep in hpfs

<davej@suse.de> (02/04/03 1.537.1.100)
	[PATCH] strtok->strsep in hfs

<davej@suse.de> (02/04/03 1.537.1.101)
	[PATCH] typo in pci_set_mwi header

<davej@suse.de> (02/04/03 1.537.1.102)
	[PATCH] strtok->strsep in autofs

<davej@suse.de> (02/04/03 1.537.1.103)
	[PATCH] strtok->strsep in shmem

<davej@suse.de> (02/04/03 1.537.1.104)
	[PATCH] i2c-proc wasn't checking kmalloc result

<davej@suse.de> (02/04/03 1.537.1.105)
	[PATCH] compile fix for gemtek-pci radio card

<davej@suse.de> (02/04/03 1.537.1.106)
	[PATCH] strtok->strsep for autofs4

<davej@suse.de> (02/04/03 1.537.1.107)
	[PATCH] strtok->strsep isofs

<davej@suse.de> (02/04/03 1.537.1.108)
	[PATCH] strtok->strsep in usb

<davej@suse.de> (02/04/03 1.537.1.109)
	[PATCH] strtok->strsep in jfs

<davej@suse.de> (02/04/03 1.537.1.110)
	[PATCH] Only offer ARM PCMCIA on ARM machines.

<davej@suse.de> (02/04/03 1.537.1.111)
	[PATCH] strtok->strsep in ntfs

<davej@suse.de> (02/04/03 1.537.1.112)
	[PATCH] strtok->strsep for reiserfs

<davej@suse.de> (02/04/03 1.537.1.113)
	[PATCH] strtok->strsep in isdn avmb1 capifs

<davej@suse.de> (02/04/03 1.537.1.114)
	[PATCH] apply KERNELRELEASE regexp globally in makefile

<davej@suse.de> (02/04/03 1.537.1.115)
	[PATCH] more kbuild cleanup.

<davej@suse.de> (02/04/03 1.537.1.116)
	[PATCH] Define KBUILD_BASENAME for .i * .s

<davej@suse.de> (02/04/03 1.537.1.117)
	[PATCH] MP1.4 SPEC compliance.

<davej@suse.de> (02/04/03 1.537.1.118)
	[PATCH] strtok->strsep in affs

<davej@suse.de> (02/04/03 1.537.1.119)
	[PATCH] Small fix to pci_alloc_consistent()

<davej@suse.de> (02/04/03 1.537.1.120)
	[PATCH] strtok->strsep in atari config

<davej@suse.de> (02/04/03 1.537.1.121)
	[PATCH] wrong return codes in ipc shm

<davej@suse.de> (02/04/03 1.537.1.122)
	[PATCH] devexit fix for i82092

<davej@suse.de> (02/04/03 1.537.1.123)
	[PATCH] Fix race in JFS

<davej@suse.de> (02/04/03 1.537.1.124)
	[PATCH] malloc.h -> slab.h

<davej@suse.de> (02/04/03 1.537.1.125)
	[PATCH] add EISA port to /proc/ioports

<davej@suse.de> (02/04/03 1.537.1.126)
	[PATCH] Fix reiserfs oops with seperate journal dev

<davej@suse.de> (02/04/03 1.537.1.127)
	[PATCH] strtok->strsep in alpha setup

<davej@suse.de> (02/04/03 1.537.1.128)
	[PATCH] watchdog nowayout for sbc60xxwdt

<davej@suse.de> (02/04/03 1.537.1.129)
	[PATCH] Remove address member from scatterlist docs.

<davej@suse.de> (02/04/03 1.537.1.130)
	[PATCH] extra PIIX entries for IRQ routers.

<davej@suse.de> (02/04/03 1.537.1.131)
	[PATCH] Allow use of 256 loop devices

<davej@suse.de> (02/04/03 1.537.1.132)
	[PATCH] watchdog nowayout for shwdt

<davej@suse.de> (02/04/03 1.537.1.133)
	[PATCH] updates for make rpm

<davej@suse.de> (02/04/03 1.537.1.134)
	[PATCH] DMI entries for HP Pavillion laptops.

<davej@suse.de> (02/04/03 1.537.1.135)
	[PATCH] Clean up CONFIG_HIGHMEM & HIGHPTE options.

<davej@suse.de> (02/04/03 1.537.1.136)
	[PATCH] watchdog nowayout for machzwd

<davej@suse.de> (02/04/03 1.537.1.137)
	[PATCH] watchdog nowayout for softdog

<davej@suse.de> (02/04/03 1.537.1.138)
	[PATCH] watchdog nowayout for wdt_pci

<davej@suse.de> (02/04/03 1.537.1.139)
	[PATCH] watchdog nowayout for wdt

<davej@suse.de> (02/04/03 1.537.1.140)
	[PATCH] missing includes.

<davej@suse.de> (02/04/03 1.537.1.141)
	[PATCH] Christoph Hellwig contact update

<davej@suse.de> (02/04/03 1.537.1.142)
	[PATCH] watchdog nowayout for mixcomwd

<davej@suse.de> (02/04/03 1.537.1.143)
	[PATCH] seq_file for /proc/partitions (take 2)

<davej@suse.de> (02/04/03 1.537.1.144)
	[PATCH] document <asm-i386/io.h> functions.

<davej@suse.de> (02/04/03 1.537.1.145)
	[PATCH] kdev_t fixes.

<davej@suse.de> (02/04/03 1.537.1.146)
	[PATCH] x86 microcode driver update

<davej@suse.de> (02/04/03 1.537.1.147)
	[PATCH] Pentium 4 NMI watchdog support

<davej@suse.de> (02/04/03 1.537.1.148)
	[PATCH] jiffies wrap fixes.

<davej@suse.de> (02/04/03 1.537.1.149)
	[PATCH] Add missing MODULE_LICENSE tags

<davej@suse.de> (02/04/03 1.537.1.150)
	[PATCH] Add support for National Semiconductor x86's.

<davej@suse.de> (02/04/03 1.537.1.151)
	[PATCH] watchdog nowayout for wdt977

<davej@suse.de> (02/04/03 1.537.1.152)
	[PATCH] PPP documentation.

<davej@suse.de> (02/04/03 1.537.1.153)
	[PATCH] x86 bluesmoke update.

<davej@suse.de> (02/04/03 1.537.1.154)
	[PATCH] pnpbios driver update.

<davej@suse.de> (02/04/03 1.537.1.155)
	[PATCH] Remove last remaining bits of strtok.

<torvalds@penguin.transmeta.com> (02/04/03 1.537.1.156)
	update for i386 config.in changes

<christopher@intel.com> (02/04/03 1.537.6.2)
	e1000 net drvr update 1/13:

<christopher@intel.com> (02/04/03 1.537.6.3)
	e1000 net drvr update 2/13:

<christopher@intel.com> (02/04/03 1.537.6.4)
	e1000 net drvr update 3/13:

<christopher@intel.com> (02/04/03 1.537.6.5)
	e1000 net drvr update 4/13:

<christopher@intel.com> (02/04/03 1.537.6.6)
	e1000 net drvr update 5/13:

<christopher@intel.com> (02/04/03 1.537.6.7)
	e1000 net drvr update 6/13:

<christopher@intel.com> (02/04/03 1.537.6.8)
	e1000 net drvr update 7/13:

<christopher@intel.com> (02/04/03 1.537.6.9)
	e1000 net drvr updates 8/13:

<christopher@intel.com> (02/04/03 1.537.6.10)
	e1000 net drvr update 9/13:

<christopher@intel.com> (02/04/03 1.537.6.11)
	e1000 net drvr updates 10/13:

<christopher@intel.com> (02/04/03 1.537.6.12)
	e1000 net drvr updates 11/13:

<christopher@intel.com> (02/04/03 1.537.6.13)
	e1000 net drvr update 12/13:

<christopher@intel.com> (02/04/03 1.537.6.14)
	e1000 net drvr update 13/13:

<davej@suse.de> (02/04/03 1.537.6.15)
	Small net driver fixes/cleanups related to setting

<davej@suse.de> (02/04/03 1.537.6.16)
	net driver janitor fixes:

<torvalds@penguin.transmeta.com> (02/04/03 1.537.1.157)
	Fix missing include due to do_exit() BKL movement

<torvalds@penguin.transmeta.com> (02/04/03 1.537.1.158)
	strtok -> strsep fixes

<torvalds@penguin.transmeta.com> (02/04/03 1.537.1.159)
	Fix compile without EISA support

<torvalds@penguin.transmeta.com> (02/04/03 1.537.1.160)
	Header file cleanup fixes

<torvalds@penguin.transmeta.com> (02/04/03 1.537.1.161)
	vmalloc_to_page() should be usable for everybody (see discussion

<p_gortmaker@yahoo.com> (02/04/03 1.537.8.2)
	s/extern inline/static inline/ for net drivers:

<p_gortmaker@yahoo.com> (02/04/03 1.537.8.3)
	These net drivers init dev->rmem_start/end but do not use these at all 

<p_gortmaker@yahoo.com> (02/04/03 1.537.8.4)
	drivers/net/sb1000.c does not use any ISA memory for I/O but does (ab)use

<p_gortmaker@yahoo.com> (02/04/03 1.537.8.5)
	The struct netdev rmem_start and rmem_end entries are specific to 8390

<p_gortmaker@yahoo.com> (02/04/03 1.537.8.6)
	Enable multiple ISA ethernet probes at boot (old behaviour was to quit

<p_gortmaker@yahoo.com> (02/04/03 1.537.8.7)
	finally, remove rmem_{start,end} from struct net_device.

<davej@suse.de> (02/04/03 1.537.8.8)
	Remove old 2.2.x wait queue compat code from cosa wan driver.

<davej@suse.de> (02/04/03 1.537.8.9)
	Merge new tc35815 net driver from 2.4.x.

<davej@suse.de> (02/04/03 1.537.8.10)
	jiffies wrap fixes for net drivers atp, yam, and sb1000.

<jgarzik@mandrakesoft.com> (02/04/03 1.537.8.11)
	Merge new sun3 82586 net driver from 2.4.x.

<davej@suse.de> (02/04/03 1.537.8.12)
	Merge SIByte SB1250 net driver from 2.4.x.

<jgarzik@mandrakesoft.com> (02/04/03 1.537.1.164)
	Remove unused, and now deprecated, references to

<jgarzik@mandrakesoft.com> (02/04/03 1.537.1.165)
	Clean up tg3 net drver PCI DMA mapping, and in the process

<greg@kroah.com> (02/04/03 1.577)
	USB HID driver

<petkan@users.sourceforge.net> (02/04/03 1.578)
	USB rtl8150 driver

<johannes@erdfelt.com> (02/04/03 1.579)
	USB UHCI driver

<Romain.Lievin@esisar.inpg.fr> (02/04/03 1.580)
	USB tiusb

<vojtech@suse.cz> (02/04/03 1.581)
	USB 64bit fixes

<sl@lineo.com> (02/04/03 1.582)
	USB safe_serial

<dbrownell@users.sourceforge.net> (02/04/03 1.583)
	USB ohci driver fixes

<greg@kroah.com> (02/04/03 1.584)
	USB

<torvalds@penguin.transmeta.com> (02/04/03 1.537.1.166)
	Get rid of duplicated EISA_bus variable

<torvalds@penguin.transmeta.com> (02/04/03 1.537.1.167)
	oops, lost end parenthesis

<davej@suse.de> (02/04/03 1.537.1.168)
	[PATCH] The last? strtok fixes.

<rml@tech9.net> (02/04/03 1.537.1.169)
	[PATCH] simple preemption debug check
