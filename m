Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310419AbSCAKAd>; Fri, 1 Mar 2002 05:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310425AbSCAJ6h>; Fri, 1 Mar 2002 04:58:37 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:57990 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S310419AbSCAJzu>; Fri, 1 Mar 2002 04:55:50 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Fri, 1 Mar 2002 01:55:25 -0800
Message-Id: <200203010955.BAA00986@adam.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: linux-2.5.6-pre2 IDE broken for Via vt82c596b chipset
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I see that there have been some changes to drivers/ide.
I have not completely tracked this problem down yet, but here goes.
When I try to boot linux-2.5.6-pre2 and load the ide-mod.o module,
I get:

VP_IDE: VIA vt82c596b (rev 12) IDE UDMA66 controller on pci
: dma_base is invalid (0x0000)
ide0: Bus-Master DMA was diabled by BIOS

	No IDE devices are detected (using devfs, /dev/ide/ exists
but is empty).  The other machine that I tried this on is also a
vt82c596b (rev 23), and behaves the same way.  Linux-2.5.3 seems
to work fine, however.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
