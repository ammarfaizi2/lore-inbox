Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275403AbTHIVIr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 17:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275406AbTHIVIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 17:08:47 -0400
Received: from mail.szintezis.hu ([195.56.253.241]:21845 "HELO
	hold.szintezis.hu") by vger.kernel.org with SMTP id S275403AbTHIVI2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 17:08:28 -0400
Subject: Re: [2.6.0-test3] Hyperthreading gone
From: Gabor MICSKO <gmicsko@szintezis.hu>
To: Florian Weimer <fw@deneb.enyo.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <87llu2bvxg.fsf@deneb.enyo.de>
References: <87llu2bvxg.fsf@deneb.enyo.de>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.5 
Date: 09 Aug 2003 23:10:29 +0200
Message-Id: <1060463443.507.4.camel@sunshine>
Mime-Version: 1.0
X-OriginalArrivalTime: 09 Aug 2003 21:08:23.0824 (UTC) FILETIME=[5E763900:01C35EBA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2003-08-09, szo keltezéssel Florian Weimer ezt írta:
> ACPI with CPU enumeration is enabled, but the sibling CPUs aren't
> activated.
> Total of 4 processors activated (11034.62 BogoMIPS).

> WARNING: No sibling found for CPU 0.

Yep. Same problem here. 


-test3 (root@sunshine) (gcc version 3.3.1 20030626 (Debian prerelease))
#4 SMP 2003. aug. 9., szombat, 22.32.15 CEST
Video mode to be used for restore is 317
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff40000 (usable)
 BIOS-e820: 000000001ff40000 - 000000001ff50000 (ACPI data)
 BIOS-e820: 000000001ff50000 - 0000000020000000 (ACPI NVS)
511MB LOWMEM available.
found SMP MP-table at 000ff780
hm, page 000ff000 reserved twice.
hm, page 00100000 reserved twice.
hm, page 000fd000 reserved twice.
hm, page 000fe000 reserved twice.
On node 0 totalpages: 130880
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126784 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID:  Product ID: BrkdlPE-ICH4 APIC at: 0xFEE00000
Processor #0 15:2 APIC version 20
I/O APIC #2 Version 32 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 1
Building zonelist for node : 0
Kernel command line: auto BOOT_IMAGE=3 ro root=304
BOOT_FILE=/boot/bzImage-3 hdd=ide-scsi 
ide_setup: hdd=ide-scsi
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 3066.970 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 6062.08 BogoMIPS
Memory: 514336k/523520k available (1969k kernel code, 8432k reserved,
629k data, 336k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU:     After generic identify, caps: bfebfbff 00000000 00000000
00000000
CPU:     After vendor identify, caps: bfebfbff 00000000 00000000
00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU:     After all inits, caps: bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#0: Thermal monitoring enabled
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel(R) Pentium(R) 4 CPU 3.06GHz stepping 07
per-CPU timeslice cutoff: 1463.27 usecs.
task migration cache decay timeout: 2 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Error: only one processor found.
WARNING: No sibling found for CPU 0.
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-22 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 28.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................
IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... register #02: 00000000
.......     : arbitration: 00
.... register #03: 00000001
.......     : Boot DT    : 1
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  1    1    0   0   0    1    1    71
 0a 001 01  0    0    0   0   0    1    1    79
 0b 001 01  0    0    0   0   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  0    0    0   0   0    1    1    99
 0f 001 01  0    0    0   0   0    1    1    A1
 10 001 01  1    1    0   1   0    1    1    A9
 11 001 01  1    1    0   1   0    1    1    B1
 12 001 01  1    1    0   1   0    1    1    B9
 13 001 01  1    1    0   1   0    1    1    C1
 14 001 01  1    1    0   1   0    1    1    C9
 15 001 01  1    1    0   1   0    1    1    D1
 16 000 00  1    0    0   0   0    0    0    00
 17 001 01  1    1    0   1   0    1    1    D9
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
IRQ20 -> 0:20
IRQ21 -> 0:21
IRQ23 -> 0:23
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 3066.0244 MHz.
..... host bus clock speed is 133.0314 MHz.
Starting migration thread for cpu 0
CPUS done 2
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f47a0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x4dda, dseg 0xf0000
PnPBIOS: Unknown tag '0x82', length '12'.
PnPBIOS: 16 nodes reported by PnP BIOS; 16 recorded by driver
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Transparent bridge - 0000:00:1e.0
PCI: Using IRQ router PIIX [8086/24c0] at 0000:00:1f.0
PCI->APIC IRQ transform: (B0,I29,P0) -> 16
PCI->APIC IRQ transform: (B0,I29,P1) -> 19
PCI->APIC IRQ transform: (B0,I29,P2) -> 18
PCI->APIC IRQ transform: (B0,I29,P3) -> 23
PCI->APIC IRQ transform: (B0,I31,P0) -> 18
PCI->APIC IRQ transform: (B0,I31,P1) -> 17
PCI->APIC IRQ transform: (B0,I31,P1) -> 17
PCI->APIC IRQ transform: (B1,I0,P0) -> 16
PCI->APIC IRQ transform: (B2,I2,P0) -> 18
PCI->APIC IRQ transform: (B2,I3,P0) -> 19
PCI->APIC IRQ transform: (B2,I3,P0) -> 19
PCI->APIC IRQ transform: (B2,I4,P0) -> 17
PCI->APIC IRQ transform: (B2,I6,P0) -> 21
PCI->APIC IRQ transform: (B2,I8,P0) -> 20
PCI: Cannot allocate resource region 0 of device 0000:02:04.0
vesafb: framebuffer at 0xe8000000, mapped to 0xe0800000, size 16384k
vesafb: mode is 1024x768x16, linelength=2048, pages=0
vesafb: protected mode interface info at c000:c220
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
fb0: VESA VGA frame buffer device
Console: switching to colour frame buffer device 128x48
pty: 256 Unix98 ptys configured
Machine check exception polling timer started.
cpufreq: P4/Xeon(TM) CPU On-Demand Clock Modulation available
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.4 [Flags: R/O].
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.11
hw_random hardware driver 1.0.0 loaded
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 845G Chipset.
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 64M @ 0xf8000000
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Intel(R) PRO/100 Network Driver - version 2.3.18-k1
Copyright (c) 2003 Intel Corporation

e100: selftest OK.
e100: eth0: Intel(R) PRO/100 Network Connection

e100: selftest OK.
e100: eth1: Intel(R) PRO/100 Network Connection
  Hardware receive checksums enabled

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ICH4: chipset revision 2
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:DMA
hda: IC35L080AVVA07-0, ATA DISK drive
hdb: WDC WD800BB-22CAA0, ATA DISK drive
Using anticipatory scheduling elevator
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: DVD-ROM DDU1621, ATAPI CD/DVD-ROM drive
hdd: SONY CD-RW CRX175A1, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 160836480 sectors (82348 MB) w/1863KiB Cache, CHS=65535/16/63,
UDMA(100)
 hda: hda1 hda2 hda3 hda4
hdb: max request size: 128KiB
hdb: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=65535/16/63,
UDMA(100)
 hdb: hdb1
end_request: I/O error, dev hdc, sector 0
hdc: ATAPI 40X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Console: switching to colour frame buffer device 128x48
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hda4, size 8192, journal first block 18,
max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda4) for (hda4)
Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 336k freed
Adding 128512k swap on /dev/hda2.  Priority:-1 extents:1
Intel 810 + AC97 Audio, version 0.24, 10:49:44 Aug  9 2003
PCI: Setting latency timer of device 0000:00:1f.5 to 64
i810: Intel ICH4 found at IO 0xe080 and 0xe400, MEM 0xfebff800 and
0xfebff400, IRQ 17
i810: Intel ICH4 mmio at 0xe18e1800 and 0xe18e3400
i810_audio: Primary codec has ID 2
i810_audio: Audio Controller supports 6 channels.
i810_audio: Defaulting to base 2 channel mode.
i810_audio: Resetting connection 0
i810_audio: Connection 0 with codec id 2
ac97_codec: AC97 Audio codec, id: ADS112 (Unknown)
i810_audio: AC'97 codec 2 supports AMAP, total channels = 6
i810_audio: setting clocking to 48566
nvidia: module license 'NVIDIA' taints kernel.
0: nvidia: loading NVIDIA Linux x86 nvidia.o Kernel Module  1.0-4496 
Wed Jul 16 19:03:09 PDT 2003
i2c-i801 version 2.7.0 (20021208)
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (4090 buckets, 32720 max) - 304 bytes per
conntrack
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
SCSI subsystem initialized
Initializing USB Mass Storage driver...
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
CSLIP: code copyright 1989 Regents of the University of California
PPP generic driver version 2.4.2
PPP BSD Compression module registered
PPP Deflate Compression module registered
Linux video capture interface: v1.00
bttv: driver version 0.9.11 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Host bridge is 0000:00:00.0
bttv: Bt8xx card found (0).
bttv0: Bt878 (rev 17) at 0000:02:03.0, irq: 19, latency: 32, mmio:
0xf42fd000
bttv0: detected: Pinnacle PCTV [bswap] [card=39], PCI subsystem ID is
bd11:1200
bttv0: using: BT878(Pinnacle PCTV Studio/Ra) [card=39,autodetected]
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: miro: id=16 tuner=1 radio=fmtuner stereo=no
bttv0: using tuner=1
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
tvaudio: TV audio decoder + audio/video mux driver
tvaudio: known chips:
tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,tea6420,tda8425,pic16c54 (PV951),ta8874z
tuner: chip found @ 0xc2
tuner: type set to 1 (Philips PAL_I (FI1246 and compatibles))
registering 1-0061
videodev: "BT878(Pinnacle PCTV Studio/Ra)" has no release callback.
Please fix your driver for proper sysfs support, see
http://lwn.net/Articles/36850/
bttv0: registered device video0
videodev: "bt848/878 vbi" has no release callback. Please fix your
driver for proper sysfs support, see http://lwn.net/Articles/36850/
bttv0: registered device vbi0
videodev: "bt848/878 radio" has no release callback. Please fix your
driver for proper sysfs support, see http://lwn.net/Articles/36850/
bttv0: registered device radio0
bttv0: PLL: 28636363 => 35468950 .. ok
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: SONY      Model: CD-RW  CRX175A1   Rev: 5YS3
  Type:   CD-ROM                             ANSI SCSI revision: 02
sr0: scsi-1 drive
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hdb1, size 8192, journal first block 18,
max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hdb1) for (hdb1)
Using r5 hash to sort names
ehci_hcd 0000:00:1d.7: EHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 23, pci mem e19b4c00
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: enabled 64bit PCI DMA
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-13
hub 1-0:0: USB hub found
hub 1-0:0: 6 ports detected
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface
driver v2.1
uhci-hcd 0000:00:1d.0: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci-hcd 0000:00:1d.0: irq 16, io base 0000e800
uhci-hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
hub 2-0:0: USB hub found
hub 2-0:0: 2 ports detected
uhci-hcd 0000:00:1d.1: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci-hcd 0000:00:1d.1: irq 19, io base 0000e880
uhci-hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
hub 3-0:0: USB hub found
hub 3-0:0: 2 ports detected
uhci-hcd 0000:00:1d.2: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci-hcd 0000:00:1d.2: irq 18, io base 0000ec00
uhci-hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
hub 4-0:0: USB hub found
hub 4-0:0: 2 ports detected
hub 1-0:0: debounce: port 3: delay 100ms stable 4 status 0x501
hub 3-0:0: debounce: port 1: delay 100ms stable 4 status 0x301
hub 3-0:0: new USB device on port 1, assigned address 2
input: USB HID v1.00 Mouse [Microsoft Microsoft IntelliMouse® Explorer]
on usb-0000:00:1d.1-1
e100: eth0 NIC Link is Up 100 Mbps Full duplex

-- 
Windows not found
(C)heers, (P)arty or (D)ance?
-----------------------------------
Micskó Gábor
Compaq Accredited Platform Specialist, System Engineer (APS, ASE)
Szintézis Computer Rendszerház Rt.      
H-9021 Gyõr, Tihanyi Árpád út 2.
Tel: +36-96-502-216
Fax: +36-96-318-658
E-mail: gmicsko@szintezis.hu
Web: http://www.hup.hu/

