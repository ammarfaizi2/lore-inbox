Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129300AbRBXMY6>; Sat, 24 Feb 2001 07:24:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129302AbRBXMYs>; Sat, 24 Feb 2001 07:24:48 -0500
Received: from mclean.mail.mindspring.net ([207.69.200.57]:11564 "EHLO
	mclean.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S129300AbRBXMYg>; Sat, 24 Feb 2001 07:24:36 -0500
Date: Sat, 24 Feb 2001 07:30:03 -0500
From: jerry <jdinardo@ix.netcom.com>
To: linux-kernel@vger.kernel.org
Subject: ide / usb problem
Message-ID: <20010224073003.A285@ix.netcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get the following message when copying a 300MB directory under 2.4.2.

uhci:host system error, PCI problems?
uhci:host controller halted, very bad

This does not happen under 2.4.1 and it happens every time under 2.4.2.
The system still runs fine except for usb mouse.
All of the files in the directory are copied correctly.

It happens when dma is enabled by hdparm -d1 /dev/hda or when dma is
enabled automatically by the kernel.

I have an Abit kt7 mb with the kt133 chipset,Athlon 900 , 128MB mem,
quantum fireball 20G disk, gcc 2-95-2 , glibc 2-2-1.

There are no problems with dma disabled.

I was not sure if the VIA82CXXX option should be set with the via kt133
chipset , but setting it results in hundreds of
    hda: dma_intr:status=0x51 { DriveReady SeekComplete Error }
    hda: dma_intr:error=0x84 { DriveStatusError BadCRC }
mesages along with the uhci: errors mentioned above.
Again , the directory was copied correctly.

Is there anyway to get 2.4.2 to use dma and not turn off my usb mouse ?

thanks jpd
