Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266580AbUHZCto@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266580AbUHZCto (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 22:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266756AbUHZCto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 22:49:44 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:923 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266580AbUHZCti
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 22:49:38 -0400
Date: Wed, 25 Aug 2004 22:01:52 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.28-pre2
Message-ID: <20040826010152.GB25340@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

Here goes the second -pre of v2.4.28.

It contains more SATA fixes, S390 update, number of 
PCI hotplug fixes, NFS update, IDE PCI Triflex, amongst 
others.

Also a bunch of gcc 3.4 fixes, hopefully we are done
with that now.

Enjoy


Summary of changes from v2.4.28-pre1 to v2.4.28-pre2
============================================

<achew:nvidia.com>:
  o [libata sata_nv] support for hardware, bug fixes
  o [libata sata_nv] fix leak on error

<david.martinez:rediris.es>:
  o Update ftape webpage

<linville:tuxdriver.com>:
  o Add IOI Media Bay to SCSI quirk list

<mbroemme:plusserver.de>:
  o Fix kernel oops in nsc-ircc.c

<rainer.weikusat:sncag.com>:
  o bkgoodman@bradgoodman.com: MTD cfi_cmdset_0002.c - Duplicate cleanup in error path

<sezeroz:ttnet.net.tr>:
  o pm3fb and kaweth missing casts
  o ns83820.c warning fixes
  o cpqarray/cciss gcc3.4 inline fixes
  o ieee1394/hisax gcc 3.4 inline fixes
  o radio/video gcc3.4 inline fixes
  o mtd gcc3.4 inline fixes
  o net drivers gcc3.4 inline fixes
  o scsi drivers gcc3.4 inline fixes
  o USB gcc3.4 inline fixes
  o net gcc3.4 inline fixes
  o char gcc3.4 inline fixes
  o filesystems (fs/) gcc3.4 inline fixes
  o intermezzo gcc3.4 inline fixes
  o uninline do_generic_direct_read

<thor:math.tu-berlin.de>:
  o NetMOS 9805 ParPort interface

Adrian Bunk:
  o 2.4.28-pre1: add two SATA Configure.help entries
  o disallow modular BINFMT_ELF

Alan Cox:
  o [libata] improve translation of ATA errors to SCSI sense codes
  o ad1816 sound driver web page and email address update

Andrew Morton:
  o libata build fix

Badari Pulavarty:
  o scsi PHYS_4G merging doesn't work

Bartlomiej Zolnierkiewicz:
  o Fix IDE Triflex hang on boot with two single-channel controllers

Dan Zink:
  o PCI Hotplug: fix potential hang in cpqphp

Daniel Ritz:
  o enable read prefetch on o2micro bridges to fix HDSP
  o fix EnE Cardbus bridges for HDSP

David S. Miller:
  o [SPARC64]: Add missing nop to itlb_base.S

Dely Sy:
  o PCI Hotplug: Fixes for hot-plug drivers in 2.4 kernel

Douglas Gilbert:
  o [libata] fix INQUIRY handling

Gary Hade:
  o PCI Hotplug: change MAINTAINERS

Jeff Garzik:
  o [libata] (cosmetic) sync with 2.6.x
  o [libata] support commands SYNCHRONIZE CACHE, VERIFY, VERIFY(16)
  o [libata] fix PIO data xfer on big endian
  o [libata] ATAPI PIO data xfer
  o [libata] add ioctl infrastructure
  o [libata] fix error recovery reference count and in-recovery flag
  o [ata] remove 'packed' attributed from struct ata_prd

Marcelo Tosatti:
  o Changed EXTRAVERSION to -pre2

Martin Schwidefsky:
  o s390: core changes
  o s390: ibm partition table
  o s390: system tick misaccounting
  o s390: dasd changes
  o s390: ctc fixes
  o s390: iucv net driver fixes
  o s390: qeth network driver fixes

Mikael Pettersson:
  o gcc34 inline failure fixes

Neil Brown:
  o Allow larger NFSd MAXBLKSIZE on architectures with larger PAGE_SIZE
  o Fixed possibly xdr parsing error if write size exceed 2^31
  o Use llseek instead of f_pos= for directory seeking
  o mark NFS/TCP not EXPERIMENTAL

Patrick McHardy:
  o [RBTREE]: Add rb_{first,last,prev,next}
  o [NET_SCHED]: Replace eligible list by rbtree in HFSC scheduler
  o [NET_SCHED]: Replace actlist by rbtrees in HFSC scheduler
  o [NET_SCHED]: O(1) children vtoff adjustment in HFSC scheduler
  o [PKT_SCHED]: Remove unnecessary memsets in packet schedulers

Pete Zaitcev:
  o USB: update unusual_devs.h
  o USB: remove "interrupt, status %x, frame# %i"
  o The Dell's fix for TEAC CD-210PU

