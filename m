Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263305AbTEVWIh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 18:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263317AbTEVWIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 18:08:37 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:22221 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S263305AbTEVWIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 18:08:32 -0400
Date: Thu, 22 May 2003 19:19:38 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: lkml <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.21-rc3
Message-ID: <Pine.LNX.4.55L.0305221915450.1975@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Here goes the third release candidate of 2.4.21.


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

