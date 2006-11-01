Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752437AbWKAVR6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752437AbWKAVR6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 16:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752440AbWKAVR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 16:17:58 -0500
Received: from smtpout06-01.prod.mesa1.secureserver.net ([64.202.165.224]:12170
	"HELO smtpout06-04.prod.mesa1.secureserver.net") by vger.kernel.org
	with SMTP id S1752437AbWKAVR5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 16:17:57 -0500
Message-ID: <45490EFE.1060608@seclark.us>
Date: Wed, 01 Nov 2006 16:17:50 -0500
From: Stephen Clark <Stephen.Clark@seclark.us>
Reply-To: Stephen.Clark@seclark.us
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22smp i686; en-US; m18) Gecko/20010110 Netscape6/6.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alexey Dobriyan <adobriyan@gmail.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: fc6 kernel 2.6.18-1.2798 breaks acpi on HP laptop n5430
References: <4548DDF4.2030903@seclark.us> <20061101201218.GA4899@martell.zuzino.mipt.ru>
In-Reply-To: <20061101201218.GA4899@martell.zuzino.mipt.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan wrote:

>On Wed, Nov 01, 2006 at 12:48:36PM -0500, Stephen Clark wrote:
>  
>
>>I know this is a problem with a RH kernel but I also know RH gurus
>>monitor this list
>>and make contributions.
>>
>>I just upgraded to FC6 and now my HP pavilion n5430 laptop hangs during
>>boot right after displaying
>>a bunch of stuff about acpi.
>>    
>>
>
>messages are very secret so you can't show them?
>
>  
>
>>kernel 2.6.18-1.2200.fc5 works OK can I run it on fc6?
>>    
>>
>
>
>  
>
Yes - sorry
this is the output from 2.6.18-1.2798

BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001ffff000 (ACPI data)
 BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
511MB LOWMEM available.
Using x86 segment limits to approximate NX protection
DMI 2.2 present.
Using APIC driver default
ACPI: PM-Timer IO Port: 0x8008
Allocating PCI resources starting at 30000000 (gap: 20000000:dff80000)
Detected 850.075 MHz processor.
Built 1 zonelists.  Total pages: 131056
Kernel command line: ro root=/dev/VolGroup00/LogVol00 lapic nousb 
console=ttyS0,38400
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Enabling fast FPU save and restore... done.
Initializing CPU#0
CPU 0 irqstacks, hard=c079f000 soft=c077f000
PID hash table entries: 2048 (order: 11, 8192 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 512616k/524224k available (2105k kernel code, 10976k reserved, 
844k data, 240k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 1701.57 BogoMIPS 
(lpj=3403147)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512
Enabling disabled K7/SSE Support.
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 64K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
Freeing SMP alternatives: 12k freed
ACPI: Core revision 20060707
ACPI: setting ELCR to 0200 (from 0800)
CPU0: AMD mobile AMD Duron(tm) Processor stepping 00
SMP motherboard not detected.
Brought up 1 CPUs
checking if image is initramfs... it is
Freeing initrd memory: 2119k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfd8b0, last bus=1
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI quirk: region 8000-803f claimed by ali7101 ACPI
PCI quirk: region 8040-805f claimed by ali7101 SMB
ACPI: PCI Interrupt Link [LNKA] (IRQs 5 7 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 5 7 10 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 5 7) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 5 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKU] (IRQs *9)
ACPI: Embedded Controller [EC0] (gpe 25) interrupt mode.
ACPI: Power Resource [PFAN] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 11 devices
usbcore: USB support disabled
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a 
report
NetLabel: Initializing
NetLabel:  domain hash size = 128
NetLabel:  protocols = UNLABELED CIPSOv4
NetLabel:  unlabeled traffic allowed by default
pnp: 00:07: ioport range 0x3810-0x381f has been reserved
pnp: 00:07: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:07: ioport range 0x8000-0x805f could not be reserved
pnp: 00:07: ioport range 0x4d6-0x4d6 has been reserved
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: ea100000-efffffff
  PREFETCH window: 38000000-380fffff
PCI: Bus 2, cardbus bridge: 0000:00:04.0
  IO window: 00002000-000020ff
  IO window: 00002400-000024ff
  PREFETCH window: 30000000-31ffffff
  MEM window: 32000000-33ffffff
PCI: Bus 6, cardbus bridge: 0000:00:04.1
  IO window: 00002800-000028ff
  IO window: 00002c00-00002cff
  PREFETCH window: 34000000-35ffffff
  MEM window: 36000000-37ffffff
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:04.0[A] -> Link [LNKA] -> GSI 11 (level, 
low) -> IRQ 11
ACPI: PCI Interrupt 0000:00:04.1[A] -> Link [LNKA] -> GSI 11 (level, 
low) -> IRQ 11
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 6, 327680 bytes)
TCP bind hash table entries: 8192 (order: 5, 163840 bytes)
TCP: Hash tables configured (established 16384 bind 8192)
TCP reno registered
Simple Boot Flag at 0x36 set to 0x1
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
audit: initializing netlink socket (disabled)
audit(1162414819.244:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
ksign: Installing public key data
Loading keyring
- Added public key EAA0802BFF323905
- User ID: Red Hat, Inc. (Kernel Module GPG key)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Limiting direct PCI/PCI transfers.
Activating ISA DMA hang workarounds.
ACPI: Transitioning device [FAN] to D3
ACPI: Transitioning device [FAN] to D3
ACPI: Fan [FAN] (off)
ACPI: CPU0 (power states: C1[C1] C2[C2]
====== hangs here ======

2.6.18-1.2200.fc5 ==== this works
Linux version 2.6.18-1.2200.fc5 
(brewbuilder@hs20-bc2-3.build.redhat.com) (gcc version 4.1.1 20060525 
(Red Hat 4.1.1-1)) #1 Sat Oct 14 16:59:26 EDT 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001ffff000 (ACPI data)
 BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
511MB LOWMEM available.
Using x86 segment limits to approximate NX protection
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 126960 pages, LIFO batch:31
DMI 2.2 present.
ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f7c20
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x1fffcc46
ACPI: FADT (v001 ALI    M1533    0x06040000 PTL  0x000f4240) @ 0x1fffef64
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x1fffefd8
ACPI: DSDT (v001 COMPAL      736 0x06040000 MSFT 0x0100000d) @ 0x00000000
ACPI: PM-Timer IO Port: 0x8008
Allocating PCI resources starting at 30000000 (gap: 20000000:dff80000)
Detected 850.084 MHz processor.
Built 1 zonelists.  Total pages: 131056
Kernel command line: ro root=/dev/VolGroup00/LogVol00 lapic nousb ide0=ata66
ide_setup: ide0=ata66 -- OBSOLETE OPTION, WILL BE REMOVED SOON!
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
mapped APIC to ffffd000 (fee00000)
Enabling fast FPU save and restore... done.
Initializing CPU#0
CPU 0 irqstacks, hard=c075b000 soft=c075a000
PID hash table entries: 2048 (order: 11, 8192 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 513164k/524224k available (2041k kernel code, 10520k reserved, 
801k data, 220k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 1701.40 BogoMIPS 
(lpj=3402802)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0183fbff c1c7fbff 00000000 00000000 
00000000 00000000 00000000
CPU: After vendor identify, caps: 0183fbff c1c7fbff 00000000 00000000 
00000000 00000000 00000000
Enabling disabled K7/SSE Support.
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 64K (64 bytes/line)
CPU: After all inits, caps: 0383f3ff c1c7fbff 00000000 00000420 00000000 
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD mobile AMD Duron(tm) Processor stepping 00
Checking 'hlt' instruction... OK.
ACPI: Core revision 20060707
ACPI: setting ELCR to 0200 (from 0800)
checking if image is initramfs... it is
Freeing initrd memory: 2115k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
spurious 8259A interrupt: IRQ7.
PCI: PCI BIOS revision 2.10 entry at 0xfd8b0, last bus=1
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 8000-803f claimed by ali7101 ACPI
PCI quirk: region 8040-805f claimed by ali7101 SMB
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 5 7 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 5 7 10 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 5 7) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 5 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKU] (IRQs *9)
ACPI: Embedded Controller [EC0] (gpe 25) interrupt mode.
ACPI: Power Resource [PFAN] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 11 devices
usbcore: USB support disabled
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a 
report
pnp: 00:07: ioport range 0x3810-0x381f has been reserved
pnp: 00:07: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:07: ioport range 0x8000-0x805f could not be reserved
pnp: 00:07: ioport range 0x4d6-0x4d6 has been reserved
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: ea100000-efffffff
  PREFETCH window: 38000000-380fffff
PCI: Bus 2, cardbus bridge: 0000:00:04.0
  IO window: 00002000-000020ff
  IO window: 00002400-000024ff
  PREFETCH window: 30000000-31ffffff
  MEM window: 32000000-33ffffff
PCI: Bus 6, cardbus bridge: 0000:00:04.1
  IO window: 00002800-000028ff
  IO window: 00002c00-00002cff
  PREFETCH window: 34000000-35ffffff
  MEM window: 36000000-37ffffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:04.0[A] -> Link [LNKA] -> GSI 11 (level, 
low) -> IRQ 11
ACPI: PCI Interrupt 0000:00:04.1[A] -> Link [LNKA] -> GSI 11 (level, 
low) -> IRQ 11
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 6, 262144 bytes)
TCP bind hash table entries: 8192 (order: 5, 163840 bytes)
TCP: Hash tables configured (established 16384 bind 8192)
TCP reno registered
Simple Boot Flag at 0x36 set to 0x1
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
audit: initializing netlink socket (disabled)
audit(1162414937.820:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
ksign: Installing public key data
Loading keyring
- Added public key AFB81CC8AAE721BE
- User ID: Red Hat, Inc. (Kernel Module GPG key)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Limiting direct PCI/PCI transfers.
Activating ISA DMA hang workarounds.
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI: Transitioning device [FAN] to D3
ACPI: Transitioning device [FAN] to D3
ACPI: Fan [FAN] (off)
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: Thermal Zone [THRM] (60 C)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12ac
Non-volatile memory driver v1.2
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected ALi M1647 chipset
agpgart: AGP aperture is 64M @ 0xf0000000
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:0a: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K size 4096 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ALI15X3: IDE controller at PCI slot 0000:00:0f.0
ACPI: Unable to derive IRQ for device 0000:00:0f.0
ACPI: PCI Interrupt 0000:00:0f.0[A]: no GSI
ALI15X3: chipset revision 195
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1000-0x1007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1008-0x100f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: HITACHI_DK23CA-20, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: MATSHITADVD-ROM SR-8175, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: max request size: 128KiB
hda: 39070080 sectors (20003 MB) w/2048KiB Cache, CHS=38760/16/63, UDMA(66)
hda: cache flushes not supported
 hda: hda1 hda2
ide-floppy driver 0.99.newide
Yenta: CardBus bridge found at 0000:00:04.0 [103c:0018]
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:04.0, mfunc 0x009c1b22, devctl 0x66
Yenta: ISA IRQ mask 0x04b8, PCI irq 11
Socket status: 30000006
Yenta: CardBus bridge found at 0000:00:04.1 [103c:0018]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:04.1, mfunc 0x009c1b22, devctl 0x66
Yenta: ISA IRQ mask 0x04b8, PCI irq 11
Socket status: 30000020
PNP: PS/2 Controller [PNP0303:KBC0,PNP0f13:MSE0] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
powernow: PowerNOW! Technology present. Can scale: frequency and voltage.
powernow: SGTC: 10000
powernow: Minimum speed 300 MHz. Maximum speed 850 MHz.
powernow-k8: Processor cpuid 670 not supported
Using IPI Shortcut mode
Time: tsc clocksource has been installed.
ACPI: (supports S0 S1 S3 S4 S5)
Freeing unused kernel memory: 220k freed
Write protecting the kernel read-only data: 377k
Time: acpi_pm clocksource has been installed.
input: AT Translated Set 2 keyboard as /class/input/input0
USB Universal Host Controller Interface driver v3.0
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
input: PS2++ Logitech Wheel Mouse as /class/input/input1
device-mapper: ioctl: 4.7.0-ioctl (2006-06-24) initialised: 
dm-devel@redhat.com
pccard: CardBus card inserted into slot 1
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
audit(1162414948.510:2): selinux=0 auid=4294967295
hdc: ATAPI 24X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ath_hal: module license 'Proprietary' taints kernel.
ath_hal: 0.9.18.0 (AR5210, AR5211, AR5212, RF5111, RF5112, RF2413, RF5413)
Linux Tulip driver version 1.1.13 (May 11, 2002)
PCI: Enabling device 0000:00:10.0 (0010 -> 0013)
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:10.0[A] -> Link [LNKB] -> GSI 11 (level, 
low) -> IRQ 11
tulip0:  MII transceiver #1 config 1000 status 7849 advertising 01e1.
eth0: ADMtek Comet rev 17 at e0834000, 00:D0:59:5C:E0:EB, IRQ 11.
input: PC Speaker as /class/input/input2
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
wlan: 0.8.4.2 (svn r1784)
ath_rate_sample: 1.2 (svn r1784)
ath_pci: 0.9.4.5 (svn r1784)
PCI: Enabling device 0000:06:00.0 (0000 -> 0002)
ACPI: PCI Interrupt 0000:06:00.0[A] -> Link [LNKA] -> GSI 11 (level, 
low) -> IRQ 11
wifi0: 11b rates: 1Mbps 2Mbps 5.5Mbps 11Mbps
wifi0: 11g rates: 1Mbps 2Mbps 5.5Mbps 11Mbps 6Mbps 9Mbps 12Mbps 18Mbps 
24Mbps 36Mbps 48Mbps 54Mbps
wifi0: H/W encryption support: WEP AES AES_CCM TKIP
wifi0: mac 7.8 phy 4.5 radio 5.6
wifi0: Use hw queue 1 for WME_AC_BE traffic
wifi0: Use hw queue 0 for WME_AC_BK traffic
wifi0: Use hw queue 2 for WME_AC_VI traffic
wifi0: Use hw queue 3 for WME_AC_VO traffic
wifi0: Use hw queue 8 for CAB traffic
wifi0: Use hw queue 9 for beacons
wifi0: Atheros 5212: mem=0x36000000, irq=11
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [LNKC] -> GSI 5 (level, low) 
-> IRQ 5
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
cs: IO port probe 0x100-0x3af: excluding 0x200-0x207 0x378-0x37f
cs: IO port probe 0x3e0-0x4ff: excluding 0x408-0x40f 0x480-0x48f
cs: IO port probe 0x820-0x8ff: clean.
cs: IO port probe 0xc00-0xcf7: clean.
cs: IO port probe 0xa00-0xaff: clean.
cs: IO port probe 0x100-0x3af: excluding 0x200-0x207 0x378-0x37f
cs: IO port probe 0x3e0-0x4ff: excluding 0x408-0x40f 0x480-0x48f
cs: IO port probe 0x820-0x8ff: clean.
cs: IO port probe 0xc00-0xcf7: clean.
cs: IO port probe 0xa00-0xaff: clean.
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE]
lp0: using parport0 (interrupt-driven).
lp0: console ready
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SBTN]
ibm_acpi: IBM ThinkPad ACPI Extras v0.12a
ibm_acpi: http://ibm-acpi.sf.net/
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
EXT3 FS on dm-0, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 524280k swap on /dev/VolGroup00/LogVol01.  Priority:-1 extents:1 
across:524280k
Bluetooth: Core ver 2.10
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
Bluetooth: HIDP (Human Interface Emulation) ver 1.1
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
ip_tables: (C) 2000-2006 Netfilter Core Team
Netfilter messages via NETLINK v0.30.
ip_conntrack version 2.4 (4095 buckets, 32760 max) - 228 bytes per conntrack
Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin 
is 60 seconds).
Hangcheck: Using get_cycles().
ath0: no IPv6 routers present
eth0: no IPv6 routers present

-- 

"They that give up essential liberty to obtain temporary safety, 
deserve neither liberty nor safety."  (Ben Franklin)

"The course of history shows that as a government grows, liberty 
decreases."  (Thomas Jefferson)



