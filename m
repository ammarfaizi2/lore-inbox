Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266189AbUIAMjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266189AbUIAMjv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 08:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266319AbUIAMjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 08:39:51 -0400
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:49059 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S266189AbUIAMjQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 08:39:16 -0400
From: Romain Moyne <aero_climb@yahoo.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: Time runs exactly three times too fast
Date: Thu, 2 Sep 2004 17:08:30 +0200
User-Agent: KMail/1.7
References: <200409021453.09730.aero_climb@yahoo.fr> <200409021614.10377.aero_climb@yahoo.fr> <Pine.LNX.4.58.0409010835050.4481@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.58.0409010835050.4481@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200409021708.31410.aero_climb@yahoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Mercredi 01 Septembre 2004 14:35, Zwane Mwaikambo a écrit :
> On Thu, 2 Sep 2004, Romain Moyne wrote:
> > presario:/etc/rc2.d# ls
> > S10sysklogd  S20alsa   S20makedev  S20xprint  S99kdm            S99xdm
> > S11klogd     S20exim4  S20pcmcia   S89atd     S99rmnologin
> > S14ppp       S20inetd  S20xfs      S89cron    S99stop-bootlogd
> > presario:/etc/rc2.d#
>
> Please send a dmesg and .config

presario:/sys/devices/system/cpu/cpu0# dmesg
Linux version 2.6.9-rc1 (root@presario) (version gcc 3.3.4 (Debian 1:3.3.4-9)) 
#1 Thu Sep 2 14:52:15 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff70000 (usable)
 BIOS-e820: 000000001ff70000 - 000000001ff7f000 (ACPI data)
 BIOS-e820: 000000001ff7f000 - 000000001ff80000 (ACPI NVS)
 BIOS-e820: 000000001ff80000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 130928
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126832 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI present.
ACPI: RSDP (v000 PTLTD                                     ) @ 0x000f7280
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x1ff7a89f
ACPI: FADT (v001 NVIDIA CK8      0x06040000 PTL_ 0x000f4240) @ 0x1ff7ee34
ACPI: MADT (v001 NVIDIA NV_APIC_ 0x06040000  LTP 0x00000000) @ 0x1ff7eea8
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x1ff7ef02
ACPI: SSDT (v001 PTLTD  POWERNOW 0x06040000  LTP 0x00000001) @ 0x1ff7ef2a
ACPI: DSDT (v001 NVIDIA      CK8 0x06040000 MSFT 0x0100000e) @ 0x00000000
Built 1 zonelists
Kernel command line: root=/dev/hda3 ro
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 266.119 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 514768k/523712k available (1923k kernel code, 8176k reserved, 1004k 
data, 120k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 517.12 BogoMIPS
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 078bfbff c1d3fbff 00000000 00000000
CPU: After vendor identify, caps:  078bfbff c1d3fbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After all inits, caps:        078bfbff c1d3fbff 00000000 00000010
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) XP Processor 3000+ stepping 00
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: IRQ9 SCI: Edge set to Level Trigger.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd8bc, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040715
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Embedded Controller [EC0] (gpe 33)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P2P0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP0._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LUS0] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LUS1] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LUS2] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LPID] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LTID] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
PCI: Using ACPI for IRQ routing
ACPI: PCI Interrupt Link [LSMB] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:01.1[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LUS0] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LUS1] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:02.1[B] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LUS2] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:02.2[C] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LACI] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LMCI] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:06.1[B] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 11
ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNK2] enabled at IRQ 10
ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LNK3] enabled at IRQ 11
ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:02:04.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:02:04.1[B] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LNK5] enabled at IRQ 11
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
PCI: Cannot allocate resource region 4 of device 0000:00:01.1
PCI: Cannot allocate resource region 5 of device 0000:00:01.1
get_random_bytes called before random driver initialization
Simple Boot Flag at 0x37 set to 0x1
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
Real Time Clock Driver v1.12
Serial: 8250/16550 driver $Revision: 1.90 $ 48 ports, IRQ sharing enabled
ACPI: PCI interrupt 0000:00:06.1[B] -> GSI 10 (level, low) -> IRQ 10
loop: loaded (max 8 devices)
Using anticipatory io scheduler
nbd: registered device at major 43
8139cp: 10/100 PCI Ethernet driver v1.2 (Mar 22, 2004)
8139cp: pci dev 0000:02:01.0 (id 10ec:8139 rev 10) is not an 8139C+ compatible 
chip
8139cp: Try the "8139too" driver instead.
8139too Fast Ethernet driver 0.9.27
ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 10 (level, low) -> IRQ 10
eth0: RealTek RTL8139 at 0xe080e800, 00:0f:b0:08:29:0a, IRQ 10
eth0:  Identified 8139 chip type 'RTL-8101'
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE3-150: IDE controller at PCI slot 0000:00:08.0
NFORCE3-150: chipset revision 165
NFORCE3-150: not 100% native mode: will probe irqs later
NFORCE3-150: BIOS didn't set cable bits correctly. Enabling workaround.
NFORCE3-150: 0000:00:08.0 (rev a5) UDMA133 controller
    ide0: BM-DMA at 0x2080-0x2087, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x2088-0x208f, BIOS settings: hdc:DMA, hdd:pio
hda: IC25N060ATMR04-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: HL-DT-ST DVD+RW GCA-4040N, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 117210240 sectors (60011 MB) w/7884KiB Cache, CHS=16383/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
mice: PS/2 mouse device common for all mice
input: PC Speaker
i8042.c: Detected active multiplexing controller, rev 1.9.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
ReiserFS: hda3: found reiserfs format "3.6" with standard journal
ReiserFS: hda3: using ordered data mode
ReiserFS: hda3: journal params: device hda3, size 8192, journal first block 
18,max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda3: checking transaction log (hda3)
ReiserFS: hda3: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 120k freed
NET: Registered protocol family 1
Adding 498004k swap on /dev/hda2.  Priority:-1 extents:1
SCSI subsystem initialized
sbp2: $Rev: 1219 $ Ben Collins <bcollins@debian.org>
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ndiswrapper version 0.10 loaded (preempt=yes,smp=no)
ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 11 (level, low) -> IRQ 11
ndiswrapper: using irq 11
wlan0: ndiswrapper ethernet device 00:90:4b:59:c5:c4 using driver bcmwl5.sys
ndiswrapper device wlan0 supports  WPA with TKIP cipher
ndiswrapper: driver bcmwl5.sys (Broadcom,10/28/2003, 3.40.25.3) added
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ACPI: PCI interrupt 0000:00:02.2[C] -> GSI 10 (level, low) -> IRQ 10
ehci_hcd 0000:00:02.2: nVidia Corporation nForce3 USB 2.0
PCI: Setting latency timer of device 0000:00:02.2 to 64
ehci_hcd 0000:00:02.2: irq 10, pci mem e08c6000
ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 1
PCI: cache line size of 64 is not supported by device 0000:00:02.2
ehci_hcd 0000:00:02.2: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
usb usb1: control timeout on ep0out
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected AGP bridge 0
agpgart: Setting up Nforce3 AGP.
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 128M @ 0xe8000000
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 11 (level, low) -> IRQ 11
ohci_hcd 0000:00:02.0: nVidia Corporation nForce3 USB 1.1
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: irq 11, pci mem e08c8000
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
ACPI: PCI interrupt 0000:00:02.1[B] -> GSI 10 (level, low) -> IRQ 10
ohci_hcd 0000:00:02.1: nVidia Corporation nForce3 USB 1.1 (#2)
PCI: Setting latency timer of device 0000:00:02.1 to 64
ohci_hcd 0000:00:02.1: irq 10, pci mem e0935000
ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 3 ports detected
usb 2-1: new low speed USB device using address 2
input: USB HID v1.11 Mouse [Microsoft Microsoft Wireless Optical Mouse® 1.0A] 
on usb-0000:00:02.0-1
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
ts: Compaq touchscreen protocol output
ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:06.0 to 64
intel8x0_measure_ac97_clock: measured 48658 usecs
intel8x0: measured clock 16605 rejected
intel8x0: clocking to 48000


My config file is in my first message :)

>Do you have files in /sys/devices/system/cpu/cpu0/cpufreq ?
I don't.
