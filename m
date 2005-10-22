Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751268AbVJVTb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbVJVTb5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 15:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbVJVTb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 15:31:57 -0400
Received: from mail.majordomo.ru ([81.177.16.8]:778 "EHLO mail.majordomo.ru")
	by vger.kernel.org with ESMTP id S1751268AbVJVTb4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 15:31:56 -0400
Message-ID: <435ACC89.8050409@lindevel.ru>
Date: Sat, 22 Oct 2005 23:34:33 +0000
From: "Nikolay N. Ivanov" <group@lindevel.ru>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: ru-ru, ru
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6.13.4: don't reboot
References: <20051022171757.6ED8222AF02@anxur.fi.muni.cz>
In-Reply-To: <20051022171757.6ED8222AF02@anxur.fi.muni.cz>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby пишет:

>>HP Compaq nx6110 don't reboot with kernel 2.6.13.4.
>>    
>>
>The last OK was?
>  
>
Yes.

-----------------
bla, bla, bla...
Rebooting.
Restarting system.
.
----------------------

And stop... Ctrl+Alt+Del don't work.


>>Poweroff and acpi functions works normally. Is it kernel bug?
>>    
>>
>May be.
>  
>
dmesg:

Linux version 2.6.13.4nn (root@nbc) (gcc version 3.3.4) #5 Sat Oct 22 
17:55:07 UTC 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000f7d0000 (usable)
 BIOS-e820: 000000000f7d0000 - 000000000f7efc00 (reserved)
 BIOS-e820: 000000000f7efc00 - 000000000f7fb000 (ACPI NVS)
 BIOS-e820: 000000000f7fb000 - 000000000f800000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec02000 (reserved)
 BIOS-e820: 00000000fed20000 - 00000000fed9b000 (reserved)
 BIOS-e820: 00000000feda0000 - 00000000fedc0000 (reserved)
 BIOS-e820: 00000000ffb00000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
247MB LOWMEM available.
On node 0 totalpages: 63440
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 59344 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 HP                                    ) @ 0x000fe270
ACPI: RSDT (v001 HP     099C     0x02060520 HP   0x00000001) @ 0x0f7efc84
ACPI: FADT (v002 HP     099C     0x00000002 HP   0x00000001) @ 0x0f7efc00
ACPI: MADT (v001 HP     099C     0x00000001 HP   0x00000001) @ 0x0f7efcb4
ACPI: MCFG (v001 HP     099C     0x00000001 HP   0x00000001) @ 0x0f7efd10
ACPI: DSDT (v001 HP       DAU00  0x00010000 MSFT 0x0100000e) @ 0x00000000
Allocating PCI resources starting at 0f800000 (gap: 0f800000:d0800000)
Built 1 zonelists
Kernel command line: BOOT_IMAGE=Linux ro root=306
Initializing CPU#0
PID hash table entries: 1024 (order: 10, 16384 bytes)
Detected 1400.442 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 247168k/253760k available (2520k kernel code, 6020k reserved, 
975k data, 152k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 2804.05 BogoMIPS 
(lpj=1402025)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: afe9fbff 00100000 00000000 00000000 
00000000 00000000 00000000
CPU: After vendor identify, caps: afe9fbff 00100000 00000000 00000000 
00000000 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 1024K
CPU: After all inits, caps: afe9fbff 00100000 00000000 00000040 00000000 
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
mtrr: v2.0 (20020519)
CPU: Intel(R) Celeron(R) M processor         1.40GHz stepping 08
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0200 (from 0c00)
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xf0322, last bus=3
PCI: Using MMCONFIG
ACPI: Subsystem revision 20050408
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [C002] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.C002] segment is 0
ACPI: Assume root bridge [\_SB_.C002] bus is 0
Boot video device is 0000:00:02.0
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.C002._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.C002.C067._PRT]
ACPI: Embedded Controller [C004] (gpe 16)
ACPI: Power Resource [C1BD] (on)
ACPI: PCI Interrupt Link [C0D7] (IRQs 10 *11)
ACPI: PCI Interrupt Link [C0D8] (IRQs *10 11)
ACPI: PCI Interrupt Link [C0D9] (IRQs *10 11)
ACPI: PCI Interrupt Link [C0DA] (IRQs *10 11)
ACPI: PCI Interrupt Link [C0ED] (IRQs *10 11)
ACPI: PCI Interrupt Link [C0EE] (IRQs 10 11) *0, disabled.
ACPI: PCI Interrupt Link [C0EF] (IRQs *10 11)
ACPI: PCI Interrupt Link [C0F0] (IRQs 10 11) *0, disabled.
ACPI: Power Resource [C251] (off)
ACPI: Power Resource [C252] (off)
ACPI: Power Resource [C253] (off)
ACPI: Power Resource [C254] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 12 devices
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a 
report
pnp: 00:09: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:09: ioport range 0x1000-0x107f could not be reserved
pnp: 00:09: ioport range 0x1100-0x113f has been reserved
pnp: 00:09: ioport range 0x1200-0x121f has been reserved
PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
PCI: Bus 3, cardbus bridge: 0000:02:06.0
  IO window: 00003000-00003fff
  IO window: 00004000-00004fff
  PREFETCH window: 10000000-11ffffff
  MEM window: 12000000-13ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: 3000-4fff
  MEM window: d0000000-d03fffff
  PREFETCH window: 10000000-11ffffff
PCI: Setting latency timer of device 0000:00:1e.0 to 64
ACPI: PCI Interrupt Link [C0D9] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:02:06.0[A] -> Link [C0D9] -> GSI 10 (level, 
low) -> IRQ 10
Machine check exception polling timer started.
audit: initializing netlink socket (disabled)
audit(1130004909.334:1): initialized
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
ACPI: AC Adapter [C16B] (on-line)
ACPI: Battery Slot [C16D] (battery present)
ACPI: Battery Slot [C16C] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [C1E0]
ACPI: Lid Switch [C1E1]
ACPI: Fan [C255] (off)
ACPI: Fan [C256] (off)
ACPI: Fan [C257] (off)
ACPI: Fan [C258] (off)
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Processor [C000] (supports 8 throttling states)
ACPI: Thermal Zone [TZ1] (52 C)
ACPI: Thermal Zone [TZ2] (40 C)
ACPI: Thermal Zone [TZ3] (29 C)
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 915GM Chipset.
agpgart: Detected 7932K stolen memory.
agpgart: AGP aperture is 256M @ 0xc0000000
[drm] Initialized drm 1.0.0 20040925
PNP: PS/2 Controller [PNP0303:C1BA,PNP0f13:C1BB] at 0x60,0x64 irq 1,12
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
ACPI: PCI Interrupt Link [C0EF] enabled at IRQ 10
ACPI: PCI Interrupt 0000:00:1e.3[B] -> Link [C0EF] -> GSI 10 (level, 
low) -> IRQ 10
ACPI: PCI interrupt for device 0000:00:1e.3 disabled
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
b44.c:v0.95 (Aug 3, 2004)
ACPI: PCI Interrupt Link [C0D7] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:02:0e.0[A] -> Link [C0D7] -> GSI 11 (level, 
low) -> IRQ 11
eth0: Broadcom 4400 10/100BaseT Ethernet 00:14:38:11:75:37
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH6: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [C0D7] -> GSI 11 (level, 
low) -> IRQ 11
ICH6: chipset revision 3
ICH6: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x2580-0x2587, BIOS settings: hda:DMA, hdb:DMA
Probing IDE interface ide0...
hda: TOSHIBA MK4025GAS, ATA DISK drive
hdb: DW-224E-C, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hda: max request size: 128KiB
hda: 78140160 sectors (40007 MB), CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 < hda5 hda6 hda7 >
hdb: ATAPI 24X DVD-ROM CD-R/RW drive, 1654kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
libata version 1.12 loaded.
usbmon: debugfs is not available
ACPI: PCI Interrupt Link [C0F0] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:1d.7[A] -> Link [C0F0] -> GSI 11 (level, 
low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 
Family) USB2 EHCI Controller
ehci_hcd 0000:00:1d.7: debug port 1
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: irq 11, io mem 0xd0580000
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
USB Universal Host Controller Interface driver v2.3
ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [C0F0] -> GSI 11 (level, 
low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 
Family) USB UHCI #1
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 11, io base 0x00002000
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt Link [C0D8] enabled at IRQ 10
ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [C0D8] -> GSI 10 (level, 
low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 
Family) USB UHCI #2
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 10, io base 0x00002020
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [C0D9] -> GSI 10 (level, 
low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 
Family) USB UHCI #3
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 10, io base 0x00002040
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt Link [C0DA] enabled at IRQ 10
ACPI: PCI Interrupt 0000:00:1d.3[D] -> Link [C0DA] -> GSI 10 (level, 
low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 
Family) USB UHCI #4
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.3: irq 10, io base 0x00002060
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usb 2-1: new low speed USB device using uhci_hcd and address 2
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
input: USB HID v1.10 Mouse [1241:1177] on usb-0000:00:1d.0-1
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
mice: PS/2 mouse device common for all mice
Advanced Linux Sound Architecture Driver Version 1.0.9b (Thu Jul 28 
12:20:13 2005 UTC).
ALSA device list:
  No soundcards found.
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP reno registered
ip_conntrack version 2.1 (1982 buckets, 15856 max) - 212 bytes per conntrack
input: AT Translated Set 2 keyboard on isa0060/serio0
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  
http://snowman.net/projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
ACPI wakeup devices:
C067 C0BA C0C1 C0C2 C0C3 C0C4
ACPI: (supports S0 S3 S4 S4bios S5)
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 152k freed
Synaptics Touchpad, model: 1, fw: 6.2, id: 0x25a0b1, caps: 0xa04793/0x300000
serio: Synaptics pass-through port at isa0060/serio4/input0
input: SynPS/2 Synaptics TouchPad on isa0060/serio4
ts: Compaq touchscreen protocol output
Adding 997880k swap on /dev/hda5.  Priority:-1 extents:1
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
cdrom: open failed.
b44: eth0: Link is up at 100 Mbps, full duplex.
b44: eth0: Flow control is off for TX and off for RX.
ACPI: PCI Interrupt 0000:00:1e.3[B] -> Link [C0EF] -> GSI 10 (level, 
low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1e.3 to 64
ACPI: PCI Interrupt Link [C0EE] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:1e.2[A] -> Link [C0EE] -> GSI 11 (level, 
low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1e.2 to 64
intel8x0_measure_ac97_clock: measured 50137 usecs
intel8x0: clocking to 48000
input: PC Speaker
mtrr: no more MTRRs available

-------------------------

With best regards, Nikolay.


