Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319106AbSHSXbw>; Mon, 19 Aug 2002 19:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319109AbSHSXbw>; Mon, 19 Aug 2002 19:31:52 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:20755 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S319106AbSHSXbs>; Mon, 19 Aug 2002 19:31:48 -0400
Date: Mon, 19 Aug 2002 19:46:16 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: lkml <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.20-pre4
Message-ID: <Pine.LNX.4.44.0208191944210.10105-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


So here goes -pre4, with JFS merged.

Also, if you got bootup lockups or some unexpected weird error try
-pre4 ;)



Summary of changes from v2.4.20-pre3 to v2.4.20-pre4
============================================

<gone@us.ibm.com>:
  o setup_arch() cleanups
  o (2/4) discontigmem support for i386 against 2.4.20pre3

<green@angband.namesys.com>:
  o Fix a problem that when doing online resizing, resizer code forgot to update bitmap usage counters
  o Fix a problem where bitmap usage counters were possibly incorrectly updated on bigendian and 64 bit boxes

<hch@lst.de>:
  o VM docs from -ac
  o fix current BK tree compilation with devfs enabled

<johnstul@us.ibm.com>:
  o 686-notsc_A0
  o [PATCH] notsc-warning_A0

<oliver@oenone.homelinux.org>:
  o USB: hpusbscsi driver updates

<roland@topspin.com>:
  o USB storage: get rid of DMA to stack

Adrian Bunk <bunk@fs.tum.de>:
  o Fix ftape build problems

Christoph Hellwig <hch@sb.bsdonline.org>:
  o JFS: Initial import of version 1.0.18 for Linux 2.4

Dave Kleikamp <shaggy@kleikamp.austin.ibm.com>:
  o JFS: Fix structure alignment problem on 64-bit machines
  o JFS: Add hch's copyright
  o JFS: sanitize ->clear_inode, remove ->put-inode
  o Fix races in JFS threads
  o JFS: Yet another truncation fix
  o JFS does not need to set i_version.  It is never used
  o JFS: fix fsync
  o procfs entries should be created when CONFIG_JFS_STATISTICS is set
  o JFS: set s_maxbytes to 1 byte lower
  o Rework JFS's inode locking
  o JFS: Dynamically allocate metapage structures
  o Remove d_delete calls from jfs_rmdir & jfs_unlink
  o JFS: Fix handling of commit_sem
  o Add resize function to JFS
  o fix typo in fs/jfs/resize.c
  o JFS: Replace depreciated initializer syntax with C99 style
  o JFS: Trivial fixes

Geert Uytterhoeven <geert@linux-m68k.org>:
  o Fix compile warning in init/do_mounts.c

Greg Kroah-Hartman <greg@kroah.com>:
  o USB: serial Config.in cleanups
  o USB: ftdi_sio driver update
  o USB: ipaq driver updates
  o USB: pl2303 driver update
  o USB:  serial driver minor fixes
  o USB: ir-usb driver minor fixes
  o USB: add usb-storage sddr-55 driver
  o USB: bluetooth driver fixes
  o USB: scanner driver update and maintainer change

Marcelo Tosatti <marcelo@plucky.distro.conectiva>:
  o Changed EXTRAVERSION to -pre4
  o Added arch/i386/kernel/time.o to exportobj list

Niels Kristian Bech Jensen <nkbj@image.dk>:
  o Avoiding implicit declaration in net/netsyms.c
  o Fixing a compiler warning in drivers/block/genhd.c

Paul Mackerras <paulus@samba.org>:
  o fix bug in yield()

Richard Gooch <rgooch@atnf.csiro.au>:
  o Switched to ISO C structure field initialisers
  o base.c

Simon Evans <spse@secret.org.uk>:
  o 2.4.19 - add support for f5u011 to catc.c

Steven Cole <elenstev@mesatop.com>:
  o 2.4.20-pre2 add module text for 58 options

Trond Myklebust <trond.myklebust@fys.uio.no>:
  o Add round trip timing to RPC over UDP client [1/3]
  o Add round trip timing to RPC over UDP client [2/3]
  o Add round trip timing to RPC over UDP client [3/3]
  o Improve RPC request ordering
  o Improve network congestion code [1/3]
  o Improve network congestion code [2/3]
  o Improve network congestion code [3/3]
  o Fix RPC write_space() code
  o Increase UDP socket buffer size

V. Ganesh <ganesh@vxindia.veritas.com>:
  o typo in usb/serial/ipaq.h


