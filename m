Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268769AbRG0Eaw>; Fri, 27 Jul 2001 00:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268770AbRG0Ean>; Fri, 27 Jul 2001 00:30:43 -0400
Received: from femail24.sdc1.sfba.home.com ([24.0.95.149]:11687 "EHLO
	femail24.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S268769AbRG0Eac>; Fri, 27 Jul 2001 00:30:32 -0400
Date: Fri, 27 Jul 2001 00:30:32 -0400 (EDT)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
X-X-Sender: <mharris@asdf.capslock.lan>
To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Hard disk problem:
Message-ID: <Pine.LNX.4.33.0107270005210.25463-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
X-Spam-To: uce@ftc.gov
Copyright: Copyright 2001 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Is this a hardware or software problem, or could it be either?

Jul 26 23:51:59 asdf kernel: hda: dma_intr: status=0x51
{ DriveReady SeekComplete Error }
Jul 26 23:51:59 asdf kernel: hda: dma_intr: error=0x40
{ UncorrectableError }, LBAsect=8545004, sector=62608
Jul 26 23:51:59 asdf kernel: end_request: I/O error, dev 03:05
(hda), sector 62608

Just got it opening up a mail folder.  Drive made a bit of noise
and then PINE had to be killed.

2 root@asdf:~# hdparm -i /dev/hda

/dev/hda:

 Model=IBM-DTLA-307030, FwRev=TX4OA50C, SerialNo=YKDYKGF1437
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=40
 BuffType=DualPortCache, BuffSize=1916kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=60036480
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 udma5

No mucking around with hdparm on this box, using stock RHL7.1
i586 UP kernel.



----------------------------------------------------------------------
    Mike A. Harris  -  Linux advocate  -  Open Source advocate
       Opinions and viewpoints expressed are solely my own.
----------------------------------------------------------------------
Definition: MCSE - Microsoft Certified Solitaire Expert

