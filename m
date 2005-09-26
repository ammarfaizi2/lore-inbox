Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751564AbVIZAZY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564AbVIZAZY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 20:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751577AbVIZAZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 20:25:24 -0400
Received: from hulk.vianw.pt ([195.22.31.43]:60371 "EHLO hulk.vianw.pt")
	by vger.kernel.org with ESMTP id S1751563AbVIZAZX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 20:25:23 -0400
Message-ID: <43374DDB.6090708@esoterica.pt>
Date: Mon, 26 Sep 2005 01:24:43 +0000
From: Paulo da Silva <psdasilva@esoterica.pt>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Strange behaviour with SATA disks. Light always ON
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
I don't know if this is the right place to ask
about this, or even if this is a problem at all.

Anyway I didn't find relevant information on
this ...

I have just bought a new PC with two SATA drives.
I had no problems to have them working,
apparently fine except for one thing:
After reading the kernel, the driver access light (led?)
is always on!
Is this normal? Why?

BTW, is there any documentation/utilities similar
to hdparm for SATA?

Thanks a lot for any answer/comment.

I'm sending the 1st lines of dmesg just in case ...
If more information is needed, please let me know.

____________________________________
Linux version 2.6.11.7-skas3-v8 (root@Gandalf) (gcc version 
3.3.5-20050130 (Gentoo 3.3.5.20050130-r1, ssp-3.3.5.20050130-1, 
pie-8.7.7.1)) #6 SMP Sat Sep 3 21:32:14 WEST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007ffb0000 (usable)
 BIOS-e820: 000000007ffb0000 - 000000007ffbe000 (ACPI data)
 BIOS-e820: 000000007ffbe000 - 000000007fff0000 (ACPI NVS)
 BIOS-e820: 000000007fff0000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
1151MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000ff780
On node 0 totalpages: 524208
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 294832 pages, LIFO batch:16
DMI 2.3 present.
ACPI: RSDP (v000 ACPIAM                                ) @ 0x000fafa0
ACPI: RSDT (v001 A M I  OEMRSDT  0x02000503 MSFT 0x00000097) @ 0x7ffb0000
ACPI: FADT (v001 A M I  OEMFACP  0x02000503 MSFT 0x00000097) @ 0x7ffb0200
ACPI: MADT (v001 A M I  OEMAPIC  0x02000503 MSFT 0x00000097) @ 0x7ffb0390
ACPI: OEMB (v001 A M I  AMI_OEM  0x02000503 MSFT 0x00000097) @ 0x7ffbe040
ACPI: MCFG (v001 A M I  OEMMCFG  0x02000503 MSFT 0x00000097) @ 0x7ffb6cc0
ACPI: DSDT (v001  A0143 A0143006 0x00000006 INTL 0x02002026) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:4 APIC version 20
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 80000000 (gap: 80000000:7fb00000)
Built 1 zonelists
Kernel command line: BOOT_IMAGE=Palma rw root=805 video=vesafb:ywrap,mtrr
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 3213.006 MHz processor.
Using tsc for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 2074372k/2096832k available (2504k kernel code, 21656k reserved, 
1006k data, 212k init, 1179328k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 6340.60 BogoMIPS (lpj=3170304)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: bfebfbff 20000000 00000000 00000000 
0000649d 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 20000000 00000000 00000000 
0000649d 00000000 00000000
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 20000000 00000000 00000080 0000649d 
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (24) available
CPU0: Thermal monitoring enabled
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Pentium(R) 4 CPU 3.20GHz stepping 03
per-CPU timeslice cutoff: 2030.85 usecs.
task migration cache decay timeout: 3 msecs.
Booting processor 1/1 eip 3000
Initializing CPU#1
Calibrating delay loop... 6406.14 BogoMIPS (lpj=3203072)
CPU: After generic identify, caps: bfebfbff 20000000 00000000 00000000 
0000649d 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 20000000 00000000 00000000 
0000649d 00000000 00000000
monitor/mwait feature present.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 20000000 00000000 00000080 0000649d 
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (24) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) Pentium(R) 4 CPU 3.20GHz stepping 03
Total of 2 processors activated (12746.75 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
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
checking if image is initramfs...it isn't (bad gzip magic numbers); 
looks like an initrd
Freeing initrd memory: 238k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=3
PCI: Using MMCONFIG
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050211
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P3._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 *11 12 14 15)
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: disabled - APM is not SMP safe.
highmem bounce pool size: 64 pages
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Initializing Cryptographic API
vesafb: framebuffer at 0xd0000000, mapped to 0xf8880000, using 6144k, 
total 262144k
vesafb: mode is 1024x768x16, linelength=2048, pages=1
vesafb: protected mode interface info at c000:d5c0
vesafb: pmi: set display start = c00cd5f6, set palette = c00cd660
vesafb: pmi: ports = 3b4 3b5 3ba 3c0 3c1 3c4 3c5 3c6 3c7 3c8 3c9 3cc 3ce 
3cf 3d0 3d1 3d2 3d3 3d4 3d5 3da
vesafb: scrolling: ywrap using protected mode interface, yres_virtual=3072
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
bootsplash 3.1.6-2004/03/31: looking for picture...<6> silentjpeg size 
121940 bytes,<6>...found (1024x768, 121832 bytes, v3).
Console: switching to colour frame buffer device 122x43
fb0: VESA VGA frame buffer device
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
[drm] Initialized drm 1.0.0 20040925
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 16 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH6: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
ICH6: chipset revision 4
ICH6: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: PIONEER DVD-RW DVR-109, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide1...
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2000kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
libata version 1.10 loaded.
ahci version 1.00
ACPI: PCI interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ahci(0000:00:1f.2) AHCI 0001.0000 32 slots 4 ports 1.5 Gbps 0xf impl IDE 
mode
ahci(0000:00:1f.2) flags: 64bit ncq pm led slum part
ata1: SATA max UDMA/133 cmd 0xF8810D00 ctl 0x0 bmdma 0x0 irq 19
ata2: SATA max UDMA/133 cmd 0xF8810D80 ctl 0x0 bmdma 0x0 irq 19
ata3: SATA max UDMA/133 cmd 0xF8810E00 ctl 0x0 bmdma 0x0 irq 19
ata4: SATA max UDMA/133 cmd 0xF8810E80 ctl 0x0 bmdma 0x0 irq 19
ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 
88:207f
ata1: dev 0 ATA, max UDMA/133, 488397168 sectors: lba48
ata1: dev 0 configured for UDMA/133
scsi0 : ahci
ata2: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 
88:207f
ata2: dev 0 ATA, max UDMA/133, 488397168 sectors: lba48
ata2: dev 0 configured for UDMA/133
scsi1 : ahci
ata3: no device found (phy stat 00000000)
scsi2 : ahci
ata4: no device found (phy stat 00000000)
scsi3 : ahci
  Vendor: ATA       Model: ST3250823AS       Rev: 3.03
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: ST3250823AS       Rev: 3.03
  Type:   Direct-Access                      ANSI SCSI revision: 05
sata_sil version 0.8
ACPI: PCI interrupt 0000:01:05.0[A] -> GSI 22 (level, low) -> IRQ 22
ata5: SATA max UDMA/100 cmd 0xF8812C80 ctl 0xF8812C8A bmdma 0xF8812C00 
irq 22
ata6: SATA max UDMA/100 cmd 0xF8812CC0 ctl 0xF8812CCA bmdma 0xF8812C08 
irq 22
ata7: SATA max UDMA/100 cmd 0xF8812E80 ctl 0xF8812E8A bmdma 0xF8812E00 
irq 22
ata8: SATA max UDMA/100 cmd 0xF8812EC0 ctl 0xF8812ECA bmdma 0xF8812E08 
irq 22
ata5: no device found (phy stat 00000000)
scsi4 : sata_sil
ata6: no device found (phy stat 00000000)
scsi5 : sata_sil
ata7: no device found (phy stat 00000000)
scsi6 : sata_sil
ata8: no device found (phy stat 00000000)
scsi7 : sata_sil
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 < sda5 sda6 sda7 sda8 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2 < sdb5 sdb6 sdb7 sdb8 >
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0

