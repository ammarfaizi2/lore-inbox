Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285251AbRLMXRI>; Thu, 13 Dec 2001 18:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285252AbRLMXRA>; Thu, 13 Dec 2001 18:17:00 -0500
Received: from [206.98.161.198] ([206.98.161.198]:21779 "EHLO
	bart.learningpatterns.com") by vger.kernel.org with ESMTP
	id <S285251AbRLMXQq>; Thu, 13 Dec 2001 18:16:46 -0500
Subject: Re: Unknown bridge resource
From: Edward Muller <emuller@learningpatterns.com>
To: Juergen Sawinski <juergen.sawinski@mpimf-heidelberg.mpg.de>
Cc: "Martin> Mares" <mj@ucw.cz>,
        "linux-kernel@vger" <linux-kernel@vger.kernel.org>
In-Reply-To: <1008211968.16830.1.camel@nc1701d>
In-Reply-To: <Pine.GSO.4.30.0112130004310.5686-100000@balu> 
	<1008211968.16830.1.camel@nc1701d>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 13 Dec 2001 18:14:21 -0500
Message-Id: <1008285265.9614.0.camel@akira.learningpatterns.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Supply what info?

cat /proc/pci (here it is incase this is it)
----------------
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Intel Corp. 440BX/ZX - 82443BX/ZX Host bridge (rev 3).
      Master Capable.  Latency=64.  
      Prefetchable 32 bit memory at 0xf8000000 [0xfbffffff].
  Bus  0, device   1, function  0:
    PCI bridge: Intel Corp. 440BX/ZX - 82443BX/ZX AGP bridge (rev 3).
      Master Capable.  Latency=128.  Min Gnt=140.
  Bus  0, device   2, function  0:
    CardBus bridge: Texas Instruments PCI1450 (rev 3).
      IRQ 11.
      Master Capable.  Latency=64.  Min Gnt=192.Max Lat=7.
      Non-prefetchable 32 bit memory at 0x50000000 [0x50000fff].
  Bus  0, device   2, function  1:
    CardBus bridge: Texas Instruments PCI1450 (#2) (rev 3).
      IRQ 11.
      Master Capable.  Latency=64.  Min Gnt=192.Max Lat=7.
      Non-prefetchable 32 bit memory at 0x50100000 [0x50100fff].
  Bus  0, device   3, function  0:
    Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 9).
      IRQ 11.
      Master Capable.  Latency=66.  Min Gnt=8.Max Lat=56.
      Non-prefetchable 32 bit memory at 0xe8120000 [0xe8120fff].
      I/O at 0x1800 [0x183f].
      Non-prefetchable 32 bit memory at 0xe8100000 [0xe811ffff].
  Bus  0, device   3, function  1:
    Serial controller: PCI device 115d:000c (Xircom) (rev 0).
      IRQ 11.
      I/O at 0x1840 [0x1847].
      Non-prefetchable 32 bit memory at 0xe8121000 [0xe8121fff].
  Bus  0, device   5, function  0:
    Multimedia audio controller: Cirrus Logic CS 4614/22/24
[CrystalClear SoundFusion Audio Accelerator] (rev 1).
      IRQ 11.
      Master Capable.  Latency=64.  Min Gnt=4.Max Lat=24.
      Non-prefetchable 32 bit memory at 0xe8122000 [0xe8122fff].
      Non-prefetchable 32 bit memory at 0xe8000000 [0xe80fffff].
  Bus  0, device   7, function  0:
    Bridge: Intel Corp. 82371AB PIIX4 ISA (rev 2).
  Bus  0, device   7, function  1:
    IDE interface: Intel Corp. 82371AB PIIX4 IDE (rev 1).
      Master Capable.  Latency=64.  
      I/O at 0x1850 [0x185f].
  Bus  0, device   7, function  2:
    USB Controller: Intel Corp. 82371AB PIIX4 USB (rev 1).
      IRQ 11.
      Master Capable.  Latency=64.  
      I/O at 0x1860 [0x187f].
  Bus  0, device   7, function  3:
    Bridge: Intel Corp. 82371AB PIIX4 ACPI (rev 3).
      IRQ 9.
  Bus  1, device   0, function  0:
    VGA compatible controller: S3 Inc. 86C270-294 Savage/IX-MV (rev 17).
      IRQ 11.
      Master Capable.  Latency=64.  Min Gnt=4.Max Lat=255.
      Non-prefetchable 32 bit memory at 0xf0000000 [0xf7ffffff].
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Intel Corp. 440BX/ZX - 82443BX/ZX Host bridge (rev 3).
      Master Capable.  Latency=64.  
      Prefetchable 32 bit memory at 0xf8000000 [0xfbffffff].
  Bus  0, device   1, function  0:
    PCI bridge: Intel Corp. 440BX/ZX - 82443BX/ZX AGP bridge (rev 3).
      Master Capable.  Latency=128.  Min Gnt=140.
  Bus  0, device   2, function  0:
    CardBus bridge: Texas Instruments PCI1450 (rev 3).
      IRQ 11.
      Master Capable.  Latency=64.  Min Gnt=192.Max Lat=7.
      Non-prefetchable 32 bit memory at 0x50000000 [0x50000fff].
  Bus  0, device   2, function  1:
    CardBus bridge: Texas Instruments PCI1450 (#2) (rev 3).
      IRQ 11.
      Master Capable.  Latency=64.  Min Gnt=192.Max Lat=7.
      Non-prefetchable 32 bit memory at 0x50100000 [0x50100fff].
  Bus  0, device   3, function  0:
    Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 9).
      IRQ 11.
      Master Capable.  Latency=66.  Min Gnt=8.Max Lat=56.
      Non-prefetchable 32 bit memory at 0xe8120000 [0xe8120fff].
      I/O at 0x1800 [0x183f].
      Non-prefetchable 32 bit memory at 0xe8100000 [0xe811ffff].
  Bus  0, device   3, function  1:
    Serial controller: PCI device 115d:000c (Xircom) (rev 0).
      IRQ 11.
      I/O at 0x1840 [0x1847].
      Non-prefetchable 32 bit memory at 0xe8121000 [0xe8121fff].
  Bus  0, device   5, function  0:
    Multimedia audio controller: Cirrus Logic CS 4614/22/24
[CrystalClear SoundFusion Audio Accelerator] (rev 1).
      IRQ 11.
      Master Capable.  Latency=64.  Min Gnt=4.Max Lat=24.
      Non-prefetchable 32 bit memory at 0xe8122000 [0xe8122fff].
      Non-prefetchable 32 bit memory at 0xe8000000 [0xe80fffff].
  Bus  0, device   7, function  0:
    Bridge: Intel Corp. 82371AB PIIX4 ISA (rev 2).
  Bus  0, device   7, function  1:
    IDE interface: Intel Corp. 82371AB PIIX4 IDE (rev 1).
      Master Capable.  Latency=64.  
      I/O at 0x1850 [0x185f].
  Bus  0, device   7, function  2:
    USB Controller: Intel Corp. 82371AB PIIX4 USB (rev 1).
      IRQ 11.
      Master Capable.  Latency=64.  
      I/O at 0x1860 [0x187f].
  Bus  0, device   7, function  3:
    Bridge: Intel Corp. 82371AB PIIX4 ACPI (rev 3).
      IRQ 9.
  Bus  1, device   0, function  0:
    VGA compatible controller: S3 Inc. 86C270-294 Savage/IX-MV (rev 17).
      IRQ 11.
      Master Capable.  Latency=64.  Min Gnt=4.Max Lat=255.
      Non-prefetchable 32 bit memory at 0xf0000000 [0xf7ffffff].

-----------------------------------------------------------------

Or do you/Martin want lspci -vv ? ... Here it is ... just in case...

-------------
00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
(rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: <available only to root>

00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge
(rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 128
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	Memory behind bridge: f0000000-f7ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B+

00:02.0 CardBus bridge: Texas Instruments PCI1450 (rev 03)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 50000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=04, sec-latency=176
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+

00:02.1 CardBus bridge: Texas Instruments PCI1450 (rev 03)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR+
	Latency: 64, cache line size 08
	Interrupt: pin B routed to IRQ 11
	Region 0: Memory at 50100000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=05, subordinate=07, sec-latency=176
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+

00:03.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100]
(rev 09)
	Subsystem: Intel Corporation: Unknown device 2408
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e8120000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at 1800 [size=64]
	Region 2: Memory at e8100000 (32-bit, non-prefetchable) [size=128K]
	Expansion ROM at <unassigned> [disabled] [size=1M]
	Capabilities: <available only to root>

00:03.1 Serial controller: Xircom: Unknown device 000c (prog-if 02
[16550])
	Subsystem: Intel Corporation: Unknown device 2408
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 1840 [size=8]
	Region 1: Memory at e8121000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <available only to root>

00:05.0 Multimedia audio controller: Cirrus Logic CS 4614/22/24
[CrystalClear SoundFusion Audio Accelerator] (rev 01)
	Subsystem: IBM: Unknown device 0153
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort-
<MAbort- >SERR- <PERR+
	Latency: 64 (1000ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e8122000 (32-bit, non-prefetchable) [size=4K]
	Region 1: Memory at e8000000 (32-bit, non-prefetchable) [size=1M]
	Capabilities: <available only to root>

00:07.0 Bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
(prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at 1850 [size=16]

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
(prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at 1860 [size=32]

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 03)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

01:00.0 VGA compatible controller: S3 Inc. 86C270-294 Savage/MX-/IX (rev
11) (prog-if 00 [VGA])
	Subsystem: IBM: Unknown device 017f
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1000ns min, 63750ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at f0000000 (32-bit, non-prefetchable) [size=128M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: <available only to root>
----------------------------------------------------

As a reminder ... the exact error/msg I get is ...

Unknown bridge resource 0: assuming transparent
Unknown bridge resource 2: assuming transparent

If it's not the above info, then what?

On Wed, 2001-12-12 at 21:52, Juergen Sawinski wrote:
> If the pci id is not found (see drivers/pci/pci.ids), you'll get this
> message. If you can supply the description, the maintainer is Martin
> Mares <mj@ucw.cz>, see also http://pciids.sf.net/.
> 
> On Thu, 2001-12-13 at 00:08, Pozsar Balazs wrote:
> > 
> > Hi all,
> > 
> > During boot, i got these two lines in dmesg:
> > Unknown bridge resource 0: assuming transparent
> > Unknown bridge resource 2: assuming transparent
> > 
> > What do they mean?
> > 
> > 
> > ps: I noticed these because they are written on the console even if quiet
> > mode is on. There was a patch for 2.4-ac, but it seems that it somehow
> > lost... :(
> > 
> > -- 
> > Balazs Pozsar
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> -- 
> Juergen Sawinski
> Max-Planck-Institute for Medical Research
> Dept. of Biomedical Optics
> Jahnstr. 29
> D-69120 Heidelberg
> Germany
> 
> Phone:  +49-6221-486-309
> Fax:    +49-6221-486-325
> 
> priv.
> Phone:  +49-6221-418 848
> Mobile: +49-171-532 5302
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
-------------------------------
Edward Muller
Director of IS

973-715-0230 (cell)
212-487-9064 x115 (NYC)

http://www.learningpatterns.com
-------------------------------

