Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315282AbSFOLjd>; Sat, 15 Jun 2002 07:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315285AbSFOLjc>; Sat, 15 Jun 2002 07:39:32 -0400
Received: from h-64-105-136-45.SNVACAID.covad.net ([64.105.136.45]:65437 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S315282AbSFOLjb>; Sat, 15 Jun 2002 07:39:31 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sat, 15 Jun 2002 04:39:22 -0700
Message-Id: <200206151139.EAA01867@adam.yggdrasil.com>
To: acpi-devel@lists.sourceforge.net
Subject: acpi problems in 2.5.20 or 2.5.21
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        Linux-2.5.19 with acpi runs fine on every machine that I
have tried it on, as does Linux-2.5.21 without acpi.  However,
Linux-2.5.21 with acpi hangs at boot time before the kernel
prints any output on one of these computers, and reboots at boot
time before printing any output that I could see on another.
I suspect that something is wrong with the way the kernel gets

                                        2.5.19  2.5.21  2.5.21
                                        + ACPI  + ACPI  no ACPI

VIA VT82C691 [Apollo PRO] (rev c4)	ok	ok	ok
VIA VT82C691 [Apollo PRO] (rev 44)	ok	hangs	ok
Intel 440GX - 82443GX Host bridge	ok	reboots	ok

	There were substantial acpi changes in 2.5.20, and
almost acpi changes in 2.5.21.

	Anyhow, I hope this information is useful.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
