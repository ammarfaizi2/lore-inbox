Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266974AbSLKByq>; Tue, 10 Dec 2002 20:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266975AbSLKByq>; Tue, 10 Dec 2002 20:54:46 -0500
Received: from mail.tpgi.com.au ([203.12.160.58]:36024 "EHLO mail2.tpgi.com.au")
	by vger.kernel.org with ESMTP id <S266974AbSLKByo>;
	Tue, 10 Dec 2002 20:54:44 -0500
Content-Type: text/plain; charset=US-ASCII
From: Brendon Higgins <bh_doc@users.sourceforge.net>
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: dvd-drive no longer works (2.4.20)
Date: Wed, 11 Dec 2002 12:04:59 +1000
User-Agent: KMail/1.4.3
References: <200212051151.59330.bh_doc@users.sourceforge.net> <3DEF7EEC.9040906@alvie.com> <200212061154.20386.bh_doc@users.sourceforge.net>
In-Reply-To: <200212061154.20386.bh_doc@users.sourceforge.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212111204.59505.bh_doc@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Help! I've still got the problem with my DVD drive that I posted a while ago, 
and I've recieved no reply for several days. Does anybody have even the 
slightest clue what might be going on? I'm stumped, and any input would be 
appreciated.

Regardless of any DMA setting, booting still complains with:
...
 00) IDE UDMA133 controller on pci00:11.1
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:DMA
hda: ST340016A, ATA DISK drive
hdb: ST310232A, ATA DISK drive
hdc: HITACHI DVD-ROM GD-2500, ATAPI CD/DVD-ROM drive
hdd: CREATIVE CD-RW RW8433E, ATAPI CD/DVD-ROM drive
hdd: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
hdd: set_drive_speed_status: error=0x04
ide1: Drive 1 didn't accept speed setting. Oh, well.
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
...

and

...
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
hdc: status error: status=0x7f { DriveReady DeviceFault SeekComplete 
DataRequest CorrectedError Index Error }
hdc: status error: error=0x7f
hdc: DMA disabled
hdc: drive not ready for command
hdc: ATAPI reset complete
hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdc: drive not ready for command
hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdc: drive not ready for command
hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdc: drive not ready for command
ide-scsi: (IO,CoD) != (0,1) while issuing a packet command
hdc: ATAPI reset complete
hdc: status error: status=0x08 { DataRequest }
hdc: drive not ready for command
hdc: ATAPI reset complete
hdc: status error: status=0x08 { DataRequest }
scsi0 channel 0 : resetting for second half of retries.
SCSI bus is being reset for host 0 channel 0.
hdc: drive not ready for command
hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdc: drive not ready for command
ide-scsi: (IO,CoD) != (0,1) while issuing a packet command
hdc: ATAPI reset complete
...

Thank you,
Brendon


On Fri, 6 Dec 2002 11:54 am, you wrote:
> On Fri, 6 Dec 2002 2:29 am, you wrote:
> > Could you activate the kernel config option "Enable DMA only for disks"
> > and see if it still happens?
>
> Alas it made no difference. I don't think this is actually about DMA. It
> happens with or without DMA turned on.
>
> Oh, and I forget to mention that I'm not subscribed to the list, so thanx
> for CCing me in your reply.
>
> Peace,
> Brendon

