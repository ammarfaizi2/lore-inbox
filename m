Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262260AbTJAO4H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 10:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262269AbTJAO4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 10:56:07 -0400
Received: from ctchost115.edial.com ([66.152.249.115]:16659 "EHLO
	wlm.edial.com") by vger.kernel.org with ESMTP id S262260AbTJAOzw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 10:55:52 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: Serial ATA support in 2.4.22
Date: Wed, 1 Oct 2003 10:55:51 -0400
Message-ID: <C67EF1F46A97534FADC870220F3AC8B79D4FDD@exchange.edial.office>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Serial ATA support in 2.4.22
Thread-Index: AcOILBtXLTjnMo1vRnmnaxP+OLdMNg==
From: "Andrew Marold" <andrew.marold@wlm.edial.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just got some new Dell Precision 360's, 2 of which have SATA drives
that I'm trying to install RH9 on. I built a new kernel from the 2.4.22
sources, patched with the 2.4.22-ac4 patches. When I boot, linux
recognizes the drives, but hangs doing a partition check. Here's what I
see on the console:

ata1: SATA max UDMA/133 cmd 0xFE00 ctl 0xFE12 bmdma 0xFEA0 irq 17
ata2: SATA max UDMA/133 cmd 0xFE20 ctl 0xFE32 bmdma 0xFEA8 irq 17
ata1: dev 0 ATA, max UDMA/133, 234375000 sectors (lba48)
ata1: dev 0 configured for UDMA/133
ata2: port disabled, ignoring.
scsi0: ata_piix
scsi1: ata_piix
  Vendor: ATA	Model: ST3120026AS	Rev: 0.71
  Type:   Direct-Access			ANSI SCSI revision: 05
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 234375000 512-byte sectors (120000 MB)
Partition check:
sda:<3>ata1: DMA timeout, stat 0x24

Has this been seen before, or are these boxes just too far out on the
bleeding edge and I'm going to have to wait a while ?

Thanks,
	Drew

Andrew Marold - Andrew.Marold@edial.com
Release Engineer - eDial Inc.

Call me for free:
http://beta.edial.com/call/Andrew_Marold

Nothing looks worse on your outdoor resume than
a list of the possible locations of your remains. 
