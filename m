Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316195AbSFDD6l>; Mon, 3 Jun 2002 23:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316213AbSFDD6k>; Mon, 3 Jun 2002 23:58:40 -0400
Received: from pD9E23D09.dip.t-dialin.net ([217.226.61.9]:1682 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S316195AbSFDD6i>; Mon, 3 Jun 2002 23:58:38 -0400
Date: Mon, 3 Jun 2002 21:58:32 -0600 (MDT)
From: Lightweight patch manager <patch@luckynet.dynu.com>
X-X-Sender: patch@hawkeye.luckynet.adm
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: linux-2.5.20-ct1
Message-ID: <Pine.LNX.4.44.0206032154470.17873-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I picked up some trivial patches and fixed some stuff here and there...

The result is available at
<URL:ftp://luckynet.dynu.com/pub/linux/2.5.20-ct1/linux-2.5.20-ct1.patch.bz2>

The full ChangeLog is available at
<URL:ftp://luckynet.dynu.com/pub/linux/2.5.20-ct1/ChangeLog-2.5.20-ct1>

The single patches are available at 
<URL:ftp://luckynet.dynu.com/pub/linux/2.5.20-ct1/single-patches/>

Here is the ChangeLog:

Summary of changes from v2.5.20 to v2.5.20-ct1
==============================================

<dank@kegel.com>:
  o Trivial: must be __KERNEL__ for byteorder/generic.h

<rweight@us.ibm.com>:
  o Scalable CPU bitmasks
  o Scalable phys_cpu_present_map

<wli@holomorphy.com>:
  o remove mixture of non-atomic operations with page->flags which requires atomic operations to access
  o repetitive reinitialization of active_list and inactive_list in free_area_init_core()
  o make balance_classzone() use list.h
  o complete comment regarding inner workings of buddy system
  o duplicate declaration of rq in sched_init()
  o Re: forget_pte()
  o remove antiquated comment from page_alloc.c
  o convert page_alloc.c bugchecks to BUG_ON()
  o remove MARK_USED() macros
  o remove memlist_* macros from page_alloc.c
  o correct inaccurate comment regarding zone_table's usage

<zwane@linux.realnet.co.sz>:
  o bluesmoke merge

Adam J. Richter <adam@yggdrasil.com>:
  o Trivial patch: linux-2.5.20/Rules.make cleanup

Andreas Dilger <adilger@clusterfs.com>:
  o Re: another -pre

Andrew Morton <akpm@zip.com.au>:
  o PCI device matching fix

Anton Blanchard <anton@samba.org>:
  o Fix for recent swap changes on 64 bit archs

Arnaldo Carvalho de Melo <acme@conectiva.com.br>:
  o more copy_{to,from}_user fixes

Brad Hards <bhards@bigpond.net.au>:
  o General options - begone

cr@darav.de <cr@daRav.de>:
  o agppart SiS 745 Patch - did it wrong before

James Simmons <jsimmons@transvirtual.com>:
  o Fbdev updates and fixes

Keith Owens <kaos@ocs.com.au>:
  o kbuild-2.5 (slightly older version (didn't have a certain bug))

Maksim Krasnyanskiy <maxk@qualcomm.com>:
  o Fix non-modular Bluetooth compilation
  o Bluetooth PCMCIA drivers update

Martin Dalecki <dalecki@evision-ventures.com>:
  o airo wireless -  "I can't get no, compilation..."
  o 2.5.20 IDE 83

Pavel Machek <pavel@ucw.cz>:
  o Cleanup swsusp in 2.5.20
  o Fix suspend-to-RAM in 2.5.20
  o Re: Fix suspend-to-RAM in 2.5.20

Randy Hron <rwhron@earthlink.net>:
  o remove space in cache names

Russell King <rmk@arm.linux.org.uk>:
  o fix 2.5.20 ramdisk

Rusty Russell <rusty@rustcorp.com.au>:
  o TRIVIAL: TAGS creation should go into arch dirs

Thunder from the hill <patch@hawkeye.luckynet.adm>:
  o Remove the special handling for hidden files in fs/isofs/namei.c and fs/isofs/dir.c
  o Make mount_block_root() wait up to 60 seconds before panic() in case we don't find root fs.

Trond Myklebust <trond.myklebust@fys.uio.no>:
  o Re: [2.5.20-BUG] 3c59x + highmem + acpi + nfs -> kernel panic
-- 
Lightweight patch manager using pine. If you have any objections, tell me.

