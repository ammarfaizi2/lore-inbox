Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129274AbRBWWem>; Fri, 23 Feb 2001 17:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129822AbRBWWed>; Fri, 23 Feb 2001 17:34:33 -0500
Received: from [63.140.126.166] ([63.140.126.166]:7940 "EHLO helium.inexs.com")
	by vger.kernel.org with ESMTP id <S129485AbRBWWeX>;
	Fri, 23 Feb 2001 17:34:23 -0500
Date: Fri, 23 Feb 2001 16:34:14 -0600
From: Chuck Campbell <campbell@neosoft.com>
To: linux-kernel@vger.kernel.org
Cc: campbell@neosoft.com
Subject: 2.4.2-ac1 and ide questions/problems
Message-ID: <20010223163414.A1096@helium.inexs.com>
Reply-To: campbell@neosoft.com
Mail-Followup-To: linux-kernel@vger.kernel.org, campbell@neosoft.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This machine started as a Redhat linux 6.1 install some time ago, with lots 
of updates since then.

Prior to the kernel upgrade, I upgraded binutils to binutils-2.9.5.0.31-1,
modutils to modutils-2.4.2-1, e2fsprogs to e2fsprogs-1.19-0.

I've just installed kernel 2.4.2-ac1 from a clean build and I'm seeing the 
following at boot time:

hda: WDC AC31600H, ATA DISK drive
hdb: Maxtor 91303D6, ATA DISK drive
hdc: ST36450A, ATA DISK drive
hdd: CDA66801I, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: Disabling (U)DMA for WDC AC31600H
hda: 3173184 sectors (1625 MB) w/128KiB Cache, CHS=787/64/63
hdb: 25450992 sectors (13031 MB) w/512KiB Cache, CHS=25249/16/63, (U)DMA
hdc: 12594960 sectors (6449 MB) w/448KiB Cache, CHS=13328/15/63, DMA
hdd: ATAPI 6X CD-ROM drive, 240kB Cache
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 hda3
 hdb:hdb: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdb: dma_intr: error=0x04 { DriveStatusError }
 hdb1 hdb2 hdb3 hdb4
 hdc: hdc1 hdc2 hdc3 hdc4


What does the disabling of DMA for the WDC drive mean, and can I re-enable it
with hdparm in a trouble free fashion?

What does this error during partition check mean and is it worriesome, or can 
I ignore it?
  
hdb:hdb: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdb: dma_intr: error=0x04 { DriveStatusError }

thanks,
-chuck



-- 
ACCEL Services, Inc.| Specialists in Gravity, Magnetics |  1(713)993-0671 ph.
1980 Post Oak Blvd. |   and Integrated Interpretation   |  1(713)960-1157 fax
    Suite 2050      |                                   |
 Houston, TX, 77056 |          Chuck Campbell           | campbell@neosoft.com
                    |  President & Senior Geoscientist  |

     "Integration means more than having all the maps at the same scale!"
