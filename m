Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317264AbSHAWb2>; Thu, 1 Aug 2002 18:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317280AbSHAWb2>; Thu, 1 Aug 2002 18:31:28 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:4100 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S317264AbSHAWb1>;
	Thu, 1 Aug 2002 18:31:27 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Marcin Dalecki <dalecki@evision.ag>
Date: Fri, 2 Aug 2002 00:34:27 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: IDE from current bk tree, UDMA and two channels...
CC: viro@math.psu.edu, linux-kernel@vger.kernel.org, mingo@elte.hu
X-mailer: Pegasus Mail v3.50
Message-ID: <CEC235645E@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  2 Aug 02 at 0:13, Marcin Dalecki wrote:
> 
> Would you mind sending me hdparm -i /dev/hdx and hdparm -I /dev/hdx
> for documentation purposes? The host controller chip could be the
> one to blame as well.
> 
> I fear the need for jet another black list.

Here they are. This is with i845 (82801BA rev B5) host chip. I'll check
i440BX tomorrow and PDC20265 on sunday. I believe that PDC20265
worked because of I did not notice problem at home, only at work.
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz

/dev/hdc:

 Model=TOSHIBA MK6409MAV, FwRev=F1.03 A, SerialNo=58S40974
 Config={ Fixed }
 RawCHS=13424/15/63, TrkSize=0, SectSize=0, ECCbytes=36
 BuffType=unknown, BuffSize=0kB, MaxMultSect=16, MultSect=off
 CurCHS=13424/15/63, CurSects=12685680, LBA=yes, LBAsects=12685680
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4 
 DMA modes: sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 udma0 udma1 *udma2 
 AdvancedPM=no WriteCache=enabled
 Drive Supports : Reserved : ATA-1 ATA-2 ATA-3 ATA-4 


/dev/hdc:

non-removable ATA device, with non-removable media
    Model Number:       TOSHIBA MK6409MAV                       
    Serial Number:      58S40974            
    Firmware Revision:  F1.03 A 
Standards:
    Supported: 1 2 3 4 
    Likely used: 4
Configuration:
    Logical         max     current
    cylinders       13424   13424
    heads           15      15
    sectors/track   63      63
    bytes/track:    0       (obsolete)
    bytes/sector:   0       (obsolete)
    current sector capacity: 12685680
    LBA user addressable sectors = 12685680
Capabilities:
    LBA, IORDY(can be disabled)
    ECC bytes: 36   Queue depth: 1
    Standby timer values: spec'd by Vendor, no device specific minimum
    r/w multiple sector transfer: Max = 16  Current = 16
    DMA: sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 udma0 udma1 *udma2 
         Cycle time: min=120ns recommended=120ns
    PIO: pio0 pio1 pio2 pio3 pio4 
         Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
    Enabled Supported:
       *    NOP cmd
       *    READ BUFFER cmd
       *    WRITE BUFFER cmd
       *    Host Protected Area feature set
       *    look-ahead
       *    write cache
       *    Power Management feature set
            Security Mode feature set
       *    SMART feature set
Security: 
        supported
    not enabled
    not locked
        frozen
    not expired: security count
    not supported: enhanced erase
    22min for SECURITY ERASE UNIT. 

00:1f.1 IDE interface: Intel Corp. 82801BA IDE U100 (rev 05) (prog-if 80 [Master])
    Subsystem: Intel Corp.: Unknown device 5054
00:1f.1 Class 0101: 8086:244b (rev 05) (prog-if 80 [Master])
    Subsystem: 8086:5054
    Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
    Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
    Latency: 0
    Region 4: I/O ports at ffa0 [size=16]
00: 86 80 4b 24 05 00 80 02 05 80 01 01 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: a1 ff 00 00 00 00 00 00 00 00 00 00 86 80 54 50
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 47 e3 47 e3 00 00 00 00 05 00 01 02 00 00 00 00
50: 00 00 00 00 10 14 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 47 0f 00 00 00 00 00 00


pcibus = 33333
00:1f.1 vendor=8086 device=244b class=0101 irq=0 base4=ffa1
----------PIIX BusMastering IDE Configuration---------------
Driver Version:                     1.3
South Bridge:                       9291
Revision:                           IDE 0x5
Highest DMA rate:                   UDMA100
BM-DMA base:                        0xffa0
PCI clock:                          33.3MHz
-----------------------Primary IDE-------Secondary IDE------
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   80w                 40w
-------------------drive0----drive1----drive2----drive3-----
Prefetch+Post:        yes       yes       yes       yes
Transfer Mode:       UDMA       PIO      UDMA       PIO
Address Setup:       90ns      90ns      90ns      90ns
Cmd Active:         360ns     360ns     360ns     360ns
Cmd Recovery:       540ns     540ns     540ns     540ns
Data Active:         90ns     360ns      90ns     360ns
Data Recovery:       30ns     540ns      30ns     540ns
Cycle Time:          22ns     900ns      60ns     900ns
Transfer Rate:   88.8MB/s   2.2MB/s  33.3MB/s   2.2MB/s

(whee, Intel defines UDMA(100) to 88.8MB/s?)
