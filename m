Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315450AbSEBWwl>; Thu, 2 May 2002 18:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315454AbSEBWwk>; Thu, 2 May 2002 18:52:40 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:43268 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S315450AbSEBWwZ> convert rfc822-to-8bit; Thu, 2 May 2002 18:52:25 -0400
Date: Thu, 2 May 2002 18:51:18 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.19-pre8
Message-ID: <Pine.LNX.4.21.0205021845430.10896-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi, 


Here goes the pre8. I plan just one more -pre before starting the -rc
stage.

One might ask why 2.4.19 is taking so long to be released. The reason are
the IDE changes: They need to be widely tested, its _really_ critical
code.



Summary of changes from v2.4.19-pre7 to v2.4.19-pre8
============================================

<arjanv@redhat.com> (02/04/04 1.220.5.2)
	Merge some new PCI IDs from 2.5.x e100 to eepro100 net driver.

<akpm@zip.com.au> (02/04/04 1.220.5.3)
	Various minor bug fixes for the 3c59x net driver.

<k.kasprzak@box43.pl> (02/04/05 1.385)
	dgrs net driver janitor fixes:

<santiago@newphoenix.net> (02/04/05 1.383.1.1)
	Update OSS ac97_codec driver to add special init and control

<davej@suse.de> (02/04/05 1.386)
	Cosmetic cleanups to 8139cp net driver.

<zwane@commfireservices.com> (02/04/05 1.387)
	Add power management support to 3c509 net driver.

<kraxel@bytesex.org> (02/04/15 1.383.10.1)
	backport 2.5.8 videodev fixes

<kraxel@bytesex.org> (02/04/15 1.383.10.2)
	adapt meye driver to videodev fixes

<wim@iguana.be> (02/04/16 1.383.2.35)
	Merged in Matt Domsch nowayout module option to override CONFIG_WATCHDOG_NOWAYOUT from the 2.5 kernel.

<stelian@popies.net> (02/04/17 1.383.11.1)
	Doclet for sonypi driver, as reported by Christoph Begall.

<stelian@popies.net> (02/04/17 1.383.11.2)
	fix an off by one bug in command line parameter parsing

<stelian@popies.net> (02/04/17 1.383.12.1)
	Fix meye driver request_irq bug.

<stelian@popies.net> (02/04/17 1.383.12.2)
	Enable the meye driver to get parameters on the kernel command line.

<akpm@zip.com.au> (02/04/17 1.383.13.1)
	[PATCH] add __LINE__ to out_of_line_bug()

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.2)
	[PATCH] PATCH: some configure.help updates

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.3)
	[PATCH] PATCH: more configure.help

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.4)
	[PATCH] PATCH: More configure.help

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.5)
	[PATCH] PATCH: more Configure.help

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.6)
	[PATCH] PATCH: maintainers update

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.7)
	[PATCH] PATCH: make cpu names clearer for new VIA

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.8)
	[PATCH] PATCH: dmi now handles boxes where apic enabling is bad

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.9)
	[PATCH] PATCH: via fix updates

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.10)
	[PATCH] PATCH: turn on ACPI SMP scan for hypedthreading

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.11)
	[PATCH] PATCH: optimisation - align the tlbstate

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.12)
	[PATCH] PATCH: shift apic mapping init and only if apic desired

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.13)
	[PATCH] PATCH: fix kernel memcpy prefetch

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.14)
	[PATCH] PATCH: newer mpt fusio works on ia64

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.15)
	[PATCH] PATCH: kernel printk levels for ia64 init

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.16)
	[PATCH] PATCH: kernel printk levels for mips32/mips64

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.17)
	[PATCH] PATCH: fix up printk levels for ppc

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.18)
	[PATCH] PATCH: fix s/390 cross compile

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.19)
	[PATCH] PATCH: second s/390 cross compile fix + printk levels

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.20)
	[PATCH] PATCH: printk levels for s390 64bit

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.21)
	[PATCH] PATCH: sparc printk levels

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.22)
	[PATCH] PATCH: printk levels for sh

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.23)
	[PATCH] PATCH: fix up some paride porting bits

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.24)
	[PATCH] PATCH: allow root to use sysctl to set the rtc limit

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.25)
	[PATCH] PATCH: add support for the earliest specialix sx variants

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.26)
	[PATCH] PATCH: (reminder) sak..

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.27)
	[PATCH] PATCH: fix smp watchdog build

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.28)
	[PATCH] PATCH: add byte counts to mkiss

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.29)
	[PATCH] PATCH: add mobility electronics parport

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.30)
	[PATCH] PATCH: fix pcmcia config properly

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.31)
	[PATCH] PATCH: fix region handling in isapnp

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.32)
	[PATCH] PATCH: Add aurora/telford tools wan drivers

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.33)
	[PATCH] PATCH: further osund copyfromuser bits

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.34)
	[PATCH] PATCH: some codec init updates

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.35)
	[PATCH] PATCH: minimal fixes for the emu10k crash with highmem bug

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.36)
	[PATCH] PATCH: handle setup_arg_pages fail

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.37)
	[PATCH] PATCH: printk levels for dcache

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.38)
	[PATCH] PATCH: inode.c printk

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.39)
	[PATCH] PATCH: fix unicode mishandling

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.40)
	[PATCH] PATCH: add prototypes for apic timer handling functions

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.41)
	[PATCH] PATCH: fix NLS unpack for UTF8

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.42)
	[PATCH] PATCH: more PCI idents

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.43)
	[PATCH] PATCH: missing tr_source_route prototype

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.44)
	[PATCH] PATCH: expose tr_source_route

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.45)
	[PATCH] PATCH: save .config for rpm

<bcrl@redhat.com> (02/04/17 1.383.13.46)
	[PATCH] Fix /proc/slabinfo memory overflow

<tim@physik3.uni-rostock.de> (02/04/17 1.383.13.47)
	[PATCH] fix up incorrect jiffies compare fix

<khalid@fc.hp.com> (02/04/18 1.383.13.50)
	[PATCH] serial ports moved on i386 in 2.4.19-pre7

<tigran@aivazian.name> (02/04/18 1.383.13.51)
	[PATCH] fix compiler warning in microcode driver

<trond.myklebust@fys.uio.no> (02/04/18 1.383.13.52)
	[PATCH] Fix tcp_read_sock()

<trond.myklebust@fys.uio.no> (02/04/18 1.383.13.53)
	[PATCH] Do RPC over TCP reads in the bh fastpath...

<aia21@cus.cam.ac.uk> (02/04/18 1.383.13.54)
	[PATCH] Fix LDM compilation.

<davem@nuts.ninka.net> (02/04/18 1.383.11.6)
	Sparc64 fixes:

<trond.myklebust@fys.uio.no> (02/04/18 1.383.15.1)
	xprt.c:

<tony@cantech.net.au> (02/04/18 1.383.16.1)
	[PATCH] Change "return EBLAH" to "return -EBLAH in drivers/*

<greg@kroah.com> (02/04/18 1.383.16.2)
	USB whiteheat firmware

<greg@kroah.com> (02/04/18 1.383.16.3)
	USB whiteheat driver

<greg@kroah.com> (02/04/18 1.383.16.4)
	USB wacom driver

<johannes@erdfelt.com> (02/04/18 1.383.16.5)
	[PATCH] Re: removing sleep_on in hub.c

<david-b@pacbell.net> (02/04/18 1.383.16.6)
	[PATCH] USB devio device removal fix

<david-b@pacbell.net> (02/04/18 1.383.16.7)
	[PATCH] USB GeneLink/NDIS tweaks

<greg@kroah.com> (02/04/18 1.383.16.8)
	MAINTAINERS

<greg@kroah.com> (02/04/18 1.383.16.9)
	USB storage

<david-b@pacbell.net> (02/04/18 1.383.16.10)
	[PATCH] EHCI and Intel/VIA/Philips/...

<oliver@neukum.name> (02/04/18 1.383.16.11)
	[PATCH] added device id for hpusbscsi

<greg@kroah.com> (02/04/18 1.383.16.12)
	removed duplicate MATAINERS entry for Petko

<Robert.Olsson@data.slu.se> (02/04/18 1.383.17.1)
	Net pktgen updates:

<buytenh@gnu.org> (02/04/18 1.383.17.2)
	Bridging fix:

<davem@nuts.ninka.net> (02/04/19 1.383.11.7)
	Sparc: Pass sigcontext in to signal handlers properly

<davem@nuts.ninka.net> (02/04/21 1.383.11.8)
	ATYFB driver gcc-3.1 build fix: Dont put const object into initdata.

<davem@nuts.ninka.net> (02/04/22 1.383.11.9)
	PM2FB driver gcc-3.1 build fix: Dont put const object into initdata.

<davem@nuts.ninka.net> (02/04/22 1.383.11.10)
	Sparc64 ebus: Kill __FUNCTION__ pasting.

<rusty@rustcorp.com.au> (02/04/22 1.383.18.1)
	[PATCH] TRIVIAL 2.4.19-pre7: i386_pci-pc.c warning

<davem@nuts.ninka.net> (02/04/23 1.383.11.11)
	SunGEM bug fix:

<kuznet@ms2.inr.ac.ru> (02/04/23 1.383.17.3)
	Net fixes:

<buytenh@gnu.org> (02/04/23 1.383.17.4)
	Bridging fix:

<marcelo@plucky.distro.conectiva> (02/04/23 1.383.18.3)
	Update NBD URL

<rusty@rustcorp.com.au> (02/04/23 1.383.18.4)
	[PATCH] TRIVIAL 2.4.19-pre7: newline in printk in olympic driver

<rusty@rustcorp.com.au> (02/04/23 1.383.18.5)
	[PATCH] TRIVIAL 2.4.19-pre7: Configure.help "neet" typo fix:

<rusty@rustcorp.com.au> (02/04/23 1.383.18.6)
	[PATCH] TRIVIAL 2.4.19-pre7: request_region in acornscsi.c

<rusty@rustcorp.com.au> (02/04/23 1.383.18.7)
	[PATCH] TRIVIAL 2.4.19-pre7: drivers_net_dl2k.c __devinit's

<rusty@rustcorp.com.au> (02/04/23 1.383.18.8)
	[PATCH] TRIVIAL 2.4.19-pre7: drivers_net_sis900.c: misiing

<rusty@rustcorp.com.au> (02/04/23 1.383.18.9)
	[PATCH] TRIVIAL 2.4.19-pre7: drivers_net_eepro100: missing

<marcelo@plucky.distro.conectiva> (02/04/23 1.383.18.10)
	Revert Christoph's end_buffer_io_kiobuf change

<rgooch@ras.ucalgary.ca> (02/04/23 1.383.18.11)
	[PATCH] devfs update

<rusty@rustcorp.com.au> (02/04/23 1.383.18.12)
	[PATCH] TRIVIAL 2.4.19-pre7: Message changed in libc

<trini@kernel.crashing.org> (02/04/23 1.383.2.37)
	[PATCH] Add GPL v2 note to some PPC files

<maxk@qualcomm.com> (02/04/23 1.383.2.38)
	GCCs older than 2.95 do not like __func__ thing, patch provided below fixes 

<maxk@qualcomm.com> (02/04/23 1.383.2.39)
	This patch fixes HCI filter misbehavior on 64 bit platforms.

<Andries.Brouwer@cwi.nl> (02/04/23 1.383.2.40)
	[PATCH] In kd.h K_NUMLOCK/K_CAPSLOCK definitions are interchanged

<rusty@rustcorp.com.au> (02/04/23 1.383.2.41)
	[PATCH] TRIVIAL 2.4.19-pre7: netfilter overlap calc

<rusty@rustcorp.com.au> (02/04/23 1.383.2.42)
	[PATCH] TRIVIAL 2.4.19-pre7: Warn about ioctl collision

<rusty@rustcorp.com.au> (02/04/23 1.383.2.43)
	[PATCH] TRIVIAL 2.4.19-pre7: make TAGS to work with bitkeeper

<geert@linux-m68k.org> (02/04/23 1.383.2.44)
	Update MVME i82596 Ethernet driver

<geert@linux-m68k.org> (02/04/23 1.383.2.45)
	[PATCH] Yearly m68k update (part 43)

<geert@linux-m68k.org> (02/04/23 1.383.2.46)
	[PATCH] Yearly m68k update (part 44)

<geert@linux-m68k.org> (02/04/23 1.383.2.47)
	[PATCH] Yearly m68k update (part 45)

<geert@linux-m68k.org> (02/04/23 1.383.2.48)
	[PATCH] Yearly m68k update (part 46)

<geert@linux-m68k.org> (02/04/23 1.383.2.49)
	[PATCH] Yearly m68k update (part 47)

<geert@linux-m68k.org> (02/04/23 1.383.2.50)
	[PATCH] Yearly m68k update (part 48)

<geert@linux-m68k.org> (02/04/23 1.383.2.51)
	[PATCH] Yearly m68k update (part 49)

<geert@linux-m68k.org> (02/04/23 1.383.2.52)
	[PATCH] Yearly m68k update (part 50)

<geert@linux-m68k.org> (02/04/23 1.383.2.53)
	[PATCH] Yearly m68k update (part 51)

<geert@linux-m68k.org> (02/04/23 1.383.2.54)
	[PATCH] Yearly m68k update (part 52)

<geert@linux-m68k.org> (02/04/23 1.383.2.55)
	[PATCH] Yearly m68k update (part 53)

<geert@linux-m68k.org> (02/04/23 1.383.2.56)
	[PATCH] Yearly m68k update (part 54)

<geert@linux-m68k.org> (02/04/23 1.383.2.57)
	[PATCH] Yearly m68k update (part 55)

<geert@linux-m68k.org> (02/04/23 1.383.2.58)
	[PATCH] Yearly m68k update (part 56)

<geert@linux-m68k.org> (02/04/23 1.383.2.59)
	[PATCH] Yearly m68k update (part 57)

<geert@linux-m68k.org> (02/04/23 1.383.2.60)
	[PATCH] atyfb initdata

<rusty@rustcorp.com.au> (02/04/23 1.383.2.61)
	[PATCH] TRIVIAL 2.4.19-pre7: request_region for via82c505.c

<rusty@rustcorp.com.au> (02/04/23 1.383.2.62)
	[PATCH] TRIVIAL 2.4.19-pre7: msbusmouse.c

<rusty@rustcorp.com.au> (02/04/23 1.383.2.63)
	[PATCH] TRIVIAL 2.4.19-pre7: logibusmouse.c

<rusty@rustcorp.com.au> (02/04/23 1.383.2.64)
	[PATCH] TRIVIAL 2.4.19-pre7: smp_call_function not allowed from bh

<rusty@rustcorp.com.au> (02/04/23 1.383.2.65)
	[PATCH] TRIVIAL 2.4.19-pre7: net_ipv6_sit.c wrong net_device

<alan@lxorguk.ukuu.org.uk> (02/04/23 1.383.2.66)
	[PATCH] PATCH: updated IBM ServeRAID driver

<kuebelr@email.uc.edu> (02/04/23 1.383.2.67)
	[PATCH] spelling mistakes

<marcelo@plucky.distro.conectiva> (02/04/23 1.383.2.68)
	Fix nfs_create_request to not wip current->policy

<trond.myklebust@fys.uio.no> (02/04/23 1.383.2.70)
	[PATCH] Fix warnings from sunrpc tcp changes

<trini@kernel.crashing.org> (02/04/23 1.383.2.71)
	[PATCH] Fixup drivers/Makefile for drivers/macintosh as well

<marcelo@plucky.distro.conectiva> (02/04/23 1.383.2.72)
	cpqarray driver update 

<Martin.Bligh@us.ibm.com> (02/04/23 1.383.2.73)
	[PATCH] stop NULL pointer dereference in __alloc_pages

<greg@kroah.com> (02/04/23 1.383.2.74)
	[PATCH] PCI Hotplug Config.in fix

<greg@kroah.com> (02/04/23 1.383.2.75)
	[PATCH] IBM PCI Hotplug fix

<marcelo@plucky.distro.conectiva> (02/04/23 1.383.2.76)
	Kees Cook email address changed

<davem@nuts.ninka.net> (02/04/24 1.383.17.5)
	Kill in_ntoa from the tree.  Use NIPQUAD instead.

<ebrower@usa.net> (02/04/24 1.383.11.12)
	Add Sparc Voyager power management support.

<davem@nuts.ninka.net> (02/04/24 1.383.17.6)
	Tigon3: Handle posted writes correctly.

<kaber@trash.net> (02/04/24 1.383.17.7)
	In pfifo packet scheduler use qdisc->dev

<trini@kernel.crashing.org> (02/04/24 1.383.17.8)
	Do not ask about ECONET suboptions

<tetapi@utu.fi> (02/04/25 1.383.11.13)
	SunGEM:

<anton@samba.org> (02/04/25 1.383.11.14)
	Sparc64 ioctl32 updates:

<davem@nuts.ninka.net> (02/04/26 1.383.11.15)
	Sparc64:

<stelian@popies.net> (02/04/29 1.383.19.1)
	Allow multiple processes to open the sonypi device

<bjorn.wesen@axis.com> (02/04/29 1.383.2.78)
	Cris arch update

<twaugh@redhat.com> (02/04/29 1.383.2.79)
	[PATCH] 2.4.19-pre7: SIIG cards

<twaugh@redhat.com> (02/04/29 1.383.2.80)
	[PATCH] 2.4.19-pre7: kernel-doc-nano-HOWTO fix

<hch@infradead.org> (02/04/29 1.383.2.81)
	[PATCH] x86 init cleanups

<hch@infradead.org> (02/04/29 1.383.2.82)
	[PATCH] optimize initialization of struct kiobuf

<hch@infradead.org> (02/04/29 1.383.2.83)
	[PATCH] fix Config.in breakage

<bcrl@redhat.com> (02/04/29 1.383.2.84)
	[PATCH] vsnprintf returns incorrect length

<hch@infradead.org> (02/04/29 1.383.2.85)
	[PATCH] sb_set_blocksize/sb_min_blocksize

<hch@infradead.org> (02/04/29 1.383.2.86)
	[PATCH] give important spinlocks their own cachelign

<davem@nuts.ninka.net> (02/04/29 1.383.11.16)
	Sparc64 fix pagetable leak:

<marcelo@plucky.distro.conectiva> (02/04/29 1.383.2.88)
	PPC64 update

<maxk@qualcomm.com> (02/04/29 1.383.2.89)
	Add support for ATM Ethernet bridging (RFC 2684)

<rob@osinvestor.com> (02/04/30 1.383.2.90)
	[PATCH] drivers/char/eurotechwdt.c

<mlocke@mvista.com> (02/04/30 1.383.2.91)
	Add 8xx PCMCIA socket driver

<neilb@cse.unsw.edu.au> (02/04/30 1.383.2.92)
	[PATCH] MicroMemory battery backed PCI RAM card support

<david@gibson.dropbear.id.au> (02/04/30 1.383.2.93)
	[PATCH] Update for orinoco driver

<adilger@clusterfs.com> (02/04/30 1.383.2.94)
	[PATCH] minor cleanup in ext3 code

<hch@infradead.org> (02/04/30 1.383.2.95)
	[PATCH] kill code duplication in buffer handling

<rob@osinvestor.com> (02/04/30 1.383.2.96)
	[PATCH] drivers/char/shwdt.c

<wstinson@infonie.fr> (02/05/01 1.389)
	request_region janitor update for sdla wan driver

<wstinson@infonie.fr> (02/05/01 1.390)
	baycom_ser_fdx hamradio driver request_region janitor updates:

<wstinson@infonie.fr> (02/05/01 1.383.1.3)
	request_region janitor update for megaraid scsi driver:

<wstinson@infonie.fr> (02/05/01 1.383.1.4)
	request_region janitor updates for ultrastor scsi driver:

<tony@cantech.net.au> (02/05/01 1.383.1.5)
	s/-Efoo/Efoo/ cleanup for drivers:

<ShingChuang@via.com.tw> (02/05/01 1.391)
	Add support for new chip to via-rhine net driver.

<mufasa@sis.com.tw> (02/05/01 1.392)
	Add support for SiS962 phy to sis900 net driver.

<andrea@suse.de> (02/05/02 1.383.2.97)
	[PATCH] Fix setitimer deadlock

<viro@math.psu.edu> (02/05/02 1.383.2.98)
	[PATCH] Fix UFS block size checks

<axboe@suse.de> (02/05/02 1.394)
	[PATCH] cdrom changer load timeout

<maxk@qualcomm.com> (02/05/02 1.397)
	[PATCH] 2.4.19-pre7 TUN/TAP driver readv/writev support

<hch@infradead.org> (02/05/02 1.398)
	[PATCH] add definition of yield()

<trini@kernel.crashing.org> (02/05/02 1.399)
	[PATCH] Fix winbond compile dependancy

<mason@suse.com> (02/05/02 1.400)
	[PATCH] reiserfs 64 bit fix

<barrow_dj@yahoo.com> (02/05/02 1.401)
	[PATCH] Fix SMP race condition on startup

<hermes@gibson.dropbear.id.au> (02/05/02 1.402)
	[PATCH] Orinoco 0.11b update

<marcelo@plucky.distro.conectiva> (02/05/02 1.403)
	Changed EXTRAVERSION to pre8

<marcelo@plucky.distro.conectiva> (02/05/02 1.404)
	Undo removal of __init from init_idle

Summary of changes from v2.4.19-pre6 to v2.4.19-pre7
============================================

<davem@nuts.ninka.net> (02/03/26 1.189.1.19)
	SunHME driver updates:

<davem@nuts.ninka.net> (02/03/27 1.181.2.39)
	Tigon3 net driver fixes:

<davem@nuts.ninka.net> (02/03/27 1.189.1.20)
	In SBUS probing, handle empty SBUS correctly.

<davem@nuts.ninka.net> (02/03/27 1.181.2.40)
	Tigon3 net driver bug fix:

<davem@nuts.ninka.net> (02/03/28 1.189.1.21)
	Make for_all_sbusdev handle an empty SBUS properly.

<davem@nuts.ninka.net> (02/03/28 1.181.2.41)
	Tigon3 driver update:

<rmk@flint.arm.linux.org.uk> (02/03/30 1.294.1.1)
	Prevent selection of ARM options with non-ARM architectures

<davem@nuts.ninka.net> (02/03/30 1.181.2.42)
	net/core/sock.c needs linux/tcp.h to get at TCP state macros.

<kai@tp1.ruhr-uni-bochum.de> (02/03/31 1.300.2.1)
	Use iounmap on ioremap'ed area.

<davem@nuts.ninka.net> (02/04/03 1.181.2.43)
	In tcp_sendmsg, make sure we jump to the out label

<davem@nuts.ninka.net> (02/04/03 1.181.2.44)
	Tigon3 driver pci_unmap_foo changes were half complete,

<davem@nuts.ninka.net> (02/04/04 1.189.1.22)
	Sparc64's flush_thread needs to initialize the PGD cache

<davem@nuts.ninka.net> (02/04/04 1.335.1.1)
	RTL8150 USB driver needs linux/init.h

<davem@nuts.ninka.net> (02/04/04 1.335.1.2)
	drivers/ieee1394/ohci1394.h uses readl/writel so it

<akpm@zip.com.au> (02/04/05 1.378)
	[PATCH] BUG bits

<marcelo@plucky.distro.conectiva> (02/04/05 1.379)
	added missing include

<trini@kernel.crashing.org> (02/04/05 1.382)
	[PATCH] Curse into drivers/macintosh on CONFIG_PPC

<viro@math.psu.edu> (02/04/05 1.383)
	[PATCH] fix for leak in get_anon_super()

<kaos@ocs.com.au> (02/04/07 1.383.2.1)
	[PATCH] 2.4.19-pre6 standardize {aic7xxx,aicasm}/Makefile

<kaos@ocs.com.au> (02/04/07 1.383.2.2)
	[PATCH] 2.4.19-pre6 standardize aacraid/Makefile

<prom@berlin.ccc.de> (02/04/07 1.383.2.3)
	[PATCH] radeonfb accelerator id in 2.4.19

<EdV@macrolink.com> (02/04/07 1.383.2.4)
	[PATCH] serial driver procfs 2.4.19-pre6

<hch@infradead.org> (02/04/07 1.383.2.5)
	[PATCH] highmem setup

<wim@iguana.be> (02/04/07 1.383.2.6)
	[PATCH] 2.4.19-pre6 i8xx series chipsets patches

<wim@iguana.be> (02/04/07 1.383.2.7)
	[PATCH] 2.4.19-pre6 i8xx series chipsets patches

<wim@iguana.be> (02/04/07 1.383.2.8)
	[PATCH] 2.4.19-pre6 i8xx series chipsets patches

<kanoj@vger.kernel.org> (02/04/08 1.189.1.23)
	get_cycles() needs to be defined

<davem@nuts.ninka.net> (02/04/08 1.189.1.24)
	In math-emu/op-common.h:FP_FROM_INT, correct handling of

<davem@nuts.ninka.net> (02/04/08 1.189.1.25)
	Sparc64 math-emu fix:

<davem@nuts.ninka.net> (02/04/08 1.335.1.3)
	Generate dependencies in include/math-emu

<davem@nuts.ninka.net> (02/04/08 1.189.1.26)
	Update sparc64 defconfig.

<davem@nuts.ninka.net> (02/04/08 1.335.1.4)
	Use include <math-emu/foo.h> instead of "foo.h" in

<johannes@erdfelt.com> (02/04/08 1.383.3.1)
	[PATCH] uhci.c 2.4.19-pre6 SMP deadlock

<johannes@erdfelt.com> (02/04/08 1.383.3.2)
	[PATCH] uhci.c 2.4.19-pre6 cleanup

<johannes@erdfelt.com> (02/04/08 1.383.3.3)
	[PATCH] uhci.c 2.4.19-pre6 incorrect locking

<johannes@erdfelt.com> (02/04/08 1.383.3.4)
	[PATCH] uhci.c 2.4.19-pre6 FSBR speed problem

<greg@kroah.com> (02/04/08 1.383.3.5)
	added Petko's maintainer info for the rtl8150 USB driver.

<greg@kroah.com> (02/04/08 1.383.3.6)
	USB visor driver

<msw@redhat.com> (02/04/08 1.383.3.7)
	USB wacom driver.

<greg@kroah.com> (02/04/08 1.383.3.8)
	USB usb-uhci driver

<davem@nuts.ninka.net> (02/04/09 1.189.1.27)
	Sparc64: Fix elf_gregset_t layout for native 64-bit binaries.

<davem@nuts.ninka.net> (02/04/09 1.335.1.5)
	Fix typo in previous math-emu/soft-fp.h changes

<bcrl@redhat.com> (02/04/10 1.181.2.45)
	Rearrange some int members of

<trini@kernel.crashing.org> (02/04/10 1.181.2.46)
	CONFIG_APPLETALK and

<davem@nuts.ninka.net> (02/04/10 1.335.1.6)
	drivers/ide/ide.c: Do not assume u64 == unsigned long long

<davem@nuts.ninka.net> (02/04/10 1.335.1.7)
	drivers/ide/ide-proc.c: Do not assume u64 == unsigned long long

<rddunlap@osdl.org> (02/04/10 1.181.2.47)
	Remove bogus networking stats

<uzi@uzix.org> (02/04/10 1.189.1.28)
	Sparc32 fixes:

<laforge@gnumonks.org> (02/04/10 1.181.2.48)
	IPv6 netfilter fixes:

<trond.myklebust@fys.uio.no> (02/04/10 1.181.2.49)
	Add tcp_read_sock which allows one to

<davem@nuts.ninka.net> (02/04/10 1.383.4.2)
	fs/nfsd/nfsctl.c: Include linux/init.h

<akpm@zip.com.au> (02/04/11 1.383.4.4)
	[PATCH] fix ext3 i_blocks accounting

<rgooch@ras.ucalgary.ca> (02/04/11 1.383.4.5)
	[PATCH] devfs update

<rml@tech9.net> (02/04/11 1.383.4.6)
	[PATCH] Re: [PATCH] 2.4: reserve syscalls from 2.5

<hch@infradead.org> (02/04/11 1.383.4.7)
	[PATCH] rlimit vs bdev in pagecache

<hch@infradead.org> (02/04/11 1.383.4.8)
	[PATCH] really write out inodes

<hch@infradead.org> (02/04/11 1.383.4.9)
	[PATCH] forward raw device ioctls

<hch@infradead.org> (02/04/11 1.383.4.10)
	[PATCH] kmem_cache_shrink return value

<rusty@rustcorp.com.au> (02/04/11 1.383.4.11)
	[PATCH] Re: [PATCH] TRIVIAL 2.4.19-pre5: adjtimex and SINGLESHOT

<zaitcev@redhat.com> (02/04/11 1.383.4.12)
	[PATCH] sd.c and 128 SCSI disks

<benh@kernel.crashing.org> (02/04/11 1.383.2.11)
	This patch updates several of the PPC-specific drivers in

<paulus@samba.org> (02/04/11 1.383.2.12)
	[PATCH] PPC update for 2.4.19-pre6

<marcelo@plucky.distro.conectiva> (02/04/11 1.383.2.13)
	Added missing "linux/init.h" include.

<jbglaw@lug-owl.de> (02/04/11 1.383.2.14)
	[PATCH] Update for ./arch/alpha/kernel/srm_env.c driver

<bjorn_helgaas@hp.com> (02/04/11 1.383.2.15)
	[PATCH] [PATCH] agpgart support for HP ZX1

<hch@infradead.org> (02/04/11 1.383.2.16)
	[PATCH] OOM killer updates

<riel@conectiva.com.br> (02/04/11 1.383.2.17)
	[PATCH] remove compiler.h from mmap.c

<marcelo@plucky.distro.conectiva> (02/04/12 1.383.2.18)
	Changed ext2/ext3 MAINTAINERS file entries

<kai@tp1.ruhr-uni-bochum.de> (02/04/14 1.383.9.1)
	Add support for ISDN card USR PCI TA

<marc@mbsi.ca> (02/04/15 1.383.2.19)
	[PATCH] yet another VAIO dmi_blacklist entry

<maxk@qualcomm.com> (02/04/15 1.383.2.20)
	Bluetooth subsystem sync up

<gibbs@scsiguy.com> (02/04/15 1.383.2.21)
	[PATCH] sd.c fixes applied incorectly to 2.4.19-preXX

<gibbs@scsiguy.com> (02/04/15 1.383.2.22)
	[PATCH] Aic7xxx driver version 6.2.6

<hch@infradead.org> (02/04/15 1.383.2.24)
	[PATCH] disable APIC when broken mptable is found

<hch@infradead.org> (02/04/15 1.383.2.25)
	[PATCH] mem= command lines fixes.

<hch@infradead.org> (02/04/15 1.383.2.26)
	[PATCH] unlock buffer_head _after_ end_kio_request

<hch@infradead.org> (02/04/15 1.383.2.27)
	[PATCH] allow forcing APIC mode

<kaos@ocs.com.au> (02/04/15 1.383.2.28)
	[PATCH] Standardise the frame pointer compile option

<arjanv@redhat.com> (02/04/15 1.383.2.29)
	[PATCH] Add missing ataraid entries

<khalid_aziz@hp.com> (02/04/15 1.383.2.30)
	[PATCH] HCDP serial ports

<marcelo@plucky.distro.conectiva> (02/04/16 1.383.2.31)
	Add missing code from the IDE merge

<hch@infradead.org> (02/04/16 1.383.2.32)
	[PATCH] generate nice manpages from kernel-doc

<marcelo@plucky.distro.conectiva> (02/04/16 1.383.2.33)
	Changed EXTRAVERSION to pre7

<marcelo@plucky.distro.conectiva> (02/04/16 1.383.2.34)
	Removed duplicated init.h include

Summary of changes from v2.4.19-pre5 to v2.4.19-pre6
============================================

<vojtech@suse.cz> (02/04/01 1.311)
	[PATCH] Fixes for non-legacy gameports.

<manfred@colorfullife.com> (02/04/01 1.312)
	[PATCH] block/IDE/interrupt lockup fix

<martin@meltin.net> (02/04/01 1.313)
	[PATCH] Patch to pull NFS server address off root_server_path

<akpm@zip.com.au> (02/04/01 1.314)
	[PATCH] Let all hptraid ioctls to throught the block layer

<viro@math.psu.edu> (02/04/01 1.315)
	Cleans do_remount_sb() up and docbookifies it.

<viro@math.psu.edu> (02/04/01 1.316)
	Slightly cleans up the handling of anon. devices,

<viro@math.psu.edu> (02/04/01 1.317)
	Obvious cleanups in get_sb_bdev().

<viro@math.psu.edu> (02/04/01 1.318)
	* capability check moved from do_kern_mount() into do_add_mount().

<viro@math.psu.edu> (02/04/01 1.319)
	rootfs made an alias of ramfs.

<viro@math.psu.edu> (02/04/01 1.320)
	Removes lock_super()/unlock_super() from callers of ->read_super().

<viro@math.psu.edu> (02/04/01 1.321)
	mount_sem turned into rwsem.  The only reader is handling of

<viro@math.psu.edu> (02/04/01 1.322)
	turns (mount_sem,vfsmntlist,root_vfsmnt) into per-process object

<viro@math.psu.edu> (02/04/01 1.323)
	makes /proc/mounts a symlink to /proc/<pid>/mounts.

<viro@math.psu.edu> (02/04/01 1.324)
	kills set_devname(), makes "name" an argument of alloc_vfsmnt().

<bcrl@redhat.com> (02/04/01 1.325)
	The patch below fixes a problem whereby a vma which has its vm_start 

<arjanv@redhat.com> (02/04/02 1.326)
	[PATCH] dma_addr_t vs highmem

<greg@kroah.com> (02/04/02 1.300.3.1)
	USB visor driver

<greg@kroah.com> (02/04/02 1.300.3.2)
	USB HID driver fixes

<bhards@bigpond.net.au> (02/04/02 1.300.3.3)
	USB CDCEther driver update

<petkan@mastika.lnxw.com> (02/04/02 1.300.3.4)
	USB

<david-b@pacbell.net> (02/04/02 1.300.3.5)
	USB hcd core

<david-b@pacbell.net> (02/04/02 1.300.3.6)
	USB ohci driver fixes

<petkan@mastika.lnxw.com> (02/04/02 1.300.3.7)
	USB pegasus driver

<suse.cz@mastika.lnxw.com> (02/04/02 1.300.3.8)
	USB 

<johannes@erdfelt.com> (02/04/02 1.300.3.9)
	USB uhci

<greg@kroah.com> (02/04/02 1.300.3.10)
	USB

<stelian@popies.net> (02/04/03 1.327)
	Enable more accurate events on Vaio laptops without a jogdial (FX series)

<kaos@ocs.com.au> (02/04/03 1.326.1.1)
	[PATCH] 2.4.19-pre5 Makefile standardization

<jaharkes@cs.cmu.edu> (02/04/03 1.326.1.2)
	[PATCH] 2.4.19-pre5 Coda update

<marcelo@plucky.distro.conectiva> (02/04/03 1.326.1.3)
	Removed the EXPERIMENTAL mark of fs/Config.in ext3 entry.

<marcelo@plucky.distro.conectiva> (02/04/03 1.329)
	Cosmetic fix to avoid the agpgart detection 

<rml@tech9.net> (02/04/03 1.330)
	[PATCH] 2.4: BUG_ON (1/2)

<rml@tech9.net> (02/04/03 1.331)
	[PATCH] 2.4: BUG_ON (2/2)

<marcelo@plucky.distro.conectiva> (02/04/03 1.332)
	Re add MWAVE Config.in entry

<rusty@rustcorp.com.au> (02/04/03 1.333)
	[PATCH] TRIVIAL 2.4.19-pre5: PPC leapyear fix

<marcelo@plucky.distro.conectiva> (02/04/03 1.334)
	Add ALi 1644 support to AGP

<bcrl@redhat.com> (02/04/04 1.335)
	[PATCH] Update mmap patch

<sam@minnie.(none)> (02/04/04 1.326.2.1)
	tlan.c:

<ioshadij@hotmail.com> (02/04/04 1.336)
	[PATCH] kjournald locking fix

<alan@lxorguk.ukuu.org.uk> (02/04/04 1.337)
	[PATCH] PATCH: regenerated against new tree - Configs

<alan@lxorguk.ukuu.org.uk> (02/04/04 1.338)
	[PATCH] PATCH: make indydog use long for bitops

<alan@lxorguk.ukuu.org.uk> (02/04/04 1.339)
	[PATCH] PATCH: wdt285 error returns

<alan@lxorguk.ukuu.org.uk> (02/04/04 1.340)
	[PATCH] PATCH: silly doc fix

<alan@lxorguk.ukuu.org.uk> (02/04/04 1.341)
	[PATCH] PATCH: also add bridge resources to resource tree

<alan@lxorguk.ukuu.org.uk> (02/04/04 1.342)
	[PATCH] PATCH: returns on error fixes for sound

<alan@lxorguk.ukuu.org.uk> (02/04/04 1.343)
	[PATCH] PATCH: make the mad16 use the newer input/gameport api right

<alan@lxorguk.ukuu.org.uk> (02/04/04 1.344)
	[PATCH] PATCH: yet more sound error returns

<alan@lxorguk.ukuu.org.uk> (02/04/04 1.345)
	[PATCH] PATCH: and one or two more for luck 8)

<alan@lxorguk.ukuu.org.uk> (02/04/04 1.346)
	[PATCH] PATCH: only flush block on the last close

<alan@lxorguk.ukuu.org.uk> (02/04/04 1.347)
	[PATCH] PATCH: missing neomagic include bits

<hch@infradead.org> (02/04/04 1.348)
	[PATCH] SARD

<viro@math.psu.edu> (02/04/04 1.349)
	[PATCH] IS_DEADDIR() checks

<rusty@rustcorp.com.au> (02/04/04 1.350)
	[PATCH] TRIVIAL 2.4.19-pre5: documentation fix

<trini@kernel.crashing.org> (02/04/04 1.351)
	[PATCH] Don't always ask about Intel or AMD RNGs

<rusty@rustcorp.com.au> (02/04/05 1.353)
	[PATCH] TRIVIAL 2.4.19-pre5: fcntl (F_DUPFD) return

<neilb@cse.unsw.edu.au> (02/04/05 1.354)
	[PATCH] PATCH 1 of 16 - Fix problems with raid1 resync code.

<neilb@cse.unsw.edu.au> (02/04/05 1.355)
	[PATCH] PATCH 2 of 16 - Flush out final sync requests on an idle system.

<neilb@cse.unsw.edu.au> (02/04/05 1.356)
	[PATCH] PATCH 3 of 16 - Remove exp_find, it is never used

<neilb@cse.unsw.edu.au> (02/04/05 1.357)
	[PATCH] PATCH 4 of 16 - read_lock the export table when lockd calls

<neilb@cse.unsw.edu.au> (02/04/05 1.358)
	[PATCH] PATCH 5 of 16 - Fix possible leak of mnt/dentry references.

<neilb@cse.unsw.edu.au> (02/04/05 1.359)
	[PATCH] PATCH 6 of 16 - Use MKDEV for making device number from components

<neilb@cse.unsw.edu.au> (02/04/05 1.360)
	[PATCH] PATCH 7 of 16 - Central updating of fh_stale statistics.

<neilb@cse.unsw.edu.au> (02/04/05 1.361)
	[PATCH] PATCH 8 of 16 - Get nfsd_setattr to not put too much weight on

<neilb@cse.unsw.edu.au> (02/04/05 1.362)
	[PATCH] PATCH 9 of 16 - Tidy up some vfs calls in nfsd

<neilb@cse.unsw.edu.au> (02/04/05 1.363)
	[PATCH] PATCH 12 of 16 - Stop fat_fh_to_dentry returning NULL + set

<neilb@cse.unsw.edu.au> (02/04/05 1.364)
	[PATCH] PATCH 10 of 16 - Cleanup the syscall interface to nfsd

<neilb@cse.unsw.edu.au> (02/04/05 1.365)
	[PATCH] PATCH 13 of 16 - Tidy up exp_get code

<neilb@cse.unsw.edu.au> (02/04/05 1.366)
	[PATCH] PATCH 14 of 16 - Change exports hash lists to list.h lists

<neilb@cse.unsw.edu.au> (02/04/05 1.367)
	[PATCH] PATCH 15 of 16 - Link exports for a given client together

<neilb@cse.unsw.edu.au> (02/04/05 1.368)
	[PATCH] PATCH 16 of 16 - Change /proc/fs/nfs/exports to use seq_file

<viro@math.psu.edu> (02/04/05 1.369)
	kills floppy_eject(), replacing it with normal open()/ioctl()/close().

<viro@math.psu.edu> (02/04/05 1.370)
	moves initrd-related options (rd_doload, etc.) into do_mounts.c

<viro@math.psu.edu> (02/04/05 1.371)
	switches wait_for_keypress() to normal syscalls.

<viro@math.psu.edu> (02/04/05 1.372)
	moves devfs_make_root() to do_mounts.c and cleans it up.

<Lionel.Bouton@inet6.fr> (02/04/05 1.373)
	[PATCH] Against 2.4.19-pre5, Bugfixes

<kaos@ocs.com.au> (02/04/05 1.374)
	[PATCH] 2.4.19-pre5 prevent user space includes

<marcelo@plucky.distro.conectiva> (02/04/05 1.375)
	Changed EXTRAVERSION to pre6

<neilb@cse.unsw.edu.au> (02/04/05 1.376)
	[PATCH] Re: PATCH 11 of 16 - Tidyup init/exit fof nfsd module

Summary of changes from v2.4.19-pre4 to v2.4.19-pre5
============================================

<sawa@yamamoto.gr.jp> (02/03/15 1.197.1.1)
	Fix bug in at1700 net driver:

<jgarzik@mandrakesoft.com> (02/03/15 1.197.1.2)
	pcnet32 net driver update 1/6:

<anton@samba.org> (02/03/15 1.197.1.3)
	pcnet32 net driver updates 2/6:

<anton@samba.org> (02/03/15 1.197.1.4)
	pcnet32 net driver updates 3/6:

<anton@samba.org> (02/03/15 1.197.1.5)
	pcnet32 net driver updates 4/6:

<anton@samba.org> (02/03/15 1.197.1.6)
	pcnet32 net driver updates 5/6:

<anton@samba.org> (02/03/15 1.197.1.7)
	pcnet32 net driver updates 6/6:

<jes@wildopensource.com> (02/03/15 1.197.1.8)
	acenic gige net driver update:

<jes@wildopensource.com> (02/03/15 1.197.1.9)
	acenic driver fixes:

<jt@bougret.hpl.hp.com> (02/03/15 1.197.1.10)
	Convert hp100 net driver to PCI DMA mapping API.

<jgarzik@mandrakesoft.com> (02/03/15 1.197.1.11)
	Don't include linux/delay.h twice in eepro100 net driver.

<davem@nuts.ninka.net> (02/03/19 1.181.2.10)
	Netfilter enhancement from Harald Welte and Netfilter team.

<kuznet@ms2.inr.ac.ru> (02/03/19 1.181.2.11)
	Remove obsolete confusing instructions on tcp_max_syn_backlog

<kuznet@ms2.inr.ac.ru> (02/03/19 1.181.2.12)
	Make pkt_sched.h:PSCHED_TDIFF_SAFE behave sane when measuring

<kuznet@ms2.inr.ac.ru> (02/03/19 1.181.2.13)
	Remove unused field from TCP struct open_request.

<kuznet@ms2.inr.ac.ru> (02/03/19 1.181.2.14)
	Do not fail creating _new_ NOARP entry with EPERM.

<kuznet@ms2.inr.ac.ru> (02/03/19 1.181.2.15)
	Old bug in skbuff.c, found by someone, but was lost.

<kuznet@ms2.inr.ac.ru> (02/03/19 1.181.2.16)
	IPv4 FIB routing fixes:

<kuznet@ms2.inr.ac.ru> (02/03/19 1.181.2.17)
	In IPv4 ICMP:

<kuznet@ms2.inr.ac.ru> (02/03/19 1.181.2.18)
	Fix for ipv4 tunnel devices:

<kuznet@ms2.inr.ac.ru> (02/03/19 1.181.2.19)
	IP input fixes:

<kuznet@ms2.inr.ac.ru> (02/03/19 1.181.2.20)
	Terrible bug in ipv4/route.c, mis-sized ip_rt_acct leads to

<kuznet@ms2.inr.ac.ru> (02/03/19 1.181.2.21)
	TCP Input fixes:

<kuznet@ms2.inr.ac.ru> (02/03/19 1.181.2.22)
	UDP fixes:

<kuznet@ms2.inr.ac.ru> (02/03/19 1.181.2.23)
	IPV6 addrconf exploit fix:

<kuznet@ms2.inr.ac.ru> (02/03/19 1.181.2.24)
	IPv6 neighbour discovery fixes:

<kuznet@ms2.inr.ac.ru> (02/03/19 1.181.2.25)
	TCP ipv6 fixes:

<kuznet@ms2.inr.ac.ru> (02/03/19 1.181.2.26)
	Port of 2.2.x AF_PACKET bug fix.

<kuznet@ms2.inr.ac.ru> (02/03/19 1.181.2.27)
	Fix bug in sch_prio.c where wrong handle was

<kuznet@ms2.inr.ac.ru> (02/03/19 1.181.2.28)
	In sch_sfq.c, allow to descrease length of queue

<kuznet@ms2.inr.ac.ru> (02/03/19 1.181.2.29)
	Add new sysctl, medium_id, to devinet.

<kuznet@ms2.inr.ac.ru> (02/03/19 1.181.2.30)
	Forgotten portion of "kill unused struct open_request" changes.

<kuznet@ms2.inr.ac.ru> (02/03/19 1.181.2.31)
	Allow to bind to an already in use local port

<davem@nuts.ninka.net> (02/03/19 1.189.1.1)
	Update sparc64 defconfig.

<kanojsarcar@yahoo.com> (02/03/19 1.189.1.2)
	Move VPTE_BASE_foo definitions to common

<kraxel@bytesex.org> (02/03/20 1.221)
	fix compile error due to recent videodev changes

<kraxel@bytesex.org> (02/03/20 1.222)
	fix compile error due to recent videodev changes

<edward_peng@dlink.com.tw> (02/03/20 1.220.1.3)
	Update dl2k gigabit ethernet driver to watch RX in case of lockup.

<jgarzik@mandrakesoft.com> (02/03/20 1.220.1.4)
	dl2k net driver updates:

<jgarzik@mandrakesoft.com> (02/03/20 1.220.1.5)
	Add pci id to orinoco_plx wireless driver (Brendan McAdams)

<jgarzik@mandrakesoft.com> (02/03/20 1.220.2.2)
	Add two AC97 codec ids to the OSS ac97_codec driver.

<jes@wildopensource.com> (02/03/20 1.220.1.6)
	Update acenic gigabit ethernet driver to clean up VLAN support integration.

<k.kasprzak@box43.pl> (02/03/20 1.220.1.7)
	de620 net driver janitor fixes:

<silicon@falcon.sch.bme.hu> (02/03/20 1.220.2.3)
	Update munich WAN driver to not kfree memory multiple times.

<jgarzik@mandrakesoft.com> (02/03/20 1.220.1.8)
	s/kfree/kfree_skb/ in drivers/s390/net/ctctty.c.

<jgarzik@mandrakesoft.com> (02/03/20 1.220.1.9)
	(sync with 2.5.x.  in 2.4.x, this is just a cosmetic change)

<brownfld@irridia.com> (02/03/20 1.220.1.10)
	Support second port on dual-port SysConnect SK-9844 NICs.

<p_gortmaker@yahoo.com> (02/03/20 1.220.1.11)
	MODULE_DESC net drivers cleanup.

<go@turbolinux.co.jp> (02/03/20 1.220.1.12)
	Update pcnet32 net driver with the following changes:

<arjanv@redhat.com> (02/03/20 1.220.1.13)
	Revert xircom_cb net driver back to earlier version which works in all cases.

<arjanv@redhat.com> (02/03/20 1.220.1.14)
	Increase eepro100 net driver tx/rx ring sizes, to be more appropriate for 100mbit

<arjanv@redhat.com> (02/03/20 1.220.1.15)
	Add eepro100 net driver rx soft reset function.

<arjanv@redhat.com> (02/03/20 1.220.1.16)
	Implement RX soft reset for certain cases in eepro100 net driver.

<arjanv@redhat.com> (02/03/20 1.220.1.17)
	Update eepro100 net driver to properly enable/disable software timer

<arjanv@redhat.com> (02/03/20 1.220.1.18)
	eepro100 net driver h/w bug workaround updates:

<arjanv@redhat.com> (02/03/20 1.220.1.19)
	Move pci_enable_device and associated code above first PCI resource info access.

<jgarzik@mandrakesoft.com> (02/03/20 1.220.1.20)
	Build fix: include linux/crc32.h in bmac net driver.

<jgarzik@mandrakesoft.com> (02/03/20 1.220.1.21)
	Merge include/asm-i386/checksum.h from 2.5.7.

<jgarzik@mandrakesoft.com> (02/03/20 1.220.1.22)
	Revert 2.4.18 epic100 net driver power-up sequence "fix".

<davem@nuts.ninka.net> (02/03/20 1.189.1.3)
	In sparc64/ebus, handle machines with both RIO and

<davem@nuts.ninka.net> (02/03/20 1.189.1.4)
	On sparc64 Schizo PCI controllers, there is no inofixup

<davem@nuts.ninka.net> (02/03/20 1.189.1.5)
	On sparc64, handle assigning ROM and non-standard resources

<davem@nuts.ninka.net> (02/03/20 1.189.1.6)
	In Sun GEM/HME drivers, if OpenBoot firmware is not

<davem@nuts.ninka.net> (02/03/20 1.189.1.7)
	Model Sparc64 pci_assign_resource more closely to the

<davem@nuts.ninka.net> (02/03/20 1.189.1.8)
	SunHME net driver cleanups:

<davem@nuts.ninka.net> (02/03/20 1.181.2.32)
	Bonding driver updates:

<dwmw2@infradead.org> (02/03/21 1.220.2.5)
	 The safe parts of the newer MTD code:

<davem@nuts.ninka.net> (02/03/21 1.189.1.9)
	In Sun GEM/HME drivers, if pci_assign_resource of PCI ROM fails,

<dwmw2@infradead.org> (02/03/21 1.220.2.6)
	Merge

<davem@nuts.ninka.net> (02/03/21 1.189.1.10)
	Remove debugging printk while probing MAC address.

<davem@nuts.ninka.net> (02/03/21 1.189.1.11)
	Sun HME/GEM driver probing cleanups.

<davem@nuts.ninka.net> (02/03/21 1.181.2.33)
	Add missing KERN_foo printk specifiers to networking.

<uzi@uzix.org> (02/03/21 1.189.1.12)
	Merge 2.4.x VGER sparc32 changes into 2.4.19

<laforge@gnumonks.org> (02/03/21 1.181.2.34)
	Add configure Configure.help message and

<wstinson@infonie.fr> (02/03/21 1.189.1.13)
	Remove explicit initialization of static vars to zero

<cruault@724.com> (02/03/21 1.181.2.35)
	Make sure outgoing ICMP and TCP resets

<davem@nuts.ninka.net> (02/03/21 1.189.1.14)
	Move bootstr_valid/bootstr_buf back into .data section.

<dwmw2@dwmw2.baythorne.internal> (02/03/22 1.220.2.7)
	Add drivers/mtd/mtdconcat.o to export-objs

<dwmw2@infradead.org> (02/03/22 1.220.2.8)
	Make the partial MTD merge actually compile without warnings.

<dwmw2@infradead.org> (02/03/22 1.220.2.9)
	Minor JFFS2 fixes.

<davem@nuts.ninka.net> (02/03/22 1.181.2.36)
	Code (and commentary) in SYN-RECEIVED processing

<marcelo@plucky.distro.conectiva> (02/03/22 1.220.1.24)
	Add Promise 20276 to supported IDE controllers

<kaos@ocs.com.au> (02/03/22 1.220.1.25)
	[PATCH] 2.4.19-pre4 remove include modversions.h

<sfr@canb.auug.org.au> (02/03/22 1.220.1.26)
	[PATCH] APM missing bits from 2.4.19-pre4

<hch@infradead.org> (02/03/22 1.220.1.27)
	[PATCH] Alpha extern inline -> static inline

<hch@infradead.org> (02/03/22 1.220.1.28)
	[PATCH] alpha lseek prototype

<hch@infradead.org> (02/03/22 1.220.1.29)
	[PATCH] Alpha exports

<hch@infradead.org> (02/03/22 1.220.1.30)
	[PATCH] Alpha fixes for hashed page waitqueues from -aa

<davem@nuts.ninka.net> (02/03/22 1.181.2.37)
	Bump TcpPassiveOpens when tcp_create_openreq_child succeeds.

<hch@infradead.org> (02/03/22 1.220.1.32)
	[PATCH] remove wake_up_page

<marcelo@plucky.distro.conectiva> (02/03/22 1.220.1.33)
	Remove Pacific Digital A-DMA support in Config.in

<alfre@IBD.es> (02/03/22 1.220.1.34)
	[PATCH] Too much debug info from ide-tape

<akpm@zip.com.au> (02/03/22 1.220.1.37)
	[PATCH] smaller kernels

<axboe@suse.de> (02/03/22 1.220.1.38)
	[PATCH] UDF read-write 2.4.19-pre4 bug

<rusty@rustcorp.com.au> (02/03/22 1.220.1.39)
	[PATCH] 2.4.19-pre4 Trivial II: APM update

<rusty@rustcorp.com.au> (02/03/22 1.220.1.40)
	[PATCH] 2.4.19-pre4 Trivial III: SAK message.

<marcelo@plucky.distro.conectiva> (02/03/22 1.220.1.42)
	When writing too little (0) or too much (>num_physpages) of microcode data

<bunk@fs.tum.de> (02/03/22 1.220.1.43)
	[PATCH] s/malloc.h/slab.h/ in sis_ds.c

<bunk@fs.tum.de> (02/03/22 1.220.1.44)
	[PATCH] Don't offer CONFIG_INDYDOG on non-ip22 machines

<akpm@zip.com.au> (02/03/22 1.220.1.45)
	[PATCH] x86 BUG handling

<greg@kroah.com> (02/03/22 1.220.6.1)
	USB visor driver

<marcelo@plucky.distro.conectiva> (02/03/22 1.220.1.46)
	Remove option to use the noop elevator

<petkan@mastika.> (02/03/22 1.220.6.2)
	USB pegasus driver

<oliver@oenone.homelinux.org> (02/03/22 1.220.6.3)
	USB hpusbscsi driver

<oliver@oenone.homelinux.org> (02/03/22 1.220.6.4)
	USB kaweth driver

<paschal@rcsis.com> (02/03/22 1.220.6.5)
	USB printer driver

<vojtech@suse.cz> (02/03/22 1.220.6.6)
	USB HID driver

<nemosoft@smcc.demon.nl> (02/03/22 1.220.6.7)
	USB pwc driver

<john@larvalstage.com> (02/03/22 1.220.1.47)
	[PATCH] trivial borken compile fixes for 2.4.19-pre4

<greg@kroah.com> (02/03/22 1.220.6.8)
	USB hub

<greg@kroah.com> (02/03/22 1.220.6.9)
	USB hub

<ganesh@tuxtop.vxindia.veritas.com> (02/03/22 1.220.6.10)
	USB ipaq driver

<david-b@pacbell.net> (02/03/22 1.220.6.11)
	USB ohci and unlink-in-completion

<david-b@pacbell.net> (02/03/22 1.220.6.12)
	USB update documentation

<johannes@erdfelt.com> (02/03/22 1.220.6.13)
	USB uhci driver update

<greg@kroah.com> (02/03/22 1.220.6.14)
	USB core

<david-b@pacbell.net> (02/03/22 1.220.6.15)
	USB usbfs periodic endpoint/bandwidth reporting

<rmk@flint.arm.linux.org.uk> (02/03/23 1.220.7.1)
	Initial update - all ARM files to 2.4.18-rmk3.

<marcelo@plucky.distro.conectiva> (02/03/25 1.220.1.48)
	Import PPC64 port

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.224)
	[PATCH] Neomagic frame buffer author

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.225)
	[PATCH] PATCH: reiserfs stuff

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.226)
	[PATCH] PATCH: updated IDE - docs

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.227)
	[PATCH] PATCH: docs for neomagic fb

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.228)
	[PATCH] PATCH: docs for 3c509

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.229)
	[PATCH] PATCH: docs for RME hammerfall

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.230)
	[PATCH] PATCH: Updated Andre info

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.231)
	[PATCH] PATCH: printk levels

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.232)
	[PATCH] PATCH: comment fix

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.233)
	[PATCH] PATCH: printk level fix

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.234)
	[PATCH] PATCH: ITE8330 IRQ router

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.235)
	[PATCH] PATCH: printk levels ctd

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.236)
	[PATCH] PATCH: more printk levels

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.237)
	[PATCH] PATCH: new XD signature

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.238)
	[PATCH] PATCH: config.in fix

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.239)
	[PATCH] PATCH: add config for mk712 touchscreen

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.240)
	[PATCH] PATCH: config.in for AMD768 rng

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.241)
	[PATCH] PATCH: Ali watchdog

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.242)
	[PATCH] PATCH: mk712 touchscreen

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.243)
	[PATCH] PATCH: natsemi watchdogs

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.244)
	[PATCH] PATCH: update w83 watchdog

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.245)
	[PATCH] PATCH: add wafer watchdog

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.246)
	[PATCH] PATCH: wdt/wdt_pci fixes and cleanup

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.247)
	[PATCH] PATCH: fix timeout in zoran driver

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.248)
	[PATCH] PATCH: fix config/makefile crud

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.249)
	[PATCH] PATCH: fix timeout in arlan

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.250)
	[PATCH] PATCH: update MPT fusion drivers to 2.0 to handle new boards

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.251)
	[PATCH] PATCH: fix iph5526 to relax cpu

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.252)
	[PATCH] PATCH: fix resource bug in lance

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.253)
	[PATCH] PATCH: compile warning fix

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.254)
	[PATCH] PATCH: fix resource handling in wd.c

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.255)
	[PATCH] PATCH: Add ZV bus to Ricoh cards

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.256)
	[PATCH] PATCH: new style initializers for s390 hwcon

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.257)
	[PATCH] PATCH: time_foo for gdth

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.258)
	[PATCH] PATCH: time_fu for qlogic

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.259)
	[PATCH] PATCH: add another sparselun entry

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.260)
	[PATCH] PATCH: rme hammerfall update

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.261)
	[PATCH] PATCH: minor sound bits

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.262)
	[PATCH] PATCH: missing dependancy

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.263)
	[PATCH] PATCH: missing reparent_to_init

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.264)
	[PATCH] PATCH: more time fixes

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.265)
	[PATCH] PATCH: printk level

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.266)
	[PATCH] PATCH: minor number for mk712

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.267)
	[PATCH] PATCH: acct race fix

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.268)
	[PATCH] PATCH: fix strange httpd logging bug

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.269)
	[PATCH] PATCH: help for patch-kernel

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.270)
	[PATCH] PATCH: config changes to enable neomagic to be selected

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.271)
	[PATCH] PATCH: char Makefile - new watchdogs, mk712 etc

<marcelo@plucky.distro.conectiva> (02/03/25 1.273)
	Re-add all asserts removed by akpm's out-of-line-BUG patch

<marcelo@plucky.distro.conectiva> (02/03/25 1.274)
	ieee1394 update

<marcelo@plucky.distro.conectiva> (02/03/25 1.275)
	Makes rd_load_image() return 0 if it had failed and 1 if it was

<marcelo@plucky.distro.conectiva> (02/03/25 1.276)
	initrd_load() moved to do_mounts.c; assigning DEV_ROOT in case of

<marcelo@plucky.distro.conectiva> (02/03/25 1.277)
	code that deals with spawning /linuxrc, waiting for it, calling

<marcelo@plucky.distro.conectiva> (02/03/25 1.278)
	new helper - mount_block_root() (code that goes through the list

<marcelo@plucky.distro.conectiva> (02/03/25 1.279)
	minor cleanups - mount_root() used to be followed by the same code

<marcelo@plucky.distro.conectiva> (02/03/25 1.280)
	branch after the successful initrd_load() taken into a helper

<marcelo@plucky.distro.conectiva> (02/03/25 1.281)
	instead of mounting/umounting devfs on /dev (rootfs one) in

<marcelo@plucky.distro.conectiva> (02/03/25 1.282)
	new helper - create_dev(name, dev, devfs_name).  It either

<marcelo@plucky.distro.conectiva> (02/03/25 1.283)
	change_root() merged into its caller (handle_initrd()).  More

<marcelo@plucky.distro.conectiva> (02/03/25 1.284)
	rd_load() and rd_load_secondary() merged into their resp. callers.

<marcelo@plucky.distro.conectiva> (02/03/25 1.285)
	new helper - mount_nfs_root().  Yup, attempt to mount nfsroot.

<marcelo@plucky.distro.conectiva> (02/03/25 1.286)
	new helper - change_floppy().  Ejects floppy, asks to replace it

<marcelo@plucky.distro.conectiva> (02/03/25 1.287)
	preparation to cleanup of rd_load_image() (actual loading of

<marcelo@plucky.distro.conectiva> (02/03/25 1.288)
	straightforward switch of rd_load_image() to normal syscalls -

<akpm@reardensteel.com> (02/03/25 1.290)
	[PATCH] The inline-BUG patch

<akpm@zip.com.au> (02/03/25 1.291)
	[PATCH] tunable request queue size

<cyeoh@samba.org> (02/03/25 1.292)
	[PATCH] msync writing when MS_INVALIDATE set and memory locked

<davem@nuts.ninka.net> (02/03/25 1.189.1.15)
	QFE interrupts are mapped INTB/INTC/INTD/INTA.

<davem@nuts.ninka.net> (02/03/25 1.189.1.16)
	In Sparc64 PCI IRQ routing, remove QFE special case.

<uzi@uzix.org> (02/03/25 1.189.1.17)
	Sparc32 cleanups.

<rmk@flint.arm.linux.org.uk> (02/03/26 1.294)
	Sync ARM syscall tables.  Also try to get people to stop adding

<davem@nuts.ninka.net> (02/03/26 1.189.1.18)
	Do the slot mapping adjustment to PROM interrupt

<davem@nuts.ninka.net> (02/03/26 1.181.2.38)
	Fix device list locking.

<marcelo@plucky.distro.conectiva> (02/03/26 1.292.1.3)
	Remove asm/proc_fs.h include from fs/proc/root.c

<marcelo@plucky.distro.conectiva> (02/03/26 1.292.1.4)
	Added ppc64 init proc declarations

<marcelo@plucky.distro.conectiva> (02/03/26 1.292.1.5)
	Added ITE_IT8330G PCI ID

<marcelo@plucky.distro.conectiva> (02/03/26 1.292.1.6)
	Added missing ";" to iSeries_proc_create definition

<jaharkes@cs.cmu.edu> (02/03/27 1.292.1.7)
	[PATCH] Coda update for 2.4.19-pre4

<hch@pentafluge.infradead.org> (02/03/27 1.296)
	[PATCH] fix firewire compilation

<mj@ucw.cz> (02/03/27 1.297)
	[PATCH] PATCH: PCI ID's

<adam@nmt.edu> (02/03/27 1.298)
	[PATCH] 3ware driver update for 2.4.19-pre5

<rth@are.twiddle.net> (02/03/28 1.292.2.1)
	Fix single denorm -> double conversion.

<rth@are.twiddle.net> (02/03/28 1.292.2.2)
	Update NR_SYSCALLS.

<akpm@zip.com.au> (02/03/29 1.299)
	Various changes to the dirty buffer flushing code.

<akpm@zip.com.au> (02/03/29 1.300)
	1: Introduces two new bdflush tunables:

<akpm@zip.com.au> (02/03/29 1.302)
	[PATCH] speed up ext2 synchronous mounts

<akpm@zip.com.au> (02/03/29 1.303)
	[PATCH] speed up ext3 synchronous mounts

<arjanv@redhat.com> (02/03/29 1.304)
	[PATCH] more scsi whitelist entries

<dougg@torque.net> (02/03/29 1.305)
	[PATCH] scsi generic (sg) driver, lk 2.4.18

<bcollins@debian.org> (02/03/29 1.306)
	[PATCH] MAINTAINERS update for 1394

<vojtech@suse.cz> (02/03/29 1.307)
	[PATCH] Update the VIA driver to support the vt8233a

<hch@pentafluge.infradead.org> (02/03/29 1.308)
	[PATCH] include compiler.h in kernel.h

<jt@bougret.hpl.hp.com> (02/03/29 1.309)
	[PATCH] New wireless driver API part 1

<marcelo@plucky.distro.conectiva> (02/03/29 1.310)
	Changed EXTRAVERSION to pre5

Summary of changes from v2.4.19-pre3 to v2.4.19-pre4
============================================

<marcelo@plucky.distro.conectiva> (02/03/13 1.163)
	Update aic7xxx to 6.2.5

<sfr@canb.auug.org.au> (02/03/13 1.164)
	[PATCH] Trivial APM update part 1

<sfr@canb.auug.org.au> (02/03/13 1.165)
	[PATCH] APM patch: change implementation of ALWAYS_CALL_BUSY

<sfr@canb.auug.org.au> (02/03/13 1.166)
	[PATCH] APM patch: apm_cpu_idle cleanups

<jgarzik@mandrakesoft.com> (02/03/13 1.167)
	[PATCH] PATCH: add MWI support to PCI

<jgarzik@mandrakesoft.com> (02/03/13 1.168)
	[PATCH] PATCH: starfire updates

<jgarzik@mandrakesoft.com> (02/03/13 1.169)
	[PATCH] PATCH: tulip use pci_set_mwi

<jgarzik@mandrakesoft.com> (02/03/13 1.170)
	[PATCH] PATCH: starfire use pci_set_mwi

<akpm@zip.com.au> (02/03/14 1.171)
	[PATCH] fix layout of mapped files

<greg@kroah.com> (02/03/14 1.172)
	[PATCH] export IO_APIC_get_PCI_irq_vector for IBM PCI Hotplug driver

<kaos@ocs.com.au> (02/03/14 1.173)
	[PATCH] 2.4.19-pre3 rename duplicate partition_name()

<rml@tech9.net> (02/03/14 1.174)
	[PATCH] more lseek cleanup

<rml@tech9.net> (02/03/14 1.175)
	[PATCH] 2.4: UFS lseek cleanup

<bcrl@redhat.com> (02/03/14 1.176)
	[PATCH] ns83820 0.17 (Re: Broadcom 5700/5701 Gigabit Ethernet Adapters)

<sfr@canb.auug.org.au> (02/03/14 1.177)
	[PATCH] dnotify

<trond.myklebust@fys.uio.no> (02/03/14 1.178)
	[PATCH] Fix 2.4.19-pre3 NFS client file creation

<trond.myklebust@fys.uio.no> (02/03/14 1.179)
	[PATCH] Fix 2.4.19-pre3 NFS reads from holding a write leases.

<trond.myklebust@fys.uio.no> (02/03/14 1.180)
	[PATCH] 2.4.19-pre3 NFS close-to-open fixes

<trond.myklebust@fys.uio.no> (02/03/14 1.181)
	[PATCH] 2.4.19-pre3 NFS close-to-open fix part 2 (VFS change)

<davem@nuts.ninka.net> (02/03/13 1.182)
	Sparc64 updates and fixes:

<davem@nuts.ninka.net> (02/03/13 1.183)
	Fix unterminated comment in asm-sparc64/ide.h

<marcelo@plucky.distro.conectiva> (02/03/14 1.181.1.1)
	Remove off-by-one Davej's fix in bluesmoke.c: it causes some 

<davem@nuts.ninka.net> (02/03/14 1.184)
	Missed this add during sparc64 updates.

<davem@nuts.ninka.net> (02/03/14 1.185)
	Sparc64 build fix: add nop flush_icache_user_range definition.

<davem@nuts.ninka.net> (02/03/14 1.186)
	Kill unused variable warnings in sunlance driver.

<davem@nuts.ninka.net> (02/03/14 1.181.2.1)
	Networking updates and fixes:

<davem@nuts.ninka.net> (02/03/14 1.181.2.2)
	Fix "performance optimization" that breaks the build

<davem@nuts.ninka.net> (02/03/14 1.187)
	Kill unused variable warnings in sunbmac.c and sunqe.c

<davem@nuts.ninka.net> (02/03/14 1.188)
	SunGEM driver updates:

<davem@nuts.ninka.net> (02/03/14 1.189)
	Fix unterminated comment in asm-sparc/ide.h

<davem@nuts.ninka.net> (02/03/14 1.181.2.3)
	New driver for Tigon3 gigabit chipsets, written by

<geert@linux-m68k.org> (02/03/14 1.181.1.2)
	[PATCH] Yearly m68k update (part 41)

<geert@linux-m68k.org> (02/03/14 1.181.1.3)
	[PATCH] Yearly m68k update (part 40)

<geert@linux-m68k.org> (02/03/14 1.181.1.4)
	[PATCH] Yearly m68k update (part 39)

<geert@linux-m68k.org> (02/03/14 1.181.1.5)
	[PATCH] Yearly m68k update (part 36)

<geert@linux-m68k.org> (02/03/14 1.181.1.6)
	[PATCH] Yearly m68k update (part 31)

<geert@linux-m68k.org> (02/03/14 1.181.1.7)
	[PATCH] Yearly m68k update (part 27)

<geert@linux-m68k.org> (02/03/14 1.181.1.8)
	[PATCH] Yearly m68k update (part 35)

<geert@linux-m68k.org> (02/03/14 1.181.1.9)
	[PATCH] Yearly m68k update (part 24)

<geert@linux-m68k.org> (02/03/14 1.181.1.10)
	[PATCH] Yearly m68k update (part 38)

<geert@linux-m68k.org> (02/03/14 1.181.1.11)
	[PATCH] Yearly m68k update (part 28)

<geert@linux-m68k.org> (02/03/14 1.181.1.12)
	[PATCH] Yearly m68k update (part 13)

<geert@linux-m68k.org> (02/03/14 1.181.1.13)
	[PATCH] Yearly m68k update (part 37)

<geert@linux-m68k.org> (02/03/14 1.181.1.14)
	[PATCH] Yearly m68k update (part 7)

<geert@linux-m68k.org> (02/03/14 1.181.1.15)
	[PATCH] Yearly m68k update (part 32)

<geert@linux-m68k.org> (02/03/14 1.181.1.16)
	[PATCH] Yearly m68k update (part 34)

<geert@linux-m68k.org> (02/03/14 1.181.1.17)
	[PATCH] Yearly m68k update (part 25)

<geert@linux-m68k.org> (02/03/14 1.181.1.18)
	[PATCH] Yearly m68k update (part 11)

<geert@linux-m68k.org> (02/03/14 1.181.1.19)
	[PATCH] Yearly m68k update (part 30)

<geert@linux-m68k.org> (02/03/14 1.181.1.20)
	[PATCH] Yearly m68k update (part 6)

<geert@linux-m68k.org> (02/03/14 1.181.1.21)
	[PATCH] Yearly m68k update (part 33)

<geert@linux-m68k.org> (02/03/14 1.181.1.22)
	[PATCH] Yearly m68k update (part 4)

<geert@linux-m68k.org> (02/03/14 1.181.1.23)
	[PATCH] Yearly m68k update (part 2)

<geert@linux-m68k.org> (02/03/14 1.181.1.24)
	[PATCH] Yearly m68k update (part 8)

<geert@linux-m68k.org> (02/03/14 1.181.1.25)
	[PATCH] Yearly m68k update (part 12)

<geert@linux-m68k.org> (02/03/14 1.181.1.26)
	[PATCH] Yearly m68k update (part 16)

<geert@linux-m68k.org> (02/03/14 1.181.1.27)
	[PATCH] Yearly m68k update (part 3)

<geert@linux-m68k.org> (02/03/14 1.181.1.28)
	[PATCH] Yearly m68k update (part 29)

<geert@linux-m68k.org> (02/03/14 1.181.1.29)
	[PATCH] Yearly m68k update (part 19)

<geert@linux-m68k.org> (02/03/14 1.181.1.30)
	[PATCH] Yearly m68k update (part 21)

<geert@linux-m68k.org> (02/03/14 1.181.1.31)
	[PATCH] Yearly m68k update (part 17)

<geert@linux-m68k.org> (02/03/14 1.181.1.32)
	[PATCH] Yearly m68k update (part 5)

<geert@linux-m68k.org> (02/03/14 1.181.1.33)
	[PATCH] Yearly m68k update (part 15)

<geert@linux-m68k.org> (02/03/14 1.181.1.34)
	[PATCH] Yearly m68k update (part 26)

<geert@linux-m68k.org> (02/03/14 1.181.1.35)
	[PATCH] Yearly m68k update (part 22)

<geert@linux-m68k.org> (02/03/14 1.181.1.36)
	[PATCH] Yearly m68k update (part 1)

<geert@linux-m68k.org> (02/03/14 1.181.1.37)
	[PATCH] Yearly m68k update (part 23)

<geert@linux-m68k.org> (02/03/14 1.181.1.38)
	[PATCH] Yearly m68k update (part 9)

<geert@linux-m68k.org> (02/03/14 1.181.1.39)
	[PATCH] Yearly m68k update (part 10)

<geert@linux-m68k.org> (02/03/14 1.181.1.40)
	[PATCH] Yearly m68k update (part 18)

<geert@linux-m68k.org> (02/03/14 1.181.1.41)
	[PATCH] Yearly m68k update (part 20)

<kraxel@bytesex.org> (02/03/14 1.181.1.42)
	[PATCH] v4l: video4linux API doc update

<kraxel@bytesex.org> (02/03/14 1.181.1.43)
	[PATCH] vmalloc_to_page() backport for 2.4

<kraxel@bytesex.org> (02/03/14 1.181.1.44)
	[PATCH] v4l: videodev redesign

<kai@tp1.ruhr-uni-bochum.de> (02/03/14 1.181.1.45)
	[PATCH] ISDN fixes / update

<kai@tp1.ruhr-uni-bochum.de> (02/03/14 1.181.1.46)
	[PATCH] ISDN fixes / update

<kai@tp1.ruhr-uni-bochum.de> (02/03/14 1.181.1.47)
	[PATCH] ISDN fixes / update

<kai@tp1.ruhr-uni-bochum.de> (02/03/14 1.181.1.48)
	[PATCH] ISDN fixes / update

<kai-germaschewski@uiowa.edu> (02/03/14 1.181.1.49)
	[PATCH] ISDN fixes / update

<greg@kroah.com> (02/03/14 1.181.1.50)
	[PATCH] USB Config.in update

<greg@kroah.com> (02/03/14 1.181.1.51)
	[PATCH] USB edgeport driver bugfix

<greg@kroah.com> (02/03/14 1.181.1.52)
	[PATCH] USB usbfs name added

<greg@kroah.com> (02/03/14 1.181.1.53)
	[PATCH] USB ipaq driver bugfix

<greg@kroah.com> (02/03/14 1.181.1.54)
	[PATCH] USB catc ethtool support

<greg@kroah.com> (02/03/14 1.181.1.55)
	[PATCH] USB CREDITS and MAINTAINERS update

<greg@kroah.com> (02/03/14 1.181.1.56)
	[PATCH] USB pegasus ethtool support

<greg@kroah.com> (02/03/14 1.181.1.57)
	[PATCH] USB em26 driver added

<davem@nuts.ninka.net> (02/03/14 1.181.2.4)
	Allow ARP packets to be seen by netfilter.

<kai@tp1.ruhr-uni-bochum.de> (02/03/14 1.181.1.58)
	Put back the option to support AVM A1 / Fritz! PCMCIA cards inside hisax.

<davem@nuts.ninka.net> (02/03/14 1.181.2.5)
	Include linux/netfilter_arp.h

<marcelo@plucky.distro.conectiva> (02/03/14 1.192)
	Add missing aic7xxx updates

<axboe@suse.de> (02/03/14 1.193)
	[PATCH] cciss driver pci_*_consistent(NULL,...) fix for 2.4.19-pre2 (1 of 4)

<axboe@suse.de> (02/03/14 1.194)
	[PATCH] cciss driver GETLUNINFO ioctl (2 of 4)

<axboe@suse.de> (02/03/14 1.195)
	[PATCH] cciss driver HDIO_GETGEO_BIG ioctl for 2.4.19-pre2 (3 of 4)

<axboe@suse.de> (02/03/14 1.196)
	[PATCH] remove CCISS_REVALIDVOLS ioctl for 2.4.19-pre2 (4 of 4)

<marcelo@plucky.distro.conectiva> (02/03/14 1.197)
	The problem is that both the sd and sr drivers treat an

<davem@nuts.ninka.net> (02/03/14 1.181.2.6)
	From Harald Welte and the Netfilter team:

<davem@nuts.ninka.net> (02/03/14 1.181.2.7)
	From Harald Welte and the Netfilter team:

<EdV@macrolink.com> (02/03/15 1.198)
	This patch corrects PCI device id in pci_ids.h for Oxford Semi OX16PCI952

<jgarzik@mandrakesoft.com> (02/03/15 1.199)
	Remove VT8233 pci ids from via82cxxx_audio sound driver.

<nahshon@actcom.co.il> (02/03/15 1.200)
	Fix via audio recording, when frag size < page size.

<silicon@falcon.sch.bme.hu> (02/03/15 1.201)
	Add new slicecom/munich WAN driver.

<hch@caldera.de> (02/03/15 1.197.2.1)
	[PATCH] remove superflous assignment in mmap()

<hch@caldera.de> (02/03/15 1.197.2.2)
	[PATCH] Error return fixes

<hch@caldera.de> (02/03/15 1.197.2.3)
	[PATCH] missing include in net/sunrpc/stats.c

<davem@nuts.ninka.net> (02/03/15 1.181.2.8)
	Add arptables netfilter module for registering ARP

<bfennema@falcon.csc.calpoly.edu> (02/03/15 1.197.2.4)
	Missing byte swaps needed for big endian archs

<mikpe@csd.uu.se> (02/03/15 1.197.2.5)
	[PATCH] boot_cpu_data corruption on SMP x86

<bfennema@falcon.csc.calpoly.edu> (02/03/15 1.197.2.7)
	Fix videodev build warning

<davem@nuts.ninka.net> (02/03/17 1.181.2.9)
	Fix netfilter IPv4 conntrack build.

<marcelo@plucky.distro.conectiva> (02/03/19 1.204)
	Changed EXTRAVERSION in Makefile to pre4

<stelian.pop@fr.alcove.com> (02/03/19 1.205)
	[PATCH] videodev.c oopses in video_exclusive_register

<stelian.pop@fr.alcove.com> (02/03/19 1.206)
	[PATCH] meye driver update to new V4L API.

<rusty@rustcorp.com.au> (02/03/19 1.207)
	[PATCH] 2.4.19-pre3 Trivial I: seq_file.h update

<rusty@rustcorp.com.au> (02/03/19 1.208)
	[PATCH] Trivial I: fs_exec.c core fix

<rusty@rustcorp.com.au> (02/03/19 1.209)
	[PATCH] 2.4.19-pre3 Trivial III: -ENOTTY for nvram

<rusty@rustcorp.com.au> (02/03/19 1.210)
	[PATCH] 2.4.19-pre3 Trivial IV: -ENOTTY

<rusty@rustcorp.com.au> (02/03/19 1.211)
	[PATCH] 2.4.19-pre3 Trivial VI: MSDOS options

<marcelo@plucky.distro.conectiva> (02/03/19 1.212)
	If setup_arg_pages() fails, we continue

<rmk@arm.linux.org.uk> (02/03/19 1.213)
	[PATCH] 2.4 and 2.5: remove Alt-Sysrq-L

<rmk@arm.linux.org.uk> (02/03/19 1.214)
	[PATCH] 2.5 and 2.4: fix PCI IO BAR flags

<marcelo@plucky.distro.conectiva> (02/03/19 1.215)
	Remove unused videodev_register_lock

<marcelo@plucky.distro.conectiva> (02/03/19 1.216)
	Avoid page_to_phys() from truncating the physical addresses to 32bit,

<hch@caldera.de> (02/03/19 1.217)
	[PATCH] fix Config.in breakage

<hch@caldera.de> (02/03/19 1.218)
	[PATCH] kill slow-path micro-optimization

<hch@caldera.de> (02/03/19 1.219)
	[PATCH] export rbtree routines

<paulus@samba.org> (02/03/19 1.220)
	[PATCH] Re: [PATCH] zlib double-free bug

<trond.myklebust@fys.uio.no> (02/03/20 1.220.3.2)
	[PATCH] Fix bug in sunrpc code...

Summary of changes from v2.4.19-pre2 to v2.4.19-pre3
============================================

<marcelo@plucky.distro.conectiva> (02/03/13 1.162)
	- -ac merge (including new IDE)                         (Alan Cox)
	- S390 merge                                            (IBM)
	- More cciss fixes                                      (Stephen Cameron)
	- Eicon SMP race fix                                    (Armin Schindler)
	- w9966 driver update                                   (Jakob Kemi)
	- Unify crc32 routine (removes lots of duplicated
	  code from drivers)                                    (Matt Domsch)
	- Lanstreamer bugfixes                                  (Kent Yoder)
	- Update scsi_debug                                     (Douglas Gilbert)
	- MCE Configure.help update                             (Paul Gortmaker)
	- Fix SMB NLS oops                                      (Urban Widmark)
	- AGP Config.in update                                  (Daniele Venzano)
	- Fix small thinko in UFS set_blocksize return handling (me)
	- Avoid unecessary cache flushes on PPC                 (Paul Mackerras)
	- PPP deadlock fixes                                    (Paul Mackerras)
	- Signal changes for thread groups                      (Dave McCracken)
	- Make max_threads be based on normal zone size         (Dave McCracken)
	- ray_cs wireless extension fix                         (Jean Tourrilhes)
	- irda bugfixes and enhancements                        (Jean Tourrilhes)
	- USB update                                            (Greg KH)
	- Fix through-8259A mode for IRQ0 routing on APIC       (Maciej W. Rozycki/Joe Korty)
	- Add Dell Inspiron 2500 to broken APM blacklist        (Arjan van de Ven)
	- Fix off-by-one error in bluesmoke                     (Dave Jones)
	- Reiserfs update                                       (Oleg Drokin)
	- Fix PCI compile without /proc support                 (Eric Sandeen)
	- Fix problem with bad inode handling                   (Alexander Viro)
	- aic7xxx update                                        (Justin T. Gibbs)
	- Do not consider SCSI recovered errors as fatal errors (Justin T. Gibbs)
	- Add Memory-Write-Invalidate support to PCI            (Jeff Garzik)
	- Starfire update                                       (Ion Badulescu)
	- tulip update                                          (Jeff Garzik)


Summary of changes from v2.4.19-pre1 to v2.4.19-pre2
============================================

<marcelo@plucky.distro.conectiva> (02/03/13 1.161)
	- -ac merge                                             (Alan Cox)
	- Huge MIPS/MIPS64 merge                                (Ralf Baechle)
	- IA64 update                                           (David Mosberger)
	- PPC update                                            (Tom Rini)
	- Shrink struct page                                    (Rik van Riel)
	- QNX4 update (now its able to mount QNX 6.1 fses)      (Anders Larsen)
	- Make max_map_count sysctl configurable                (Christoph Hellwig)
	- matroxfb update                                       (Petr Vandrovec)
	- ymfpci update                                         (Pete Zaitcev)
	- LVM update                                            (Heinz J . Mauelshagen)
	- btaudio driver update                                 (Gerd Knorr)
	- bttv update                                           (Gerd Knorr)
	- Out of line code cleanup                              (Keith Owens)
	- Add watchdog API documentation                        (Christer Weinigel)
	- Rivafb update                                         (Ani Joshi)
	- Enable PCI buses above quad0 on NUMA-Q                (Martin J. Bligh)
	- Fix PIIX IDE slave PCI timings                        (Dave Bogdanoff)
	- Make PLIP work again                                  (Tim Waugh)
	- Remove unecessary printk from lp.c                    (Tim Waugh)
	- Make parport_daisy_select work for ECP/EPP modes      (Max Vorobiev)
	- Support O_NONBLOCK on lp/ppdev correctly              (Tim Waugh)
	- Add PCI card hooks to parport                         (Tim Waugh)
	- Compaq cciss driver fixes                             (Stephen Cameron)
	- VFS cleanups and fixes                                (Alexander Viro)
	- USB update (including USB 2.0 support)                (Greg KH)
	- More jiffies compare cleanups                         (Tim Schmielau)
	- PCI hotplug update                                    (Greg KH)
	- bluesmoke fixes                                       (Dave Jones)
	- Fix off-by-one in ide-scsi                            (John Fremlin)
	- Fix warnings in make xconfig                          (René Scharfe)
	- Make x86 MCE a configure option                       (Paul Gortmaker)
	- Small ramdisk fixes                                   (Christoph Hellwig)
	- Add missing atime update to pipe code                 (Christoph Hellwig)
	- Serialize microcode access                            (Tigran Aivazian)
	- AMD Elan handling on serial.c                         (Robert Schwebel)


Summary of changes from v2.4.18 to v2.4.19-pre1
============================================

<marcelo@plucky.distro.conectiva> (02/03/13 1.160)
	- Add tape support to cciss driver                      (Stephen Cameron)
	- Add Permedia3 fb driver                               (Romain Dolbeau)
	- meye driver update                                    (Stelian Pop)
	- opl3sa2 update                                        (Zwane Mwaikambo)
	- JFFS2 update                                          (David Woodhouse)
	- NBD deadlock fix                                      (Steven Whitehouse)
	- Correct sys_shmdt() return value on failure           (Adam Bottchen)
	- Apply the SET_PERSONALITY patch missing from 2.4.18   (me)
	- Alpha update                                          (Jay Estabrook)
	- SPARC64 update                                        (David S. Miller)
	- Fix potential blk freelist corruption                 (Jens Axboe)
	- Fix potential hpfs oops                               (Chris Mason)
	- get_request() starvation fix                          (Andrew Morton)
	- cramfs update                                         (Daniel Quinlan)
	- Allow binfmt_elf as module                            (Paul Gortmaker)
	- ymfpci Configure.help update                          (Pete Zaitcev)
	- Backout one eepro100 change made in 2.4.18: it
	  was causing slowdowns on some cards                   (Jeff Garzik)
	- Tridentfb compilation fix                             (Jani Monoses)
	- Fix refcounting of directories on renames in tmpfs    (Christoph Rohland)
	- Add Fujitsu notebook to broken APM implementation
	  blacklist                                             (Arjan Van de Ven)
	- "do { ... } while(0)" cleanups on some fb drivers     (Geert Uytterhoeven)
	- Fix natsemi's ETHTOOL_GLINK ioctl                     (Tim Hockin)
	- Fix clik! drive detection code in ide-floppy          (Paul Bristow)
	- Add additional support for the 82801 I/O controller   (Wim Van Sebroeck)
	- Remove duplicates in pci_ids.h                        (Wim Van Sebroeck)



