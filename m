Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129165AbRBCOUi>; Sat, 3 Feb 2001 09:20:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129143AbRBCOU2>; Sat, 3 Feb 2001 09:20:28 -0500
Received: from web12008.mail.yahoo.com ([216.136.172.216]:47888 "HELO
	web12008.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129165AbRBCOUW>; Sat, 3 Feb 2001 09:20:22 -0500
Message-ID: <20010203142021.45886.qmail@web12008.mail.yahoo.com>
Date: Sat, 3 Feb 2001 06:20:21 -0800 (PST)
From: Lourenco <andyrock50@yahoo.com>
Subject: IDE PROBLEM 2.4.0 and 2.4.1
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi!

i am getting an error every time i try to copy a big
file from my cdrom to one of my harddrives...

my hardware: P2 333 128 MB Ram
             ONLY IDE
             BOARD BX

i had run dmesg.

here it goes:

(...)
pty: 256 Unix98 ptys configured
block: queued sectors max/low 83821kB/27940kB, 256
slots per queue
RAMDISK driver initialized: 16 RAM disks of 4096K size
1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes;
override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings:
hda:pio, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings:
hdc:pio, hdd:pio
hda: FUJITSU MPE3170AT, ATA DISK drive
hdb: QUANTUM FIREBALL EX3.2A, ATA DISK drive
hdc: TOSHIBA CD-ROM XM-6402B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 33360580 sectors (17081 MB) w/512KiB Cache,
CHS=2076/255/63
hdb: 6306048 sectors (3229 MB) w/418KiB Cache,
CHS=782/128/63, UDMA(33)
hdc: ATAPI 32X CD-ROM drive, 256kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 < hda5 > hda3 hda4
 hdb: hdb1 hdb2 < hdb5 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Loading I2O Core - (c) Copyright 1999 Red Hat Software
I2O configuration manager v 0.04.
  (C) Copyright 1999 Red Hat Software
Serial driver version 5.02 (2000-08-09) with
MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
PPP generic driver version 2.4.1
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory:
96M
agpgart: Detected Intel 440BX chipset
agpgart: AGP aperture is 64M @ 0xe0000000
es1371: version v0.27 time 10:54:26 Feb  3 2001
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
uhci.c: USB UHCI at I/O 0xe000, IRQ 9
uhci.c: detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind
8192)
Linux IP multicast router 0.06 plus PIM-SM
IP-Config: No network devices available.
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
NET4: Linux IPX 0.43 for NET4.0
IPX Portions Copyright (c) 1995 Caldera, Inc.
IPX Portions Copyright (c) 2000 Conectiva, Inc.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 232k freed
Adding Swap: 128516k swap-space (priority -1)
Soundblaster audio driver Copyright (C) by Hannu
Savolainen 1993-1996
sb: ESS ES1868 Plug and Play AudioDrive detected
sb: ISAPnP reports 'ESS ES1868 Plug and Play
AudioDrive' at i/o 0x220, irq 5, dma 1, 3
SB 3.01 detected OK (220)
ESS chip ES1868 detected
<ESS ES1868 AudioDrive (rev 11) (3.01)> at 0x220 irq 5
dma 1,3
sb: ESS ES1868 Plug and Play AudioDrive detected
sb: Failed to initialize ESS ES1868 Plug and Play
AudioDrive
sb: 1 Soundblaster PnP card(s) found.
YM3812 and OPL-3 driver Copyright (C) by Hannu
Savolainen, Rob Hooft 1993-1996
<Yamaha OPL3> at 0x388
0x378: FIFO is 16 bytes
0x378: writeIntrThreshold is 16
0x378: readIntrThreshold is 16
0x378: PWord is 8 bits
0x378: Interrupts are ISA-Pulses
0x378: ECP port cfgA=0x10 cfgB=0x48
0x378: ECP settings irq=7 dma=<none or set by other
means>
parport0: PC-style at 0x378 (0x778)
[PCSPP,TRISTATE,COMPAT,EPP,ECP]
parport0: irq 7 detected
parport0: cpp_mux: aa55f00f52ad51(07)
parport0: Found 1 daisy-chained devices
lp0: using parport0 (polling).
lp0: console ready
VFS: Disk change detected on device ide1(22,0)
ISO 9660 Extensions: Microsoft Joliet Level 3
ISOFS: changing to secondary root
VFS: Disk change detected on device ide1(22,0)
ISO 9660 Extensions: Microsoft Joliet Level 3
ISOFS: changing to secondary root
isofs_read_level3_size: More than 100 file sections
?!?, aborting...
isofs_read_level3_size: inode=45152 ino=53408
isofs_read_level3_size: More than 100 file sections
?!?, aborting...
isofs_read_level3_size: inode=45232 ino=53488
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18356
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18360
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18364
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18368
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18372
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18376
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18380
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18384
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18388
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18392
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18396
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18400
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18404
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18408
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18412
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18416
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18420
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18424
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18428
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18432
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18436
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18440
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18444
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18448
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18452
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18456
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18460
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18464
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18468
hdc: cdrom_decode_status: status=0x51 { DriveReady
SeekComplete Error }
hdc: cdrom_decode_status: error=0x30
hdc: cdrom_decode_status: status=0x51 { DriveReady
SeekComplete Error }
hdc: cdrom_decode_status: error=0x30
hdc: cdrom_decode_status: status=0x51 { DriveReady
SeekComplete Error }
hdc: cdrom_decode_status: error=0x30
hdc: cdrom_decode_status: status=0x51 { DriveReady
SeekComplete Error }
hdc: cdrom_decode_status: error=0x30
hdc: DMA disabled
hdc: ATAPI reset complete
hdc: cdrom_decode_status: status=0x51 { DriveReady
SeekComplete Error }
hdc: cdrom_decode_status: error=0x30
hdc: cdrom_decode_status: status=0x51 { DriveReady
SeekComplete Error }
hdc: cdrom_decode_status: error=0x30
hdc: cdrom_decode_status: status=0x51 { DriveReady
SeekComplete Error }
hdc: cdrom_decode_status: error=0x30
hdc: ATAPI reset complete
end_request: I/O error, dev 16:00 (hdc), sector 18472
hdc: cdrom_decode_status: status=0x51 { DriveReady
SeekComplete Error }
hdc: cdrom_decode_status: error=0x30
hdc: cdrom_decode_status: status=0x51 { DriveReady
SeekComplete Error }
hdc: cdrom_decode_status: error=0x30
hdc: cdrom_decode_status: status=0x51 { DriveReady
SeekComplete Error }
hdc: cdrom_decode_status: error=0x30
hdc: cdrom_decode_status: status=0x51 { DriveReady
SeekComplete Error }
hdc: cdrom_decode_status: error=0x30
hdc: ATAPI reset complete
hdc: cdrom_decode_status: status=0x51 { DriveReady
SeekComplete Error }
hdc: cdrom_decode_status: error=0x30
hdc: cdrom_decode_status: status=0x51 { DriveReady
SeekComplete Error }
hdc: cdrom_decode_status: error=0x30
hdc: cdrom_decode_status: status=0x51 { DriveReady
SeekComplete Error }
hdc: cdrom_decode_status: error=0x30
hdc: ATAPI reset complete
end_request: I/O error, dev 16:00 (hdc), sector 18476
hdc: cdrom_decode_status: status=0x51 { DriveReady
SeekComplete Error }
hdc: cdrom_decode_status: error=0x30
hdc: cdrom_decode_status: status=0x51 { DriveReady
SeekComplete Error }
hdc: cdrom_decode_status: error=0x30
hdc: cdrom_decode_status: status=0x51 { DriveReady
SeekComplete Error }
hdc: cdrom_decode_status: error=0x30
hdc: cdrom_decode_status: status=0x51 { DriveReady
SeekComplete Error }
hdc: cdrom_decode_status: error=0x30
hdc: ATAPI reset complete
hdc: cdrom_decode_status: status=0x51 { DriveReady
SeekComplete Error }
hdc: cdrom_decode_status: error=0x30
hdc: cdrom_decode_status: status=0x51 { DriveReady
SeekComplete Error }
hdc: cdrom_decode_status: error=0x30
hdc: cdrom_decode_status: status=0x51 { DriveReady
SeekComplete Error }
hdc: cdrom_decode_status: error=0x30
hdc: ATAPI reset complete
end_request: I/O error, dev 16:00 (hdc), sector 18480
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18484
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18488
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18492
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18468
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18472
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18468
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18472
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18468
hdc: cdrom_decode_status: status=0x51 { DriveReady
SeekComplete Error }
hdc: cdrom_decode_status: error=0x30
hdc: cdrom_decode_status: status=0x51 { DriveReady
SeekComplete Error }
hdc: cdrom_decode_status: error=0x30
hdc: cdrom_decode_status: status=0x51 { DriveReady
SeekComplete Error }
hdc: cdrom_decode_status: error=0x30
hdc: cdrom_decode_status: status=0x51 { DriveReady
SeekComplete Error }
hdc: cdrom_decode_status: error=0x30
hdc: ATAPI reset complete
hdc: cdrom_decode_status: status=0x51 { DriveReady
SeekComplete Error }
hdc: cdrom_decode_status: error=0x30
hdc: cdrom_decode_status: status=0x51 { DriveReady
SeekComplete Error }
hdc: cdrom_decode_status: error=0x30
hdc: cdrom_decode_status: status=0x51 { DriveReady
SeekComplete Error }
hdc: cdrom_decode_status: error=0x30
hdc: ATAPI reset complete
end_request: I/O error, dev 16:00 (hdc), sector 18472
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18468
hdc: cdrom_decode_status: status=0x51 { DriveReady
SeekComplete Error }
hdc: cdrom_decode_status: error=0x30
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18472



__________________________________________________
Get personalized email addresses from Yahoo! Mail - only $35 
a year!  http://personal.mail.yahoo.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
