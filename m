Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964971AbWFHUM7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964971AbWFHUM7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 16:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964973AbWFHUM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 16:12:59 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:27594 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964971AbWFHUM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 16:12:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=UHNP/f5TgveldbFjfSvqf9Uelk2xI02VwryDnH2fuf7os+Q//ylsvT/QIm/b+DAMRPNlISzsEPcBWdlw7XpsdFquCkHJe8JGDFLusUVGNkiLvnRbvO3Y2HxWMkNBFvP6RTUkAik/nUefSITONIEVtSkP5hdItpLgWRjh695Bdg8=
Message-ID: <5bdc1c8b0606081312k1fc1c061q87bf85c20b561ff5@mail.gmail.com>
Date: Thu, 8 Jun 2006 13:12:56 -0700
From: "Mark Knecht" <markknecht@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: 2.6.17-rc6-rt1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5bdc1c8b0606072049t78eccec1w8b3b1d4024ede7ee@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_5569_17387650.1149797576017"
References: <20060607211455.GA6132@elte.hu>
	 <5bdc1c8b0606072049t78eccec1w8b3b1d4024ede7ee@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_5569_17387650.1149797576017
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 6/7/06, Mark Knecht <markknecht@gmail.com> wrote:
> Hi Ingo,
>    Since the Gentoo Pro-Audio overlay guys were so quick to get
> 2.6.17-rc6-rt1 into an ebuild I downloaded and built the kernel this
> evening using that method.
>
> 1) The kernel did boot on my AMD64 machine.
>
> 2) gdm segfaulted so I couldn't run X.
>
> 3) Basic functionality was available in a console window.
>
>    I expect the gdm problem is on my end. Maybe it's a VGA driver
> issue or something like that? I'll check that out tomorrow.
>
>    Anyway, it does boot so that's a start.
>
> Cheers,
> Mark
>

Hi all,
   I am still unable to get gdm to run. It just segfaults on me so
far. I tried rebuilding gdm under this kernel but that didn't fix it.

   I'm attaching the dmesg file that I get under the new kernel, along
with the config file zipped up.

Cheers,
Mark

------=_Part_5569_17387650.1149797576017
Content-Type: text/plain; name=dmesg-crash.txt; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Attachment-Id: f_eo7jozr9
Content-Disposition: attachment; filename="dmesg-crash.txt"

(64 bytes/line)
CPU: AMD Athlon(tm) 64 Processor 3000+ stepping 00
Using local APIC timer interrupts.
result 12564478
Detected 12.564 MHz APIC timer.
testing NMI watchdog ... OK.
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Transparent bridge - 0000:00:09.0
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disable=
d.
ACPI: PCI Interrupt Link [LNK3] (IRQs *3 4 5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disable=
d.
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disable=
d.
ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disable=
d.
ACPI: PCI Interrupt Link [LMAC] (IRQs *3 4 5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disable=
d.
ACPI: PCI Interrupt Link [LSMB] (IRQs *3 4 5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disable=
d.
ACPI: PCI Interrupt Link [LSID] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LFID] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LPCA] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disable=
d.
ACPI: PCI Interrupt Link [APC1] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC2] (IRQs 17) *0, disabled.
ACPI: PCI Interrupt Link [APC3] (IRQs 18) *0, disabled.
ACPI: PCI Interrupt Link [APC4] (IRQs 19) *0, disabled.
ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCS] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSJ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCP] (IRQs 20 21 22 23) *0, disabled.
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=3Drouteirq".  If it helps, post a r=
eport
PCI-DMA: Disabling IOMMU.
PCI: Bridge: 0000:00:09.0
  IO window: disabled.
  MEM window: da000000-da0fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0b.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0c.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0d.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0e.0
  IO window: a000-afff
  MEM window: d8000000-d9ffffff
  PREFETCH window: d0000000-d7ffffff
PCI: Setting latency timer of device 0000:00:09.0 to 64
PCI: Setting latency timer of device 0000:00:0b.0 to 64
PCI: Setting latency timer of device 0000:00:0c.0 to 64
PCI: Setting latency timer of device 0000:00:0d.0 to 64
PCI: Setting latency timer of device 0000:00:0e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 6, 262144 bytes)
TCP established hash table entries: 65536 (order: 10, 4194304 bytes)
TCP bind hash table entries: 32768 (order: 8, 1835008 bytes)
TCP: Hash tables configured (established 65536 bind 32768)
TCP reno registered
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
Total HugeTLB memory allocated, 0
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
io scheduler noop registered
io scheduler deadline registered (default)
io scheduler cfq registered
PCI: Setting latency timer of device 0000:00:0b.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0b.0:pcie00]
PCI: Setting latency timer of device 0000:00:0c.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0c.0:pcie00]
PCI: Setting latency timer of device 0000:00:0d.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0d.0:pcie00]
PCI: Setting latency timer of device 0000:00:0e.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0e.0:pcie00]
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
Using specific hotkey driver
ACPI: Thermal Zone [THRM] (40 C)
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.101 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
isa bounce pool size: 16 pages
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
e100: Intel(R) PRO/100 Network Driver, 3.5.10-k2-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.54.
ACPI: PCI Interrupt Link [APCH] enabled at IRQ 23
GSI 16 sharing vector 0xD9 and IRQ 16
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [APCH] -> GSI 23 (level, low) -=
> IRQ 217
PCI: Setting latency timer of device 0000:00:0a.0 to 64
forcedeth: using HIGHDMA
eth0: forcedeth.c: subsystem: 01043:8141 bound to 0000:00:0a.0
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
netconsole: not configured, aborting
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
NFORCE-CK804: IDE controller at PCI slot 0000:00:06.0
NFORCE-CK804: chipset revision 242
NFORCE-CK804: not 100% native mode: will probe irqs later
NFORCE-CK804: 0000:00:06.0 (rev f2) UDMA133 controller
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: LITE-ON DVDRW LDW-411S, ATAPI CD/DVD-ROM drive
hdb: LITE-ON LTR-48246S, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide1...
hda: ATAPI 40X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdb: ATAPI 48X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
libata version 1.20 loaded.
sata_nv 0000:00:07.0: version 0.8
ACPI: PCI Interrupt Link [APSI] enabled at IRQ 22
GSI 17 sharing vector 0xE1 and IRQ 17
ACPI: PCI Interrupt 0000:00:07.0[A] -> Link [APSI] -> GSI 22 (level, low) -=
> IRQ 225
PCI: Setting latency timer of device 0000:00:07.0 to 64
ata1: SATA max UDMA/133 cmd 0x9F0 ctl 0xBF2 bmdma 0xD800 irq 225
ata2: SATA max UDMA/133 cmd 0x970 ctl 0xB72 bmdma 0xD808 irq 225
ata1: SATA link down (SStatus 0)
scsi0 : sata_nv
ata2: SATA link down (SStatus 0)
scsi1 : sata_nv
ACPI: PCI Interrupt Link [APSJ] enabled at IRQ 21
GSI 18 sharing vector 0xE9 and IRQ 18
ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [APSJ] -> GSI 21 (level, low) -=
> IRQ 233
PCI: Setting latency timer of device 0000:00:08.0 to 64
ata3: SATA max UDMA/133 cmd 0x9E0 ctl 0xBE2 bmdma 0xC400 irq 233
ata4: SATA max UDMA/133 cmd 0x960 ctl 0xB62 bmdma 0xC408 irq 233
ata3: SATA link up 1.5 Gbps (SStatus 113)
ata3: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3468 86:3c01 87:4023 88:=
407f
ata3: dev 0 ATA-7, max UDMA/133, 488397168 sectors: LBA48
nv_sata: Primary device added
nv_sata: Primary device removed
nv_sata: Secondary device added
nv_sata: Secondary device removed
ata3: dev 0 configured for UDMA/133
scsi2 : sata_nv
ata4: SATA link down (SStatus 0)
scsi3 : sata_nv
  Vendor: ATA       Model: ST3250823AS       Rev: 3.03
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 < sda5 sda6 sda7 sda8 sda9 sda10 sda11 sda12 >
sd 2:0:0:0: Attached scsi disk sda
Fusion MPT base driver 3.03.09
Copyright (c) 1999-2005 LSI Logic Corporation
Fusion MPT SPI Host driver 3.03.09
usbmon: debugfs is not available
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 20
GSI 19 sharing vector 0x32 and IRQ 19
ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [APCL] -> GSI 20 (level, low) -=
> IRQ 50
PCI: Setting latency timer of device 0000:00:02.1 to 64
ehci_hcd 0000:00:02.1: EHCI Host Controller
ehci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:02.1: debug port 1
PCI: cache line size of 64 is not supported by device 0000:00:02.1
ehci_hcd 0000:00:02.1: irq 50, io mem 0xfeb00000
ehci_hcd 0000:00:02.1: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 10 ports detected
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [APCF] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [APCF] -> GSI 23 (level, low) -=
> IRQ 217
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: OHCI Host Controller
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:02.0: irq 217, io mem 0xda104000
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 10 ports detected
USB Universal Host Controller Interface driver v3.0
usb 2-4: new low speed USB device using ohci_hcd and address 2
usb 2-4: configuration #1 chosen from 1 choice
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
HID device not claimed by input or hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
oprofile: using NMI interrupt.
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
Time: tsc clocksource has been installed.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
***************************************************************************=
**
*                                                                          =
 *
*  REMINDER, the following debugging options are turned on in your .config:=
 *
*                                                                          =
 *
*        CONFIG_CRITICAL_PREEMPT_TIMING                                    =
 *
*        CONFIG_CRITICAL_IRQSOFF_TIMING                                    =
 *
*                                                                          =
 *
*  they may increase runtime overhead and latencies.                       =
 *
*                                                                          =
 *
***************************************************************************=
**
Freeing unused kernel memory: 200k freed
input: AT Translated Set 2 keyboard as /class/input/input0
input: ImExPS/2 Generic Explorer Mouse as /class/input/input1
Adding 2008084k swap on /dev/sda10.  Priority:-1 extents:1 across:2008084k
EXT3 FS on sda2, internal journal
[drm] Initialized drm 1.0.1 20051102
ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
GSI 20 sharing vector 0x3A and IRQ 20
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [APC3] -> GSI 18 (level, low) -=
> IRQ 58
[drm] Initialized radeon 1.24.0 20060225 on minor 0
ACPI: PCI Interrupt Link [APCJ] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:04.0[A] -> Link [APCJ] -> GSI 22 (level, low) -=
> IRQ 225
PCI: Setting latency timer of device 0000:00:04.0 to 64
intel8x0_measure_ac97_clock: measured 50616 usecs
intel8x0: clocking to 46873
ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
GSI 21 sharing vector 0x42 and IRQ 21
ACPI: PCI Interrupt 0000:05:06.0[A] -> Link [APC1] -> GSI 16 (level, low) -=
> IRQ 66
ACPI: PCI Interrupt 0000:05:08.0[A] -> Link [APC3] -> GSI 18 (level, low) -=
> IRQ 58
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=3D[58]  MMIO=3D[da014000-da014=
7ff]  Max Packet=3D[4096]  IR/IT contexts=3D[4/8]
Realtime LSM initialized (all groups, mlock=3D1)
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ieee1394: Current remote IRM is not 1394a-2000 compliant, resetting...
ieee1394: Node added: ID:BUS[0-00:1023]  GUID[00303c020010645c]
ieee1394: Node added: ID:BUS[0-01:1023]  GUID[0050c504e0006463]
ieee1394: Host added: ID:BUS[0-02:1023]  GUID[0800286410000f43]
scsi4 : SBP-2 IEEE-1394
ieee1394: sbp2: Logged into SBP-2 device
ieee1394: Node 0-00:1023: Max speed [S400] - Max payload [2048]
  Vendor: Maxtor 6  Model: Y160P0            Rev: YAR4
  Type:   Direct-Access-RBC                  ANSI SCSI revision: 04
SCSI device sdb: 320173056 512-byte hdwr sectors (163929 MB)
sdb: Write Protect is off
sdb: Mode Sense: 11 00 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 320173056 512-byte hdwr sectors (163929 MB)
sdb: Write Protect is off
sdb: Mode Sense: 11 00 00 00
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2
sd 4:0:0:0: Attached scsi disk sdb
scsi5 : SBP-2 IEEE-1394
ieee1394: sbp2: Logged into SBP-2 device
ieee1394: Node 0-01:1023: Max speed [S400] - Max payload [2048]
  Vendor: Maxtor 6  Model: Y160P0            Rev: YAR4
  Type:   Direct-Access-RBC                  ANSI SCSI revision: 04
SCSI device sdc: 320173056 512-byte hdwr sectors (163929 MB)
sdc: Write Protect is off
sdc: Mode Sense: 11 00 00 00
SCSI device sdc: drive cache: write back
SCSI device sdc: 320173056 512-byte hdwr sectors (163929 MB)
sdc: Write Protect is off
sdc: Mode Sense: 11 00 00 00
SCSI device sdc: drive cache: write back
 sdc: sdc1 sdc2 sdc3
sd 5:0:0:0: Attached scsi disk sdc
gdm[8956]: segfault at ffffffff8068d198 rip ffffffffff6000fb rsp 00007fffa5=
d11120 error 5
eth0: no IPv6 routers present

------=_Part_5569_17387650.1149797576017
Content-Type: application/x-bzip2; name=2.6.17-rc6-rt1.config.bz2
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eo7jq6tc
Content-Disposition: attachment; filename="2.6.17-rc6-rt1.config.bz2"

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
95LMW5HwcNzxs2lAT/Yu5IpwoSAByH9Y
------=_Part_5569_17387650.1149797576017--
