Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264088AbTKJTa5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 14:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264089AbTKJTa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 14:30:57 -0500
Received: from intra.cyclades.com ([64.186.161.6]:47314 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S264088AbTKJTaw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 14:30:52 -0500
Date: Mon, 10 Nov 2003 17:28:14 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.23-rc1
Message-ID: <Pine.LNX.4.44.0311101723110.2001-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

Here goes -rc1.

It contains network driver fixes (b44, tg3, 8139cp), several x86-64
bugfixes, amongst others.


Please help testing!


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


