Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135239AbRECVRp>; Thu, 3 May 2001 17:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135240AbRECVRg>; Thu, 3 May 2001 17:17:36 -0400
Received: from web4402.mail.yahoo.com ([216.115.105.32]:64273 "HELO
	web4402.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S135239AbRECVRY>; Thu, 3 May 2001 17:17:24 -0400
Message-ID: <20010503211723.28010.qmail@web4402.mail.yahoo.com>
Date: Thu, 3 May 2001 14:17:23 -0700 (PDT)
From: techorix <techorix@yahoo.com>
Subject: Kernel-Error with my Chipset/HD-Combination using DMA
To: linux-kernel@vger.kernel.org
Cc: andre@linux-ide.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
after changing from 2.2.17 - kernel (where no such
issues were noticeable) to 2.2.19 (with 'enable
dma-support' etc compiled into kernel) 
Would be very nice if you could tell me if the error
is related to my harddrive (hardware) or is maybe a
kernel-bug and at which version it should be fixed.
Regards,
Michael

ps. here all relevant information i could gather/think
of:

Here's the error's output (get it at bootup):

hda: dma_intr: status=0x51 { DriveReady SeekComplete
Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }

Well
hdparm -d 1 -c 1 works (were disabled after bootup)
BUT: error seems to be more often then

lspci shows this:

00:00.0 Host bridge: Acer Laboratories Inc. [ALi]
M1541 (rev 04)
00:01.0 PCI bridge: Acer Laboratories Inc. [ALi] M5243
(rev 04)
00:0f.0 IDE interface: Acer Laboratories Inc. [ALi]
M5229 IDE (rev c1)

hdparm -i this:
/dev/hda:

 Model=ST330630A, FwRev=3.21, SerialNo=3CK0EYZM
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs
RotSpdTol>.5% }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=2048kB, MaxMultSect=16,
MultSect=off
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes,
LBAsects=59777640
 IORDY=on/off, tPIO={min:240,w/IORDY:120},
tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4 
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3
udma4 


__________________________________________________
Do You Yahoo!?
Yahoo! Auctions - buy the things you want at great prices
http://auctions.yahoo.com/
