Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265325AbTGKUP4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 16:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265946AbTGKUPo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 16:15:44 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:17291 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S265325AbTGKUOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 16:14:41 -0400
Date: Fri, 11 Jul 2003 17:26:38 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: lkml <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.22-pre5
Message-ID: <Pine.LNX.4.55L.0307111705090.5422@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Here goes -pre5.

It fixes a deadlock introduced by the IO fairness changes, fixes ACPI on
IBM's x440, has an uptodated cciss driver, a new ethernet driver for IBM
PPC's 4xx, amongst other fixes.

Please help testing.

Summary of changes from v2.4.22-pre4 to v2.4.22-pre5
============================================

<jcchen:icplus.com.tw>:
  o [netdrvr sundance] increase eeprom read timeout

<mike.miller:hp.com>:
  o cciss: change names and correct subsystem device ID for U320
  o cciss: PCI BAR fix
  o cciss: Fix potential overrun
  o cciss: update version
  o cciss: First part of PCI changes/driver cleanup
  o cciss: Second part of PCI changes/driver cleanup

Andi Kleen:
  o Fix compiling on x86-64

Benjamin Herrenschmidt:
  o radeonfb 0.1.8 + my stuffs

Chris Mason:
  o Fix deadlocks in IO scheduler changes

David Woodhouse:
  o Backport vsprintf/scanf fixes from 2.5.74

Geert Uytterhoeven:
  o Fix adbhid m68k screwup

J. A. Magallon:
  o hfsplus: group Apple FS's and help text

John Stultz:
  o Fix boot crash of x440's in full acpi mode
  o Cleanup x440 acpi fix

Marcelo Tosatti:
  o Changed EXTRAVERSION to -pre5

Petr Vandrovec:
  o Fix matroxfb on PPC64

Tom Rini:
  o An ethernet driver for the IBM PPC 4xx series of machines

