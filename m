Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbTIJJw0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 05:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261277AbTIJJw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 05:52:26 -0400
Received: from max.feld.cvut.cz ([147.32.192.36]:19888 "EHLO max.feld.cvut.cz")
	by vger.kernel.org with ESMTP id S261238AbTIJJwU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 05:52:20 -0400
Message-ID: <1063187533.3f5ef44d16576@imap.feld.cvut.cz>
Date: Wed, 10 Sep 2003 11:52:13 +0200
From: juranj1@feld.cvut.cz
To: linux-kernel@vger.kernel.org
Subject: setting dma on on hdd
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.0
X-Originating-IP: 193.86.239.237
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



hello,
i am sorry for asking you but i am a newbie:(...
i have a acer tm613txv nb, kernel 2.4.22
i would like to turn on dma on hhd but i get this message

/dev/hda:
 setting using_dma to 1 (on)
 HDIO_SET_DMA failed: Operation not permitted
 using_dma    =  0 (off)

when i use a kernel 2.4.20-8 that works fine
somewhere i founded that problem could be in driver Uniform Multi-Platform E-IDE
driver Revision: 7.00beta4-2.4 which is in 2.4.22, but i dont know how shoud i
solve this problem..thank you for every advice....(i think that i have compiled
everthing what i shoud)

jirka
icq52736508

lspci:
00:00.0 Host bridge: Intel Corp. 82815 815 Chipset Host Bridge and Memory
Controller Hub (rev 11)
00:02.0 VGA compatible controller: Intel Corp. 82815 CGC [Chipset Graphics
Controller] (rev 11)
00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 03)
00:1f.0 ISA bridge: Intel Corp. 82801BAM ISA Bridge (LPC) (rev 03)
00:1f.1 IDE interface: Intel Corp. 82801BAM IDE U100 (rev 03)

messages:
Sep  8 18:47:57 pepek kernel: Uniform Multi-Platform E-IDE driver
Revision: 7.00beta4-2.4
Sep  8 18:47:57 pepek kernel: ide: Assuming 33MHz system bus speed for
PIO modes; override with idebus=xx
Sep  8 18:47:57 pepek kernel: hda: IBM-DJSA-220, ATA DISK drive
Sep  8 18:47:57 pepek kernel: hdc: UJDA710, ATAPI CD/DVD-ROM drive
Sep  8 18:47:57 pepek kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Sep  8 18:47:57 pepek kernel: ide1 at 0x170-0x177,0x376 on irq 15
Sep  8 18:47:57 pepek kernel: hda: attached ide-disk driver.
Sep  8 18:47:57 pepek kernel: hda: host protected area => 1
Sep  8 18:47:57 pepek kernel: hda: 39070080 sectors (20004 MB)
w/1874KiB
Cache, CHS=2432/255/63

hdparm -iv:
 Model=IBM-DJSA-220, FwRev=JS4OAC7A, SerialNo=44T44W45916
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=DualPortCache, BuffSize=1874kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=39070080
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 udma2 udma3 *udma4
 AdvancedPM=yes: mode=0x80 (128) WriteCache=enabled
 Drive conforms to: ATA/ATAPI-5 T13 1321D revision 1:  2 3 4 5


