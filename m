Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288083AbSACAih>; Wed, 2 Jan 2002 19:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288090AbSACAhV>; Wed, 2 Jan 2002 19:37:21 -0500
Received: from CPEdeadbeef0000.cpe.net.cable.rogers.com ([24.100.234.67]:20484
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S288084AbSACAg6>; Wed, 2 Jan 2002 19:36:58 -0500
Subject: Strange USB issues... - 2.4.x Kernels & more info
From: Shawn Starr <spstarr@sh0n.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1.99 (Preview Release)
Date: 02 Jan 2002 19:38:46 -0500
Message-Id: <1010018353.20263.15.camel@unaropia>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I should mention this happens in 2.4.x kernel series.

I have a Pentium 200Mhz AMD Bios (home machine):

USB 1.0 - 2 ports

The bios has 2 options:

PCI hardware/Motherboard:
00:00.0 Host bridge: Intel Corporation 430HX - 82439HX TXC [Triton II] (rev 03)
00:07.0 ISA bridge: Intel Corporation 82371SB PIIX3 ISA [Natoma/Triton II] (rev 01)
00:07.1 IDE interface: Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton II]
00:09.0 VGA compatible controller: ATI Technologies Inc 3D Rage I/II 215GT [Mach64 GT] (rev 41)
00:0b.0 SCSI storage controller: Adaptec AHA-7850 (rev 03)
00:0c.0 Ethernet controller: 3Com Corporation 3c900B-TPO [Etherlink XL TPO] (rev 04)

AcerOpen Pentium 200Mhz w/o MMX. 64MiB RAM (60ns)
Hard drives:

hda: FUJITSU MPE3064AT, ATA DISK drive
hdb: WDC AC32500H, ATA DISK drive
hdc: YAMAHA CRW2100E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15

SCSI subsystem driver Revision: 1.00
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.4
        <Adaptec 2902/04/10/15/20/30C SCSI adapter>
        aic7850: Single Channel A, SCSI Id=7, 3/253 SCBs

st: Version 20011103, bufsize 32768, wrt 30720, max init. bufs 4, s/g segs 16
Attached scsi tape st0 at scsi0, channel 0, id 4, lun 0
Attached scsi CD-ROM sr0 at scsi1, channel 0, id 0, lun 0

Soundblaster audio driver Copyright (C) by Hannu Savolainen 1993-1996
sb: Creative SB32 PnP detected
sb: ISAPnP reports 'Creative SB32 PnP' at i/o 0x220, irq 5, dma 1, 5
<Sound Blaster 16 (4.13)> at 0x220 irq 5 dma 1,5
<Sound Blaster 16> at 0x330 irq 5 dma 0,0
sb: 1 Soundblaster PnP card(s) found.
YM3812 and OPL-3 driver Copyright (C) by Hannu Savolainen, Rob Hooft 1993-1996
ISAPnP reports AWE32 WaveTable at i/o 0x620
<SoundBlaster EMU8000 (RAM2048k)>




Enable USB controller and enable USB legacy stuff. 


If I turn on USB and boot to a Linux kernel WITH NO USB support compiled
in. I get:

1) Slow loading of kernel into memory on bootup
2) AT keyboard timeout (?) errors and no activity with the keyboard
(shift lock/numlock/scroll lock). I  have to reboot to correct the
problem by disabling USB in the bios.

I'm not sure why this is happening, if anyone else has been noticing
this please let me know or would like me to do some debugging :-)

Shawn.



