Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262245AbVHAAi6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262245AbVHAAi6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 20:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262207AbVHAAi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 20:38:57 -0400
Received: from zproxy.gmail.com ([64.233.162.200]:19983 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262288AbVHAAi3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 20:38:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WgXlHCcMdfxKotef/CcupCAksyR7F7T+ual6RtLQyYpttpmRSz5uDLvVANwqYiy7bXyqOLL1v9vRQMRxjXRvuFcEq07/aUiYnD5FwGNVeaTWND7KRqTw59m727Uh0CzmJay7YbyWSx2Y+c7rPJVAKE37D1rPoFJu1DJp0hS4kg4=
Message-ID: <57861437050731173826aad36d@mail.gmail.com>
Date: Sun, 31 Jul 2005 19:38:28 -0500
From: Jesus Delgado <jdelgado@gmail.com>
Reply-To: Jesus Delgado <jdelgado@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.13-rc4-mm1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050731020552.72623ad4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050731020552.72623ad4.akpm@osdl.org>
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

On 7/31/05, Andrew Morton <akpm@osdl.org> wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc4/2.6.13-rc4-mm1/
> 
> 
> - Dropped areca-raid-linux-scsi-driver.patch and iteraid.patch.  People who
>   need these can get them from 2.6.13-rc3-mm3.
> 
> - Dropped the CKRM patches.  I don't think they were doing much in -mm and
>   we didn't find many problems with them anyway.
> 
> - Dropped the connector patches: turns out that we no longer have a netlink
>   slot available for them anyway.
> 
> 
> 
> Changes since 2.6.13-rc3-mm3:
> 
> 
>  linus.patch
>  git-cryptodev.patch
>  git-drm.patch
>  git-audit.patch
>  git-jfs.patch
>  git-kbuild.patch
>  git-libata-adma-mwi.patch
>  git-libata-chs-support.patch
>  git-libata-passthru.patch
>  git-libata-promise-sata-pata.patch
>  git-net.patch
>  git-net-gregkh-i2c-w1-netlink-callbacks-fix.patch
>  git-netdev-chelsio.patch
>  git-netdev-e100.patch
>  git-netdev-smc91x-eeprom.patch
>  git-netdev-ieee80211-wifi.patch
>  git-ocfs2.patch
>  git-serial.patch
>  git-scsi-block.patch
>  git-scsi-misc.patch
>  git-scsi-rc-fixes.patch
> 
>  Subsystem trees
> 
> -bio_clone-fix.patch
> -pcmcia-ide-cs-id_table-update.patch
> -pcmcia-fix-comment.patch
> -pcmcia-remove-duplicates-in-orinoco_cs.patch
> -pcmcia-update-au1000-to-work-with-recent-changes.patch
> -pcmcia-avoid-duble-iounmap-of-one-address.patch
> -pcmcia-fix-many-device-ids.patch
> -pcmcia-update-documentation.patch
> -pcmcia-fix-sharing-irqs-and-request_irq-without-irq_handle_present.patch
> -yenta-free_irq-on-suspend.patch
> -pcmcia-disable-read-prefetch-write-burst-on-old-o2micro-bridges.patch
> -cciss-per-disk-queue.patch
> -fix-incorrect-asus-k7m-irq-router-detection.patch
> -x86_64-always-ack-ipis-even-on-errors.patch
> -x86_64-update-defconfig.patch
> -x86_64-use-for_each_cpu_mask-for-clustered-ipi-flush.patch
> -x86_64-i386-x86_64-remove-prototypes-for-not-existing.patch
> -x86_64-move-cpu_present-possible_map-parsing-earlier.patch
> -x86_64-minor-clean-up-to-cpu-setup-use-smp_processor_id-instead-of-custom-hack.patch
> -x86_64-clarify-booting-processor-message.patch
> -x86_64-some-cleanup-in-setup64c.patch
> -x86_64-remove-unused-variable-in-delayc.patch
> -x86_64-improve-config_gart_iommu-description-and-make-it-default-y.patch
> -x86_64-some-updates-for-boot-optionstxt.patch
> -x86_64-fix-some-comments-in-tlbflushh.patch
> -x86_64-remove-obsolete-eat_key-prototype.patch
> -x86_64-fix-some-typos-in-systemh-comments.patch
> -x86_64-fix-incorrectly-defined-msr_k8_syscfg.patch
> -x86_64-fix-overflow-in-numa-hash-function-setup.patch
> -x86_64-print-a-boot-message-for-hotplug-memory-zones.patch
> -x86_64-create-per-cpu-machine-check-sysfs-directories.patch
> -x86_64-remove-ia32_-build-tools-in-makefile.patch
> -x86_64-remove-the-broadcast-options-that-were-added-for.patch
> -x86_64-support-more-than-8-cores-on-amd-systems.patch
> -x86_64-icecream-has-no-way-of-detecting-assembler-level.patch
> -x86_64-turn-bug-data-into-valid-instruction.patch
> -x86_64-when-running-cpuid4-need-to-run-on-the-correct.patch
> -x86_64-remove-unnecessary-include-in-faultc.patch
> -x86_64-small-assembly-improvements.patch
> -x86_64-switch-to-the-interrupt-stack-when-running-a.patch
> -x86_64-fix-srat-handling-on-non-dual-core-systems.patch
> -x86_64-fix-gcc-4-warning-in-sched_find_first_bit.patch
> -x86_64-use-msleep-in-smpbootc.patch
> -x86_64-remove-unused-variable-in-k8-busc.patch
> -x86_64-fix-cpu_to_node-setup-for-sparse-apic_ids.patch
> -cs89x0-collect-tx_bytes-statistics.patch
> -ppc32-inotify-syscalls.patch
> -ppc64-inotify-syscalls.patch
> -selinux-default-labeling-of-mls-field.patch
> -e1000-no-need-for-reboot-notifier.patch
> -pcdp-if-pcdp-contains-parity-information-use-it.patch
> -qla2xxx-mark-dependency-on-fw_loader.patch
> -alpha-fix-statement-with-no-effect-warnings.patch
> -mm-ensure-proper-alignment-for-node_remap_start_pfn.patch
> -acpi-disable-c2-c3-for-_all_-ibm-r40e-laptops-bug-3549.patch
> -acpi-re-enable-c2-c3-cpu-states-for-systems-without.patch
> -agp-restore-apbase-after-setting-apsize.patch
> -gregkh-driver-stable_api_nonsense.txt-fixes.patch
> -gregkh-i2c-i2c-max6875-simplify.patch
> -gregkh-i2c-i2c-max6875-fix-build-error.patch
> -gregkh-i2c-i2c-ds1337-12-24-mode-fix.patch
> -gregkh-i2c-i2c-missing-space.patch
> -gregkh-i2c-w1-kconfig.patch
> -gregkh-pci-pci-smbus-quirk.patch
> -gregkh-pci-pci-adjust-pci-rom-code-to-handle-more-broken-roms.patch
> -gregkh-pci-pci-remove-pci_bridge_ctl_vga-handling-from-setup-busc.patch
> -gregkh-pci-pci-dma-build-fix.patch
> -gregkh-pci-pci-remove-pretty-names-fix.patch
> -git-scsi-misc-drivers-scsi-chc-remove-devfs-stuff.patch
> -gregkh-usb-usb-ftdi_sio-new-devices.patch
> -gregkh-usb-usb-ftdi_sio-rts-dtr.patch
> -gregkh-usb-usb-ftdi_sio-timeout-fix.patch
> -gregkh-usb-usb-usbfs-dont-leak-data.patch
> -gregkh-usb-usb-usbnet-remove-unused-vars.patch
> -gregkh-usb-usb-dont-delete-unregistered-interfaces.patch
> -usb-hidinput_hid_event-oops-fix.patch
> -option-card-driver-update-maintainer-entry-fixes.patch
> -fix-something-in-scsi.patch
> -usb-storage-rearrange-stuff.patch
> -fix-something-in-usb.patch
> -sk98lin-basic-suspend-resume-support.patch
> -x86-avoid-wasting-irqs-patch-update.patch
> -x86_64-avoid-wasting-irqs-patch-update.patch
> -add-cmos-attribute-to-floppy-driver.patch
> -add-cmos-attribute-to-floppy-driver-tidy.patch
> -intel8x0-free-irq-in-suspend.patch
> -serial-add-mmio-support-to-8250_pnp.patch
> -device-mapper-fix-deadlocks-in-core-prep.patch
> -device-mapper-fix-deadlocks-in-core.patch
> -device-mapper-fix-md-lock-deadlocks-in-core.patch
> 
>  Merged
> 
> +i2c-mpc-revert-duplicate-patch.patch
> 
>  Fix doublly-applied patch
> 
> +skge-build-fix.patch
> 
>  Fix net driver build
> 
> +disable-address-space-randomization-on-transmeta-cpus.patch
> 
>  Make /proc/sys/kernel/randomize_va_space default to off on Transmeta CPUs,
> because it can make them run slowly.
> 
> +v4l-miscellaneous-fixes.patch
> +v4l-cx88-card-support-and-documentation-finishing.patch
> 
>  v4l fixes
> 
> +maintainers-record-man-pages.patch
> +maintainers-record-man-pages-fix.patch
> 
>  Mention the manpage guy in MAINTAINERS
> 
> +ppc64-fix-config_altivec-not-set.patch
> 
>  ppc64 fix
> 
> +display-name-of-fbdev-device.patch
> 
>  fbdev featurette
> 
> -git-acpi.patch
> 
>  I dropped this - not sure why.
> 
> +acpi_register_gsi-change-acpi_register_gsi-interface.patch
> +acpi_register_gsi-change-acpi-pci-code.patch
> +acpi_register_gsi-change-hpet-driver.patch
> +acpi_register_gsi-change-phpacpi-driver.patch
> +acpi_register_gsi-change-acpi-based-8250-driver.patch
> +acpi_register_gsi-change-ia64-iosapic-code.patch
> 
>  ACPI feature work
> 
> +enable-acpi_hotplug_cpu-automatically-if-hotplug_cpu=y.patch
> 
>  Kconfig fix
> 
> +gregkh-driver-floppy-cmos-attribute.patch
> +gregkh-driver-floppy-cmos-attribute-tidy.patch
> 
>  Additions to Greg's driver tree
> 
> +gregkh-i2c-i2c-max6875-documentation-cleanup.patch
> +gregkh-i2c-i2c-hwmon-soften-lm75.patch
> +gregkh-i2c-i2c-hwmon-lm78-j.patch
> +gregkh-i2c-i2c-hwmon-document-w83627ehg.patch
> +gregkh-i2c-i2c-w83792d-01.patch
> +gregkh-i2c-i2c-w83792d-02.patch
> +gregkh-i2c-i2c-w83792d-03.patch
> +gregkh-i2c-i2c-refactor-message.patch
> +gregkh-i2c-i2c-hwmon-tag-superio-functions-__init.patch
> 
>  Additions to Greg's i2c tree
> 
> +input-quirk-for-the-fn-key-on-powerbooks-with-an-usb.patch
> 
>  Input driver fix
> 
> +git-net.patch
> 
>  Bring this back - it was innocent
> 
> +git-net-gregkh-i2c-w1-netlink-callbacks-fix.patch
> 
>  Fix it for changes in Greg's tree
> 
> +drivers-net-wireless-hostap-hostapc-export_symtab-does-nothing.patch
> 
>  Wireless driver cleanup
> 
> +gregkh-pci-pci-remove-pretty-names-02.patch
> +gregkh-pci-pci-cleanup-pci.h.patch
> 
>  Additions to Greg's PCI tree
> 
> +gregkh-usb-usb-cypress_m8-whitespace-fixes.patch
> +gregkh-usb-usb-option-card-driver-coding-style-tweaks.patch
> +gregkh-usb-usb-gadget-centrialize-numbers.patch
> +gregkh-usb-usb-storage-rearrange-stuff.patch
> +gregkh-usb-usb-storage-fix-something.patch
> 
>  Additions to Greg's USB tree
> 
> +usb-ehci-microframe-handling-fix.patch
> 
>  USB fix
> 
> +page-fault-patches-optional-page_lock-acquisition-in-fix.patch
> +page-fault-patches-optional-page_lock-acquisition-in-fix-2.patch
> +page-fault-patches-fix-highpte-in-do_anon_page.patch
> 
>  Fix the pagefault scalability patches
> 
> +x86-ptep-clear-optimization.patch
> +x86-ptep-clear-optimization-fix.patch
> 
>  x86 pte handling speedup
> 
> +mm-slabc-prefetchw-the-start-of-new-allocated-objects.patch
> 
>  slab microoptimisation
> 
> +forcedeth-write-back-the-misordered-mac-address.patch
> 
>  Fix forcedeth driver
> 
> +r8169-pci-id-for-the-linksys-eg1032.patch
> 
>  r8169 device support
> 
> +ppc32-add-missing-4xx-emac-sysfs-nodes.patch
> +arch-ppc-kernel-ppc_ksymsc-remove-unused-define-export_symtab_strops.patch
> +8xx-convert-fec-driver-to-use-work_struct.patch
> +8xx-using-dma_alloc_coherent-instead-consistent_alloc.patch
> +8xx-fec-fix-interrupt-handler-prototypes.patch
> 
>  ppc32 stuff
> 
> +vm86-honor-tf-bit-when-emulating-an-instruction.patch
> 
>  x86 vm86 fix
> 
> +kdump-save-parameter-segment-in-protected-mode-x86.patch
> 
>  kdump enhamcement
> 
> +i386-clean-up-vdso-alignment-padding.patch
> +x86-automatically-enable-bigsmp-when-we-have-more-than-8-cpus.patch
> +i386-inline-asm-cleanup.patch
> +i386-inline-asm-cleanup-kexec-fix.patch
> +i386-arch-cleanup-seralize-msr.patch
> +i386-arch-cleanup-seralize-msr-fix.patch
> +i386-inline-assembler-cleanup-encapsulate-descriptor-and-task-register-management.patch
> +i386-inline-assembler-cleanup-encapsulate-descriptor-and-task-register-management-fix.patch
> +i386-generate-better-code-around-descriptor-update-and-access-functions.patch
> +i386-load_tls-fix.patch
> +i386-use-set_pte-macros-in-a-couple-places-where-they-were-missing.patch
> 
>  Various x86 cleanups.  Mainly: move all the open-coded asm statements into
>  nice wrapper functions.  Partly because it makes things easier for
>  virtualisation patches, partly because it cleans things up and people
>  occasionally get these things wrong.
> 
> +x86_64-remove-duplicated-sys_time64.patch
> +x86_64-fix-off-by-one-in-e820_mapped.patch
> +x86_64-prefetchw-can-fall-back-to-prefetch-if-3dnow.patch
> 
>  x86_64 fixes
> 
> -swsusp-process-freezing-remove-smp-races.patch
> -swsusp-process-freezing-remove-smp-races-msp3400-fix.patch
> 
>  Dropped - it's planned to do this differently.
> 
> +remove-busywait-in-refrigerator.patch
> +swsusp-fix-remaining-u32-vs-pm_message_t-confusion-2.patch
> 
>  swsusp fixes
> 
> +swsusp-simpler-calculation-of-number-of-pages-in-pbe-list.patch
> 
>  swsusp simplification
> 
> +swsusup-with-dm-crypt-mini-howto.patch
> 
>  swsusp documentation
> 
> +uml-rename-kconfig-files-to-be-like-the-other-arches.patch
> +uml-workaround-gdb-problems-on-debugging.patch
> +uml-fix-sigwinch-handler-race-while-waiting-for-signals.patch
> 
>  UML updates
> 
> +s390-use-klist-in-qeth-driver.patch
> 
>  s390 driver cleanup
> 
> -areca-raid-linux-scsi-driver.patch
> 
>  Dropped
> 
> -aio-fix-races-in-callback-path.patch
> 
>  Dropped - believed to be incorrect.
> 
> +kconfig-trivial-cleanup.patch
> 
>  Kconfig cleanup
> 
> +fix-sound-arm-makefile-for-locality-of-reference.patch
> 
>  Make ARM makefile more maintainable
> 
> +remove-special-hpet_emulate_rtc-config-option.patch
> 
>  make RTC emulation non-optional in the HPET driver
> 
> +schedule-obsolete-oss-drivers-for-removal-version-2.patch
> 
>  Add some OSS drivers to death row.
> 
> +disk-quotas-fail-when-etc-mtab-is-symlinked-to-proc-mounts.patch
> +disk-quotas-fail-when-etc-mtab-is-symlinked-to-proc-mounts-tidy.patch
> 
>  Better support for /etc/mtab symlinked to /proc/mounts
> 
> +add-init=-warning-to-init-mainc.patch
> 
>  Print a warning when the target of `init=' cannot be executed.
> 
> +remove-a-dead-extern-in-memc.patch
> 
>  Cleanup
> 
> +remove-misleading-comment-above-sys_brk.patch
> 
>  Fix comment
> 
> +move-m68k-rtc-drivers-over-to-initcalls.patch
> +move-68360serialc-over-use-initcalls.patch
> 
>  Cleanups
> 
> +remove-pipe-definitions.patch
> 
>  Remove dead macros
> 
> +sd-initialize-sd-cards.patch
> +sd-read-only-switch.patch
> +sd-scr-register.patch
> +sd-scr-in-sysfs.patch
> +sd-4-bit-bus.patch
> +sd-copyright-notice.patch
> 
>  Secure digital card drivers
> 
> +corgi-keyboard-fix-a-couple-of-compile-errors.patch
> +corgi-keyboard-add-some-power-management-code.patch
> +corgi-keyboard-code-tidying.patch
> +corgi-touchscreen-allow-the-driver-to-share-the-pmu.patch
> +corgi-touchscreen-code-cleanup--fixes.patch
> +w100fb-rewrite-for-platform-independence.patch
> +w100fb-update-corgi-platform-code-to-match-new-driver.patch
> +input-add-a-new-switch-event-type.patch
> 
>  Corgi driver updates
> 
> -ckrm-core-ckrm-event-callbacks.patch
> -ckrm-processor-delay-accounting.patch
> -ckrm-processor-delay-accounting-warning-fixes.patch
> -ckrm-core-infrastructure.patch
> -ckrm-resource-control-file-system-rcfs.patch
> -ckrm-classtype-definitions-for-task-class.patch
> -ckrm-classtype-definitions-for-socket-class.patch
> -ckrm-numtasks-controller.patch
> -ckrm-documentation.patch
> -ckrm-add-missing-read_unlock.patch
> -ckrm-move-callbacks-from-listenaq-to-socketclass.patch
> -ckrm-change-ipaddr_port-syntax.patch
> -ckrm-check-to-see-if-my-guarantee-is-set-to-dontcare.patch
> -ckrm-minor-cosmetic-cleanups-in-numtasks-controller.patch
> -ckrm-undo-removal-of-check-in-numtasks_put_ref_local.patch
> -ckrm-rule-based-classification-engine-stub-rcfs-support.patch
> -ckrm-rule-based-classification-engine-basic-rcfs-support.patch
> -ckrm-rule-based-classification-engine-bitvector-support-for-classification-info.patch
> -ckrm-rule-based-classification-engine-full-ce.patch
> -ckrm-rule-based-classification-engine-full-ce-fix.patch
> -ckrm-rule-based-classification-engine-more-advanced-classification-engine.patch
> -#ckrm-rule-based-classification-engine-more-advanced-classification-engine-netlink-fix.patch
> -ckrm-clean-up-typo-in-printk-message.patch
> -ckrm-fix-for-compiler-warnings.patch
> -ckrm-fix-share-calculation.patch
> -ckrm-fix-edge-cases-with-empty-lists-and-rule-deletion.patch
> -ckrm-add-numtasks-controller-config-file-write-support.patch
> -ckrm-add-fork-rate-control-to-the-numtasks-controller.patch
> -ckrm-classification-engines-rbce-and-crbce-are-mutually-exclusive.patch
> -ckrm-make-get_class-global.patch
> -ckrm-cleanups-to-ckrm-initialization.patch
> -ckrm-replace-target-file-interface-with-a-writable-members-file.patch
> -ckrm-use-sizeof-instead-of-define-for-the-array-size-in-taskclass.patch
> -ckrm-fix-a-bug-in-the-use-of-classtype.patch
> -ckrm-include-taskdelaysh-in-crbceh.patch
> -ckrm-send-timestamps-to-userspace-in-msecs-instead-of-jiffies.patch
> -ckrm-fix-compile-warnings-and-delete-dead-code.patch
> -ckrm-fix-a-null-dereference-bug.patch
> -ckrm-classification-engine-configuration-support-cleanup.patch
> -ckrm-use-sizeof-instead-of-define-for-the-array-size-in-rbce.patch
> -ckrm-delete-target-file-from-tc_magicc.patch
> 
>  Dropped
> 
> -connector.patch
> -connector-exit-notifier.patch
> -connector-add-a-fork-connector.patch
> 
>  Dropped
> 
> -iteraid.patch
> 
>  Dropped
> 
> +sched-better-wake-balancing-3.patch
> 
>  CPU scheduler tweak
> 
> +video_bt848-remove-not-required-part-of-the-help-text.patch
> 
>  v4l fixlet
> 
> -files-fix-rcu-initializers.patch
> -files-rcuref-apis.patch
> -files-break-up-files-struct.patch
> -files-sparc64-fix-2.patch
> -files-files-struct-with-rcu.patch
> -files-lock-free-fd-look-up.patch
> -files-files-locking-doc.patch
> 
>  Dropped these for now: we have one report that they break swsusp resume.
>  Whcih is odd.
> 
> -reiser4-swsusp-process-freezing-remove-smp-races-fix.patch
> -reiser4-swsusp-process-freezing-remove-smp-races-fix-2.patch
> 
>  No longer needed
> 
> +reiser4-wundef-fix.patch
> +reiser4-wundef-fix-2.patch
> 
>  reiser4 warning fixes
> 
> +v9fs-documentation-makefiles-configuration-add-fd-based-transport-to-makefile-docs.patch
> +v9fs-vfs-superblock-operations-and-glue-add-fd-based-transport-to-mount-options.patch
> +v9fs-transport-modules-add-fd-based-transport-module.patch
> 
>  v9fs updates
> 
> +fbsysfs-remove-casts-from-void.patch
> 
>  fbdev cleanup
> 
> +fuse-device-functions-document-mount-options-documentation-update.patch
> +fuse-device-functions-request-counter-overflow-fix.patch
> +fuse-device-functions-module-alias.patch
> +fuse-stricter-mount-option-checking.patch
> +fuse-dont-update-file-times.patch
> 
>  FUSE updates
> 
> +include-linux-blkdevh-extern-inline-static-inline.patch
> 
>  Cleanup
> 
> 
> All 601 patches:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc4/2.6.13-rc4-mm1/patch-list
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
