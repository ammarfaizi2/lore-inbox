Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932452AbVIFMyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932452AbVIFMyU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 08:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbVIFMyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 08:54:20 -0400
Received: from laf31-5-82-235-130-100.fbx.proxad.net ([82.235.130.100]:16865
	"EHLO lexbox.fr") by vger.kernel.org with ESMTP id S932452AbVIFMyT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 08:54:19 -0400
Subject: Promise SATAII 150 TX (PDC 20579) & PATA/SATA port problem
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Date: Tue, 6 Sep 2005 14:51:47 +0200
Message-ID: <17AB476A04B7C842887E0EB1F268111E026F4D@xpserver.intra.lexbox.org>
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Promise SATAII 150 TX (PDC 20579) & PATA/SATA port problem
thread-index: AcWy4b3EnpVNIn7KQDuni7USno37SA==
From: "David Sanchez" <david.sanchez@lexbox.fr>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm using the linux 2.6.13 (from www.linux-mips.org) containing the
libata patch (2.6.13-rc7-libata1.patch.bz2) on an AMD DBAu1550 (mips32).
I've connected a HDD to the pata port of my PDC 20579 controller.
Unfortunately, it doesn't work. Here a part of the boot messages:

...
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
PCI: Enabling device 0000:00:0c.0 (0000 -> 0003)
sata_promise PATA port found
ata1: SATA max UDMA/133 cmd 0xC0054200 ctl 0xC0054238 bmdma 0x0 irq 2
ata2: SATA max UDMA/133 cmd 0xC0054280 ctl 0xC00542B8 bmdma 0x0 irq 2
ata3: PATA max UDMA/133 cmd 0xC0054300 ctl 0xC0054338 bmdma 0x0 irq 2
ata1: no device found (phy stat 00002821)
scsi0 : sata_promise
ata2: no device found (phy stat 00002821)
scsi1 : sata_promise
ata3: disabling port
scsi2 : sata_promise 
...


I've try to connect a HDD on a SATA port and the problem still appears
:(. More when I try the 2.6.10 kernel with the corresponding libata
patch it, works !

Does somebody have such a behaviour ?
Please help me ! What can I do to make the kernel2.6.13 works with my
promise controller ?

Thanks
David

