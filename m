Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964913AbVLMOMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964913AbVLMOMN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 09:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964914AbVLMOMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 09:12:13 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:9411 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964913AbVLMOMM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 09:12:12 -0500
Subject: Updated PATA libata patch set
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 13 Dec 2005 14:12:10 +0000
Message-Id: <1134483130.11732.43.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've uploaded another patchset versus 2.6.14-mm2. When 2.6.15 is
behaving and settled I'll update to that but for now the less unknowns
the better when debugging.

The major updates this release are:

- Big update to the ata_piix driver. Add MWDMA support, fix numerous
bugs in the original code and ide/pci/piix.c. Should be as functional as
the ide/pci code if not better but no doubt has a few new bugs to
replace the old ones.

- Drivers for original piix and mpiix (broken and unsupported by the
ide/pci piix driver)

- LBA48 PIO/LBA28 DMA support now working

- ALI UDMA (no MWDMA yet)

- IT8212 LBA48 size locking for smart mode

- IRQ mask support for old controllers


http://zeniv.linux.org.uk/~alan/IDE



Please give it a test and let me know what works/fails.

Alan

