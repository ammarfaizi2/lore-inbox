Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314444AbSESPPI>; Sun, 19 May 2002 11:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314450AbSESPPH>; Sun, 19 May 2002 11:15:07 -0400
Received: from [62.70.58.70] ([62.70.58.70]:24022 "EHLO mail.pronto.tv")
	by vger.kernel.org with ESMTP id <S314444AbSESPPG> convert rfc822-to-8bit;
	Sun, 19 May 2002 11:15:06 -0400
Message-Id: <200205191514.g4JFEsV13608@mail.pronto.tv>
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: Pronto TV AS
To: linux-kernel@vger.kernel.org
Subject: nVidia NIC/IDE/something support?
Date: Sun, 19 May 2002 17:14:54 +0200
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

I just bought this Asus board, A7N266-VM, with nVidia IDE, LAN and god knows 
chipset. Linux doesn't understand it, and I really want it... Any plans of 
supporting this? See below for /proc/pci output.

thanks

roy

please cc: to me, as I'm nolonger on the list

--
vs_demo:~# cat /proc/pci
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: PCI device 10de:01a4 (nVidia Corporation) (rev 178).
      Prefetchable 32 bit memory at 0xf8000000 [0xfbffffff].
  Bus  0, device   0, function  1:
    RAM memory: PCI device 10de:01ac (nVidia Corporation) (rev 178).
  Bus  0, device   0, function  2:
    RAM memory: PCI device 10de:01ad (nVidia Corporation) (rev 178).
  Bus  0, device   0, function  3:
    RAM memory: PCI device 10de:01aa (nVidia Corporation) (rev 178).
  Bus  0, device   1, function  0:
    ISA bridge: PCI device 10de:01b2 (nVidia Corporation) (rev 195).
  Bus  0, device   1, function  1:
    SMBus: PCI device 10de:01b4 (nVidia Corporation) (rev 193).
      IRQ 5.
      Master Capable.  No bursts.  Min Gnt=3.Max Lat=1.
      I/O at 0x5000 [0x500f].
      I/O at 0x5500 [0x550f].
      I/O at 0x5100 [0x511f].
  Bus  0, device   2, function  0:
    USB Controller: PCI device 10de:01c2 (nVidia Corporation) (rev 195).
      IRQ 5.
      Master Capable.  No bursts.  Min Gnt=3.Max Lat=1.
      Non-prefetchable 32 bit memory at 0xe7000000 [0xe7000fff].
  Bus  0, device   3, function  0:
    USB Controller: PCI device 10de:01c2 (nVidia Corporation) (rev 195).
      IRQ 5.
      Master Capable.  No bursts.  Min Gnt=3.Max Lat=1.
      Non-prefetchable 32 bit memory at 0xe6800000 [0xe6800fff].
  Bus  0, device   4, function  0:
    Ethernet controller: PCI device 10de:01c3 (nVidia Corporation) (rev 194).
      IRQ 5.
      Master Capable.  No bursts.  Min Gnt=1.Max Lat=20.
      Non-prefetchable 32 bit memory at 0xe6000000 [0xe60003ff].
      I/O at 0xd800 [0xd807].
  Bus  0, device   5, function  0:
    Multimedia audio controller: PCI device 10de:01b0 (nVidia Corporation) 
(rev 194).
      IRQ 5.
      Master Capable.  No bursts.  Min Gnt=1.Max Lat=12.
      Non-prefetchable 32 bit memory at 0xe5800000 [0xe587ffff].
  Bus  0, device   6, function  0:
    Multimedia audio controller: PCI device 10de:01b1 (nVidia Corporation) 
(rev 194).
      IRQ 11.
      Master Capable.  No bursts.  Min Gnt=2.Max Lat=5.
      I/O at 0xe100 [0xe1ff].
      I/O at 0xe000 [0xe07f].
      Non-prefetchable 32 bit memory at 0xe5000000 [0xe5000fff].
  Bus  0, device   8, function  0:
    PCI bridge: PCI device 10de:01b8 (nVidia Corporation) (rev 194).
  Bus  0, device   9, function  0:
    IDE interface: PCI device 10de:01bc (nVidia Corporation) (rev 195).
      Master Capable.  No bursts.  Min Gnt=3.Max Lat=1.
      I/O at 0xa800 [0xa80f].
  Bus  0, device  30, function  0:
    PCI bridge: PCI device 10de:01b7 (nVidia Corporation) (rev 178).
      Master Capable.  No bursts.  Min Gnt=8.
  Bus  1, device   6, function  0:
    Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 16).
      IRQ 5.
      Master Capable.  Latency=64.  Min Gnt=32.Max Lat=64.
      I/O at 0xb800 [0xb8ff].
      Non-prefetchable 32 bit memory at 0xe4800000 [0xe48000ff].
  Bus  2, device   0, function  0:
    VGA compatible controller: PCI device 10de:01a0 (nVidia Corporation) (rev 
177).
      IRQ 11.
      Master Capable.  Latency=32.  Min Gnt=5.Max Lat=1.
      Non-prefetchable 32 bit memory at 0xe3000000 [0xe3ffffff].
      Prefetchable 32 bit memory at 0xe8000000 [0xefffffff].


-- 
Roy Sigurd Karlsbakk

Computers are like air conditioners.
They stop working when you open Windows.
