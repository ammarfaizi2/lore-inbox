Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267957AbUGaO34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267957AbUGaO34 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 10:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267960AbUGaO34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 10:29:56 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6031 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267957AbUGaO3T convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 10:29:19 -0400
Date: Sat, 31 Jul 2004 11:26:59 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.27-rc4
Message-ID: <20040731142658.GA6497@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

Here goes the forth 2.4.27 release candidate.

It includes a dozen of USB fixes, JFS update, IA64 fixes, 
networking update, amongst others.

2.4.27 final should be out soon.

Please read the detailed changelog for more details.


Summary of changes from v2.4.27-rc3 to v2.4.27-rc4
============================================

<ajgrothe:yahoo.com>:
  o [CRYPTO]: Add TEA and XTEA algorithms

<jaap.keuter:xs4all.nl>:
  o [IPV4]: Calculate default broadcast even when using SIOCSIGNETMASK

<mjc:redhat.com>:
  o USB: more sparse fixes

<tomd:csds.uidaho.edu>:
  o [CRYPTO]: Set CRYPTO_TFM_RES_BAD_KEY_LEN in twofish

Adrian Bunk:
  o [IPV4]: Remove no longer available URL
  o cmpci oops on rmmod + fix

Anton Blanchard:
  o [TG3]: Missing rmb() in rx processing

Arun Sharma:
  o ia64: tighten FPH state context switch check

Dave Kleikamp:
  o JFS: Error path released metadata page it shouldn't have
  o JFS: Updated field isn't always written to disk during truncate
  o JFS: Protect active_ag with a spinlock
  o JFS: prevent concurrent calls to txCommit on the imap inode
  o JFS: Check for dmap corruption before using leafidx
  o JFS: jfs_dmap build fix

David S. Miller:
  o [TG3]: Always do 4gb tx dma test, and fix the test
  o [TG3]: Fibre PHY fixes from Sun
  o [TG3]: Update driver version and reldate
  o [TG3]: Delay both before and after PCI cfg space readback after reset
  o [TG3]: Bump driver version and reldate
  o [TG3]: Update reldate to match 2.6.x sources
  o [IPV4]: Make raw sockets behave like udp wrt. MSG_TRUNC
  o [ATM]: Update Marko Kiiskila's email address
  o [PKT_SCHED]: sch_netem.c needs linux/init.h
  o [CRYPTO]: No MODULE_ALIAS in 2.4.x

Geert Uytterhoeven:
  o M68k ifpsp060
  o M68k 68060 errata I14
  o M68k Maintainership

Herbert Xu:
  o [CRYPTO]: Fix stack overrun in crypt()

Jochen Hein:
  o Update Jochen CREDITS entry

Karsten Keil:
  o I4L: Fix IRQ-sharing lockup in nj_s

Marcel Holtmann:
  o [Bluetooth] Respond to L2CAP info requests
  o [Bluetooth] Add support for another ALPS module
  o [Bluetooth] Use a signed integer for the RSSI value

Marcelo Tosatti:
  o USB: fix endless resubmit in auerswald (Wolfgang Mues)
  o Changed EXTRAVERSION to -rc4

Masanari Iida:
  o Fix harmless typo in drivers/char/sysrq.c

Mikael Pettersson:
  o cardbus.c pointer truncation bug on 64-bitters

Patrick McHardy:
  o [IPV4/IPV6]: Add myself to MAINTAINERS

Pete Zaitcev:
  o USB: update unusual_devs.h
  o USB: GET_ID from nonzero interface (errandir_news@mph.eclipse.co.uk)
  o USB: add free_len=0 initialization to ipaq.c (Ganesh Varadaraja)
  o USB: correct dbg() arguments in pl2303 (Phil Dibowitz)
  o USB: missing rcomplete=0 in printer.c (David Woodhouse)

Petr Vandrovec:
  o [VLAN]: Do not access released memory

Samuel Thibault:
  o [UDP]: Return true length if user specifies MSG_TRUNC

Stephen Hemminger:
  o [PKT_SCHED]: Update to network emulation QOS scheduler
  o [PKT_SCHED]: One small netem fixes
  o [BRIDGE]: Fix assertion failure in 2.4.27-rc3
  o [PKT_SCHED]: netem update for 2.4

Stéphane Eranian:
  o ia64: fix info in /proc/pal/*/bus_info
  o ia64: fix perfmon buffer init

