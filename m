Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267869AbTBKSWm>; Tue, 11 Feb 2003 13:22:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267879AbTBKSWm>; Tue, 11 Feb 2003 13:22:42 -0500
Received: from mailout10.sul.t-online.com ([194.25.134.21]:59877 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267869AbTBKSWk>; Tue, 11 Feb 2003 13:22:40 -0500
Subject: Can't enable dma on /dev/hda
From: maxxle@t-online.de (maxxle)
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8-3mdk 
Date: 11 Feb 2003 19:31:16 +0000
Message-Id: <1044991886.3923.43.camel@sam>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm running a debian 3.0 System using kernel 2.4.19 (also tried 2.4.20).
On this system it's not possible to enable dma on /dev/hda (HDD IDE)

The MoBo is a VIA Board called VIA-C3M266 (CLE266 chipset)
Northbridge: VT8623
Southbridge: VT8235

My kernel is compiled with this features:
ATAPI/IDE/MFM/RLL support --> IDE, ATA and ATAPI Block devices --> 
[*] generic PCI bus-master DMA support
[*] Use PCI DMA by default when available  
[*] VIA82CXXX chipset support

And this is what hdparm tels me:
hdparm -d 1 /dev/hda:

/dev/hda:
 setting using_dma to 1 (on)
 HDIO_SET_DMA failed: Operation not permitted
 using_dma    =  0 (off)


What can I do to force my system to run using dma on /dev/hda.
Or is my CLE266 chipset a bit too new for being supported by 2.4.19/20?


Hope somebody is able to help me


maxxle

