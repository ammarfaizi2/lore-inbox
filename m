Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751482AbWJ1BFG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbWJ1BFG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 21:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbWJ1BFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 21:05:06 -0400
Received: from wx-out-0506.google.com ([66.249.82.228]:52490 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751482AbWJ1BFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 21:05:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tUQTmWlz/XvKFC3s8qARw0U3/W7euuz8/Titnkq1E3dial4kImPqzYtqLnx3BCDocwUkf2Q6uIM+ie0xf1W01bLeTBfxW/Dwm/YbJsIA/ULdUqcWkOVA0T3PWP90XAQ9WSDAcrVzZ1YogJXeD2ivG1BBk4Ge7Vgewgkew1QySRc=
Message-ID: <b6a2187b0610271805w154ca251tb7db33ed0926623@mail.gmail.com>
Date: Sat, 28 Oct 2006 09:05:01 +0800
From: "Jeff Chua" <jeff.chua.linux@gmail.com>
To: "Adrian Bunk" <bunk@stusta.de>
Subject: Re: linux-2.6.19-rc2 tg3 problem
Cc: linux-kernel@vger.kernel.org, "David Miller" <davem@davemloft.net>
In-Reply-To: <20061027203109.GZ27968@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <b6a2187b0610230824m38ce6fb2j65cd26099e982449@mail.gmail.com>
	 <20061025013022.GG27968@stusta.de>
	 <b6a2187b0610251754x7dc2c51aoad2244b8cdcb1c09@mail.gmail.com>
	 <20061026152455.GI27968@stusta.de>
	 <b6a2187b0610270649t4cc71781y8e1695f02e1c608e@mail.gmail.com>
	 <20061027203109.GZ27968@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/06, Adrian Bunk <bunk@stusta.de> wrote:

> That's still pretty terse...
> If there is anything interesting in the dmesg, it's above this point
> (Please send complete "dmesg -s 1000000" for both cases).


The working one (2.6.18) ...

Linux version 2.6.18 (root@indiana.corp.fedex.com) (gcc version 3.4.5) #3 SMP PR
EEMPT Fri Oct 27 14:39:13 SGT 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000df686c00 (usable)
 BIOS-e820: 00000000df686c00 - 00000000df688c00 (ACPI NVS)
 BIOS-e820: 00000000df688c00 - 00000000df68ac00 (ACPI data)
 BIOS-e820: 00000000df68ac00 - 00000000e0000000 (reserved)
 BIOS-e820: 00000000f0000000 - 00000000f4000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fed00400 (reserved)
 BIOS-e820: 00000000fed20000 - 00000000feda0000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fef00000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
2678MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000fe710
On node 0 totalpages: 915078
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 685702 pages, LIFO batch:31
DMI 2.3 present.
ACPI: RSDP (v002 DELL                                  ) @ 0x000feb00
ACPI: XSDT (v001 DELL    GX620   0x00000007 ASL  0x00000061) @ 0x000fd253
ACPI: FADT (v003 DELL    GX620   0x00000007 ASL  0x00000061) @ 0x000fd34b
ACPI: SSDT (v001   DELL    st_ex 0x00001000 INTL 0x20050309) @ 0xfffd6996
ACPI: MADT (v001 DELL    GX620   0x00000007 ASL  0x00000061) @ 0x000fd43f
ACPI: BOOT (v001 DELL    GX620   0x00000007 ASL  0x00000061) @ 0x000fd4b1
ACPI: ASF! (v016 DELL    GX620   0x00000007 ASL  0x00000061) @ 0x000fd4d9
ACPI: MCFG (v001 DELL    GX620   0x00000007 ASL  0x00000061) @ 0x000fd540
ACPI: HPET (v001 DELL    GX620   0x00000007 ASL  0x00000061) @ 0x000fd57e
ACPI: SSDT (v001 DpgPmm  Cpu0Ist 0x00000011 INTL 0x20050309) @ 0xdf686c40
ACPI: SSDT (v001 DpgPmm  Cpu1Ist 0x00000011 INTL 0x20050309) @ 0xdf687049
ACPI: SSDT (v001 DpgPmm    CpuPm 0x00000010 INTL 0x20050309) @ 0xdf687452
ACPI: DSDT (v001   DELL    dt_ex 0x00001000 INTL 0x20050309) @ 0x00000000
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x05] disabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x07] disabled)
ACPI: LAPIC_NMI (acpi_id[0xff] high level lint[0x1])
ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
ACPI: HPET id: 0x8086a201 base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at e1000000 (gap: e0000000:10000000)
Detected 2992.720 MHz processor.
Built 1 zonelists.  Total pages: 915078
Kernel command line: BOOT_IMAGE=(hd0,1)/linux/bzc1 root=/dev/sda2 resume=/dev/sd
a3 pci=routeirq ata2=noprobe
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 3626308k/3660312k available (2077k kernel code, 32932k reserved, 816k da
ta, 184k init, 2742808k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Using HPET for base-timer
Calibrating delay using timer specific routine.. 5990.39 BogoMIPS (lpj=11980799)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 20100000 00000000 00000000 0000649d
00000000 00000001
CPU: After vendor identify, caps: bfebfbff 20100000 00000000 00000000 0000649d 0
0000000 00000001
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU: After all inits, caps: bfebfbff 20100000 00000000 00000180 0000649d 0000000
0 00000001
Compat vDSO mapped to ffffe000.
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
ACPI: Core revision 20060707
CPU0: Intel(R) Pentium(R) D CPU 3.00GHz stepping 07
SMP alternatives: switching to SMP code
Booting processor 1/1 eip 3000
Initializing CPU#1
Calibrating delay using timer specific routine.. 5985.38 BogoMIPS (lpj=11970772)
CPU: After generic identify, caps: bfebfbff 20100000 00000000 00000000 0000649d
00000000 00000001
CPU: After vendor identify, caps: bfebfbff 20100000 00000000 00000000 0000649d 0
0000000 00000001
monitor/mwait feature present.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
CPU: After all inits, caps: bfebfbff 20100000 00000000 00000180 0000649d 0000000
0 00000001
Total of 2 processors activated (11975.78 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
migration_cost=325
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
Boot video device is 0000:00:02.0
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI4._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI2._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI3._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs *3 4 5 6 7 9 10 11 12 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 11 12 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 7 9 10 11 12 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 *9 10 11 12 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 *5 6 7 9 10 11 12 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 *10 11 12 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 10 devices
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: Routing PCI interrupts for all devices because "pci=routeirq" specified
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 17 (level, low) -> IRQ 17
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 21 (level, low) -> IRQ 18
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 22 (level, low) -> IRQ 19
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 20
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 23 (level, low) -> IRQ 21
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 21 (level, low) -> IRQ 18
ACPI: PCI Interrupt 0000:00:1e.2[A] -> GSI 23 (level, low) -> IRQ 21
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI Interrupt 0000:00:1f.2[C] -> GSI 20 (level, low) -> IRQ 22
ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 17 (level, low) -> IRQ 17
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 16
NET: Registered protocol family 23
pnp: 00:01: ioport range 0x800-0x85f could not be reserved
pnp: 00:01: ioport range 0xc00-0xc7f has been reserved
pnp: 00:01: ioport range 0x860-0x8ff has been reserved
pnp: 00:09: ioport range 0x100-0x1fe has been reserved
pnp: 00:09: ioport range 0x200-0x277 has been reserved
pnp: 00:09: ioport range 0x280-0x2e7 has been reserved
pnp: 00:09: ioport range 0x2f0-0x2f7 has been reserved
pnp: 00:09: ioport range 0x300-0x377 has been reserved
pnp: 00:09: ioport range 0x380-0x3bb has been reserved
pnp: 00:09: ioport range 0x3c0-0x3e7 could not be reserved
pnp: 00:09: ioport range 0x3f6-0x3f7 has been reserved
PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: fe900000-fe9fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.0
  IO window: disabled.
  MEM window: fe800000-fe8fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.1
  IO window: disabled.
  MEM window: fe700000-fe7fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:01.0 to 64
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1c.0 to 64
ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1c.1 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 262144 (order: 9, 3145728 bytes)
TCP bind hash table entries: 65536 (order: 7, 786432 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
Simple Boot Flag at 0x7a set to 0x1
apm: disabled - APM is not SMP safe.
highmem bounce pool size: 64 pages
Total HugeTLB memory allocated, 0
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [VBTN]
ACPI Exception (acpi_processor-0681): AE_NOT_FOUND, Processor Device is not pres
ent [20060707]
ACPI: Getting cpuindex for acpiid 0x3
ACPI Exception (acpi_processor-0681): AE_NOT_FOUND, Processor Device is not pres
ent [20060707]
ACPI: Getting cpuindex for acpiid 0x4
ibm_acpi: ec object not found
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 945G Chipset.
agpgart: Detected 7932K stolen memory.
agpgart: AGP aperture is 256M @ 0xe0000000
[drm] Initialized drm 1.0.1 20051102
RAMDISK driver initialized: 16 RAM disks of 20480K size 1024 blocksize
loop: loaded (max 8 devices)
HP CISS Driver (v 3.6.10)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH7: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 16 (level, low) -> IRQ 16
ICH7: chipset revision 1
ICH7: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
Probing IDE interface ide0...
hda: HL-DT-ST DVD+/-RW GWA4164B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
megaraid cmm: 2.20.2.7 (Release Date: Sun Jul 16 00:01:03 EST 2006)
megaraid: 2.20.4.9 (Release Date: Sun Jul 16 12:27:22 EST 2006)
megasas: 00.00.03.01 Sun May 14 22:49:52 PDT 2006
libata version 2.00 loaded.
ata_piix 0000:00:1f.2: version 2.00
ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
ACPI: PCI Interrupt 0000:00:1f.2[C] -> GSI 20 (level, low) -> IRQ 22
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0xFE00 ctl 0xFE12 bmdma 0xFEA0 irq 22
ata2: SATA max UDMA/133 cmd 0xFE20 ctl 0xFE32 bmdma 0xFEA8 irq 22
scsi0 : ata_piix
ata1.00: ATA-7, max UDMA/133, 488281250 sectors: LBA48 NCQ (depth 0/32)
ata1.00: ata1: dev 0 multi count 8
ata1.01: ATA-7, max UDMA/133, 488281250 sectors: LBA48 NCQ (depth 0/32)
ata1.01: ata1: dev 1 multi count 8
ata1.00: configured for UDMA/133
ata1.01: configured for UDMA/133
scsi1 : ata_piix
ata2: port is slow to respond, please be patient
ata2: port failed to respond (30 secs)
ata2: SRST failed (status 0xFF)
ata2: SRST failed (err_mask=0x100)
ata2: softreset failed, retrying in 5 secs
ata2: SRST failed (status 0xFF)
ata2: SRST failed (err_mask=0x100)
ata2: softreset failed, retrying in 5 secs
ata2: SRST failed (status 0xFF)
ata2: SRST failed (err_mask=0x100)
ata2: reset failed, giving up
  Vendor: ATA       Model: WDC WD2500JS-75N  Rev: 10.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: WDC WD2500JS-75N  Rev: 10.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 488281250 512-byte hdwr sectors (250000 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 488281250 512-byte hdwr sectors (250000 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 sda9 sda10 sda11 sda12 sda13 sda
14 sda15 >
sd 0:0:0:0: Attached scsi disk sda
SCSI device sdb: 488281250 512-byte hdwr sectors (250000 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 488281250 512-byte hdwr sectors (250000 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb:
sd 0:0:1:0: Attached scsi disk sdb
usbmon: debugfs is not available
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 21 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 18, io mem 0xffa80800
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 21 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 18, io base 0x0000ff80
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 22 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000ff60
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 20, io base 0x0000ff40
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 23 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.3: irq 21, io base 0x0000ff20
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
usb 4-1: new low speed USB device using uhci_hcd and address 2
usb 4-1: configuration #1 chosen from 1 choice
usb 4-2: new low speed USB device using uhci_hcd and address 3
usb 4-2: configuration #1 chosen from 1 choice
usbcore: registered new driver hiddev
input: Dell Dell USB Keyboard as /class/input/input0
input: USB HID v1.10 Keyboard [Dell Dell USB Keyboard] on usb-0000:00:1d.2-1
input: USB Optical Mouse as /class/input/input1
input: USB HID v1.11 Mouse [USB Optical Mouse] on usb-0000:00:1d.2-2
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
device-mapper: ioctl: 4.7.0-ioctl (2006-06-24) initialised: dm-devel@redhat.com
EDAC MC: Ver: 2.0.1 Oct 27 2006
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Starting balanced_irq
Using IPI No-Shortcut mode
Time: tsc clocksource has been installed.
ACPI: (supports S0 S1 S3 S4 S5)
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 184k freed
Adding 7823644k swap on /dev/sda3.  Priority:-1 extents:1 across:7823644k
tg3.c:v3.65 (August 07, 2006)
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:02:00.0 to 64
eth0: Tigon3 [partno(BCM5751PKFBG) rev 4001 PHY(5750)] (PCI Express) 10/100/1000
BaseT Ethernet 00:13:72:7b:2a:f0
eth0: RXcsums[1] LinkChgREG[1] MIirq[1] ASF[0] Split[0] WireSpeed[1] TSOcap[1]
eth0: dma_rwctrl[76180000] dma_mask[64-bit]
ip_tables: (C) 2000-2006 Netfilter Core Team
ip_conntrack version 2.4 (8192 buckets, 65536 max) - 224 bytes per conntrack
tg3: eth0: Link is up at 100 Mbps, full duplex.
tg3: eth0: Flow control is on for TX and on for RX.




The bad one (2.6.19-rc1) "diff" ..

# diff dmesg-2.6.18 dmesg-2.6.19-rc1
1c1
< Linux version 2.6.18 (root@indiana.corp.fedex.com) (gcc version
3.4.5) #3 SMP PREEMPT Fri Oct 27 14:39:13 SGT 2006
---
> Linux version 2.6.19-rc1 (root@indiana.corp.fedex.com) (gcc version 3.4.5) #1 SMP PREEMPT Fri Oct 27 15:43:45 SGT 2006
16a17,23
> Entering add_active_range(0, 0, 915078) 0 entries of 256 used
> Zone PFN ranges:
>   DMA             0 ->     4096
>   Normal       4096 ->   229376
>   HighMem    229376 ->   915078
> early_node_map[1] active PFN ranges
>     0:        0 ->   915078
18,20c25,31
<   DMA zone: 4096 pages, LIFO batch:0
<   Normal zone: 225280 pages, LIFO batch:31
<   HighMem zone: 685702 pages, LIFO batch:31
---
>   DMA zone: 32 pages used for memmap
>   DMA zone: 0 pages reserved
>   DMA zone: 4064 pages, LIFO batch:0
>   Normal zone: 1760 pages used for memmap
>   Normal zone: 223520 pages, LIFO batch:31
>   HighMem zone: 5357 pages used for memmap
>   HighMem zone: 680345 pages, LIFO batch:31
55,56c66,67
< Detected 2992.720 MHz processor.
< Built 1 zonelists.  Total pages: 915078
---
> Detected 2992.858 MHz processor.
> Built 1 zonelists.  Total pages: 907929
67c78,86
< Memory: 3626308k/3660312k available (2077k kernel code, 32932k
reserved, 816k data, 184k init, 2742808k highmem)
---
> Memory: 3626280k/3660312k available (2110k kernel code, 32960k reserved, 828k data, 184k init, 2742808k highmem)
> virtual kernel memory layout:
>     fixmap  : 0xfff4f000 - 0xfffff000   ( 704 kB)
>     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
>     vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
>     lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
>       .init : 0xc03e5000 - 0xc0413000   ( 184 kB)
>       .data : 0xc030fab4 - 0xc03deab4   ( 828 kB)
>       .text : 0xc0100000 - 0xc030fab4   (2110 kB)
70c89
< Calibrating delay using timer specific routine.. 5990.39 BogoMIPS
(lpj=11980799)
---
> Calibrating delay using timer specific routine.. 5990.51 BogoMIPS (lpj=11981021)
73d91
< CPU: After vendor identify, caps: bfebfbff 20100000 00000000
00000000 0000649d 00000000 00000001
89c107
< Calibrating delay using timer specific routine.. 5985.38 BogoMIPS
(lpj=11970772)
---

> Calibrating delay using timer specific routine.. 5985.38 BogoMIPS (lpj=11970761)
91d108
< CPU: After vendor identify, caps: bfebfbff 20100000 00000000
00000000 0000649d 00000000 00000001
99c116
< Total of 2 processors activated (11975.78 BogoMIPS).
---
> Total of 2 processors activated (11975.89 BogoMIPS).
104c121
< migration_cost=325
---
> migration_cost=327
134,135c151,153
< usbcore: registered new driver usbfs
< usbcore: registered new driver hub
---
> usbcore: registered new interface driver usbfs
> usbcore: registered new interface driver hub
> usbcore: registered new device driver usb
151a170,179
> PCI: Cannot allocate resource region 8 of bridge 0000:00:01.0
> PCI: Cannot allocate resource region 8 of bridge 0000:00:1c.0
> PCI: Cannot allocate resource region 8 of bridge 0000:00:1c.1
> PCI: Cannot allocate resource region 0 of device 0000:00:02.0
> PCI: Cannot allocate resource region 3 of device 0000:00:02.0
> PCI: Cannot allocate resource region 0 of device 0000:00:02.1
> PCI: Cannot allocate resource region 0 of device 0000:00:1d.7

> PCI: Cannot allocate resource region 2 of device 0000:00:1e.2
> PCI: Cannot allocate resource region 3 of device 0000:00:1e.2
> PCI: Cannot allocate resource region 0 of device 0000:02:00.0
164a193,199
> PCI: Failed to allocate mem resource #8:100000@e1000000 for 0000:00:1c.0
> PCI: Failed to allocate mem resource #0:80000@e1000000 for 0000:00:02.0
> PCI: Failed to allocate mem resource #0:80000@e1000000 for 0000:00:02.1
> PCI: Failed to allocate mem resource #3:40000@e1000000 for 0000:00:02.0
> PCI: Failed to allocate mem resource #0:400@e1000000 for 0000:00:1d.7
> PCI: Failed to allocate mem resource #2:200@e1000000 for 0000:00:1e.2
> PCI: Failed to allocate mem resource #3:100@e1000000 for 0000:00:1e.2
167c202
<   MEM window: fe900000-fe9fffff
---
>   MEM window: disabled.
168a204
> PCI: Failed to allocate mem resource #0:10000@0 for 0000:02:00.0
171c207
<   MEM window: fe800000-fe8fffff
---
>   MEM window: disabled.
175c211
<   MEM window: fe700000-fe7fffff
---
>   MEM window: disabled.
198d233< Initializing Cryptographic API
233c268
< megasas: 00.00.03.01 Sun May 14 22:49:52 PDT 2006
---
> megasas: 00.00.03.05 Mon Oct 02 11:21:32 PDT 2006
235c270
< ata_piix 0000:00:1f.2: version 2.00
---
> ata_piix 0000:00:1f.2: version 2.00ac6
249,250c284,285
< ata2: port is slow to respond, please be patient
< ata2: port failed to respond (30 secs)
---
> ata2: port is slow to respond, please be patient (Status 0xff)
> ata2: port failed to respond (30 secs, Status 0xff)
260,263c295
<   Vendor: ATA       Model: WDC WD2500JS-75N  Rev: 10.0
<   Type:   Direct-Access                      ANSI SCSI revision: 05
<   Vendor: ATA       Model: WDC WD2500JS-75N  Rev: 10.0
<   Type:   Direct-Access                      ANSI SCSI revision: 05
---
> scsi 0:0:0:0: Direct-Access     ATA      WDC WD2500JS-75N 10.0 PQ: 0 ANSI: 5
273a306
> scsi 0:0:1:0: Direct-Access     ATA      WDC WD2500JS-75N 10.0 PQ: 0 ANSI: 5
286,295c319,321
< PCI: Setting latency timer of device 0000:00:1d.7 to 64
< ehci_hcd 0000:00:1d.7: EHCI Host Controller
< ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
< ehci_hcd 0000:00:1d.7: debug port 1
< PCI: cache line size of 128 is not supported by device 0000:00:1d.7
< ehci_hcd 0000:00:1d.7: irq 18, io mem 0xffa80800
< ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
< usb usb1: configuration #1 chosen from 1 choice
< hub 1-0:1.0: USB hub found
< hub 1-0:1.0: 8 ports detected
---
> ACPI: PCI interrupt for device 0000:00:1d.7 disabled
> ehci_hcd 0000:00:1d.7: init 0000:00:1d.7 fail, -16
> ehci_hcd: probe of 0000:00:1d.7 failed with error -16
300c326
< uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
---
> uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
302,304c328,330
< usb usb2: configuration #1 chosen from 1 choice
< hub 2-0:1.0: USB hub found
< hub 2-0:1.0: 2 ports detected
---
> usb usb1: configuration #1 chosen from 1 choice
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 2 ports detected
308c334
< uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
---
> uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
310,312c336,338
< usb usb3: configuration #1 chosen from 1 choice
< hub 3-0:1.0: USB hub found
< hub 3-0:1.0: 2 ports detected
---
> usb usb2: configuration #1 chosen from 1 choice
> hub 2-0:1.0: USB hub found
> hub 2-0:1.0: 2 ports detected
316c342
< uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
---
> uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
318,320c344,346
< usb usb4: configuration #1 chosen from 1 choice
< hub 4-0:1.0: USB hub found
< hub 4-0:1.0: 2 ports detected
---
> usb usb3: configuration #1 chosen from 1 choice
> hub 3-0:1.0: USB hub found
> hub 3-0:1.0: 2 ports detected
324c350
< uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
---
> uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
326,333c352,359
< usb usb5: configuration #1 chosen from 1 choice
< hub 5-0:1.0: USB hub found
< hub 5-0:1.0: 2 ports detected
< usb 4-1: new low speed USB device using uhci_hcd and address 2
< usb 4-1: configuration #1 chosen from 1 choice
< usb 4-2: new low speed USB device using uhci_hcd and address 3
< usb 4-2: configuration #1 chosen from 1 choice
< usbcore: registered new driver hiddev
---
> usb usb4: configuration #1 chosen from 1 choice
> hub 4-0:1.0: USB hub found
> hub 4-0:1.0: 2 ports detected
> usb 3-1: new low speed USB device using uhci_hcd and address 2
> usb 3-1: configuration #1 chosen from 1 choice
> usb 3-2: new low speed USB device using uhci_hcd and address 3
> usb 3-2: configuration #1 chosen from 1 choice
> usbcore: registered new interface driver hiddev
338c364
< usbcore: registered new driver usbhid
---
> usbcore: registered new interface driver usbhid
341d366
< serio: i8042 AUX port at 0x60,0x64 irq 12
342a368
> serio: i8042 AUX port at 0x60,0x64 irq 12
344c370
< device-mapper: ioctl: 4.7.0-ioctl (2006-06-24) initialised:
dm-devel@redhat.com
---
> device-mapper: ioctl: 4.10.0-ioctl (2006-09-14) initialised: dm-devel@redhat.com
346c372
< TCP bic registered
---
> TCP cubic registered
356c382
< tg3.c:v3.65 (August 07, 2006)
---
> tg3.c:v3.66 (September 23, 2006)
358,361c384,385
< PCI: Setting latency timer of device 0000:02:00.0 to 64
< eth0: Tigon3 [partno(BCM5751PKFBG) rev 4001 PHY(5750)] (PCI Express)
10/100/1000BaseT Ethernet 00:13:72:7b:2a:f0
< eth0: RXcsums[1] LinkChgREG[1] MIirq[1] ASF[0] Split[0] WireSpeed[1]
TSOcap[1]
< eth0: dma_rwctrl[76180000] dma_mask[64-bit]
---
> tg3: Cannot find proper PCI device base address, aborting.
> ACPI: PCI interrupt for device 0000:02:00.0 disabled
363,365c387
< ip_conntrack version 2.4 (8192 buckets, 65536 max) - 224 bytes per conntrack
< tg3: eth0: Link is up at 100 Mbps, full duplex.
< tg3: eth0: Flow control is on for TX and on for RX.
---
> ip_conntrack version 2.4 (8192 buckets, 65536 max) - 228 bytes per conntrack


> If this won't help, the next step will be to bisect for the commit that
> broke it for you.

Ok, let me know if the above doesn't help ...


Thanks,
Jeff.
