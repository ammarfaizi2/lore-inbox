Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265698AbUBKToU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 14:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265728AbUBKToU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 14:44:20 -0500
Received: from intra.cyclades.com ([64.186.161.6]:59562 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S265698AbUBKToR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 14:44:17 -0500
Date: Wed, 11 Feb 2004 17:31:41 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.25-rc2
Message-ID: <Pine.LNX.4.58L.0402111728060.28576@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ola,

Here goes -rc2, with small number of fixes and corrections.

Most notably acpi4asus and toshiba ACPI updates.

Detailed changelog follows.

Summary of changes from v2.4.25-rc1 to v2.4.25-rc2
============================================

<brad:wasp.net.au>:
  o backport 2.6.x yenta detection fix

<davem:nuts.davemloft.net>:
  o [IPV4]: Use same sysctl number for IGMP version forcing as 2.6.x
  o [SPARC64]: Fix exception remaining length calcs in VIS copy routines

<john:neggie.net>:
  o toshiba_acpi 0.17 from John Belmonte

<khali:linux-fr.org>:
  o Small i2c maintainer correction

<len.brown:intel.com>:
  o [ACPI] proposed fix for AML parameter passing from Bob Moore http://bugzilla.kernel.org/show_bug.cgi?id=1766
  o [ACPI] proposed fix for AML parameter passing from Bob Moore http://bugzilla.kernel.org/show_bug.cgi?id=1766
  o [ACPI] fix IA64 build warning from Martin Hicks

<macro:ds2.pg.dga.pl>:
  o [NET]: Fix comment typo in net/socket.c

<marcelo:logos.cnet>:
  o Changed EXTRAVERSION to -rc2

<shaggy:kleikamp.dyn.webahead.ibm.com>:
  o JFS: rename should update mtime on source and target directories
  o JFS: Threads should exit with complete_and_exit

<sziwan:hell.org.pl>:
  o acpi4asus update from Karol 'sziwan' Kozimor

Adrian Bunk:
  o Fix amd7930_fn.c compilation with CONFIG_HOTPLUG=n

Alan Cox:
  o sstfb oops fix

Andrew Morton:
  o Improper handling of %c in vsscanf

Geert Uytterhoeven:
  o Fix fs/inode.c warning if !HIGHMEM

Keith Owens:
  o [XFS] No need to have xfs in mod-subdirs in the fs/Makefile anymore

Paul Mackerras:
  o [PPC64] Two small fixes for hvc_console (the hypervisor virtual console)

