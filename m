Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269559AbTHESlD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 14:41:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269619AbTHESlD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 14:41:03 -0400
Received: from pwmail.portoweb.com.br ([200.248.222.108]:54169 "EHLO
	portoweb.com.br") by vger.kernel.org with ESMTP id S269559AbTHESk5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 14:40:57 -0400
Date: Tue, 5 Aug 2003 15:44:09 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@logos.cnet
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.22-rc1
Message-ID: <Pine.LNX.4.44.0308051543130.12501-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello, 

Here goes the first release candidate of 2.4.22.

Please test it extensively.

Detailed changelog below. 

Summary of changes from v2.4.22-pre10 to v2.4.22-rc1
============================================

<calum.mackay:cdmnet.org>:
  o export the symbol "mmu_cr4_features" for XFree86

<lethal:unusual.internal.linux-sh.org>:
  o sh: Define __flush_icache_all() for SH-3
  o sh: Fix single stepping from looping
  o sh: Add pgprot_nocached() definition
  o sh: Further support for SecureEdge5410 and SH7751R

<marcelo:logos.cnet>:
  o Delete: fs/noquot.c
  o Cset exclude: bunk@fs.tum.de|ChangeSet|20030804201535|32414
  o Changed EXTRAVERSION to -rc1

Adrian Bunk:
  o fix a compile warning in acpi/system.c
  o Fix circular dependency

Benjamin Herrenschmidt:
  o ppc32: Fix PowerMac mediabay driver

Jeff Garzik:
  o devices.txt: rename /dev/intel_rng to /dev/hwrandom
  o [i810_rng] update docs to reflect new /dev name, and new pkg name

Manfred Spraul:
  o fix select() with an xoffed tty

Theodore Y. T'so:
  o Correct 64-bit write system call assignment


