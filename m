Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293095AbSCOSmB>; Fri, 15 Mar 2002 13:42:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293088AbSCOSlp>; Fri, 15 Mar 2002 13:41:45 -0500
Received: from atlas.inria.fr ([138.96.66.22]:63173 "EHLO atlas.inria.fr")
	by vger.kernel.org with ESMTP id <S293091AbSCOSlb>;
	Fri, 15 Mar 2002 13:41:31 -0500
Message-Id: <200203151841.g2FIfRa09172@atlas.inria.fr>
Content-Type: text/plain; charset=US-ASCII
From: Nicolas Turro <Nicolas.Turro@sophia.inria.fr>
To: linux-kernel@vger.kernel.org
Subject: amd nvidia and mem=nopentium
Date: Fri, 15 Mar 2002 19:41:26 +0100
X-Mailer: KMail [version 1.3]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi, i have system dual athlon  XP 1900+ system and a nvidia graphic board :

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: PCI device 1022:700c (Advanced Micro Devices [AMD]) (rev 17).
      Master Capable.  Latency=32.
      Prefetchable 32 bit memory at 0xf0000000 [0xf7ffffff].
      Prefetchable 32 bit memory at 0xef800000 [0xef800fff].
      I/O at 0xe800 [0xe803].
  Bus  0, device   1, function  0:
    PCI bridge: PCI device 1022:700d (Advanced Micro Devices [AMD]) (rev 0).
      Master Capable.  No bursts.  Min Gnt=8.
  Bus  0, device   7, function  0:
    ISA bridge: Advanced Micro Devices [AMD] AMD-768 [??] ISA (rev 4).
  Bus  0, device   7, function  1:
    IDE interface: Advanced Micro Devices [AMD] AMD-768 [??] IDE (rev 4).
      Master Capable.  Latency=32.
      I/O at 0xd800 [0xd80f].
  Bus  0, device   7, function  3:
    Bridge: Advanced Micro Devices [AMD] AMD-768 [??] ACPI (rev 3).
      Master Capable.  Latency=32.
  Bus  0, device  16, function  0:
    PCI bridge: Advanced Micro Devices [AMD] AMD-768 [??] PCI (rev 4).
      Master Capable.  No bursts.  Min Gnt=4.
  Bus  1, device   5, function  0:
    VGA compatible controller: PCI device 10de:0202 (nVidia Corporation) (rev 
163).
      IRQ 11.
      Master Capable.  Latency=248.  Min Gnt=5.Max Lat=1.
      Non-prefetchable 32 bit memory at 0xe6000000 [0xe6ffffff].
      Prefetchable 32 bit memory at 0xe8000000 [0xebffffff].
      Prefetchable 32 bit memory at 0xe7800000 [0xe787ffff].
  Bus  2, device   0, function  0:
    USB Controller: Advanced Micro Devices [AMD] AMD-768 [??] USB (rev 7).
      IRQ 5.
      Master Capable.  Latency=32.  Max Lat=80.
      Non-prefetchable 32 bit memory at 0xe5800000 [0xe5800fff].
  Bus  2, device   4, function  0:
    Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 16).
      IRQ 10.
      Master Capable.  Latency=32.  Min Gnt=2.Max Lat=24.
      I/O at 0xc800 [0xc8ff].
  Bus  2, device   6, function  0:
    Ethernet controller: Advanced Micro Devices [AMD] 79c970 [PCnet LANCE] 
(rev 68).
      IRQ 10.
      Master Capable.  Latency=32.  Min Gnt=24.Max Lat=24.
      I/O at 0xc400 [0xc41f].
      Non-prefetchable 32 bit memory at 0xe5000000 [0xe500001f].

I need to use the mem=nopentium kernel parameter in order to run X without
crashes. I'd like to know :
1- what are the consequences of  'mem=nopentium' ? Any performance loss ?
i intend to use a gigabit ethernet adapter on this box.
2- is there any fix going on that i should monitor ?

Thanks in advance..

Nicolas
