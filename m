Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751656AbWADKSs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751656AbWADKSs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 05:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751655AbWADKSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 05:18:48 -0500
Received: from prosun.first.fraunhofer.de ([194.95.168.2]:46492 "EHLO
	prosun.first.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1751448AbWADKSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 05:18:47 -0500
Subject: ata2: translated ATA stat/err 0x51/0c to SCSI SK/ASC/ASCQ
	0xb/00/00 status=0x51 { DriveReady SeekComplete Error }
From: Soeren Sonnenburg <kernel@nn7.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Wed, 04 Jan 2006 11:18:40 +0100
Message-Id: <1136369920.18235.10.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

does anyone know what this could sata error message could mean ?

ata2: translated ATA stat/err 0x51/0c to SCSI SK/ASC/ASCQ 0xb/00/00
ata2: status=0x51 { DriveReady SeekComplete Error }
ata2: error=0x0c { DriveStatusError }

I get *lots* of this when I copy files from the sata disk to some
ieee1394 device and it seems they are sharing interrupt 16:

 16:     430796   IO-APIC-level  ide2, ide3, libata, ohci1394

Happens with kernel 2.6.15, asus a7v8x, sata_promise tx2/4 ...

>From time to time I can trigger a cold freeze, but it is not exactly
easy...


Any ideas ?
Soeren
-- 
When you live in a sick society, just about everything you do is wrong.

