Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267897AbTBVNUu>; Sat, 22 Feb 2003 08:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267898AbTBVNUu>; Sat, 22 Feb 2003 08:20:50 -0500
Received: from angband.namesys.com ([212.16.7.85]:1152 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S267897AbTBVNUt>; Sat, 22 Feb 2003 08:20:49 -0500
Date: Sat, 22 Feb 2003 16:30:57 +0300
From: Oleg Drokin <green@namesys.com>
To: thetech@folkwolf.net, linux-kernel@vger.kernel.org
Subject: Box freezes if I enable "AMD 76x native power management"
Message-ID: <20030222163057.A884@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   Starting from 2.4.20 until now (including 2.4.21-pre4 and 2.4.21-pre4-ac5",
   whenever I enable "AMD 76x native power management" in my kernel config, I get
   kernel that hangs at boot after reporting elevator stuff about my IDE drives.
   Is anybody interested?

   I have dual-cpu Athlon-1700+ on some Tyan MB:
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System Controller (rev 17).
      Master Capable.  Latency=64.
      Prefetchable 32 bit memory at 0xf4000000 [0xf7ffffff].
      Prefetchable 32 bit memory at 0xf0101000 [0xf0101fff].
      I/O at 0x1430 [0x1433].
  Bus  0, device   1, function  0:
    PCI bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] AGP Bridge (rev 0).
      Master Capable.  Latency=99.  Min Gnt=12.
  Bus  0, device   7, function  0:
    ISA bridge: Advanced Micro Devices [AMD] AMD-766 [ViperPlus] ISA (rev 2).
  Bus  0, device   7, function  1:
    IDE interface: Advanced Micro Devices [AMD] AMD-766 [ViperPlus] IDE (rev 1).
      Master Capable.  Latency=64.
      I/O at 0xf000 [0xf00f].
  Bus  0, device   7, function  3:
    Bridge: Advanced Micro Devices [AMD] AMD-766 [ViperPlus] ACPI (rev 1).
      Master Capable.  Latency=64.
  Bus  0, device   7, function  4:
    USB Controller: Advanced Micro Devices [AMD] AMD-766 [ViperPlus] USB (rev 7).
      IRQ 11.
      Master Capable.  Latency=16.  Max Lat=80.
      Non-prefetchable 32 bit memory at 0xdc000 [0xdcfff].

Bye,
    Oleg
