Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312491AbSC3N23>; Sat, 30 Mar 2002 08:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312487AbSC3N2K>; Sat, 30 Mar 2002 08:28:10 -0500
Received: from web12901.mail.yahoo.com ([216.136.174.68]:62644 "HELO
	web12901.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S312488AbSC3N17>; Sat, 30 Mar 2002 08:27:59 -0500
Message-ID: <20020330132759.60218.qmail@web12901.mail.yahoo.com>
Date: Sat, 30 Mar 2002 14:27:58 +0100 (CET)
From: =?iso-8859-1?q?Jim=20MacBaine?= <jmacbaine@yahoo.de>
Subject: PDC20268 broke in 2.4.19-pre4-ac3
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-11531316-1017494878=:60146"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-11531316-1017494878=:60146
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline


The Promise PDC20268 driver fails with my setup
in 2.4.19-pre4-ac3. The same setup works fine for
about three weeks with 2.4.19-pre2-ac4.

The configuration remained unchanged except for 
serial console support to read the kernel messages.

There are two IBM harddisks attached to the first
channel, a single HP CDRW on the secound channel 
of a Promise Ultra100 TX2:

hde: IC35L060AVER07-0, ATA DISK drive
hdf: IBM-DJNA-352030, ATA DISK drive
hdh: R/RW 4x4x32, ATAPI CD/DVD-ROM drive

Although the kernel says, 

Warning: Primary channel requires an 80-pin cable
         for operation.

I swear the two disks on the first channel are 
connected with an original Promise UDMA/100 cable.
The CDRW is not connected with an 80-pin cable, 
but works well with 2.4.19-pre2-ac4. 

Please see the attached file for the full startup 
log. 

Regards, 
Jim




__________________________________________________________________

Gesendet von Yahoo! Mail - http://mail.yahoo.de
Sie brauchen mehr Speicher für Ihre E-Mails? - http://premiummail.yahoo.de
--0-11531316-1017494878=:60146
Content-Type: text/plain; name="linux.txt"
Content-Description: linux.txt
Content-Disposition: inline; filename="linux.txt"

Linux version 2.4.19-pre4-ac3 (jim@pluto) (gcc version 2.95.3 20010315 (SuSE)) #3 Sat Mar 30 13:00:23 CET 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000002fff0000 (usable)
 BIOS-e820: 000000002fff0000 - 000000002fff3000 (ACPI NVS)
 BIOS-e820: 000000002fff3000 - 0000000030000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 196592
zone(0): 4096 pages.
zone(1): 192496 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=normal-new ro root=101 BOOT_FILE=/boot/vmlinuz-2.4.19-pre4-ac3 console=ttyS0
Initializing CPU#0
Detected 864.473 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1723.59 BogoMIPS
Memory: 774268k/786368k available (923k kernel code, 11712k reserved, 311k data, 228k init, 0k highmem)
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium III (Coppermine) stepping 03
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb290, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router VIA [1106/0596] at 00:07.0
Activating ISA DMA hang workarounds.
PnPBIOS: Found PnP BIOS installation structure at 0xc00fbce0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xbd10, dseg 0xf0000
PnPBIOS: 14 nodes reported by PnP BIOS; 14 recorded by driver
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)
Starting kswapd
Journalled Block Device driver loaded
devfs: v1.10 (20020120) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
Real Time Clock Driver v1.10e
block: 1024 slots per queue, batch=256
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c596b (rev 23) IDE UDMA66 controller on pci00:07.1
    ide0: BM-DMA at 0xc000-0xc007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xc008-0xc00f, BIOS settings: hdc:DMA, hdd:DMA
PDC20268: IDE controller on PCI bus 00 dev 60
PCI: Found IRQ 11 for device 00:0c.0
PCI: Sharing IRQ 11 with 00:0d.0
PDC20268: chipset revision 1
PDC20268: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0xdc00-0xdc07, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xdc08-0xdc0f, BIOS settings: hdg:pio, hdh:pio
hda: Maxtor 34098H4, ATA DISK drive
hdc: _NEC DV-5500A, ATAPI CD/DVD-ROM drive
hdd: CDD4801 CD-R/RW, ATAPI CD/DVD-ROM drive
hde: IC35L060AVER07-0, ATA DISK drive
hdf: IBM-DJNA-352030, ATA DISK drive
hdh: R/RW 4x4x32, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xcc00-0xcc07,0xd002 on irq 11
ide3 at 0xd400-0xd407,0xd802 on irq 11
hda: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=4865/255/63, UDMA(66)
hde: 120103200 sectors (61493 MB) w/1916KiB Cache, CHS=119150/16/63, UDMA(100)
hdf: set_drive_speed_status: status=0xff { Busy }
Warning: Primary channel requires an 80-pin cable for operation.
hdf reduced to Ultra33 mode.
hdf: set_drive_speed_status: status=0xff { Busy }
hdf: status timeout: status=0xff { Busy }
hdf: drive not ready for command
hdf: 39876480 sectors (20417 MB) w/1966KiB Cache, CHS=39560/16/63, (U)DMA
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
 /dev/ide/host2/bus0/target0/lun0:hde: status timeout: status=0xff { Busy }
hde: DMA disabled
hdf: DMA disabled
PDC202XX: Primary channel reset.
hde: drive not ready for command
ide2: reset timed-out, status=0xff
hde: status timeout: status=0xff { Busy }
PDC202XX: Primary channel reset.
hde: drive not ready for command
ide2: reset timed-out, status=0xff
end_request: I/O error, dev 21:00 (hde), sector 0
end_request: I/O error, dev 21:00 (hde), sector 2
end_request: I/O error, dev 21:00 (hde), sector 4
end_request: I/O error, dev 21:00 (hde), sector 6
end_request: I/O error, dev 21:00 (hde), sector 0
end_request: I/O error, dev 21:00 (hde), sector 2
end_request: I/O error, dev 21:00 (hde), sector 4
end_request: I/O error, dev 21:00 (hde), sector 6
 unable to read partition table
 /dev/ide/host2/bus0/target1/lun0:hdf: status timeout: status=0xff { Busy }
PDC202XX: Primary channel reset.
hdf: drive not ready for command
ide2: reset timed-out, status=0xff
hdf: status timeout: status=0xff { Busy }
PDC202XX: Primary channel reset.
hdf: drive not ready for command
ide2: reset timed-out, status=0xff
end_request: I/O error, dev 21:40 (hdf), sector 0
end_request: I/O error, dev 21:40 (hdf), sector 2
end_request: I/O error, dev 21:40 (hdf), sector 4
end_request: I/O error, dev 21:40 (hdf), sector 6
end_request: I/O error, dev 21:40 (hdf), sector 0
end_request: I/O error, dev 21:40 (hdf), sector 2
end_request: I/O error, dev 21:40 (hdf), sector 4
end_request: I/O error, dev 21:40 (hdf), sector 6
 unable to read partition table
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 1k freed
VFS: Mounted root (minix filesystem).


--0-11531316-1017494878=:60146--
