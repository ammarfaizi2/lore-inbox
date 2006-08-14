Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751509AbWHNHlk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751509AbWHNHlk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 03:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751621AbWHNHlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 03:41:40 -0400
Received: from stapleshigh.net ([199.249.227.133]:40135 "EHLO junker.org")
	by vger.kernel.org with ESMTP id S1751509AbWHNHlj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 03:41:39 -0400
Date: Mon, 14 Aug 2006 03:41:38 -0400 (EDT)
From: Eric Schoeller <eric@junker.org>
To: linux-kernel@vger.kernel.org
Subject: sata_sil driver dev 0 failed to IDENTIFY (INIT_DEV_PARAMS failed)
Message-ID: <20060814034028.C66081@junker.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

howdy,

i am using the sata_sil driver with a Silicon Image, Inc. SiI 3112
Controller and have recently started receiving these messages on driver
load:

[17179867.424000] libata version 1.20 loaded.
[17179958.936000] sata_sil 0000:02:0b.0: version 0.9
[17179958.936000] ACPI: PCI Interrupt 0000:02:0b.0[A] -> Link [LNKA] ->
GSI 3 (level, low) -> IRQ 3
[17179958.936000] ata1: SATA max UDMA/100 cmd 0xD0838080 ctl 0xD083808A
bmdma 0xD0838000 irq 3
[17179958.936000] ata2: SATA max UDMA/100 cmd 0xD08380C0 ctl 0xD08380CA 
bmdma 0xD0838008 irq 3
[17179966.296000] ata1 is slow to respond, please be patient
[17179975.928000] ata1: SATA link up 1.5 Gbps (SStatus 113)
[17179975.928000] ata1: dev 0 failed to IDENTIFY (INIT_DEV_PARAMS failed)
[17179975.928000] scsi0 : sata_sil
[17179976.132000] ata2: SATA link down (SStatus 0)

As a result, the maxtor 250gb drive fails to be detected   :(
I'm  roughly 1900 miles away from this box so I have no ability to
physically inspect the device. I'm worried that the drive is blown (sure
wish smartmontools was compatible with libata so I might have seen this
coming sooner!) but  after checking the usual sources I'm still not
entirely sure what this error message means exactly.

Any insights are greatly appreciated!

Eric Schoeller
Linux 2.6.17.8 #1 SMP Sun Aug 13 17:49:13 MDT 2006 i686 Intel(R)
Pentium(R) 4 CPU 1400MHz GNU/Linux
