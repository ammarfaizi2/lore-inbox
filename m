Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263915AbTHWRgH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 13:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265173AbTHWRgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 13:36:06 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:17300 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S263460AbTHWRez convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 13:34:55 -0400
Date: Sat, 23 Aug 2003 14:30:45 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: lkml <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.22-rc3
Message-ID: <Pine.LNX.4.55L.0308231429530.19769@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Here goes -rc3, with several fixes. The ACPI changes should fix most of
well known ACPI issues: Please test it.

This is the last -rc I hope.

Detailed changelog below


Summary of changes from v2.4.22-rc2 to v2.4.22-rc3
============================================

<len.brown:intel.com>:
  o ACPI update
  o ACPI build fix
  o linux-acpi-2.4.22.patch

<marcelo:logos.cnet>:
  o Cset exclude: jgarzik@redhat.com|ChangeSet|20030706160607|06244
  o Cset exclude: jgarzik@redhat.com|ChangeSet|20030705173225|06246
  o Changed EXTRAVERSION to -rc3
  o Update Makefile: drivers/sgi removed
  o Make the Toshiba TC35815 only selectable on the only system know to actually use it

<markhe:veritas.com>:
  o Wrong assumption in set_bh_page()

<paul.clements:steeleye.com>:
  o nbd: fix race conditions

<steved:redhat.com>:
  o Stop call_decode() from ignorning RPC header errors

Alan Cox:
  o Alan CREDIT/MAINTAINERS update

Andi Kleen:
  o Disable ACPI NUMA support for x86-64
  o Critical x86-64 fixes for 2.4.22-rc
  o [SECURITY] Fix interrupt gates on x86-64

Andrea Arcangeli:
  o Andrea contact information update

Andreas Gruenbacher:
  o More steal_locks fixes: we should be in full LSB compliance now

David S. Miller:
  o [IPV6]: Fix dangling multicast device references

David Stevens:
  o [NET]: Fix IGMPv2/MLDv2 list handling OOPS

Erik Andersen:
  o Fix cdrom error handling

Geert Uytterhoeven:
  o Remove unused label in sunrpc code
  o Update Geert's contact information

Ivan Kokshaysky:
  o alpha: yet another stxncpy fix

Jeff Garzik:
  o fix OOPS in bonding driver, when removing primary slave
  o add a couple pci ids to pci_ids.h

Kai Makisara:
  o Change Kai Makisara's email address

Marcelo Tosatti:
  o Ingo: Fix ptrace swap race
  o Changed HFS maintainer: Roman Zippel is now doing the work

Michal Ostrowski:
  o Fix PPPoE oops on unload

Muli Ben-Yehuda:
  o fix trident.c lockup on module load 2.4.22-rc1

Nathan Scott:
  o Fix 2.4 loop handling of sector size ioctl

Petr Vandrovec:
  o Allow atime updates on ncpfs

Ralf Bächle:
  o Important DEC/MIPS update
  o More MIPS update

