Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031782AbWLBUcp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031782AbWLBUcp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 15:32:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031783AbWLBUcp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 15:32:45 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50867 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1031782AbWLBUco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 15:32:44 -0500
Date: Sat, 2 Dec 2006 20:39:53 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Ricardo Lugo <ricardolugo@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hang booting onboard HPT 366 with libata (PATA)
Message-ID: <20061202203953.60829865@localhost.localdomain>
In-Reply-To: <F9FBBC4B-BDB9-49E5-8089-3D6E8BFE0FA0@gmail.com>
References: <61D44F12-D09C-4A6F-9FC7-4AC49FEC757B@gmail.com>
	<20061202111928.428e83d2@localhost.localdomain>
	<20061202130317.273abf75@localhost.localdomain>
	<F9FBBC4B-BDB9-49E5-8089-3D6E8BFE0FA0@gmail.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ACPI: PCI Interrupt 0000:00:13.1[B] -> GSI 18 (level, low) -> IRQ 16
> ata4: PATA max UDMA/66 cmd 0xE400 ctl 0xE802 bmdma 0xEC00 irq 16
> scsi3: pata_hpt366
> ata4.00: qc timeout (cmd 0xec)
> ata4.00: failed to IDENTIFY (I/O error, err_mask=0x4)

Ok that wil need more work. I think that you are experiencing two
independant bugs here and the patch fixed only the first.

Alan
