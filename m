Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316968AbSFWDy5>; Sat, 22 Jun 2002 23:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316969AbSFWDy4>; Sat, 22 Jun 2002 23:54:56 -0400
Received: from pD952AF65.dip.t-dialin.net ([217.82.175.101]:19155 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S316968AbSFWDyz>; Sat, 22 Jun 2002 23:54:55 -0400
Date: Sat, 22 Jun 2002 21:54:40 -0600 (MDT)
From: Lightweight patch manager <patch@luckynet.dynu.com>
X-X-Sender: patch@hawkeye.luckynet.adm
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Daniel Phillips <phillips@bonn-fries.net>
Subject: Linux 2.5.24-ct1 (81 Csets)
Message-ID: <Pine.LNX.4.44.0206222153350.8375-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the promised 2.5.24-ct1. Basically some stuff + kbuild-2.5
Altogether we have 81 ChangeSets (see below)

Single patches are availabla at:
<URL:ftp://luckynet.dynu.com/pub/linux/2.5.24-ct1/patches/>
The whole patch is here:
<URL:ftp://luckynet.dynu.com/pub/linux/2.5.24-ct1/patch-2.5.24-ct1.bz2>
The full ChangeLog is here
<URL:ftp://luckynet.dynu.com/pub/linux/2.5.24-ct1/ChangeLog-2.5.24-ct1.bz2>

RCS file: /var/cvs/thunder-2.5/ChangeSet,v
Working file: ChangeSet
head: 1.80
total revisions: 81
=============================================================================

<acahalan@cs.uml.edu>:
  o [patch] fat/msdos/vfat crud removal

<ak@suse.de>:
  o Re: 2.5.23+ bootflag.c triggers __iounmap: bad address

<boris@kista.gajba.net>:
  o mad16.c

<da-x@gmx.net>:
  o Re: [PATCH] 2.5.21 - list.h cleanup

<dent@cosy.sbg.ac.at>:
  o adding slist.h: simple single-linked-list helper functions

<garloff@suse.de>:
  o Re: [PATCH] /proc/scsi/map

<gerald@esi.ac.at>:
  o isapnp_dma0.patch

<gerald@io.com>:
  o small cleanup of ide parameter parsing

<gianni@ecsc.co.uk>:
  o AF_PACKET: Clear out packet-mmap pages

<jwhite@codeweavers.com>:
  o Fix bug parsing option of isofs driver
  o Reverse isofs unhide option to hide

<manik@cisco.com>:
  o (off 2.5.22) replacing __builtin_expect with unlikely in Alpha headers

<martin.schwidefsky@debitel.net>:
  o 2.5.21 - end_request warning

<mgross@unix-os.sc.intel.com>:
  o tcore for 2.5.23 kernel

<ryan@michonline.com>:
  o ad1848_lib.c compile fix

<thunder7@xs4all.nl>:
  o 2.5.24 doesn't compile on Alpha

<tyketto@wizard.com>:
  o Re: 2.5.21 -- sound/core/misc.c:93: `file' undeclared in function

<wa@almesberger.net>:
  o policing for sch_prio (2.4,2.5)
  o include/net/dsfield.h warning (2.4,2.5)

<willy@debian.org>:
  o fs/locks.c: Fix posix locking for threaded tasks

<wli@holomorphy.com>:
  o remove magic numbers for fault return codes
  o smp_call_function() deadlock during boot

<zwane@linux.realnet.co.sz>:
  o [RFC] Memory barriers

Adam J. Richter <adam@yggdrasil.com>:
  o Trivial PATCH: linux-2.5.20/include/linux/blkdev.h -
  o Patch: linux-2.5.23/Rules.make - enable modversions.h to build
  o Re: IDE{,-SCSI} trouble [2.5.20]
  o Patch: linux-2.5.20/fs/bio.c - ll_rw_kio made incorrect
  o bio_append patch

Adrian Bunk <bunk@fs.tum.de>:
  o [2.5 patch] fix compilation of ad1848_lib.c
  o [2.5 patch] i2o_proc.c needs tqueue.h
  o [2.5 patch] drivers/net/aironet4500.h must include tqueue.h

Andi Kleen <ak@muc.de>:
  o [NEW PATCH, testers needed] was Re: [PATCH] poll/select fast path

Andrew Morton <akpm@zip.com.au>:
  o [Ext2-devel] Shrinking ext3 directories 1/3
  o [Ext2-devel] Shrinking ext3 directories 2/3
  o [Ext2-devel] Shrinking ext3 directories 3/3

Andrey Panin <pazke@orbita1.ru>:
  o [RFC] SGI VISWS support for 2.5

Andries E. Brouwer <Andries.Brouwer@cwi.nl>:
  o [PATCHlet] 2.5.23 usb, ide

Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>:
  o [redone PATCH 2.5.22] simple ide-tape/floppy.c cleanup

Benjamin LaHaise <bcrl@redhat.com>:
  o [patch] credentials for 2.5.23

Chris Mason <mason@suse.com>:
  o Re: ext3 performance bottleneck as the number of spindles gets

Chris Wright <chris@wirex.com>:
  o 2.5.20 drivers/scsi/ips.c cleanup

Frank Davis <fdavis@si.rr.com>:
  o 2.5.24 : include/linux/intermezzo_fs.h
  o 2.5.24 : tr_source_route undefined fix

Geert Uytterhoeven <geert@linux-m68k.org>:
  o khttpd and make_times_h

Greg Kroah-Hartman <greg@kroah.com>:
  o Re: 2.5.22 fix for pci_hotplug
  o Re: 2.5.22 fix for pci_hotplug

Hirofumi Ogawa <hirofumi@mail.parknet.co.jp>:
  o remove the fat_cvf

Ivan Kokshaysky <ink@jurassic.park.msu.ru>:
  o Re: 2.5.24 doesn't compile on Alpha

James Morris <jmorris@intercode.com.au>:
  o 3c509 compile fix for 2.5.24

James Simmons <jsimmons@transvirtual.com>:
  o [UPDATES] fbdev ports and fixes

Jan-Benedict Glaw <jbglaw@lug-owl.de>:
  o [Docu-PATCH] Updated docu for srm_env.o driver

Jeff Garzik <jgarzik@mandrakesoft.com>:
  o Re: [PROBLEM] sundance on d-link dfe-580tx

Patrick Mochel <mochel@osdl.org>:
  o Re: [patch] PCI device matching fix

Pete Zaitcev <zaitcev@redhat.com>:
  o Patch - SCSI host numbers - please apply

Peter Chubb <peter@chubb.wattle.id.au>:
  o ppp_generic.c doesn't compile on IA64

Robert Kuebel <kuebelr@email.uc.edu>:
  o do_mounts.c - compiler warning, comments, cramfs

Robert Love <rml@tech9.net>:
  o scheduler hints

Russell King <rmk@arm.linux.org.uk>:
  o CONFIG_GENERIC_ISA_DMA
  o Allow jffs2/super.c to build
  o Re: sparc64 pgalloc.h pgd_quicklist question

Rusty Russell <rusty@rustcorp.com.au>:
  o Trivial rename bitmap_member -> DECLARE_BITMAP
  o Fixed set_affinity/get_affinity syscalls

Stephen Rothwell <sfr@canb.auug.org.au>:
  o Consolidate include/asm/signal.h
  o cs46xx.c needs init.h
  o ipc statics
  o make Alpha use generic copy_siginfo_to_user
  o Make CRIS use generic copy_siginfo_to_user

Thunder from the hill <patch@luckynet.dynu.com>:
  o [2.5] Double quote patches part one: drivers 1/2
  o [2.5] Double quote patches part two: drivers 2/2
  o Floppy fix (unknown author)
  o HFS' inode.c needs init.h (unknown author)
  o Alpha patches (unknown author)
  o [2.5] List macros take two
  o Matroxfb tvout patches (unknown author)
  o 2.5.20 stack patch (unknown author)
  o Tulip devname fixes
  o [update] credentials for 2.5.24
  o Makefile fix for hamradio soundmodems

Tom Rini <trini@kernel.crashing.org>:
  o Include <linux/gfp.h> directly instead of via <linux/mm.h>
  o Remove numerous includes from <linux/mm.h>
-- 
Lightweight patch manager using pine. If you have any objections, tell me.

