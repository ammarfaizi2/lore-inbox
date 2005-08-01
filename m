Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262199AbVHAA2X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262199AbVHAA2X (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 20:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262204AbVHAA2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 20:28:23 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:12597 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262199AbVHAA2V convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 20:28:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=mKMWUh82W0UT5UeIN+zMG2uhQ0CvyNwNHhixdk/8HUMqm3+06mDCetBkLpuQwwTDH20KwoEQy+wHoOGNrhacZf3JJltML4M2gy+2bj/yT0OcAMauqU4BJA6jdnDATF5BePEpV8beQuetosqyMO3/KIQcxUgcAuMOsJf6aALkusM=
Message-ID: <57861437050731172866f84381@mail.gmail.com>
Date: Sun, 31 Jul 2005 19:28:19 -0500
From: Jesus Delgado <jdelgado@gmail.com>
Reply-To: Jesus Delgado <jdelgado@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: kernels 2.6.13-rc4 and 2.6.13-rc4-mm1 boot hang in laptop emachines M6897
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all:

  Im try test with kernels 2.6.13-rc4 and 2.6.13-rc4-mm1, the problems
is the boot hang:
  my test is different combinations the acpi=off , noacpi, pci=noirq,
etc.etc both have is the same error not boot.

 The only information is simple:

......

 Uncompressiong Linux... Ok. booting the kernel.
_ 
 
 Not more information.

 anex dmesg the kernel 2.6.12-ck3.


Linux version 2.6.12-ck3 (root@jes88.com (gcc version 4.0.1 20050720
(Red Hat 4.0.1-4)) #1 Mon Jul 25 00:14:40 CDT 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000004fef0000 (usable)
 BIOS-e820: 000000004fef0000 - 000000004fefb000 (ACPI data)
 BIOS-e820: 000000004fefb000 - 000000004ff00000 (ACPI NVS)
 BIOS-e820: 000000004ff00000 - 0000000050000000 (reserved)
 BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)
382MB HIGHMEM available.
896MB LOWMEM available.
On node 0 totalpages: 327408
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 98032 pages, LIFO batch:31
DMI 2.3 present.
ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f8410
ACPI: RSDT (v001 Arima  161Fh    0x06040000  LTP 0x00000000) @ 0x4fef6b5d
ACPI: FADT (v001 Arima  161Fh    0x06040000 PTL_ 0x000f4240) @ 0x4fefae66
ACPI: SSDT (v001 PTLTD  POWERNOW 0x06040000  LTP 0x00000001) @ 0x4fefaeda
ACPI: MADT (v001 PTLTD           APIC   0x06040000  LTP 0x00000000) @ 0x4fefafb0
ACPI: DSDT (v001  Arima 161Fh    0x06040000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x4008
Allocating PCI resources starting at 50000000 (gap: 50000000:affe0000)
Built 1 zonelists
Kernel command line: ro root=LABEL=/ early-login quiet vga=788
Initializing CPU#0
CPU 0 irqstacks, hard=c0470000 soft=c046f000
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 1804.747 MHz processor.
Using pmtmr for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1292408k/1309632k available (2620k kernel code, 16076k
reserved, 680k data, 188k init, 392128k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3571.71 BogoMIPS (lpj=1785856)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 078bfbff e1d3fbff 00000000 00000000
00000000 00000000 00000000
CPU: After vendor identify, caps: 078bfbff e1d3fbff 00000000 00000000
00000000 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU: After all inits, caps: 078bfbff e1d3fbff 00000000 00000010
00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Mobile AMD Athlon(tm) 64 Processor 3000+ stepping 08
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0400 (from 0e00)
checking if image is initramfs... it is
Freeing initrd memory: 1086k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd8cc, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050309
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [ALKA] (IRQs 16 17 18 19 20 21 22 23) *9, disabled.
ACPI: PCI Interrupt Link [ALKB] (IRQs 23) *11, disabled.
ACPI: PCI Interrupt Link [ALKC] (IRQs 22) *10, disabled.
ACPI: PCI Interrupt Link [ALKD] (IRQs 21) *10, disabled.
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 *9 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 11 12 14 15) *10
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 *10 11 12 14 15)
ACPI: Embedded Controller [EC] (gpe 1)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 8 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
pnp: 00:05: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:05: ioport range 0xf510-0xf511 could not be reserved
pnp: 00:05: ioport range 0xf500-0xf500 has been reserved
pnp: 00:05: ioport range 0x4000-0x407f could not be reserved
pnp: 00:05: ioport range 0x8100-0x811f has been reserved
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
audit: initializing netlink socket (disabled)
audit(1122837729.645:0): initialized
highmem bounce pool size: 64 pages
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
vesafb: framebuffer at 0xd8000000, mapped to 0xf8880000, using 1875k,
total 65536k
vesafb: mode is 800x600x16, linelength=1600, pages=67
vesafb: protected mode interface info at c000:564d
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 100x37
fb0: VESA VGA frame buffer device
ACPI: CPU0 (power states: C1[C1] C2[C2])
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected AGP bridge 0
agpgart: AGP aperture is 256M @ 0xe0000000
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 76 ports, IRQ sharing enabled
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:11.1
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:11.1[A] -> Link [LNKC] -> GSI 11 (level,
low) -> IRQ 11
PCI: Via IRQ fixup for 0000:00:11.1, from 0 to 11
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
    ide0: BM-DMA at 0x1ce0-0x1ce7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1ce8-0x1cef, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: HTS548060M9AT00, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: PIONEER DVD-RW DVR-K12D, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: max request size: 1024KiB
hda: 117210240 sectors (60011 MB) w/7877KiB Cache, CHS=16383/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 < hda5 hda6 hda7 > hda4
hdc: ATAPI 24X DVD-ROM DVD-R CD-R/RW drive, 2000kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
mice: PS/2 mouse device common for all mice
md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 128Kbytes
TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
TCP bind hash table entries: 65536 (order: 8, 1835008 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI wakeup devices:
SLPB  LID PCI0 PS2K USB1 USB2 USB3 Z00A CRD0 NICD
ACPI: (supports S0 S3 S4 S5)
Freeing unused kernel memory: 188k freed
input: AT Translated Set 2 keyboard on isa0060/serio0
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
Synaptics Touchpad, model: 1, fw: 5.9, id: 0x236eb3, caps: 0x904713/0x10008
input: SynPS/2 Synaptics TouchPad on isa0060/serio1
floppy0: no floppy controllers found
via-rhine.c:v1.10-LK1.2.0-2.6 June-10-2004 Written by Donald Becker
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:12.0[A] -> Link [LNKB] -> GSI 11 (level,
low) -> IRQ 11
PCI: Via IRQ fixup for 0000:00:12.0, from 9 to 11
eth0: VIA Rhine II at 0xd0002c00, 00:03:25:0d:9e:58, IRQ 11.
eth0: MII PHY found at address 1, status 0x7869 advertising 05e1 Link 41e1.
snd_via82xx: Unknown parameter `'
snd_via82xx: Unknown parameter `'
snd_via82xx: Unknown parameter `'
shpchp: shpc_init : shpc_cap_offset == 0
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 9
PCI: setting IRQ 9 as level-triggered
ACPI: PCI Interrupt 0000:00:11.6[C] -> Link [LNKA] -> GSI 9 (level,
low) -> IRQ 9
PCI: Via IRQ fixup for 0000:00:11.6, from 10 to 9
PCI: Setting latency timer of device 0000:00:11.6 to 64
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:10.3[D] -> Link [LNKD] -> GSI 10 (level,
low) -> IRQ 10
PCI: Via IRQ fixup for 0000:00:10.3, from 0 to 10
ehci_hcd 0000:00:10.3: EHCI Host Controller
ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:10.3: irq 10, io mem 0xd0002800
ehci_hcd 0000:00:10.3: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
USB Universal Host Controller Interface driver v2.2
ACPI: PCI Interrupt 0000:00:10.0[A] -> Link [LNKA] -> GSI 9 (level,
low) -> IRQ 9
PCI: Via IRQ fixup for 0000:00:10.0, from 0 to 9
uhci_hcd 0000:00:10.0: UHCI Host Controller
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:10.0: irq 9, io base 0x00001c80
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.1[B] -> Link [LNKB] -> GSI 11 (level,
low) -> IRQ 11
PCI: Via IRQ fixup for 0000:00:10.1, from 0 to 11
uhci_hcd 0000:00:10.1: UHCI Host Controller
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:10.1: irq 11, io base 0x00001ca0
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.2[C] -> Link [LNKC] -> GSI 11 (level,
low) -> IRQ 11
PCI: Via IRQ fixup for 0000:00:10.2, from 0 to 11
uhci_hcd 0000:00:10.2: UHCI Host Controller
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:10.2: irq 11, io base 0x00001cc0
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKB] -> GSI 11 (level,
low) -> IRQ 11
Yenta: CardBus bridge found at 0000:00:0a.0 [161f:2032]
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:0a.0, mfunc 0x01001002, devctl 0x44
Yenta: ISA IRQ mask 0x0000, PCI irq 11
Socket status: 30000006
ieee1394: Initialized config rom entry `ip1394'
ohci1394: $Rev: 1250 $ Ben Collins <bcollins@debian.org>
ACPI: PCI Interrupt 0000:00:13.0[A] -> Link [LNKD] -> GSI 10 (level,
low) -> IRQ 10
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[10] 
MMIO=[d0002000-d00027ff]  Max Packet=[2048]
audit(1122855742.998:0): user pid=1260 uid=0 length=52
loginuid=4294967295 msg='hwclock: op=changing system time id=0
res=success'
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Lid Switch [LID]
ibm_acpi: ec object not found
ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0003252129001aa3]
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
cdrom: open failed.
cdrom: open failed.
EXT3 FS on hda2, internal journal
ReiserFS: hda5: found reiserfs format "3.6" with standard journal
ReiserFS: hda5: using ordered data mode
ReiserFS: hda5: journal params: device hda5, size 8192, journal first
block 18, max trans len 1024, max batch 900, max commit age 30, max
trans age 30
ReiserFS: hda5: checking transaction log (hda5)
ReiserFS: hda5: Using r5 hash to sort names
ReiserFS: hda4: found reiserfs format "3.6" with standard journal
ReiserFS: hda4: using ordered data mode
ReiserFS: hda4: journal params: device hda4, size 8192, journal first
block 18, max trans len 1024, max batch 900, max commit age 30, max
trans age 30
ReiserFS: hda4: checking transaction log (hda4)
ReiserFS: hda4: Using r5 hash to sort names
ReiserFS: hda7: found reiserfs format "3.6" with standard journal
ReiserFS: hda7: using ordered data mode
ReiserFS: hda7: journal params: device hda7, size 8192, journal first
block 18, max trans len 1024, max batch 900, max commit age 30, max
trans age 30
ReiserFS: hda7: checking transaction log (hda7)
ReiserFS: hda7: Using r5 hash to sort names
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (8192 buckets, 65536 max) - 272 bytes per conntrack
audit(1122855757.741:0): user pid=1505 uid=0 length=144
loginuid=4294967295 msg='PAM bad_ident: user=?
exe="/usr/bin/gdm-binary" (hostname=?, addr=?, terminal=? result=User
not known to the underlying authentication module)'
cs: IO port probe 0xc00-0xcff: clean.
cs: IO port probe 0x800-0x8ff: clean.
cs: IO port probe 0x100-0x4ff: clean.
cs: IO port probe 0xa00-0xaff: clean.
eth0: link up, 100Mbps, full-duplex, lpa 0x41E1
fglrx: module license 'Proprietary. (C) 2002 - ATI Technologies,
Starnberg, GERMANY' taints kernel.
[fglrx] Maximum main memory to use for locked dma buffers: 1171 MBytes.
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 9 (level,
low) -> IRQ 9
[fglrx] module loaded - fglrx 8.14.13 [Jun  8 2005] on minor 0
[fglrx] Kernel AGP support doesn't provide agplock functionality.
[fglrx] AGP detected, AgpState   = 0x1f000a1b (hardware caps of chipset)
agpgart: Found an AGP 3.5 compliant device at 0000:00:00.0.
agpgart: Putting AGP V3 device at 0000:00:00.0 into 8x mode
agpgart: Putting AGP V3 device at 0000:01:00.0 into 8x mode
[fglrx] AGP enabled,  AgpCommand = 0x1f000312 (selected caps)
[fglrx] free  AGP = 256126976
[fglrx] max   AGP = 256126976
[fglrx] free  LFB = 52719616
[fglrx] max   LFB = 52719616
[fglrx] free  Inv = 0
[fglrx] max   Inv = 0
[fglrx] total Inv = 0
[fglrx] total TIM = 0
[fglrx] total FB  = 0
[fglrx] total AGP = 65536
lp: driver loaded but no devices found
[fglrx] AGP detected, AgpState   = 0x1f000a1b (hardware caps of chipset)
agpgart: Found an AGP 3.5 compliant device at 0000:00:00.0.
agpgart: Putting AGP V3 device at 0000:00:00.0 into 8x mode
agpgart: Putting AGP V3 device at 0000:01:00.0 into 8x mode

Any Idea, helpme please.
