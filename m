Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317305AbSGDB2w>; Wed, 3 Jul 2002 21:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317308AbSGDB2w>; Wed, 3 Jul 2002 21:28:52 -0400
Received: from paloma15.e0k.nbg-hannover.de ([62.181.130.15]:14244 "HELO
	paloma15.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S317305AbSGDB2u>; Wed, 3 Jul 2002 21:28:50 -0400
Content-Type: text/plain;
  charset="iso-8859-15"
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Tony Lindgren <tony@atomide.com>
Subject: Re: amd-smp-idle module avail for testing max 90 W power savings
Date: Thu, 4 Jul 2002 03:31:40 +0200
User-Agent: KMail/1.4.1
Cc: Sebastian Droege <sebastian.droege@gmx.de>,
       Daniel Nofftz <nofftz@castor.uni-trier.de>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200207040331.40378.Dieter.Nuetzel@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 3 July 2002 05:50, Dieter Nützel wrote:
> I'll give your code a shot on my brand new
> dual Athlon MP 1900+ (MP unlocked XPs, 4th bridge of L5 is closed)
> MSI K7D Master-L (MS-6501 v1.0) AMD 760MPX
> 1 GB DDR266-SDRAM CL2
>
> But it doesn't go hot...;-)

The module could not be loaded:

SunWave1 src/patches# insmod amd-smp-idle.o
amd-smp-idle.o: init_module: Device or resource busy
Hint: insmod errors can be caused by incorrect module parameters, including 
invalid IO or IRQ parameters.
      You may find more information in syslog or the output from dmesg

amd-smp-idle: AMD processor idle module version 20020702
amd-smp-idle: Initializing northbridge Advanced Micro Devices [AMD] AMD-760 MP 
[IGD4-2P] System Controller
amd-smp-idle: Could not find southbridge

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System 
Controller (rev 17).
      Master Capable.  Latency=32.
      Prefetchable 32 bit memory at 0xe8000000 [0xebffffff].
      Prefetchable 32 bit memory at 0xee100000 [0xee100fff].
      I/O at 0xc400 [0xc403].
  Bus  0, device   1, function  0:
    PCI bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] AGP Bridge 
(rev 0).
      Master Capable.  Latency=32.  Min Gnt=14.
  Bus  0, device   7, function  0:
    ISA bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ISA (rev 5).
  Bus  0, device   7, function  1:
    IDE interface: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE (rev 4).
      Master Capable.  Latency=32.
      I/O at 0xc000 [0xc00f].
  Bus  0, device   7, function  3:
    Bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI (rev 3).
      Master Capable.  Latency=32.
  Bus  0, device  16, function  0:
    PCI bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] PCI (rev 5).
      Master Capable.  Latency=32.  Min Gnt=6.
  Bus  1, device   5, function  0:
    VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 4 / Voodoo 5 (rev 
1).
      IRQ 17.
      Non-prefetchable 32 bit memory at 0xe0000000 [0xe3ffffff].
      Prefetchable 32 bit memory at 0xd8000000 [0xdfffffff].
      I/O at 0xb000 [0xb0ff].
  Bus  2, device   0, function  0:
    USB Controller: Advanced Micro Devices [AMD] AMD-768 [Opus] USB (rev 7).
      IRQ 19.
      Master Capable.  Latency=32.  Max Lat=80.
      Non-prefetchable 32 bit memory at 0xed122000 [0xed122fff].
  Bus  2, device   4, function  0:
    Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 8).
      IRQ 16.
      Master Capable.  Latency=32.  Min Gnt=2.Max Lat=20.
      I/O at 0x9000 [0x901f].
  Bus  2, device   4, function  1:
    Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 8).
      Master Capable.  Latency=32.
      I/O at 0x9400 [0x9407].
  Bus  2, device   5, function  0:
    Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 4).
      IRQ 17.
      Master Capable.  Latency=32.  Min Gnt=8.Max Lat=56.
      Prefetchable 32 bit memory at 0xee000000 [0xee000fff].
      I/O at 0x9800 [0x981f].
      Non-prefetchable 32 bit memory at 0xed000000 [0xed0fffff].
  Bus  2, device   6, function  0:
    SCSI storage controller: Adaptec AHA-2940U/UW/D / AIC-7881U (rev 1).
      IRQ 18.
      Master Capable.  Latency=32.  Min Gnt=8.Max Lat=8.
      I/O at 0x9c00 [0x9cff].
      Non-prefetchable 32 bit memory at 0xed120000 [0xed120fff].
  Bus  2, device   9, function  0:
    Ethernet controller: Intel Corp. 82559ER (rev 9).
      IRQ 17.
      Master Capable.  Latency=32.  Min Gnt=8.Max Lat=56.
      Non-prefetchable 32 bit memory at 0xed121000 [0xed121fff].
      I/O at 0xa000 [0xa03f].
      Non-prefetchable 32 bit memory at 0xed100000 [0xed11ffff].

Thanks,
	Dieter

-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
@home: Dieter.Nuetzel@hamburg.de
