Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264704AbUGaWQY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264704AbUGaWQY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 18:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264702AbUGaWQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 18:16:23 -0400
Received: from smtp18.wxs.nl ([195.121.6.14]:19884 "EHLO smtp18.wxs.nl")
	by vger.kernel.org with ESMTP id S264763AbUGaWOL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 18:14:11 -0400
Date: Sun, 01 Aug 2004 00:13:08 +0200
From: Arvind Autar <Autar022@planet.nl>
Subject: Hardrive driver issues?
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       b.zolnierkiewicz@elka.pw.edu.pl, jgarzik@pobox.com, Autar022@planet.nl
Message-id: <1091311988.15039.1.camel@localhost>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.6
Content-type: text/plain
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

o, here I'm, trying to setup a box.
I installed debian sarge with 2.4.25-1-386. It ran fine, but didn't
work with my s-ata disk.

I grabbed 2.6.8-rc2 and 2.6.8-rc1-mm1. Bot gave me the same results.

My ata disk uses Amd74xx Adn the s-ata siimage/sata_sil . The amd74
got compiled in as * because that's the disk where linux got
installed. siimage/sata_sil got copmiled as a module, I needed the
disk to mount my fat32 partition so I could get to mine music files. I
booted both kernels both of them started to freeze after a while. So I
started to look in the log files and found this: (see attachment)208K
Unfortunately I don't have any debugging(?) info from the Amd74xx all
I know is that it gives some error about kernel bug at
drivers/ide/ide-10.c:112 and it makes my computer probably freeze. I
even booted with: 'noirqdebug' but the results I got where

SCSI subsystem initialized
ACPI : PCI interrupt 0000:01:0b[A] -> GSI 11(level , low ) -> IRQ 11
ata1 : SATA max UDMA / 100 cmd 0xE0B8E080 ctl 0xE0B8E08A bmdma
0xE0B8E000 irq 11
ata2 : SATA max UDMA / 100 cmd 0xE0B8E0C0 ctl 0xE0B8E0CA bmdma
0xE0B8E008 irq 11
and then there was a freeze

I hope this problem gets solved soon.

Ps: I'm not subscribed to this mailinglist, please CC me.

Arvind.





