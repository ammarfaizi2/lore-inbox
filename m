Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293379AbSCUFce>; Thu, 21 Mar 2002 00:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293386AbSCUFc0>; Thu, 21 Mar 2002 00:32:26 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:6132
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S293379AbSCUFcQ>; Thu, 21 Mar 2002 00:32:16 -0500
Date: Wed, 20 Mar 2002 21:33:38 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux 2.4.19-pre4
Message-ID: <20020321053338.GA3201@matchmail.com>
Mail-Followup-To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <Pine.LNX.4.21.0203201757560.9129-100000@freak.distro.conectiva> <Pine.LNX.4.30.0203210000440.4385-100000@mustard.heime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2002 at 12:01:31AM +0100, Roy Sigurd Karlsbakk wrote:
> hi
> 
> it's good with a nice and detailed changelog - but ... I'd be grateful to
> see a nice little summary at the top.
> 

Using:
egrep -iA1 '\([0-9]{2}[/][0-9]{2}[/][0-9]{2}.*\..*\)'

Here it is:
<marcelo@plucky.distro.conectiva> (02/03/13 1.163)
	Update aic7xxx to 6.2.5
--
<sfr@canb.auug.org.au> (02/03/13 1.164)
	[PATCH] Trivial APM update part 1
--
<sfr@canb.auug.org.au> (02/03/13 1.165)
	[PATCH] APM patch: change implementation of ALWAYS_CALL_BUSY
--
<sfr@canb.auug.org.au> (02/03/13 1.166)
	[PATCH] APM patch: apm_cpu_idle cleanups
--
<jgarzik@mandrakesoft.com> (02/03/13 1.167)
	[PATCH] PATCH: add MWI support to PCI
--
<jgarzik@mandrakesoft.com> (02/03/13 1.168)
	[PATCH] PATCH: starfire updates
--
<jgarzik@mandrakesoft.com> (02/03/13 1.169)
	[PATCH] PATCH: tulip use pci_set_mwi
--
<jgarzik@mandrakesoft.com> (02/03/13 1.170)
	[PATCH] PATCH: starfire use pci_set_mwi
--
<akpm@zip.com.au> (02/03/14 1.171)
	[PATCH] fix layout of mapped files
--
<greg@kroah.com> (02/03/14 1.172)
	[PATCH] export IO_APIC_get_PCI_irq_vector for IBM PCI Hotplug driver
--
<kaos@ocs.com.au> (02/03/14 1.173)
	[PATCH] 2.4.19-pre3 rename duplicate partition_name()
--
<rml@tech9.net> (02/03/14 1.174)
	[PATCH] more lseek cleanup
--
<rml@tech9.net> (02/03/14 1.175)
	[PATCH] 2.4: UFS lseek cleanup
--
<bcrl@redhat.com> (02/03/14 1.176)
	[PATCH] ns83820 0.17 (Re: Broadcom 5700/5701 Gigabit Ethernet Adapters=
--
<sfr@canb.auug.org.au> (02/03/14 1.177)
	[PATCH] dnotify
--
<trond.myklebust@fys.uio.no> (02/03/14 1.178)
	[PATCH] Fix 2.4.19-pre3 NFS client file creation
--
<trond.myklebust@fys.uio.no> (02/03/14 1.179)
	[PATCH] Fix 2.4.19-pre3 NFS reads from holding a write leases.
--
<trond.myklebust@fys.uio.no> (02/03/14 1.180)
	[PATCH] 2.4.19-pre3 NFS close-to-open fixes
--
<trond.myklebust@fys.uio.no> (02/03/14 1.181)
	[PATCH] 2.4.19-pre3 NFS close-to-open fix part 2 (VFS change)
--
<davem@nuts.ninka.net> (02/03/13 1.182)
	Sparc64 updates and fixes:
--
<davem@nuts.ninka.net> (02/03/13 1.183)
	Fix unterminated comment in asm-sparc64/ide.h
--
<marcelo@plucky.distro.conectiva> (02/03/14 1.181.1.1)
	Remove off-by-one Davej's fix in bluesmoke.c: it causes some=20
--
<davem@nuts.ninka.net> (02/03/14 1.184)
	Missed this add during sparc64 updates.
--
<davem@nuts.ninka.net> (02/03/14 1.185)
	Sparc64 build fix: add nop flush_icache_user_range definition.
--
<davem@nuts.ninka.net> (02/03/14 1.186)
	Kill unused variable warnings in sunlance driver.
--
<davem@nuts.ninka.net> (02/03/14 1.181.2.1)
	Networking updates and fixes:
--
<davem@nuts.ninka.net> (02/03/14 1.181.2.2)
	Fix "performance optimization" that breaks the build
--
<davem@nuts.ninka.net> (02/03/14 1.187)
	Kill unused variable warnings in sunbmac.c and sunqe.c
--
<davem@nuts.ninka.net> (02/03/14 1.188)
	SunGEM driver updates:
--
<davem@nuts.ninka.net> (02/03/14 1.189)
	Fix unterminated comment in asm-sparc/ide.h
--
<davem@nuts.ninka.net> (02/03/14 1.181.2.3)
	New driver for Tigon3 gigabit chipsets, written by
--
<geert@linux-m68k.org> (02/03/14 1.181.1.2)
	[PATCH] Yearly m68k update (part 41)
--
<geert@linux-m68k.org> (02/03/14 1.181.1.3)
	[PATCH] Yearly m68k update (part 40)
--
<geert@linux-m68k.org> (02/03/14 1.181.1.4)
	[PATCH] Yearly m68k update (part 39)
--
<geert@linux-m68k.org> (02/03/14 1.181.1.5)
	[PATCH] Yearly m68k update (part 36)
--
<geert@linux-m68k.org> (02/03/14 1.181.1.6)
	[PATCH] Yearly m68k update (part 31)
--
<geert@linux-m68k.org> (02/03/14 1.181.1.7)
	[PATCH] Yearly m68k update (part 27)
--
<geert@linux-m68k.org> (02/03/14 1.181.1.8)
	[PATCH] Yearly m68k update (part 35)
--
<geert@linux-m68k.org> (02/03/14 1.181.1.9)
	[PATCH] Yearly m68k update (part 24)
--
<geert@linux-m68k.org> (02/03/14 1.181.1.10)
	[PATCH] Yearly m68k update (part 38)
--
<geert@linux-m68k.org> (02/03/14 1.181.1.11)
	[PATCH] Yearly m68k update (part 28)
--
<geert@linux-m68k.org> (02/03/14 1.181.1.12)
	[PATCH] Yearly m68k update (part 13)
--
<geert@linux-m68k.org> (02/03/14 1.181.1.13)
	[PATCH] Yearly m68k update (part 37)
--
<geert@linux-m68k.org> (02/03/14 1.181.1.14)
	[PATCH] Yearly m68k update (part 7)
--
<geert@linux-m68k.org> (02/03/14 1.181.1.15)
	[PATCH] Yearly m68k update (part 32)
--
<geert@linux-m68k.org> (02/03/14 1.181.1.16)
	[PATCH] Yearly m68k update (part 34)
--
<geert@linux-m68k.org> (02/03/14 1.181.1.17)
	[PATCH] Yearly m68k update (part 25)
--
<geert@linux-m68k.org> (02/03/14 1.181.1.18)
	[PATCH] Yearly m68k update (part 11)
--
<geert@linux-m68k.org> (02/03/14 1.181.1.19)
	[PATCH] Yearly m68k update (part 30)
--
<geert@linux-m68k.org> (02/03/14 1.181.1.20)
	[PATCH] Yearly m68k update (part 6)
--
<geert@linux-m68k.org> (02/03/14 1.181.1.21)
	[PATCH] Yearly m68k update (part 33)
--
<geert@linux-m68k.org> (02/03/14 1.181.1.22)
	[PATCH] Yearly m68k update (part 4)
--
<geert@linux-m68k.org> (02/03/14 1.181.1.23)
	[PATCH] Yearly m68k update (part 2)
--
<geert@linux-m68k.org> (02/03/14 1.181.1.24)
	[PATCH] Yearly m68k update (part 8)
--
<geert@linux-m68k.org> (02/03/14 1.181.1.25)
	[PATCH] Yearly m68k update (part 12)
--
<geert@linux-m68k.org> (02/03/14 1.181.1.26)
	[PATCH] Yearly m68k update (part 16)
--
<geert@linux-m68k.org> (02/03/14 1.181.1.27)
	[PATCH] Yearly m68k update (part 3)
--
<geert@linux-m68k.org> (02/03/14 1.181.1.28)
	[PATCH] Yearly m68k update (part 29)
--
<geert@linux-m68k.org> (02/03/14 1.181.1.29)
	[PATCH] Yearly m68k update (part 19)
--
<geert@linux-m68k.org> (02/03/14 1.181.1.30)
	[PATCH] Yearly m68k update (part 21)
--
<geert@linux-m68k.org> (02/03/14 1.181.1.31)
	[PATCH] Yearly m68k update (part 17)
--
<geert@linux-m68k.org> (02/03/14 1.181.1.32)
	[PATCH] Yearly m68k update (part 5)
--
<geert@linux-m68k.org> (02/03/14 1.181.1.33)
	[PATCH] Yearly m68k update (part 15)
--
<geert@linux-m68k.org> (02/03/14 1.181.1.34)
	[PATCH] Yearly m68k update (part 26)
--
<geert@linux-m68k.org> (02/03/14 1.181.1.35)
	[PATCH] Yearly m68k update (part 22)
--
<geert@linux-m68k.org> (02/03/14 1.181.1.36)
	[PATCH] Yearly m68k update (part 1)
--
<geert@linux-m68k.org> (02/03/14 1.181.1.37)
	[PATCH] Yearly m68k update (part 23)
--
<geert@linux-m68k.org> (02/03/14 1.181.1.38)
	[PATCH] Yearly m68k update (part 9)
--
<geert@linux-m68k.org> (02/03/14 1.181.1.39)
	[PATCH] Yearly m68k update (part 10)
--
<geert@linux-m68k.org> (02/03/14 1.181.1.40)
	[PATCH] Yearly m68k update (part 18)
--
<geert@linux-m68k.org> (02/03/14 1.181.1.41)
	[PATCH] Yearly m68k update (part 20)
--
<kraxel@bytesex.org> (02/03/14 1.181.1.42)
	[PATCH] v4l: video4linux API doc update
--
<kraxel@bytesex.org> (02/03/14 1.181.1.43)
	[PATCH] vmalloc_to_page() backport for 2.4
--
<kraxel@bytesex.org> (02/03/14 1.181.1.44)
	[PATCH] v4l: videodev redesign
--
<kai@tp1.ruhr-uni-bochum.de> (02/03/14 1.181.1.45)
	[PATCH] ISDN fixes / update
--
<kai@tp1.ruhr-uni-bochum.de> (02/03/14 1.181.1.46)
	[PATCH] ISDN fixes / update
--
<kai@tp1.ruhr-uni-bochum.de> (02/03/14 1.181.1.47)
	[PATCH] ISDN fixes / update
--
<kai@tp1.ruhr-uni-bochum.de> (02/03/14 1.181.1.48)
	[PATCH] ISDN fixes / update
--
<kai-germaschewski@uiowa.edu> (02/03/14 1.181.1.49)
	[PATCH] ISDN fixes / update
--
<greg@kroah.com> (02/03/14 1.181.1.50)
	[PATCH] USB Config.in update
--
<greg@kroah.com> (02/03/14 1.181.1.51)
	[PATCH] USB edgeport driver bugfix
--
<greg@kroah.com> (02/03/14 1.181.1.52)
	[PATCH] USB usbfs name added
--
<greg@kroah.com> (02/03/14 1.181.1.53)
	[PATCH] USB ipaq driver bugfix
--
<greg@kroah.com> (02/03/14 1.181.1.54)
	[PATCH] USB catc ethtool support
--
<greg@kroah.com> (02/03/14 1.181.1.55)
	[PATCH] USB CREDITS and MAINTAINERS update
--
<greg@kroah.com> (02/03/14 1.181.1.56)
	[PATCH] USB pegasus ethtool support
--
<greg@kroah.com> (02/03/14 1.181.1.57)
	[PATCH] USB em26 driver added
--
<davem@nuts.ninka.net> (02/03/14 1.181.2.4)
	Allow ARP packets to be seen by netfilter.
--
<kai@tp1.ruhr-uni-bochum.de> (02/03/14 1.181.1.58)
	Put back the option to support AVM A1 / Fritz! PCMCIA cards inside his=
--
<davem@nuts.ninka.net> (02/03/14 1.181.2.5)
	Include linux/netfilter_arp.h
--
<marcelo@plucky.distro.conectiva> (02/03/14 1.192)
	Add missing aic7xxx updates
--
<axboe@suse.de> (02/03/14 1.193)
	[PATCH] cciss driver pci_*_consistent(NULL,...) fix for 2.4.19-pre2 (1=
--
<axboe@suse.de> (02/03/14 1.194)
	[PATCH] cciss driver GETLUNINFO ioctl (2 of 4)
--
<axboe@suse.de> (02/03/14 1.195)
	[PATCH] cciss driver HDIO_GETGEO_BIG ioctl for 2.4.19-pre2 (3 of 4)
--
<axboe@suse.de> (02/03/14 1.196)
	[PATCH] remove CCISS_REVALIDVOLS ioctl for 2.4.19-pre2 (4 of 4)
--
<marcelo@plucky.distro.conectiva> (02/03/14 1.197)
	The problem is that both the sd and sr drivers treat an
--
<davem@nuts.ninka.net> (02/03/14 1.181.2.6)
	From Harald Welte and the Netfilter team:
--
<davem@nuts.ninka.net> (02/03/14 1.181.2.7)
	From Harald Welte and the Netfilter team:
--
<EdV@macrolink.com> (02/03/15 1.198)
	This patch corrects PCI device id in pci_ids.h for Oxford Semi OX16PCI=
--
<jgarzik@mandrakesoft.com> (02/03/15 1.199)
	Remove VT8233 pci ids from via82cxxx_audio sound driver.
--
<nahshon@actcom.co.il> (02/03/15 1.200)
	Fix via audio recording, when frag size < page size.
--
<silicon@falcon.sch.bme.hu> (02/03/15 1.201)
	Add new slicecom/munich WAN driver.
--
<hch@caldera.de> (02/03/15 1.197.1.1)
	[PATCH] remove superflous assignment in mmap()
--
<hch@caldera.de> (02/03/15 1.197.1.2)
	[PATCH] Error return fixes
--
<hch@caldera.de> (02/03/15 1.197.1.3)
	[PATCH] missing include in net/sunrpc/stats.c
--
<davem@nuts.ninka.net> (02/03/15 1.181.2.8)
	Add arptables netfilter module for registering ARP
--
<bfennema@falcon.csc.calpoly.edu> (02/03/15 1.197.1.4)
	Missing byte swaps needed for big endian archs
--
<mikpe@csd.uu.se> (02/03/15 1.197.1.5)
	[PATCH] boot_cpu_data corruption on SMP x86
--
<bfennema@falcon.csc.calpoly.edu> (02/03/15 1.197.1.7)
	Fix videodev build warning
--
<davem@nuts.ninka.net> (02/03/17 1.181.2.9)
	Fix netfilter IPv4 conntrack build.
--
<marcelo@plucky.distro.conectiva> (02/03/19 1.204)
	Changed EXTRAVERSION in Makefile to pre4
--
<stelian.pop@fr.alcove.com> (02/03/19 1.205)
	[PATCH] videodev.c oopses in video_exclusive_register
--
<stelian.pop@fr.alcove.com> (02/03/19 1.206)
	[PATCH] meye driver update to new V4L API.
--
<rusty@rustcorp.com.au> (02/03/19 1.207)
	[PATCH] 2.4.19-pre3 Trivial I: seq_file.h update
--
<rusty@rustcorp.com.au> (02/03/19 1.208)
	[PATCH] Trivial I: fs_exec.c core fix
--
<rusty@rustcorp.com.au> (02/03/19 1.209)
	[PATCH] 2.4.19-pre3 Trivial III: -ENOTTY for nvram
--
<rusty@rustcorp.com.au> (02/03/19 1.210)
	[PATCH] 2.4.19-pre3 Trivial IV: -ENOTTY
--
<rusty@rustcorp.com.au> (02/03/19 1.211)
	[PATCH] 2.4.19-pre3 Trivial VI: MSDOS options
--
<marcelo@plucky.distro.conectiva> (02/03/19 1.212)
	If setup_arg_pages() fails, we continue
--
<rmk@arm.linux.org.uk> (02/03/19 1.213)
	[PATCH] 2.4 and 2.5: remove Alt-Sysrq-L
--
<rmk@arm.linux.org.uk> (02/03/19 1.214)
	[PATCH] 2.5 and 2.4: fix PCI IO BAR flags
--
<marcelo@plucky.distro.conectiva> (02/03/19 1.215)
	Remove unused videodev_register_lock
--
<marcelo@plucky.distro.conectiva> (02/03/19 1.216)
	Avoid page_to_phys() from truncating the physical addresses to 32bit,
--
<hch@caldera.de> (02/03/19 1.217)
	[PATCH] fix Config.in breakage
--
<hch@caldera.de> (02/03/19 1.218)
	[PATCH] kill slow-path micro-optimization
--
<hch@caldera.de> (02/03/19 1.219)
	[PATCH] export rbtree routines
--
<paulus@samba.org> (02/03/19 1.220)
	[PATCH] Re: [PATCH] zlib double-free bug
--
<trond.myklebust@fys.uio.no> (02/03/20 1.222)
	[PATCH] Fix bug in sunrpc code...
--
<marcelo@plucky.distro.conectiva> (02/03/13 1.162)
	- -ac merge (including new IDE)                         (Alan Cox)
--
<marcelo@plucky.distro.conectiva> (02/03/13 1.161)
	- -ac merge                                             (Alan Cox)
--
<marcelo@plucky.distro.conectiva> (02/03/13 1.160)
	- Add tape support to cciss driver                      (Stephen Camer=
