Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269461AbTGUHxB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 03:53:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269473AbTGUHxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 03:53:01 -0400
Received: from webmail1.vol.cz ([195.250.155.194]:48392 "EHLO webmail1.vol.cz")
	by vger.kernel.org with ESMTP id S269461AbTGUHwl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 03:52:41 -0400
MIME-Version: 1.0
Subject: ACPI in 2.4.22-pre7 doesn't switch my computer off!!!
From: cijoml@volny.cz
To: linux-kernel@vger.kernel.org
Date: Mon, 21 Jul 2003 10:07:41 +0200 (CEST)
Message-ID: <138e1054c67547500d05029c100093f0@www1.mail.volny.cz>
X-Mailer: Volny.cz Webmail2 1.29
X-Originating-Ip: 213.246.96.186
X-Originating-Agent: Mozilla/5.0 (X11; U; Linux i686; cs-CZ; rv:1.4) Gecko/20030701
X-Priority: 3
X-MSMail-Priority: Normal
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have Intel Pentium 3 motherboard originally created by Intel
with P3 733MHz.

It's type D815EEA. I upgraded BIOS to latest
EA81510A.86A.0046.P11 from this site:

http://downloadfinder.intel.com/scripts-df/filter_results.asp?strOSs=All&strTypes=BIO%2CDRV%2CUTL&ProductID=385&OSFullName=All+Operating+Systems&submit=Go%21

but it didn't help me :(

Thanks for solving my problem.
I thought, that buying original Intel solution will help me to
not have problems with Linux.

CIJOML

Dmesg:

Linux version 2.4.22-pre7 (root@tata) (gcc version 3.3 (Debian))
#4 Ne èec 20 12:46:50 CEST 2003 BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000ffc0000 (usable)
 BIOS-e820: 000000000ffc0000 - 000000000fff8000 (ACPI data)
 BIOS-e820: 000000000fff8000 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000ffb80000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
255MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 65472
zone(0): 4096 pages.
zone(1): 61376 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 AMI                        ) @ 0x000ff980
ACPI: RSDT (v001 D815EA EA81510A 08193.01561) @ 0x0fff0000
ACPI: FADT (v001 D815EA EA81510A 08193.01561) @ 0x0fff1000
ACPI: SSDT (v001 D815EA EA81510A 00000.00023) @ 0x0ffe300c
ACPI: DSDT (v001 D815EA EA81510A 00000.00024) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: MADT not present
Kernel command line: BOOT_IMAGE=Linux ro root=303
video=tdfx:1024x768-24@75 Local APIC disabled by BIOS --
reenabling.
Found and enabled local APIC!
Initializing CPU#0
Detected 730.977 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1458.17 BogoMIPS
Memory: 256428k/261888k available (1381k kernel code, 5072k
reserved, 494k data, 116k init, 0k highmem) Dentry cache hash
table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU: Intel Pentium III (Coppermine) stepping 03
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 730.9471 MHz.
..... host bus clock speed is 132.8993 MHz.
cpu: 0, clocks: 1328993, slice: 664496
CPU0<T0:1328992,T1:664496,D:0,S:664496,C:1328993>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20030619
PCI: PCI BIOS revision 2.10 entry at 0xfda95, last bus=2
PCI: Using configuration type 1
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S3 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Transparent bridge - Intel Corp. 82801BA/CA/DB/EB PCI Bridge
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [URP1] (off)
ACPI: Power Resource [URP2] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *9 10 11 12)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12,
disabled) ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10
*11 12)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12,
disabled) ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11
12, disabled) ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9
10 *11 12)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 *10 11 12)
PCI: Probing PCI hardware
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 9
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or
even 'acpi=off' Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
Starting kswapd
VFS: Disk quotas vdquot_6.5.1
Journalled Block Device driver loaded
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SBTN]
ACPI: Processor [CPU1] (supports C1)
fb: Voodoo3 memory = 16384K
fb: MTRR's turned on
tdfxfb: reserving 1024 bytes for the hwcursor at d1816000
Console: switching to colour frame buffer device 128x48
fb0: 3Dfx Voodoo3 frame buffer device
pty: 256 Unix98 ptys configured
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024
blocksize Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: Detected Intel i815 chipset
agpgart: AGP aperture is 64M @ 0xf4000000
[drm] Initialized tdfx 1.0.0 20010216 on minor 0
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx ICH2: IDE controller at PCI slot 00:1f.1
ICH2: chipset revision 2
ICH2: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA,
hdb:pio     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings:
hdc:DMA, hdd:DMA
hda: QUANTUM FIREBALLP AS30.0, ATA DISK drive
blk: queue c031f640, I/O limit 4095Mb (mask 0xffffffff)
hdc: DVD-ROM DDU1621, ATAPI CD/DVD-ROM drive
hdd: _NEC CD-RW NR-9100A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 58633344 sectors (30020 MB) w/1902KiB Cache,
CHS=3649/255/63, UDMA(100) Partition check:
 hda: hda1 hda2 hda3 hda4
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
host/usb-uhci.c: $Revision: 1.275 $ time 12:47:05 Jul 20 2003
host/usb-uhci.c: High bandwidth mode enabled
PCI: Setting latency timer of device 00:1f.2 to 64
host/usb-uhci.c: USB UHCI at I/O 0xef40, IRQ 11
host/usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1f.4 to 64
host/usb-uhci.c: USB UHCI at I/O 0xef80, IRQ 10
host/usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
host/usb-uhci.c: v1.275:USB Universal Host Controller Interface
driver NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 116k freed
hub.c: new USB device 00:1f.2-1, assigned address 2
usb.c: USB device 2 (vend/prod 0x458/0x3) is not claimed by any
active driver. hub.c: new USB device 00:1f.2-2, assigned address
3
usb.c: USB device 3 (vend/prod 0x46d/0x870) is not claimed by any
active driver. Adding Swap: 128516k swap-space (priority -1)
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,3), internal journal
hub.c: new USB device 00:1f.4-2, assigned address 2
Real Time Clock Driver v1.10e
usb.c: USB device 2 (vend/prod 0x3ee/0x641f) is not claimed by
any active driver. Intel 810 + AC97 Audio, version 0.24, 12:39:13
Jul 20 2003
PCI: Setting latency timer of device 00:1f.5 to 64
i810: Intel ICH2 found at IO 0xef00 and 0xe800, MEM 0x0000 and
0x0000, IRQ 9 i810_audio: Audio Controller supports 6 channels.
i810_audio: Defaulting to base 2 channel mode.
i810_audio: Resetting connection 0
ac97_codec: AC97 Audio codec, id: ADS96 (Analog Devices AD1885)
i810_audio: AC'97 codec 0 Unable to map surround DAC's (or DAC's
not present), total channels = 2 NTFS driver v1.1.22 [Flags: R/O
MODULE]
NTFS: Warning! NTFS volume version is Win2k+: Mounting read-only
3c59x: Donald Becker and others.
www.scyld.com/network/vortex.html See
Documentation/networking/vortex.txt
01:0a.0: 3Com PCI 3c905B Cyclone 100baseTx at 0xcc00. Vers
LK1.1.18-ac  00:50:04:6a:58:cd, IRQ 11
  product code 544e rev 00.9 date 02-17-99
  Internal config register is 1800000, transceivers 0xa.
  8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate
interface.   MII transceiver found at address 24, status 782d.
  Enabling bus-master transmits and whole-frame receives.
01:0a.0: scatter/gather enabled. h/w checksums enabled
ip_conntrack version 2.1 (2046 buckets, 16368 max) - 292 bytes
per conntrack ip_tables: (C) 2000-2002 Netfilter core team
BlueZ Core ver 2.3 Copyright (C) 2000,2001 Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
BlueZ HCI USB driver ver 2.4 Copyright (C) 2000,2001 Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
usb.c: registered new driver hci_usb
BlueZ L2CAP ver 2.3 Copyright (C) 2000,2001 Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
BlueZ RFCOMM ver 1.0
Copyright (C) 2002 Maxim Krasnyansky <maxk@qualcomm.com>
Copyright (C) 2002 Marcel Holtmann <marcel@holtmann.org>
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
lp0: using parport0 (polling).
mice: PS/2 mouse device common for all mice
usb.c: registered new driver hiddev
usb.c: registered new driver hid
input: USB HID v1.00 Mouse [KYE Genius USB Wheel Mouse] on
usb1:2.0 hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik
<vojtech@suse.cz>
hid-core.c: USB HID support drivers
mtrr: 0xf0000000,0x2000000 overlaps existing 0xf0000000,0x1000000
mtrr: 0xf0000000,0x2000000 overlaps existing 0xf0000000,0x1000000
Linux video capture interface: v1.00
i2c-core.o: i2c core module
i2c-algo-bit.o: i2c bit algorithm module
i2c-core.o: driver i2c msp3400 driver registered.
i2c-core.o: driver i2c TV tuner driver registered.
bttv: driver version 0.7.107 loaded
bttv: using 4 buffers with 2080k (8320k total) for capture
bttv: Host bridge is Intel Corp. 82815 815 Chipset Host Bridge
and Memory Controller Hub bttv: Bt8xx card found (0).
bttv0: Bt878 (rev 2) at 01:0b.0, irq: 10, latency: 32, mmio:
0xee6fe000 bttv0: detected: ATI TV Wonder/VE [card=64], PCI
subsystem ID is 1002:0003 bttv0: using: BT878(ATI TV-Wonder VE)
[card=64,insmod option]
tuner: chip found @ 0xc0
tuner(bttv): type forced to 19 (Temic PAL* auto (4006 FN5))
[insmod] i2c-core.o: client [Temic PAL* auto (4006 FN5)]
registered to adapter [bt848 #0](pos. 0). i2c-core.o: adapter
bt848 #0 registered as adapter 0.
bttv0: using tuner=19
tuner: type already set (19)
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
bttv0: PLL: 28636363 => 35468950 .. ok
bttv0: registered device video0
bttv0: registered device vbi0
tvaudio: TV audio decoder + audio/video mux driver
tvaudio: known chips:
tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,tea6420,tda8425,pic16c54
(PV951),ta8874z i2c-core.o: driver generic i2c audio driver
registered.
i2c-core.o: driver tv card mixer driver registered.
btaudio: driver version 0.7 loaded [digital+analog]
btaudio: Bt878 (rev 2) at 01:0b.1, irq: 10, latency: 32, mmio:
0xee6ff000 btaudio: using card config "default"
btaudio: registered device dsp1 [digital]
btaudio: registered device dsp2 [analog]
btaudio: registered device mixer1


-- 
Horké léto s VOLNÝ: Vyhraj Ford s klimatizací! Vice na
http://soutez.volny.cz

