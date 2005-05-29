Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261385AbVE2SVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261385AbVE2SVj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 14:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261383AbVE2SVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 14:21:39 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:59693 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261385AbVE2SUf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 14:20:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:user-agent:x-accept-language:mime-version:to:subject:content-type:from;
        b=GBBFpmA0gQGaoO/dEMJXApE+1rG1UVsvWE+h3ZT0IQLdq9JfLx+jLcp5XJbgWrU8vlXsbtTZUKudnzjE7G8SwCGQPowvQahbcGkOt9JcQKJ5arpvO0pOa/5fkVFCIy2TXx/sDuOsZ8obkZkxWtZdoG1EUCcUNkyF3a/LTl0U2YE=
Message-ID: <429A07EF.6090905@gmail.com>
Date: Sun, 29 May 2005 20:20:31 +0200
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050523)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linux mailing-list <linux-kernel@vger.kernel.org>
Subject: CPUFREQ/speedstep on Intel 955X chipset based system
Content-Type: multipart/mixed;
 boundary="------------000208080908000501020009"
From: Michael Thonke <iogl64nx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000208080908000501020009
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit


Hello,

I recently bought an Asus P5WAD2 motherboard which uses the Intel 955x
chipset.
I noticed that CPUFREQ/speedsteps with the same kernel and same config from
my system with Intel 925XE and Intel Pentium 640 does not work on the
system with
Intel 955X chipset (the processor is the same). In Windows it works
perfectly on 925XE
and 955X chipset. 

The kernels I used

2.6.12-rc5 vanilla with git4 patch
2.6.12-rc5-mm1.

I attached the output of dmesg and `cat /proc/cpuinfo`

Thanks in advance

Best regards
    Michael





--------------000208080908000501020009
Content-Type: text/plain;
 name="cpuinfo.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cpuinfo.out"

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 4
model name	:               Intel(R) Pentium(R) 4 CPU 3.20GHz
stepping	: 3
cpu MHz		: 3211.542
cache size	: 2048 KB
physical id	: 0
siblings	: 2
core id		: 0
cpu cores	: 1
fpu		: yes
fpu_exception	: yes
cpuid level	: 5
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm syscall nx lm constant_tsc pni monitor ds_cpl est cid cx16 xtpr
bogomips	: 6340.60
clflush size	: 64
cache_alignment	: 128
address sizes	: 36 bits physical, 48 bits virtual
power management:

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 15
model		: 4
model name	:               Intel(R) Pentium(R) 4 CPU 3.20GHz
stepping	: 3
cpu MHz		: 3211.542
cache size	: 2048 KB
physical id	: 0
siblings	: 2
core id		: 0
cpu cores	: 1
fpu		: yes
fpu_exception	: yes
cpuid level	: 5
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm syscall nx lm constant_tsc pni monitor ds_cpl est cid cx16 xtpr
bogomips	: 6406.14
clflush size	: 64
cache_alignment	: 128
address sizes	: 36 bits physical, 48 bits virtual
power management:


--------------000208080908000501020009
Content-Type: text/plain;
 name="dmesg.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.out"

Bootdata ok (command line is root=/dev/md1 vga=794 quiet)
Linux version 2.6.12-rc5-van-trunk (root@ioGL64NX_EMT64) (gcc-Version 3.4.3 20041125 (Gentoo 3.4.3-r1, ssp-3.4.3-0, pie-8.7.7)) #2 SMP Sun May 29 19:09:01 CEST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ff80000 (usable)
 BIOS-e820: 000000003ff80000 - 000000003ff8e000 (ACPI data)
 BIOS-e820: 000000003ff8e000 - 000000003ffe0000 (ACPI NVS)
 BIOS-e820: 000000003ffe0000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
ACPI: RSDP (v002 ACPIAM                                ) @ 0x00000000000fac40
ACPI: XSDT (v001 A M I  OEMXSDT  0x05000513 MSFT 0x00000097) @ 0x000000003ff80100
ACPI: FADT (v003 A M I  OEMFACP  0x05000513 MSFT 0x00000097) @ 0x000000003ff80290
ACPI: MADT (v001 A M I  OEMAPIC  0x05000513 MSFT 0x00000097) @ 0x000000003ff80390
ACPI: OEMB (v001 A M I  AMI_OEM  0x05000513 MSFT 0x00000097) @ 0x000000003ff8e040
  >>> ERROR: Invalid checksum
ACPI: MCFG (v001 A M I  OEMMCFG  0x05000513 MSFT 0x00000097) @ 0x000000003ff88760
ACPI: DSDT (v001  A0229 A0229000 0x00000000 INTL 0x02002026) @ 0x0000000000000000
On node 0 totalpages: 262016
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 257920 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:4 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:4 APIC version 16
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 40000000 (gap: 40000000:bfb00000)
Built 1 zonelists
Kernel command line: root=/dev/md1 vga=794 quiet
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 3.579545 MHz PM timer.
time.c: Detected 3211.542 MHz processor.
Console: colour dummy device 80x25
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Memory: 1025492k/1048064k available (2770k kernel code, 22132k reserved, 1172k data, 220k init)
Calibrating delay loop... 6340.60 BogoMIPS (lpj=3170304)
Mount-cache hash table entries: 256
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
using mwait in idle threads.
CPU: Physical Processor ID: 0
CPU0: Thermal monitoring enabled (TM1)
Using local APIC timer interrupts.
Detected 12.545 MHz APIC timer.
Booting processor 1/1 rip 6000 rsp ffff81000218ff58
Initializing CPU#1
Calibrating delay loop... 6406.14 BogoMIPS (lpj=3203072)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU1: Thermal monitoring enabled (TM1)
              Intel(R) Pentium(R) 4 CPU 3.20GHz stepping 03
APIC error on CPU1: 00(40)
CPU 1: Syncing TSC to CPU 0.
CPU 1: synchronized TSC with CPU 0 (last diff 37 cycles, maxerr 864 cycles)
Brought up 2 CPUs
time.c: Using PIT/TSC based timekeeping.
testing NMI watchdog ... OK.
CPU0 attaching sched-domain:
 domain 0: span 3
  groups: 1 2
  domain 1: span 3
   groups: 3
CPU1 attaching sched-domain:
 domain 0: span 3
  groups: 2 1
  domain 1: span 3
   groups: 3
NET: Registered protocol family 16
PCI: Using configuration type 1
PCI: Using MMCONFIG at e0000000
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050309
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:04:00.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P3._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P8._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 *4 5 6 7 10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 13 devices
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
pnp: 00:06: ioport range 0x290-0x297 has been reserved
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
Initializing Cryptographic API
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:01.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie03]
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie02]
Allocate Port Service[pcie03]
ACPI: PCI Interrupt 0000:00:1c.4[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1c.4 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie02]
Allocate Port Service[pcie03]
vesafb: framebuffer at 0xd8000000, mapped to 0xffffc20010100000, using 5120k, total 131072k
vesafb: mode is 1280x1024x16, linelength=2560, pages=1
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 160x64
fb0: VESA VGA frame buffer device
fb1: Virtual frame buffer device, using 1024K of video memory
ACPI: Processor [CPU1] (supports 8 throttling states)
Real Time Clock Driver v1.12
i8xx TCO timer: heartbeat value must be 2<heartbeat<39, using 30
i8xx TCO timer: initialized (0x0860). heartbeat=30 sec (nowayout=0)
Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin is 60 seconds).
Hangcheck: Using monotonic_clock().
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
io scheduler noop registered
io scheduler cfq registered
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 2 RAM disks of 2048K size 1024 blocksize
loop: loaded (max 8 devices)
ub: sizeof ub_scsi_cmd 88 ub_dev 2680
usbcore: registered new driver ub
Intel(R) PRO/1000 Network Driver - version 6.0.54-k2-NAPI
Copyright (c) 1999-2004 Intel Corporation.
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:02:00.0 to 64
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
ACPI: PCI Interrupt 0000:01:05.0[A] -> GSI 21 (level, low) -> IRQ 209
sk98lin: Network Device Driver v8.18.2.2 (beta)
(C)Copyright 1999-2005 Marvell(R).
ACPI: PCI Interrupt 0000:01:05.0[A] -> GSI 21 (level, low) -> IRQ 209
eth1: Yukon Gigabit Ethernet 10/100/1000Base-T Adapter
      PrefPort:A  RlmtMode:Check Link State
netconsole: not configured, aborting
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH7: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 22 (level, low) -> IRQ 217
ICH7: chipset revision 1
ICH7: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
Probing IDE interface ide0...
hda: HL-DT-ST DVDRAM GSA-4163B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ATAPI 40X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
libata version 1.10 loaded.
ahci version 1.00
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 23 (level, low) -> IRQ 225
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ahci(0000:00:1f.2) AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA mode
ahci(0000:00:1f.2) flags: 64bit ncq pm led clo pio slum part 
ata1: SATA max UDMA/133 cmd 0xFFFFC2000000ED00 ctl 0x0 bmdma 0x0 irq 225
ata2: SATA max UDMA/133 cmd 0xFFFFC2000000ED80 ctl 0x0 bmdma 0x0 irq 225
ata3: SATA max UDMA/133 cmd 0xFFFFC2000000EE00 ctl 0x0 bmdma 0x0 irq 225
ata4: SATA max UDMA/133 cmd 0xFFFFC2000000EE80 ctl 0x0 bmdma 0x0 irq 225
ata1: dev 0 cfg 49:2f00 82:746b 83:7f01 84:4023 85:7469 86:3c01 87:4023 88:20ff
ata1: dev 0 ATA, max UDMA7, 312581808 sectors: lba48 ncq
ata1: dev 0 configured for UDMA/133
scsi0 : ahci
ata2: dev 0 cfg 49:2f00 82:746b 83:7f01 84:4023 85:7469 86:3c01 87:4023 88:20ff
ata2: dev 0 ATA, max UDMA7, 312581808 sectors: lba48 ncq
ata2: dev 0 configured for UDMA/133
scsi1 : ahci
ata3: no device found (phy stat 00000000)
scsi2 : ahci
ata4: no device found (phy stat 00000000)
scsi3 : ahci
  Vendor: ATA       Model: SAMSUNG HD160JJ   Rev: WU10
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: SAMSUNG HD160JJ   Rev: WU10
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 < sda5 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2 < sdb5 sdb6 >
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg1 at scsi1, channel 0, id 0, lun 0,  type 0
usbmon: debugs is not available
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 20 (level, low) -> IRQ 233
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: Intel Corporation I/O Controller Hub EHCI USB
ehci_hcd 0000:00:1d.7: debug port 1
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: irq 233, io mem 0xd2cff800
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
USB Universal Host Controller Interface driver v2.2
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 20 (level, low) -> IRQ 233
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: Intel Corporation I/O Controller Hub UHCI USB #1
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 233, io base 0x00008000
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 17 (level, low) -> IRQ 50
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: Intel Corporation I/O Controller Hub UHCI USB #2
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 50, io base 0x00008400
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 58
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: Intel Corporation I/O Controller Hub UHCI USB #3
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 58, io base 0x00008800
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 19 (level, low) -> IRQ 66
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: Intel Corporation I/O Controller Hub UHCI USB #4
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.3: irq 66, io base 0x00009000
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usb 2-1: new low speed USB device using uhci_hcd and address 2
usb 2-2: new low speed USB device using uhci_hcd and address 3
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
input: USB HID v1.10 Mouse [Genius       NetScroll+Mini Traveler] on usb-0000:00:1d.0-1
input: USB HID v1.10 Keyboard [CHESEN USB Keyboard] on usb-0000:00:1d.0-2
input: USB HID v1.10 Device [CHESEN USB Keyboard] on usb-0000:00:1d.0-2
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
mice: PS/2 mouse device common for all mice
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: multipath personality registered as nr 7
md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
Advanced Linux Sound Architecture Driver Version 1.0.9.
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 19 (level, low) -> IRQ 66
PCI: Setting latency timer of device 0000:00:1b.0 to 64
ALSA device list:
  #0: HDA Intel at 0xd2cf8000 irq 66
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 64Kbytes
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI wakeup devices: 
P0P1 P0P3 P0P4 P0P5 P0P6 P0P7 P0P8 P0P9 USB2 USB3 USB4 MC97 USB1 EUSB 
ACPI: (supports S0 S1 S3 S4 S5)
md: Autodetecting RAID arrays.
md: autorun ...
md: considering sdb5 ...
md:  adding sdb5 ...
md:  adding sda5 ...
md: created md1
md: bind<sda5>
md: bind<sdb5>
md: running: <sdb5><sda5>
md1: setting max_sectors to 128, segment boundary to 32767
raid0: looking at sdb5
raid0:   comparing sdb5(20000768) with sdb5(20000768)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at sda5
raid0:   comparing sda5(20000768) with sdb5(20000768)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: done.
raid0 : md_size is 40001536 blocks.
raid0 : conf->hash_spacing is 40001536 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 8 bytes for hash.
md: ... autorun DONE.
ReiserFS: md1: found reiserfs format "3.6" with standard journal
cfq: depth 4 reached, tagging now on
ReiserFS: md1: using ordered data mode
ReiserFS: md1: journal params: device md1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: md1: checking transaction log (md1)
ReiserFS: md1: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 220k freed
cfq: depth 4 reached, tagging now on
ReiserFS: sdb1: found reiserfs format "3.6" with standard journal
ReiserFS: sdb1: using ordered data mode
ReiserFS: sdb1: journal params: device sdb1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sdb1: checking transaction log (sdb1)
ReiserFS: sdb1: Using r5 hash to sort names
e1000: eth0: e1000_watchdog_task: NIC Link is Up 100 Mbps Full Duplex
nvidia: module license 'NVIDIA' taints kernel.
ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:04:00.0 to 64
NVRM: loading NVIDIA Linux x86_64 NVIDIA Kernel Module  1.0-7174  Tue Mar 22 06:45:40 PST 2005

--------------000208080908000501020009--
