Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271940AbTHHUuc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 16:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271939AbTHHUuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 16:50:32 -0400
Received: from proibm3.procempa.com.br ([200.248.222.108]:57998 "EHLO
	portoweb.com.br") by vger.kernel.org with ESMTP id S271898AbTHHUuR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 16:50:17 -0400
Date: Fri, 8 Aug 2003 17:53:24 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@logos.cnet
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.22-rc2 
Message-ID: <Pine.LNX.4.44.0308081751390.10734-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

Here goes release candidate 2. 

It contains yet another bunch of important fixes, detailed below.

Nice weekend for all of you!


Summary of changes from v2.4.22-rc1 to v2.4.22-rc2
============================================

<bjorn.helgaas:hp.com>:
  o HP ZX1 PCI ID update

<khali:linux-fr.org>:
  o i2c-dev ioctl fixes

<marcelo:logos.cnet>:
  o ide.c: Keep hwif->hold flag needed by powermac mbay driver
  o Changed EXTRAVERSION to -rc2

<robn:verdi.et.tudelft.nl>:
  o Do not update fifo timestamps on readonly fses

Alan Cox:
  o ide makefile
  o Promise cable
  o Fix the siimage dma setup bug
  o via ide fix timing bug (as already done in 2.6.0-test)
  o fix bracketing in ti113x pcmcia header
  o remove bogus printk that can spam the logs
  o zero padding in struct on stack
  o get quota version
  o Avoid i810 ICH crashes with MMIO only

Andrew Morton:
  o ext3_read_inode() race fix

Herbert Xu:
  o Fix steal_locks race

Ivan Kokshaysky:
  o alpha: shutdown/reboot fix (Jay Estabrook, me)

Marc-Christian Petersen:
  o Intel ICH5 PCI IDs

Oleg Drokin:
  o reiserfs: fix some issues with extended inode attributes




