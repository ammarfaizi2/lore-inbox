Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136244AbRDVSBa>; Sun, 22 Apr 2001 14:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136245AbRDVSBU>; Sun, 22 Apr 2001 14:01:20 -0400
Received: from thor.komtel.net ([212.7.128.162]:6662 "EHLO thor.komtel.net")
	by vger.kernel.org with ESMTP id <S136244AbRDVSBH>;
	Sun, 22 Apr 2001 14:01:07 -0400
Message-ID: <3AE31D3A.9494A45B@foni.net>
Date: Sun, 22 Apr 2001 20:04:42 +0200
From: Andreas Neidhardt <a-neidhardt@foni.net>
Organization: Peppschmier AG
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
X-Accept-Language: de,en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel Error Message
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello from Germany,

I have trouble with a 2.2.18 kernel on a Gigabyte GA 5AX Rev. 5.2
Mainboard.
I have a lot of entrys in /var/log/messages like this:

kernel: probable hardware bug: clock timer configuration lost - probably
a VIA686a.
horst kernel: probable hardware bug: restoring chip configuration.

The Mainboard has definitely not a VIA686a. It is a Acer M1541 and M1543
Chipset ( Aladin V) with a Intel Pentium 200 MMX CPU.

My Linux Computer:

GA 5AX Rev. 5.2
128 MB SDRAM
Matrox Mystique PCI 2 MB Graphics Adapter
3Com Fast EtherLink XL 3C905B-COMBO NIC
Maxtor 20 GB IDE HDD UDMA 100
Fritz PCI ISDN Card
TEKRAM SCSI II Controller DC 390 (no SCSI Devices connected)

cat /proc/pci  =>

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Acer Labs M1541 Aladdin V (rev 4).
      Slow devsel.  Master Capable.  Latency=32.
      Non-prefetchable 32 bit memory at 0xe0000000 [0xe0000000].
  Bus  0, device   1, function  0:
    PCI bridge: Acer Labs M5243 AGP (rev 4).
      Slow devsel.  Master Capable.  Latency=32.  Min Gnt=4.
  Bus  0, device   7, function  0:
    ISA bridge: Acer Labs M1533 Aladdin IV (rev 195).
      Medium devsel.  Master Capable.  No bursts.
  Bus  0, device   8, function  0:
    VGA compatible controller: Matrox Mystique (rev 2).
      Medium devsel.  Fast back-to-back capable.  IRQ 11.  Master
Capable.  Late
ncy=32.
      Non-prefetchable 32 bit memory at 0xe1000000 [0xe1000000].
      Prefetchable 32 bit memory at 0xe2000000 [0xe2000008].
      Non-prefetchable 32 bit memory at 0xe3000000 [0xe3000000].
  Bus  0, device  10, function  0:
    Ethernet controller: 3Com Unknown device (rev 0).
      Vendor id=10b7. Device id=9058.
      Medium devsel.  IRQ 5.  Master Capable.  Latency=32.  Min
Gnt=10.Max Lat=1
0.
      I/O at 0xe000 [0xe001].
      Non-prefetchable 32 bit memory at 0xe6000000 [0xe6000000].
  Bus  0, device  11, function  0:
    Non-VGA device: AMD 53C974 (rev 16).
      Medium devsel.  IRQ 3.  Master Capable.  Latency=32.  Min
Gnt=4.Max Lat=40
.
      I/O at 0xe400 [0xe401].
  Bus  0, device  12, function  0:
    Network controller: AVM A1 (Fritz) (rev 2).
      Medium devsel.  Fast back-to-back capable.  IRQ 11.
      Non-prefetchable 32 bit memory at 0xe6002000 [0xe6002000].
      I/O at 0xe800 [0xe801].
  Bus  0, device  15, function  0:
    IDE interface: Acer Labs M5229 TXpro (rev 194).
      Medium devsel.  Fast back-to-back capable.  Master Capable.
Latency=32.
Min Gnt=2.Max Lat=4.
      I/O at 0xf000 [0xf001].







best regards

andreas

