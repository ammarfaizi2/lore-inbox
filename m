Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262571AbTIUUfS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 16:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262573AbTIUUfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 16:35:18 -0400
Received: from mikonos.cyclades.com.br ([200.230.227.67]:17169 "EHLO
	firewall.cyclades.com.br") by vger.kernel.org with ESMTP
	id S262571AbTIUUfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 16:35:00 -0400
Date: Sun, 21 Sep 2003 17:37:40 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
X-X-Sender: marcelo@logos.cnet
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.23-pre5
Message-ID: <Pine.LNX.4.44.0309211438440.17528-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Here goes -pre5. It contains a bunch of important ACPI fixes, adds a very
important missing hunk from -aa VM merge, amongst others.

Detailed changelog below


Summary of changes from v2.4.23-pre4 to v2.4.23-pre5
============================================

<achirica:telefonica.net>:
  o [wireless airo] Fix MIC support using CryptoAPI

<amir.noam:intel.com>:
  o [bonding 2.4] Get rid of MOD_*_USE_COUNT, and use C99 initializers
  o [bonding 2.4] Backport free_netdev()
  o [bonding 2.4] Backport PDE()
  o [bonding] Convert /proc to seq_file

<bjorn.helgaas:hp.com>:
  o IA64 config help update
  o IA64 460GX gart support
  o IA64 ZX1 gart support

<daniel:deadlock.et.tudelft.nl>:
  o Patch: Fix reported Atyfb problem on Sparc

<len.brown:intel.com>:
  o Extended IRQ resource type for nForce (Andrew de Quincey) Handle BIOS with _CRS that fails (Jun Nakajima)
  o Fix ACPI oops on ThinkPad T32/T40 (Shaohua David Li)
  o support non ACPI compliant SCI over-ride specs (Jun Nakajima)
  o remove ASUS A7V BIOS version 1011 from blacklist (Eric Valette)
  o fix off-by-one error in ioremap() fixes kernel crash in acpi mode: http://bugzilla.kernel.org/show_bug.cgi?id=1085
  o ACPI_CA_VERSION                 0x20030916
  o tables.c.diff
  o from 2.6 acpi_pci_link_get_irq() returns 0 on error, not -ENODEV. (Christophe Saout)
  o exclude acpitable.[ch] from the CONFIG_ACPI_HT_ONLY build
  o [ACPI] delete acpitable.[ch], which used to be just for CONFIG_ACPI_HT_ONLY
  o [ACPI] Fix SCI storm on out of spec boards like Tyan http://bugzilla.kernel.org/show_bug.cgi?id=774
  o [ACPI] acpi_disabled is used after __initdata is freed
  o [ACPI] fix IO-APIC mode SCI storm due to sharing with PCI device (David Shaohua Li) http://bugzilla.kernel.org/show_bug.cgi?id=1165

<liam.girdwood:wolfsonmicro.com>:
  o 2.4.23-pre3 WM97xx touchscreen documentation

<marcelo:logos.cnet>:
  o Liam Girdwood: eliminates pop noises when doing a PM suspend/resume with the WM9712 AC97 codec.
  o Fix ide-scsi initialization lockup (kudos to Alan)
  o Changed EXTRAVERSION to -pre5
  o Fix Andrea VM merge error

<stuart_hayes:dell.com>:
  o Fix ide-tape lock up

Adrian Bunk:
  o add CONFIG_AGP_ATI Configure.help entry

Andi Kleen:
  o Fix x86-64 compatilation for pre4

Andrea Arcangeli:
  o Fix nr_free_buffer_pages()
  o Remove unused code from balance_classzone()

Geert Uytterhoeven:
  o Fixup atyfb changes in -pre4

Harald Welte:
  o [NETFILTER]: Use u16 for port numbers

Jeff Garzik:
  o fix ifdown+ifup
  o [sound i810_audio] sync with 2.5

Jens Axboe:
  o ide-cd capacity "bug"

Marc-Christian Petersen:
  o Fix wrong slash/backslash in ACPI
  o Fix 'head.S:116: warning: extra tokens at end of #endif directive'
  o Missing 'Hermes in TMD7160/NCP130 based PCI adaptor support' config option
  o Fwd: [PATCH 2.4.23-pre1] Menu fixes

Martin K. Petersen:
  o forte sound driver update

Mikael Pettersson:
  o repair mpparse for default MP systems

Neil Brown:
  o Revert broken knfsd change

Oleg Drokin:
  o Update reiserfs configure help

Paul Mackerras:
  o Fix IDE compile on PPC in 2.4.23-pre4
  o PPC32: Fix compile for "Walnut" board.  Patch from David Gibson
  o PPC32: Use nap mode in the idle loop on the PPC970
  o PPC32: Change the ucontext to move the sigmask back where it was

Tom Rini:
  o PPC32: Fix udelay in the PPC boot code for non-16.6 MHz timebases
  o PPC32: Fix another incorrect asm statement
  o PPC32: Fix a rounding error in the bootwrapper udelay



