Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275355AbTHSGDm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 02:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275358AbTHSGDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 02:03:41 -0400
Received: from core.kaist.ac.kr ([143.248.147.118]:10391 "EHLO
	core.kaist.ac.kr") by vger.kernel.org with ESMTP id S275355AbTHSGDk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 02:03:40 -0400
Message-ID: <003f01c36617$01c3dc80$a5a5f88f@core8fyzomwjks>
From: "Cho, joon-woo" <jwc@core.kaist.ac.kr>
To: <linux-kernel@vger.kernel.org>
Subject: [Q] IDE drive DMA failure
Date: Tue, 19 Aug 2003 14:59:09 +0900
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I send some data from ide disk to some PCI device's RAM directly.

At above sentence, 'directly' means that data is not transferred through
RAM.

Data path is only from ide disk controller to PCI device's RAM.

Anyway data can be transferred by PIO.

But DMA method can't operate. Below is error message.

Aug 18 15:08:12 localhost kernel: hdc: dma_timer_expiry: status=0x58 {
DriveReady SeekComplete DataRequest }
Aug 18 15:08:12 localhost kernel: hdc: timeout waiting for DMA
Aug 18 15:08:12 localhost kernel: ide_dmaproc: chipset supported
ide_dma_timeout func only: 14

After this DMA timeout error, data is transferred by PIO.

Do you have similar experience?

I want to send data by DMA method.

What is problem? Kernel? Hardware?

And how can I solve this problem?

Please give me anser or hint, Thanks!


Below is my system spec

CPU
celeron 400

Motherboard
440BX

IDE interface
Intel Corporation 82371AB PIIX4 IDE (rev 1).


HDD
hdc: IC35L040AVVA07-0, ATA DISK drive (Hitachi)


