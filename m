Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264904AbUFHJJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264904AbUFHJJE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 05:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264911AbUFHJJD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 05:09:03 -0400
Received: from jive.SoftHome.net ([66.54.152.27]:23722 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id S264904AbUFHJIw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 05:08:52 -0400
Subject: I get hdb: task_no_data_intr: status=0x51 { DriveReady
	SeekComplete Error } with a 80GB Maxtor drive
From: THroLL <makiaveli@SoftHome.net>
To: linux-kernel@vger.kernel.org
Message-Id: <1086667443.847.9.camel@Tupac.wesTsiDe.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 08 Jun 2004 06:04:03 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello
	I've just buy a new ata 133 disk and when I try to partition it or
mount any partition from it I get the same error lines:

hdb: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hdb: task_no_data_intr: error=0x04 { DriveStatusError }
hdb: Write Cache FAILED Flushing!

	I also get this message when booting, the dmesg output is:

hda: ST340810A, ATA DISK drive
hdb: Maxtor 6Y080L0, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: HL-DT-ST GCE-8520B, ATAPI CD/DVD-ROM drive
hdd: ASUS CD-S500/A, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 78165360 sectors (40020 MB) w/2048KiB Cache, CHS=65535/16/63,
UDMA(66)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
hdb: max request size: 128KiB
hdb: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=65535/16/63,
UDMA(66) 
 /dev/ide/host0/bus0/target1/lun0: p1 p2
hdb: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hdb: task_no_data_intr: error=0x04 { DriveStatusError }
hdb: Write Cache FAILED Flushing!



	I'm using Debian SID and 2.6.6 kernel with no patches. My computer has
an AMD athlon proccesor if this can be usefull.

	Excuse my poor English.
	Thanks

