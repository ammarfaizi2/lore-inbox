Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263647AbTDTRgd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 13:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263650AbTDTRgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 13:36:33 -0400
Received: from tag.witbe.net ([81.88.96.48]:61703 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S263647AbTDTRfp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 13:35:45 -0400
From: "Paul Rolland" <rol@witbe.net>
To: <linux-kernel@vger.kernel.org>
Subject: IDE messages at boot
Date: Sun, 20 Apr 2003 19:47:45 +0200
Organization: Witbe.net
Message-ID: <004401c30764$f364a810$2101a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

At boot, probably while running hdparm to set specific parameters
for the IDE disks, I have the following messages :
hda: set_drive_speed_status: status=0x58 { DriveReady SeekComplete
DataRequest }
blk: queue c066f31c, I/O limit 4095mb (mask 0xffffffff)
hda: channel busy
hda: dma_timer_expiry: dma status == 0x60
hda: timeout waiting for DMA
hda: timeout waiting for DMA
hda: (__ide_dma_test_irq) called while not waiting
hdb: set_drive_speed_status: status=0xd0 { Busy }
blk: queue c066f648, I/O limit 4095mb (mask 0xffffffff)
hdb: channel busy
hda: dma_timer_expiry: dma status == 0x60
hda: timeout waiting for DMA
hda: timeout waiting for DMA
hda: (__ide_dma_test_irq) called while not waiting

Is this normal ?

Running again the same hdparm command line doesn't result in more
messages...

Regards,
Paul

