Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263034AbSJGNbg>; Mon, 7 Oct 2002 09:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263040AbSJGNbg>; Mon, 7 Oct 2002 09:31:36 -0400
Received: from h-64-105-137-52.SNVACAID.covad.net ([64.105.137.52]:20096 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S263034AbSJGNbf>; Mon, 7 Oct 2002 09:31:35 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Mon, 7 Oct 2002 06:37:02 -0700
Message-Id: <200210071337.GAA00726@adam.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.40 boot problem on 440GX w/dual P2 processors
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	When I try to boot 2.5.40 on a 440GX with dual Pentium II
processors, I got an infinite loop that continually printed "APIC
error on CPU1: 08(08)".  The same boots 2.5.34 OK (well, with a kernel
crash about every three hours, but it runs 2.5.31 without problems).
This is an SMP kernel with CONFIG_PREEMPT.  I expect to look into the
problem further if it still occurs in 2.5.41, but thought I ought to
report it in the meantime.

	By the way, here is the lspci from the machine:

00:00.0 Host bridge: Intel Corporation 440GX - 82443GX Host bridge
00:01.0 PCI bridge: Intel Corporation 440GX - 82443GX AGP bridge
00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
00:0d.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)
00:0f.0 Ethernet controller: Digital Equipment Corporation DECchip 21140 [FasterNet] (rev 22)
00:10.0 VGA compatible controller: S3 Inc. 86c764/765 [Trio32/64/64V+]
00:14.0 Unknown mass storage controller: Promise Technology, Inc.: Unknown device 4d69 (rev 02)


Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
