Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136055AbRDVMLn>; Sun, 22 Apr 2001 08:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136056AbRDVMLg>; Sun, 22 Apr 2001 08:11:36 -0400
Received: from B1144.pppool.de ([213.7.17.68]:1029 "EHLO susi.maya.org")
	by vger.kernel.org with ESMTP id <S136055AbRDVMLY>;
	Sun, 22 Apr 2001 08:11:24 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andreas Hartmann <andihartmann@freenet.de>
Organization: Privat
To: linux-kernel@vger.kernel.org
Subject: [2.4.3ac11] clock timer configuration lost - probably a VIA686a motherboard
Date: Sun, 22 Apr 2001 14:10:14 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01042214101400.15273@athlon>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo all,


I found some posts in this list to the problem mentioned in the subject and 
want to tell about my experiences. Maybe it can help to detect the problem. 

I got a lot of messages while continuous writing / reading datas from one a 
harddisk to another harddisk (both at 1. ide-channel) during backup with 
rsync. Both harddisks use udma4. The data-stream was between 0,5 MB/s and 
20MB/s.
I never got these messages before and after the backup finished I couldn't 
see them anymore.

Apr 22 10:41:38 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Apr 22 10:41:38 athlon kernel: probable hardware bug: restoring chip 
configuration.
Apr 22 10:44:29 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Apr 22 10:44:29 athlon kernel: probable hardware bug: restoring chip 
configuration.
Apr 22 10:44:34 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Apr 22 10:44:34 athlon kernel: probable hardware bug: restoring chip 
configuration.
Apr 22 10:44:43 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Apr 22 10:44:43 athlon kernel: probable hardware bug: restoring chip 
configuration.
Apr 22 11:08:23 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Apr 22 11:08:23 athlon kernel: probable hardware bug: restoring chip 
configuration.
Apr 22 11:11:51 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Apr 22 11:11:51 athlon kernel: probable hardware bug: restoring chip 
configuration.
Apr 22 11:13:30 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Apr 22 11:13:30 athlon kernel: probable hardware bug: restoring chip 
configuration.
Apr 22 11:17:38 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Apr 22 11:17:38 athlon kernel: probable hardware bug: restoring chip 
configuration.
Apr 22 11:17:39 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Apr 22 11:17:39 athlon kernel: probable hardware bug: restoring chip 
configuration.
Apr 22 11:17:41 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Apr 22 11:17:41 athlon kernel: probable hardware bug: restoring chip 
configuration.
Apr 22 11:17:46 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Apr 22 11:17:46 athlon kernel: probable hardware bug: restoring chip 
configuration.
Apr 22 11:18:39 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Apr 22 11:18:39 athlon kernel: probable hardware bug: restoring chip 
configuration.
Apr 22 11:18:44 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Apr 22 11:18:44 athlon kernel: probable hardware bug: restoring chip 
configuration.
Apr 22 11:20:33 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Apr 22 11:20:33 athlon kernel: probable hardware bug: restoring chip 
configuration.
Apr 22 11:20:38 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Apr 22 11:20:38 athlon kernel: probable hardware bug: restoring chip 
configuration.
Apr 22 11:20:56 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Apr 22 11:20:56 athlon kernel: probable hardware bug: restoring chip 
configuration.
Apr 22 11:21:20 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Apr 22 11:21:20 athlon kernel: probable hardware bug: restoring chip 
configuration.
Apr 22 11:21:25 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Apr 22 11:21:25 athlon kernel: probable hardware bug: restoring chip 
configuration.
Apr 22 11:21:28 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Apr 22 11:21:28 athlon kernel: probable hardware bug: restoring chip 
configuration.
Apr 22 11:21:33 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Apr 22 11:21:33 athlon kernel: probable hardware bug: restoring chip 
configuration.
Apr 22 11:21:39 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Apr 22 11:21:39 athlon kernel: probable hardware bug: restoring chip 
configuration.
Apr 22 11:35:07 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Apr 22 11:35:07 athlon kernel: probable hardware bug: restoring chip 
configuration.
Apr 22 11:38:03 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Apr 22 11:38:03 athlon kernel: probable hardware bug: restoring chip 
configuration.
Apr 22 11:38:32 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Apr 22 11:38:32 athlon kernel: probable hardware bug: restoring chip 
configuration.
Apr 22 11:38:52 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Apr 22 11:38:52 athlon kernel: probable hardware bug: restoring chip 
configuration.
Apr 22 11:44:40 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Apr 22 11:44:40 athlon kernel: probable hardware bug: restoring chip 
configuration.


I have a EP7KXA-Board with VIA-KX133-chipset.

cat /proc/pci
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: VIA Technologies, Inc. VT8371 [KX133] (rev 2).
      Prefetchable 32 bit memory at 0xd6000000 [0xd7ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: VIA Technologies, Inc. VT8371 [KX133 AGP]  (rev 0).
      Master Capable.  No bursts.  Min Gnt=12.
  Bus  0, device   7, function  0:
    ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 34).
  Bus  0, device   7, function  1:
    IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 16).
      Master Capable.  Latency=32.
      I/O at 0xd000 [0xd00f].
  Bus  0, device   7, function  2:
    USB Controller: VIA Technologies, Inc. UHCI USB (rev 16).
      IRQ 9.
      Master Capable.  Latency=32.
      I/O at 0xd400 [0xd41f].
  Bus  0, device   7, function  4:
    Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 48).
      IRQ 9.
  Bus  0, device   7, function  5:
    Multimedia audio controller: VIA Technologies, Inc. AC97 Audio Controller 
(rev 32).
      IRQ 5.
      I/O at 0xdc00 [0xdcff].
      I/O at 0xe000 [0xe003].
      I/O at 0xe400 [0xe403].
  Bus  0, device   8, function  0:
    Ethernet controller: Silicon Integrated Systems [SiS] SiS900 10/100 
Ethernet (rev 2).
      IRQ 10.
      Master Capable.  Latency=32.  Min Gnt=52.Max Lat=11.
      I/O at 0xe800 [0xe8ff].
      Non-prefetchable 32 bit memory at 0xd9000000 [0xd9000fff].
  Bus  0, device   9, function  0:
    Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 16).
      IRQ 11.
      Master Capable.  Latency=32.  Min Gnt=32.Max Lat=64.
      I/O at 0xec00 [0xecff].
      Non-prefetchable 32 bit memory at 0xd9001000 [0xd90010ff].
  Bus  1, device   0, function  0:
    VGA compatible controller: ATI Technologies Inc Rage 128 PF (rev 0).
      IRQ 10.
      Master Capable.  Latency=32.  Min Gnt=8.
      Prefetchable 32 bit memory at 0xd0000000 [0xd3ffffff].
      I/O at 0xc000 [0xc0ff].
      Non-prefetchable 32 bit memory at 0xd5000000 [0xd5003fff]

Regards,
Andreas Hartmann
