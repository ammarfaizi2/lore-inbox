Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318423AbSGSB3D>; Thu, 18 Jul 2002 21:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318424AbSGSB3C>; Thu, 18 Jul 2002 21:29:02 -0400
Received: from paloma15.e0k.nbg-hannover.de ([62.181.130.15]:6551 "HELO
	paloma15.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S318423AbSGSB26>; Thu, 18 Jul 2002 21:28:58 -0400
Content-Type: text/plain;
  charset="iso-8859-15"
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Dual Athlon MP 1900+ on MSI K7D Master-L
Date: Fri, 19 Jul 2002 03:31:57 +0200
User-Agent: KMail/1.4.2
Cc: SCoTT SMeDLeY <ss@aao.gov.au>, Alan Cox <alan@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200207190331.57158.Dieter.Nuetzel@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Specs:

dual "MP unlocked" Athlon XP 1900+ (4th bridge of L5 is closed)
MSI K7D Master-L (MS-6501 v1.0), AMD 760 MPX
2 x 512 MB DDR-SDRAM 266, CL2, unregistered, no ECC

Linux SMP 2.4.19-rc1-jam2 + Page Coloring

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

/home/nuetzel> sensors
eeprom-i2c-0-50
Adapter: SMBus AMD768 adapter at 06e0
Algorithm: Non-I2C SMBus adapter
Memory type:            SDRAM DIMM SPD
SDRAM Size (MB):        invalid
12 1 2 144

eeprom-i2c-0-51
Adapter: SMBus AMD768 adapter at 06e0
Algorithm: Non-I2C SMBus adapter

w83627hf-isa-0290
Adapter: ISA adapter
Algorithm: ISA algorithm
VCore 1:   +1.71 V  (min =  +4.08 V, max =  +4.08 V)
VCore 2:   +2.48 V  (min =  +4.08 V, max =  +4.08 V)
+3.3V:     +3.36 V  (min =  +3.13 V, max =  +3.45 V)
+5V:       +4.94 V  (min =  +4.72 V, max =  +5.24 V)
+12V:     +12.08 V  (min = +10.79 V, max = +13.19 V)
-12V:     -12.70 V  (min = -13.21 V, max = -10.90 V)
-5V:       -5.10 V  (min =  -5.26 V, max =  -4.76 V)
V5SB:      +5.38 V  (min =  +4.72 V, max =  +5.24 V)
VBat:      +3.42 V  (min =  +2.40 V, max =  +3.60 V)
U160:        0 RPM  (min = 3000 RPM, div = 2)
CPU 0:    4500 RPM  (min = 3000 RPM, div = 2)
CPU 1:    4272 RPM  (min = 3000 RPM, div = 2)
System:   +33.0°C   (limit = +60°C, hysteresis = +127°C) sensor = thermistor
CPU 1:    +41.5°C   (limit = +60°C, hysteresis = +50°C) sensor = 3904 
transistor
CPU 0:    +43.0°C   (limit = +60°C, hysteresis = +50°C) sensor = 3904 
transistor
vid:      +18.50 V
alarms:   Chassis intrusion detection
beep_enable:
          Sound alarm disabled

During compilation of the glibc.
Do you need more info?

Alan, were should I put the "-j2/-j3" make flag for the kernel compilation?
/usr/src/linux/Documentation/smp.txt is way outdated ;-(

Is there a place (maybe in /usr/lib/rpmrc; SuSE/RedHat) to get both CPUs 
running during RPM packages compilation?

Thanks,
	Dieter
-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
@home: Dieter.Nuetzel@hamburg.de

