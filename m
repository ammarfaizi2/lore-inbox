Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263196AbTCNAWm>; Thu, 13 Mar 2003 19:22:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263200AbTCNAWm>; Thu, 13 Mar 2003 19:22:42 -0500
Received: from msp-24-163-212-250.mn.rr.com ([24.163.212.250]:22659 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S263196AbTCNAWk>; Thu, 13 Mar 2003 19:22:40 -0500
Subject: hdf: lost interrupt
From: Shawn <core@enodev.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-Mm2Ef1S2EJ4kitJ4QQER"
Organization: 
Message-Id: <1047602014.4756.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 13 Mar 2003 18:33:35 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Mm2Ef1S2EJ4kitJ4QQER
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I've been getting lots of messages about my Maxtor 53073H4 30GB hd, and
it doesn't seem to happen under 2.4.x. Just wondering what might be
going on. If it's my drive, or something else.

Here's some info, is there anything else I can do?

/dev/hdf:

 Model=Maxtor 53073H4, FwRev=JAC61HU0, SerialNo=F40AVV6C
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=60030432
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5 
 AdvancedPM=yes: disabled (255) WriteCache=enabled
 Drive conforms to: ATA/ATAPI-6 T13 1410D revision 0:  1 2 3 4 5 6

Mar 13 17:26:26 localhost kernel: hdf: dma_timer_expiry: dma status ==
0x64
Mar 13 17:26:26 localhost kernel: hdf: lost interrupt
Mar 13 17:26:26 localhost kernel: hdf: dma_intr: bad DMA status
(dma_stat=70)
Mar 13 17:26:26 localhost kernel: hdf: dma_intr: status=0x50 {
DriveReady SeekComplete }
Mar 13 17:27:05 localhost kernel: hdf: DMA disabled
Mar 13 17:27:13 localhost kernel: hdf: channel busy
Mar 13 17:27:13 localhost kernel: hdf: DMA disabled
Mar 13 17:27:19 localhost kernel: hdf: lost interrupt
Mar 13 17:27:19 localhost kernel: hdf: DMA disabled
Mar 13 17:28:42 localhost kernel: hdf: lost interrupt



--=-Mm2Ef1S2EJ4kitJ4QQER
Content-Disposition: attachment; filename=ioports.txt
Content-Type: text/plain; name=ioports.txt; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide3
01f0-01f7 : ide2
02f8-02ff : serial
0376-0376 : ide3
03c0-03df : vesafb
03f6-03f6 : ide2
03f8-03ff : serial
0cf8-0cff : PCI conf1
9000-9007 : CMD Technology Inc PCI0649
  9000-9007 : ide0
9400-9403 : CMD Technology Inc PCI0649
  9402-9402 : ide0
9800-9807 : CMD Technology Inc PCI0649
  9800-9807 : ide1
9c00-9c03 : CMD Technology Inc PCI0649
  9c02-9c02 : ide1
a000-a00f : CMD Technology Inc PCI0649
  a000-a007 : ide0
  a008-a00f : ide1
a400-a41f : Creative Labs SB Live! EMU10k1
  a400-a41f : EMU10K1
a800-a807 : Creative Labs SB Live! MIDI/Game P
ac00-acff : Realtek Semiconducto RTL-8139/8139C/8139C
  ac00-acff : 8139too
b000-b07f : 3Com Corporation 3c980-TX [Fast Ether
  b000-b07f : 00:0c.0
b400-b40f : VIA Technologies, In VT82C586/B/686A/B PI
  b400-b407 : ide2
  b408-b40f : ide3
b800-b81f : VIA Technologies, In USB
bc00-bc1f : VIA Technologies, In USB (#2)
c000-c01f : VIA Technologies, In USB (#3)
c400-c4ff : VIA Technologies, In VT8233 AC97 Audio Co

--=-Mm2Ef1S2EJ4kitJ4QQER--
