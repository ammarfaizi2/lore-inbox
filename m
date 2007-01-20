Return-Path: <linux-kernel-owner+w=401wt.eu-S965355AbXATTfn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965355AbXATTfn (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 14:35:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965360AbXATTfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 14:35:43 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:39158 "EHLO
	ms-smtp-01.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965355AbXATTfl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 14:35:41 -0500
Message-ID: <023c01c73cca$20bc2510$84163e05@kroptech.com>
From: "Adam Kropelin" <akropel1@rochester.rr.com>
To: <linux-pci@atrey.karlin.mff.cuni.cz>
Cc: "Auke Kok" <auke-jan.h.kok@intel.com>, <linux-kernel@vger.kernel.org>
Subject: Re: MSI failure on nForce 430 (WAS: intel 82571EB gigabit fails to see link on 2.6.20-rc5 in-tree e1000 driver (regression))
Date: Sat, 20 Jan 2007 14:35:23 -0500
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0239_01C73CA0.37D7C530"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.3028
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.3028
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0239_01C73CA0.37D7C530
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit

Adam Kropelin wrote:
> I've attached the contents dmesg, 'lspci -vvv', and 'cat
> /proc/interrupts' from 2.6.20-rc5.

Actually attached this time.

--Adam

------=_NextPart_000_0239_01C73CA0.37D7C530
Content-Type: application/octet-stream;
	name="proc-irq-2.6.20-rc5"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="proc-irq-2.6.20-rc5"

           CPU0       CPU1       =0A=
  0:   80667031     398973    XT-PIC-XT        timer=0A=
  1:          2          0   IO-APIC-edge      i8042=0A=
  6:          5          0   IO-APIC-edge      floppy=0A=
  8:          1          0   IO-APIC-edge      rtc=0A=
  9:          0          0   IO-APIC-fasteoi   acpi=0A=
 12:          7          0   IO-APIC-edge      i8042=0A=
 19:      10264          0   IO-APIC-fasteoi   eth0=0A=
 20:          0          0   IO-APIC-fasteoi   libata=0A=
 21:     933830          0   IO-APIC-fasteoi   libata=0A=
 22:          2          0   IO-APIC-fasteoi   ehci_hcd:usb2=0A=
 23:       1754          0   IO-APIC-fasteoi   ohci_hcd:usb1, HDA Intel=0A=
8412:          0          0   PCI-MSI-edge      eth1=0A=
NMI:       1756       1254 =0A=
LOC:   81066172   81066123 =0A=
ERR:          0=0A=

------=_NextPart_000_0239_01C73CA0.37D7C530
Content-Type: application/octet-stream;
	name="dmesg-2.6.20-rc5"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="dmesg-2.6.20-rc5"

Linux version 2.6.20-rc5 (adk0212@devbox3) (gcc version 4.1.1 20061011 =
(Red Hat 4.1.1-30)) #1 SMP Sun Jan 14 13:14:52 EST 2007=0A=
Command line: ro root=3D/dev/sda3=0A=
BIOS-provided physical RAM map:=0A=
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)=0A=
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)=0A=
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)=0A=
 BIOS-e820: 0000000000100000 - 000000003bee0000 (usable)=0A=
 BIOS-e820: 000000003bee0000 - 000000003bee3000 (ACPI NVS)=0A=
 BIOS-e820: 000000003bee3000 - 000000003bef0000 (ACPI data)=0A=
 BIOS-e820: 000000003bef0000 - 000000003bf00000 (reserved)=0A=
 BIOS-e820: 000000003c000000 - 0000000040000000 (reserved)=0A=
 BIOS-e820: 00000000f0000000 - 00000000f4000000 (reserved)=0A=
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)=0A=
Entering add_active_range(0, 0, 159) 0 entries of 3200 used=0A=
Entering add_active_range(0, 256, 245472) 1 entries of 3200 used=0A=
end_pfn_map =3D 1048576=0A=
DMI 2.4 present.=0A=
ACPI: RSDP (v000 DELL                                  ) @ =
0x00000000000f83d0=0A=
ACPI: RSDT (v001 DELL    bMk     0x42302e31 AWRD 0x00000000) @ =
0x000000003bee3040=0A=
ACPI: FADT (v001 DELL    bMk     0x42302e31 AWRD 0x00000000) @ =
0x000000003bee3100=0A=
ACPI: BOOT (v001 DELL    bMk     0x42302e31 AWRD 0x00000000) @ =
0x000000003bee8b40=0A=
ACPI: SSDT (v001 PTLTD  POWERNOW 0x00000001  LTP 0x00000001) @ =
0x000000003bee8c80=0A=
ACPI: HPET (v001 DELL    bMk     0x42302e31 AWRD 0x00000098) @ =
0x000000003bee8ec0=0A=
ACPI: MCFG (v001 DELL    bMk     0x42302e31 AWRD 0x00000000) @ =
0x000000003bee8f40=0A=
ACPI: SLIC (v001 DELL    bMk     0x42302e31 AWRD 0x0100000e) @ =
0x000000003bee8fc0=0A=
ACPI: MADT (v001 DELL    bMk     0x42302e31 AWRD 0x00000000) @ =
0x000000003bee8bc0=0A=
ACPI: DSDT (v001 DELL    BMK     0x00001000 MSFT 0x0100000e) @ =
0x0000000000000000=0A=
Scanning NUMA topology in Northbridge 24=0A=
Number of nodes 1=0A=
Node 0 MemBase 0000000000000000 Limit 000000003bee0000=0A=
Entering add_active_range(0, 0, 159) 0 entries of 3200 used=0A=
Entering add_active_range(0, 256, 245472) 1 entries of 3200 used=0A=
NUMA: Using 63 for the hash shift.=0A=
Using node hash shift of 63=0A=
Bootmem setup node 0 0000000000000000-000000003bee0000=0A=
Zone PFN ranges:=0A=
  DMA             0 ->     4096=0A=
  DMA32        4096 ->  1048576=0A=
  Normal    1048576 ->  1048576=0A=
early_node_map[2] active PFN ranges=0A=
    0:        0 ->      159=0A=
    0:      256 ->   245472=0A=
On node 0 totalpages: 245375=0A=
  DMA zone: 56 pages used for memmap=0A=
  DMA zone: 24 pages reserved=0A=
  DMA zone: 3919 pages, LIFO batch:0=0A=
  DMA32 zone: 3300 pages used for memmap=0A=
  DMA32 zone: 238076 pages, LIFO batch:31=0A=
  Normal zone: 0 pages used for memmap=0A=
ACPI: PM-Timer IO Port: 0x1008=0A=
ACPI: Local APIC address 0xfee00000=0A=
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)=0A=
Processor #0 (Bootup-CPU)=0A=
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)=0A=
Processor #1=0A=
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])=0A=
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])=0A=
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])=0A=
IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23=0A=
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)=0A=
ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)=0A=
ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)=0A=
ACPI: IRQ9 used by override.=0A=
ACPI: IRQ14 used by override.=0A=
ACPI: IRQ15 used by override.=0A=
Setting APIC routing to physical flat=0A=
ACPI: HPET id: 0x10b9a201 base: 0xfeff0000=0A=
Using ACPI (MADT) for SMP configuration information=0A=
Nosave address range: 000000000009f000 - 00000000000a0000=0A=
Nosave address range: 00000000000a0000 - 00000000000f0000=0A=
Nosave address range: 00000000000f0000 - 0000000000100000=0A=
Allocating PCI resources starting at 50000000 (gap: 40000000:b0000000)=0A=
SMP: Allowing 2 CPUs, 0 hotplug CPUs=0A=
PERCPU: Allocating 67136 bytes of per cpu data=0A=
Built 1 zonelists.  Total pages: 241995=0A=
Kernel command line: ro root=3D/dev/sda3=0A=
Initializing CPU#0=0A=
PID hash table entries: 4096 (order: 12, 32768 bytes)=0A=
Console: colour VGA+ 80x25=0A=
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)=0A=
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)=0A=
Checking aperture...=0A=
CPU 0: aperture @ 98c4000000 size 32 MB=0A=
Aperture too small (32 MB)=0A=
No AGP bridge found=0A=
Memory: 956760k/981888k available (2490k kernel code, 24740k reserved, =
1267k data, 344k init)=0A=
Calibrating delay using timer specific routine.. 4012.35 BogoMIPS =
(lpj=3D2006179)=0A=
Security Framework v1.0.0 initialized=0A=
SELinux:  Initializing.=0A=
SELinux:  Starting in permissive mode=0A=
selinux_register_security:  Registering secondary module capability=0A=
Capability LSM initialized as secondary=0A=
Mount-cache hash table entries: 256=0A=
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)=0A=
CPU: L2 Cache: 512K (64 bytes/line)=0A=
CPU 0/0 -> Node 0=0A=
CPU: Physical Processor ID: 0=0A=
CPU: Processor Core ID: 0=0A=
SMP alternatives: switching to UP code=0A=
ACPI: Core revision 20060707=0A=
..MP-BIOS bug: 8254 timer not connected to IO-APIC=0A=
Using local APIC timer interrupts.=0A=
result 12526135=0A=
Detected 12.526 MHz APIC timer.=0A=
SMP alternatives: switching to SMP code=0A=
Booting processor 1/2 APIC 0x1=0A=
Initializing CPU#1=0A=
Calibrating delay using timer specific routine.. 4013.92 BogoMIPS =
(lpj=3D2006961)=0A=
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)=0A=
CPU: L2 Cache: 512K (64 bytes/line)=0A=
CPU 1/1 -> Node 0=0A=
CPU: Physical Processor ID: 0=0A=
CPU: Processor Core ID: 1=0A=
AMD Athlon(tm) 64 X2 Dual Core Processor 3800+ stepping 02=0A=
CPU 1: Syncing TSC to CPU 0.=0A=
CPU 1: synchronized TSC with CPU 0 (last diff 1 cycles, maxerr 491 =
cycles)=0A=
Brought up 2 CPUs=0A=
testing NMI watchdog ... OK.=0A=
time.c: Using 25.000000 MHz WALL HPET GTOD HPET timer.=0A=
time.c: Detected 2004.179 MHz processor.=0A=
migration_cost=3D327=0A=
NET: Registered protocol family 16=0A=
No dock devices found.=0A=
ACPI: bus type pci registered=0A=
PCI: Using MMCONFIG at f0000000=0A=
PCI: No mmconfig possible on device 00:18=0A=
ACPI: Interpreter enabled=0A=
ACPI: Using IOAPIC for interrupt routing=0A=
ACPI: PCI Root Bridge [PCI0] (0000:00)=0A=
PCI: Probing PCI hardware (bus 00)=0A=
Boot video device is 0000:00:05.0=0A=
PCI: Transparent bridge - 0000:00:10.0=0A=
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]=0A=
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]=0A=
ACPI: PCI Interrupt Link [LNK1] (IRQs 5 7 9 10 11 14 15) *0, disabled.=0A=
ACPI: PCI Interrupt Link [LNK2] (IRQs 5 7 9 10 11 14 15) *0, disabled.=0A=
ACPI: PCI Interrupt Link [LNK3] (IRQs 5 7 9 10 11 14 15) *0, disabled.=0A=
ACPI: PCI Interrupt Link [LNK4] (IRQs *5 7 9 10 11 14 15)=0A=
ACPI: PCI Interrupt Link [LNK5] (IRQs 5 7 9 10 11 14 15) *0, disabled.=0A=
ACPI: PCI Interrupt Link [LNK6] (IRQs 5 *7 9 10 11 14 15)=0A=
ACPI: PCI Interrupt Link [LNK7] (IRQs 5 7 9 10 *11 14 15)=0A=
ACPI: PCI Interrupt Link [LNK8] (IRQs 5 7 9 10 11 14 15) *0, disabled.=0A=
ACPI: PCI Interrupt Link [LUBA] (IRQs 5 7 9 10 11 14 *15)=0A=
ACPI: PCI Interrupt Link [LUBB] (IRQs 5 7 9 10 11 14 15) *0, disabled.=0A=
ACPI: PCI Interrupt Link [LMAC] (IRQs *5 7 9 10 11 14 15)=0A=
ACPI: PCI Interrupt Link [LACI] (IRQs 5 7 9 10 11 14 15) *0, disabled.=0A=
ACPI: PCI Interrupt Link [LAZA] (IRQs 5 7 9 *10 11 14 15)=0A=
ACPI: PCI Interrupt Link [LPMU] (IRQs 5 *7 9 10 11 14 15)=0A=
ACPI: PCI Interrupt Link [LMCI] (IRQs 5 7 9 10 11 14 15) *0, disabled.=0A=
ACPI: PCI Interrupt Link [LSMB] (IRQs 5 7 9 *10 11 14 15)=0A=
ACPI: PCI Interrupt Link [LUB2] (IRQs *5 7 9 10 11 14 15)=0A=
ACPI: PCI Interrupt Link [LIDE] (IRQs 5 7 9 10 11 14 15) *0, disabled.=0A=
ACPI: PCI Interrupt Link [LSID] (IRQs 5 7 9 10 *11 14 15)=0A=
ACPI: PCI Interrupt Link [LFID] (IRQs 5 7 9 *10 11 14 15)=0A=
ACPI: PCI Interrupt Link [APC1] (IRQs 16) *0, disabled.=0A=
ACPI: PCI Interrupt Link [APC2] (IRQs 17) *0, disabled.=0A=
ACPI: PCI Interrupt Link [APC3] (IRQs 18) *0, disabled.=0A=
ACPI: PCI Interrupt Link [APC4] (IRQs 19) *0, disabled.=0A=
ACPI: PCI Interrupt Link [APC5] (IRQs 16) *0, disabled.=0A=
ACPI: PCI Interrupt Link [APC6] (IRQs 16) *0, disabled.=0A=
ACPI: PCI Interrupt Link [APC7] (IRQs 16) *0, disabled.=0A=
ACPI: PCI Interrupt Link [APC8] (IRQs 16) *0, disabled.=0A=
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22 23) *0, disabled.=0A=
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22 23) *0, disabled.=0A=
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22 23) *0, disabled.=0A=
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22 23) *0, disabled.=0A=
ACPI: PCI Interrupt Link [APMU] (IRQs 20 21 22 23) *0, disabled.=0A=
ACPI: PCI Interrupt Link [AAZA] (IRQs 20 21 22 23) *0, disabled.=0A=
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22 23) *0, disabled.=0A=
ACPI: PCI Interrupt Link [APCS] (IRQs 20 21 22 23) *0, disabled.=0A=
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22 23) *0, disabled.=0A=
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22 23) *0, disabled.=0A=
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22 23) *0, disabled.=0A=
ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22 23) *0, disabled.=0A=
ACPI: PCI Interrupt Link [APSJ] (IRQs 20 21 22 23) *0, disabled.=0A=
Linux Plug and Play Support v0.97 (c) Adam Belay=0A=
pnp: PnP ACPI init=0A=
pnp: PnP ACPI: found 10 devices=0A=
SCSI subsystem initialized=0A=
libata version 2.00 loaded.=0A=
usbcore: registered new interface driver usbfs=0A=
usbcore: registered new interface driver hub=0A=
usbcore: registered new device driver usb=0A=
PCI: Using ACPI for IRQ routing=0A=
PCI: If a device doesn't work, try "pci=3Drouteirq".  If it helps, post =
a report=0A=
NetLabel: Initializing=0A=
NetLabel:  domain hash size =3D 128=0A=
NetLabel:  protocols =3D UNLABELED CIPSOv4=0A=
NetLabel:  unlabeled traffic allowed by default=0A=
hpet0: at MMIO 0xfeff0000, IRQs 2, 8, 31=0A=
hpet0: 3 32-bit timers, 25000000 Hz=0A=
pnp: 00:01: ioport range 0x1000-0x107f could not be reserved=0A=
pnp: 00:01: ioport range 0x1080-0x10ff has been reserved=0A=
pnp: 00:01: ioport range 0x1400-0x147f has been reserved=0A=
pnp: 00:01: ioport range 0x1480-0x14ff could not be reserved=0A=
pnp: 00:01: ioport range 0x1800-0x187f has been reserved=0A=
pnp: 00:01: ioport range 0x1880-0x18ff has been reserved=0A=
pnp: 00:01: ioport range 0x2000-0x207f has been reserved=0A=
pnp: 00:01: ioport range 0x2080-0x20ff has been reserved=0A=
PCI: Bridge: 0000:00:02.0=0A=
  IO window: a000-afff=0A=
  MEM window: fd800000-fd8fffff=0A=
  PREFETCH window: fd700000-fd7fffff=0A=
PCI: Bridge: 0000:00:03.0=0A=
  IO window: 8000-8fff=0A=
  MEM window: fde00000-fdefffff=0A=
  PREFETCH window: fdd00000-fddfffff=0A=
PCI: Bridge: 0000:00:04.0=0A=
  IO window: b000-bfff=0A=
  MEM window: fdc00000-fdcfffff=0A=
  PREFETCH window: fd900000-fd9fffff=0A=
PCI: Bridge: 0000:00:10.0=0A=
  IO window: 9000-9fff=0A=
  MEM window: fdb00000-fdbfffff=0A=
  PREFETCH window: fda00000-fdafffff=0A=
PCI: Setting latency timer of device 0000:00:02.0 to 64=0A=
PCI: Setting latency timer of device 0000:00:03.0 to 64=0A=
PCI: Setting latency timer of device 0000:00:04.0 to 64=0A=
PCI: Setting latency timer of device 0000:00:10.0 to 64=0A=
NET: Registered protocol family 2=0A=
IP route cache hash table entries: 32768 (order: 6, 262144 bytes)=0A=
TCP established hash table entries: 131072 (order: 9, 2097152 bytes)=0A=
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)=0A=
TCP: Hash tables configured (established 131072 bind 65536)=0A=
TCP reno registered=0A=
checking if image is initramfs... it is=0A=
Freeing initrd memory: 1394k freed=0A=
Simple Boot Flag at 0x3a set to 0x80=0A=
audit: initializing netlink socket (disabled)=0A=
audit(1169166083.495:1): initialized=0A=
Total HugeTLB memory allocated, 0=0A=
VFS: Disk quotas dquot_6.5.1=0A=
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)=0A=
SELinux:  Registering netfilter hooks=0A=
io scheduler noop registered=0A=
io scheduler anticipatory registered=0A=
io scheduler deadline registered=0A=
io scheduler cfq registered (default)=0A=
PCI: Setting latency timer of device 0000:00:02.0 to 64=0A=
assign_interrupt_mode Found MSI capability=0A=
Allocate Port Service[0000:00:02.0:pcie00]=0A=
Allocate Port Service[0000:00:02.0:pcie03]=0A=
PCI: Setting latency timer of device 0000:00:03.0 to 64=0A=
assign_interrupt_mode Found MSI capability=0A=
Allocate Port Service[0000:00:03.0:pcie00]=0A=
Allocate Port Service[0000:00:03.0:pcie03]=0A=
PCI: Setting latency timer of device 0000:00:04.0 to 64=0A=
assign_interrupt_mode Found MSI capability=0A=
Allocate Port Service[0000:00:04.0:pcie00]=0A=
Allocate Port Service[0000:00:04.0:pcie03]=0A=
pci_hotplug: PCI Hot Plug PCI Core version: 0.5=0A=
Real Time Clock Driver v1.12ac=0A=
Non-volatile memory driver v1.2=0A=
Linux agpgart interface v0.101 (c) Dave Jones=0A=
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled=0A=
RAMDISK driver initialized: 16 RAM disks of 16384K size 4096 blocksize=0A=
b44.c:v1.01 (Jun 16, 2006)=0A=
ACPI: PCI Interrupt Link [APC4] enabled at IRQ 19=0A=
ACPI: PCI Interrupt 0000:04:07.0[A] -> Link [APC4] -> GSI 19 (level, =
low) -> IRQ 19=0A=
PCI: Setting latency timer of device 0000:04:07.0 to 64=0A=
eth0: Broadcom 4400 10/100BaseT Ethernet 00:18:8b:59:50:15=0A=
netconsole: not configured, aborting=0A=
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2=0A=
ide: Assuming 33MHz system bus speed for PIO modes; override with =
idebus=3Dxx=0A=
Probing IDE interface ide0...=0A=
Probing IDE interface ide1...=0A=
ide-floppy driver 0.99.newide=0A=
usbcore: registered new interface driver libusual=0A=
usbcore: registered new interface driver hiddev=0A=
usbcore: registered new interface driver usbhid=0A=
drivers/usb/input/hid-core.c: v2.6:USB HID core driver=0A=
PNP: No PS/2 controller found. Probing ports directly.=0A=
serio: i8042 KBD port at 0x60,0x64 irq 1=0A=
serio: i8042 AUX port at 0x60,0x64 irq 12=0A=
mice: PS/2 mouse device common for all mice=0A=
TCP bic registered=0A=
Initializing XFRM netlink socket=0A=
NET: Registered protocol family 1=0A=
NET: Registered protocol family 17=0A=
powernow-k8: Found 2 AMD Athlon(tm) 64 X2 Dual Core Processor 3800+ =
processors (version 2.00.00)=0A=
powernow-k8:    0 : fid 0xc (2000 MHz), vid 0xc=0A=
powernow-k8:    1 : fid 0xa (1800 MHz), vid 0xe=0A=
powernow-k8:    2 : fid 0x2 (1000 MHz), vid 0x12=0A=
ACPI: (supports S0 S1 S3 S4 S5)=0A=
Freeing unused kernel memory: 344k freed=0A=
Write protecting the kernel read-only data: 803k=0A=
USB Universal Host Controller Interface driver v3.0=0A=
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver =
(PCI)=0A=
ACPI: PCI Interrupt Link [APCF] enabled at IRQ 23=0A=
ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [APCF] -> GSI 23 (level, =
low) -> IRQ 23=0A=
PCI: Setting latency timer of device 0000:00:0b.0 to 64=0A=
ohci_hcd 0000:00:0b.0: OHCI Host Controller=0A=
ohci_hcd 0000:00:0b.0: new USB bus registered, assigned bus number 1=0A=
ohci_hcd 0000:00:0b.0: irq 23, io mem 0xfe02f000=0A=
usb usb1: configuration #1 chosen from 1 choice=0A=
hub 1-0:1.0: USB hub found=0A=
hub 1-0:1.0: 8 ports detected=0A=
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 22=0A=
ACPI: PCI Interrupt 0000:00:0b.1[B] -> Link [APCL] -> GSI 22 (level, =
low) -> IRQ 22=0A=
PCI: Setting latency timer of device 0000:00:0b.1 to 64=0A=
ehci_hcd 0000:00:0b.1: EHCI Host Controller=0A=
ehci_hcd 0000:00:0b.1: new USB bus registered, assigned bus number 2=0A=
ehci_hcd 0000:00:0b.1: debug port 1=0A=
PCI: cache line size of 64 is not supported by device 0000:00:0b.1=0A=
ehci_hcd 0000:00:0b.1: irq 22, io mem 0xfe02e000=0A=
ehci_hcd 0000:00:0b.1: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004=0A=
usb usb2: configuration #1 chosen from 1 choice=0A=
hub 2-0:1.0: USB hub found=0A=
hub 2-0:1.0: 8 ports detected=0A=
sata_nv 0000:00:0e.0: version 3.2=0A=
ACPI: PCI Interrupt Link [APSI] enabled at IRQ 21=0A=
ACPI: PCI Interrupt 0000:00:0e.0[A] -> Link [APSI] -> GSI 21 (level, =
low) -> IRQ 21=0A=
PCI: Setting latency timer of device 0000:00:0e.0 to 64=0A=
ata1: SATA max UDMA/133 cmd 0x9F0 ctl 0xBF2 bmdma 0xE000 irq 21=0A=
ata2: SATA max UDMA/133 cmd 0x970 ctl 0xB72 bmdma 0xE008 irq 21=0A=
scsi0 : sata_nv=0A=
usb 1-4: new low speed USB device using ohci_hcd and address 2=0A=
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)=0A=
ata1.00: ATA-7, max UDMA/133, 312500000 sectors: LBA48 NCQ (depth 0/32)=0A=
ata1.00: ata1: dev 0 multi count 16=0A=
ata1.00: configured for UDMA/133=0A=
scsi1 : sata_nv=0A=
usb 1-4: configuration #1 chosen from 1 choice=0A=
input: Avocent AutoView 400 as /class/input/input0=0A=
input: USB HID v1.10 Keyboard [Avocent AutoView 400] on =
usb-0000:00:0b.0-4=0A=
input: Avocent AutoView 400 as /class/input/input1=0A=
input: USB HID v1.10 Mouse [Avocent AutoView 400] on usb-0000:00:0b.0-4=0A=
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)=0A=
ata2.00: ATAPI, max UDMA/100=0A=
ata2.00: configured for UDMA/100=0A=
scsi 0:0:0:0: Direct-Access     ATA      ST3160812AS      3.AD PQ: 0 =
ANSI: 5=0A=
SCSI device sda: 312500000 512-byte hdwr sectors (160000 MB)=0A=
sda: Write Protect is off=0A=
sda: Mode Sense: 00 3a 00 00=0A=
SCSI device sda: write cache: enabled, read cache: enabled, doesn't =
support DPO or FUA=0A=
SCSI device sda: 312500000 512-byte hdwr sectors (160000 MB)=0A=
sda: Write Protect is off=0A=
sda: Mode Sense: 00 3a 00 00=0A=
SCSI device sda: write cache: enabled, read cache: enabled, doesn't =
support DPO or FUA=0A=
 sda: sda1 sda2 sda3=0A=
sd 0:0:0:0: Attached scsi disk sda=0A=
scsi 1:0:0:0: CD-ROM            HL-DT-ST DVD-ROM GDRH10N  0D04 PQ: 0 =
ANSI: 5=0A=
ACPI: PCI Interrupt Link [APSJ] enabled at IRQ 20=0A=
ACPI: PCI Interrupt 0000:00:0f.0[A] -> Link [APSJ] -> GSI 20 (level, =
low) -> IRQ 20=0A=
PCI: Setting latency timer of device 0000:00:0f.0 to 64=0A=
ata3: SATA max UDMA/133 cmd 0x9E0 ctl 0xBE2 bmdma 0xCC00 irq 20=0A=
ata4: SATA max UDMA/133 cmd 0x960 ctl 0xB62 bmdma 0xCC08 irq 20=0A=
scsi2 : sata_nv=0A=
ata3: SATA link down (SStatus 0 SControl 300)=0A=
ATA: abnormal status 0x7F on port 0x9E7=0A=
scsi3 : sata_nv=0A=
ata4: SATA link down (SStatus 0 SControl 300)=0A=
ATA: abnormal status 0x7F on port 0x967=0A=
kjournald starting.  Commit interval 5 seconds=0A=
EXT3-fs: mounted filesystem with ordered data mode.=0A=
SELinux:  Disabled at runtime.=0A=
SELinux:  Unregistering netfilter hooks=0A=
audit(1169166087.531:2): selinux=3D0 auid=3D4294967295=0A=
Intel(R) PRO/1000 Network Driver - version 7.3.15-k2-NAPI=0A=
Copyright (c) 1999-2006 Intel Corporation.=0A=
ACPI: PCI Interrupt Link [APC6] enabled at IRQ 16=0A=
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [APC6] -> GSI 16 (level, =
low) -> IRQ 16=0A=
PCI: Setting latency timer of device 0000:01:00.0 to 64=0A=
e1000: 0000:01:00.0: e1000_probe: (PCI Express:2.5Gb/s:Width x1) =
00:15:17:12:c4:17=0A=
e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection=0A=
i2c_adapter i2c-0: nForce2 SMBus adapter at 0x1c00=0A=
i2c_adapter i2c-1: nForce2 SMBus adapter at 0x1c40=0A=
input: PC Speaker as /class/input/input2=0A=
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4=0A=
sd 0:0:0:0: Attached scsi generic sg0 type 0=0A=
scsi 1:0:0:0: Attached scsi generic sg1 type 5=0A=
Floppy drive(s): fd0 is 1.44M=0A=
FDC 0 is a post-1991 82077=0A=
sr0: scsi3-mmc drive: 48x/48x cd/rw xa/form2 cdda tray=0A=
Uniform CD-ROM driver Revision: 3.20=0A=
sr 1:0:0:0: Attached scsi CD-ROM sr0=0A=
ACPI: PCI Interrupt Link [AAZA] enabled at IRQ 23=0A=
ACPI: PCI Interrupt 0000:00:10.1[B] -> Link [AAZA] -> GSI 23 (level, =
low) -> IRQ 23=0A=
PCI: Setting latency timer of device 0000:00:10.1 to 64=0A=
lp: driver loaded but no devices found=0A=
input: Power Button (FF) as /class/input/input3=0A=
ACPI: Power Button (FF) [PWRF]=0A=
input: Power Button (CM) as /class/input/input4=0A=
ACPI: Power Button (CM) [PWRB]=0A=
ibm_acpi: ec object not found=0A=
md: Autodetecting RAID arrays.=0A=
md: autorun ...=0A=
md: ... autorun DONE.=0A=
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: =
dm-devel@redhat.com=0A=
EXT3 FS on sda3, internal journal=0A=
kjournald starting.  Commit interval 5 seconds=0A=
EXT3 FS on sda1, internal journal=0A=
EXT3-fs: mounted filesystem with ordered data mode.=0A=
Adding 1052248k swap on /dev/sda2.  Priority:-1 extents:1 across:1052248k=0A=
NET: Registered protocol family 10=0A=
lo: Disabled Privacy Extensions=0A=
process `sysctl' is using deprecated sysctl (syscall) =
net.ipv6.neigh.lo.base_reachable_time; Use =
net.ipv6.neigh.lo.base_reachable_time_ms instead.=0A=
ADDRCONF(NETDEV_UP): eth0: link is not ready=0A=
b44: eth0: Link is up at 100 Mbps, full duplex.=0A=
b44: eth0: Flow control is off for TX and off for RX.=0A=
ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready=0A=
ADDRCONF(NETDEV_UP): eth1: link is not ready=0A=
audit(1169166107.318:3): audit_pid=3D1926 old=3D0 by auid=3D4294967295=0A=
irqbalance[1952]: segfault at 00005555557ca3f8 rip 0000555555555979 rsp =
00007fff932b5ac0 error 6=0A=
Bluetooth: Core ver 2.11=0A=
NET: Registered protocol family 31=0A=
Bluetooth: HCI device and connection manager initialized=0A=
Bluetooth: HCI socket layer initialized=0A=
Bluetooth: L2CAP ver 2.8=0A=
Bluetooth: L2CAP socket layer initialized=0A=
Bluetooth: RFCOMM socket layer initialized=0A=
Bluetooth: RFCOMM TTY layer initialized=0A=
Bluetooth: RFCOMM ver 1.8=0A=
Bluetooth: HIDP (Human Interface Emulation) ver 1.1=0A=
eth0: no IPv6 routers present=0A=

------=_NextPart_000_0239_01C73CA0.37D7C530
Content-Type: application/octet-stream;
	name="lspci-2.6.20-rc5"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="lspci-2.6.20-rc5"

00:00.0 RAM memory: nVidia Corporation C51 Host Bridge (rev a2)=0A=
	Subsystem: nVidia Corporation C51 Host Bridge=0A=
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 0=0A=
	Capabilities: [44] HyperTransport: Slave or Primary Interface=0A=
		Command: BaseUnitID=3D0 UnitCnt=3D15 MastHost- DefDir- DUL-=0A=
		Link Control 0: CFlE+ CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=3D0 =
IsocEn- LSEn- ExtCTL- 64b-=0A=
		Link Config 0: MLWI=3D16bit DwFcIn- MLWO=3D16bit DwFcOut- LWI=3D16bit =
DwFcInEn- LWO=3D16bit DwFcOutEn-=0A=
		Link Control 1: CFlE+ CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=3D0 =
IsocEn- LSEn+ ExtCTL- 64b-=0A=
		Link Config 1: MLWI=3D16bit DwFcIn- MLWO=3D16bit DwFcOut- LWI=3D8bit =
DwFcInEn- LWO=3D8bit DwFcOutEn-=0A=
		Revision ID: 1.03=0A=
		Link Frequency 0: 1.0GHz=0A=
		Link Error 0: <Prot- <Ovfl- <EOC- CTLTm-=0A=
		Link Frequency Capability 0: 200MHz+ 300MHz+ 400MHz+ 500MHz+ 600MHz+ =
800MHz+ 1.0GHz+ 1.2GHz- 1.4GHz- 1.6GHz- Vend-=0A=
		Feature Capability: IsocFC+ LDTSTOP+ CRCTM- ECTLT- 64bA- UIDRD-=0A=
		Link Frequency 1: 800MHz=0A=
		Link Error 1: <Prot- <Ovfl- <EOC- CTLTm-=0A=
		Link Frequency Capability 1: 200MHz+ 300MHz+ 400MHz+ 500MHz+ 600MHz+ =
800MHz+ 1.0GHz+ 1.2GHz- 1.4GHz- 1.6GHz- Vend-=0A=
		Error Handling: PFlE+ OFlE+ PFE- OFE- EOCFE- RFE- CRCFE- SERRFE- CF- =
RE- PNFE- ONFE- EOCNFE- RNFE- CRCNFE- SERRNFE-=0A=
		Prefetchable memory behind bridge Upper: 00-00=0A=
		Bus Number: 00=0A=
	Capabilities: [e0] HyperTransport: MSI Mapping=0A=
=0A=
00:00.1 RAM memory: nVidia Corporation C51 Memory Controller 0 (rev a2)=0A=
	Subsystem: nVidia Corporation C51 Memory Controller 0=0A=
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR+ FastB2B-=0A=
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR+ <PERR-=0A=
=0A=
00:00.2 RAM memory: nVidia Corporation C51 Memory Controller 1 (rev a2)=0A=
	Subsystem: nVidia Corporation C51 Memory Controller 1=0A=
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
=0A=
00:00.3 RAM memory: nVidia Corporation C51 Memory Controller 5 (rev a2)=0A=
	Subsystem: nVidia Corporation C51 Memory Controller 5=0A=
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
=0A=
00:00.4 RAM memory: nVidia Corporation C51 Memory Controller 4 (rev a2)=0A=
	Subsystem: nVidia Corporation C51 Memory Controller 4=0A=
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 0=0A=
=0A=
00:00.5 RAM memory: nVidia Corporation C51 Host Bridge (rev a2)=0A=
	Subsystem: nVidia Corporation C51 Host Bridge=0A=
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 0=0A=
	Capabilities: [44] #00 [00fe]=0A=
	Capabilities: [fc] #00 [0000]=0A=
=0A=
00:00.6 RAM memory: nVidia Corporation C51 Memory Controller 3 (rev a2)=0A=
	Subsystem: nVidia Corporation C51 Memory Controller 3=0A=
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR+ FastB2B-=0A=
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
=0A=
00:00.7 RAM memory: nVidia Corporation C51 Memory Controller 2 (rev a2)=0A=
	Subsystem: nVidia Corporation C51 Memory Controller 2=0A=
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
=0A=
00:02.0 PCI bridge: nVidia Corporation C51 PCI Express Bridge (rev a1) =
(prog-if 00 [Normal decode])=0A=
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 0, Cache Line Size: 64 bytes=0A=
	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D0=0A=
	I/O behind bridge: 0000a000-0000afff=0A=
	Memory behind bridge: fd800000-fd8fffff=0A=
	Prefetchable memory behind bridge: 00000000fd700000-00000000fd700000=0A=
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- <SERR- <PERR-=0A=
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-=0A=
	Capabilities: [40] #0d [0000]=0A=
	Capabilities: [48] Power Management version 2=0A=
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA =
PME(D0+,D1+,D2+,D3hot+,D3cold+)=0A=
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-=0A=
	Capabilities: [50] Message Signalled Interrupts: 64bit+ Queue=3D0/1 =
Enable+=0A=
		Address: 00000000fee00000  Data: 4039=0A=
	Capabilities: [60] HyperTransport: MSI Mapping=0A=
	Capabilities: [80] Express Root Port (Slot+) IRQ 0=0A=
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-=0A=
		Device: Latency L0s <512ns, L1 <4us=0A=
		Device: Errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+=0A=
		Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+=0A=
		Device: MaxPayload 128 bytes, MaxReadReq 512 bytes=0A=
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 2=0A=
		Link: Latency L0s <512ns, L1 <4us=0A=
		Link: ASPM Disabled RCB 64 bytes CommClk+ ExtSynch-=0A=
		Link: Speed 2.5Gb/s, Width x1=0A=
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug- Surpise-=0A=
		Slot: Number 0, PowerLimit 0.000000=0A=
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-=0A=
		Slot: AttnInd Off, PwrInd On, Power-=0A=
		Root: Correctable- Non-Fatal- Fatal- PME-=0A=
	Capabilities: [100] Virtual Channel=0A=
=0A=
00:03.0 PCI bridge: nVidia Corporation C51 PCI Express Bridge (rev a1) =
(prog-if 00 [Normal decode])=0A=
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 0, Cache Line Size: 64 bytes=0A=
	Bus: primary=3D00, secondary=3D02, subordinate=3D02, sec-latency=3D0=0A=
	I/O behind bridge: 00008000-00008fff=0A=
	Memory behind bridge: fde00000-fdefffff=0A=
	Prefetchable memory behind bridge: 00000000fdd00000-00000000fdd00000=0A=
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- <SERR- <PERR-=0A=
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-=0A=
	Capabilities: [40] #0d [0000]=0A=
	Capabilities: [48] Power Management version 2=0A=
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA =
PME(D0+,D1+,D2+,D3hot+,D3cold+)=0A=
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-=0A=
	Capabilities: [50] Message Signalled Interrupts: 64bit+ Queue=3D0/1 =
Enable+=0A=
		Address: 00000000fee00000  Data: 4041=0A=
	Capabilities: [60] HyperTransport: MSI Mapping=0A=
	Capabilities: [80] Express Root Port (Slot+) IRQ 0=0A=
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-=0A=
		Device: Latency L0s <512ns, L1 <4us=0A=
		Device: Errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+=0A=
		Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+=0A=
		Device: MaxPayload 128 bytes, MaxReadReq 512 bytes=0A=
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 1=0A=
		Link: Latency L0s <512ns, L1 <4us=0A=
		Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-=0A=
		Link: Speed 2.5Gb/s, Width x1=0A=
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug- Surpise-=0A=
		Slot: Number 0, PowerLimit 0.000000=0A=
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-=0A=
		Slot: AttnInd Off, PwrInd On, Power-=0A=
		Root: Correctable- Non-Fatal- Fatal- PME-=0A=
	Capabilities: [100] Virtual Channel=0A=
=0A=
00:04.0 PCI bridge: nVidia Corporation C51 PCI Express Bridge (rev a1) =
(prog-if 00 [Normal decode])=0A=
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 0, Cache Line Size: 64 bytes=0A=
	Bus: primary=3D00, secondary=3D03, subordinate=3D03, sec-latency=3D0=0A=
	I/O behind bridge: 0000b000-0000bfff=0A=
	Memory behind bridge: fdc00000-fdcfffff=0A=
	Prefetchable memory behind bridge: 00000000fd900000-00000000fd900000=0A=
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- <SERR- <PERR-=0A=
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-=0A=
	Capabilities: [40] #0d [0000]=0A=
	Capabilities: [48] Power Management version 2=0A=
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA =
PME(D0+,D1+,D2+,D3hot+,D3cold+)=0A=
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-=0A=
	Capabilities: [50] Message Signalled Interrupts: 64bit+ Queue=3D0/1 =
Enable+=0A=
		Address: 00000000fee00000  Data: 4049=0A=
	Capabilities: [60] HyperTransport: MSI Mapping=0A=
	Capabilities: [80] Express Root Port (Slot+) IRQ 0=0A=
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-=0A=
		Device: Latency L0s <512ns, L1 <4us=0A=
		Device: Errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+=0A=
		Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+=0A=
		Device: MaxPayload 128 bytes, MaxReadReq 512 bytes=0A=
		Link: Supported Speed 2.5Gb/s, Width x16, ASPM L0s L1, Port 0=0A=
		Link: Latency L0s <512ns, L1 <4us=0A=
		Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-=0A=
		Link: Speed 2.5Gb/s, Width x16=0A=
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug- Surpise-=0A=
		Slot: Number 0, PowerLimit 0.000000=0A=
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-=0A=
		Slot: AttnInd Off, PwrInd On, Power-=0A=
		Root: Correctable- Non-Fatal- Fatal- PME-=0A=
	Capabilities: [100] Virtual Channel=0A=
=0A=
00:05.0 VGA compatible controller: nVidia Corporation C51 PCI Express =
Bridge (rev a2) (prog-if 00 [VGA])=0A=
	Subsystem: Dell Unknown device 01ed=0A=
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 0=0A=
	Interrupt: pin A routed to IRQ 11=0A=
	Region 0: Memory at fc000000 (32-bit, non-prefetchable) [size=3D16M]=0A=
	Region 1: Memory at e0000000 (64-bit, prefetchable) [size=3D256M]=0A=
	Region 3: Memory at fb000000 (64-bit, non-prefetchable) [size=3D16M]=0A=
	[virtual] Expansion ROM at 50000000 [disabled] [size=3D128K]=0A=
	Capabilities: [48] Power Management version 2=0A=
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA =
PME(D0-,D1-,D2-,D3hot-,D3cold-)=0A=
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-=0A=
	Capabilities: [50] Message Signalled Interrupts: 64bit+ Queue=3D0/0 =
Enable-=0A=
		Address: 0000000000000000  Data: 0000=0A=
=0A=
00:09.0 RAM memory: nVidia Corporation MCP51 Host Bridge (rev a2)=0A=
	Subsystem: nVidia Corporation Unknown device cb84=0A=
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 0=0A=
	Capabilities: [44] HyperTransport: Slave or Primary Interface=0A=
		Command: BaseUnitID=3D9 UnitCnt=3D15 MastHost- DefDir- DUL-=0A=
		Link Control 0: CFlE+ CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=3D0 =
IsocEn- LSEn+ ExtCTL- 64b-=0A=
		Link Config 0: MLWI=3D8bit DwFcIn- MLWO=3D8bit DwFcOut- LWI=3D8bit =
DwFcInEn- LWO=3D8bit DwFcOutEn-=0A=
		Link Control 1: CFlE- CST- CFE- <LkFail+ Init- EOC+ TXO+ <CRCErr=3D0 =
IsocEn- LSEn- ExtCTL- 64b-=0A=
		Link Config 1: MLWI=3D8bit DwFcIn- MLWO=3D8bit DwFcOut- LWI=3D8bit =
DwFcInEn- LWO=3D8bit DwFcOutEn-=0A=
		Revision ID: 1.03=0A=
		Link Frequency 0: 800MHz=0A=
		Link Error 0: <Prot- <Ovfl- <EOC- CTLTm-=0A=
		Link Frequency Capability 0: 200MHz+ 300MHz+ 400MHz+ 500MHz+ 600MHz+ =
800MHz+ 1.0GHz+ 1.2GHz- 1.4GHz- 1.6GHz- Vend-=0A=
		Feature Capability: IsocFC+ LDTSTOP+ CRCTM- ECTLT- 64bA- UIDRD-=0A=
		Link Frequency 1: 200MHz=0A=
		Link Error 1: <Prot- <Ovfl- <EOC- CTLTm-=0A=
		Link Frequency Capability 1: 200MHz- 300MHz- 400MHz- 500MHz- 600MHz- =
800MHz- 1.0GHz- 1.2GHz- 1.4GHz- 1.6GHz- Vend-=0A=
		Error Handling: PFlE+ OFlE+ PFE- OFE- EOCFE- RFE- CRCFE- SERRFE- CF- =
RE- PNFE- ONFE- EOCNFE- RNFE- CRCNFE- SERRNFE-=0A=
		Prefetchable memory behind bridge Upper: 00-00=0A=
		Bus Number: 00=0A=
	Capabilities: [e0] HyperTransport: MSI Mapping=0A=
=0A=
00:0a.0 ISA bridge: nVidia Corporation MCP51 LPC Bridge (rev a3)=0A=
	Subsystem: Dell Unknown device 01ed=0A=
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 0=0A=
=0A=
00:0a.1 SMBus: nVidia Corporation MCP51 SMBus (rev a3)=0A=
	Subsystem: Dell Unknown device 01ed=0A=
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Interrupt: pin A routed to IRQ 10=0A=
	Region 4: I/O ports at 1c00 [size=3D64]=0A=
	Region 5: I/O ports at 1c40 [size=3D64]=0A=
	Capabilities: [44] Power Management version 2=0A=
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA =
PME(D0-,D1-,D2-,D3hot+,D3cold+)=0A=
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-=0A=
=0A=
00:0a.2 RAM memory: nVidia Corporation MCP51 Memory Controller 0 (rev a3)=0A=
	Subsystem: Dell Unknown device 01ed=0A=
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
=0A=
00:0b.0 USB Controller: nVidia Corporation MCP51 USB Controller (rev a3) =
(prog-if 10 [OHCI])=0A=
	Subsystem: Dell Unknown device 01ed=0A=
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 0 (750ns min, 250ns max)=0A=
	Interrupt: pin A routed to IRQ 23=0A=
	Region 0: Memory at fe02f000 (32-bit, non-prefetchable) [size=3D4K]=0A=
	Capabilities: [44] Power Management version 2=0A=
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA =
PME(D0+,D1+,D2+,D3hot+,D3cold+)=0A=
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-=0A=
=0A=
00:0b.1 USB Controller: nVidia Corporation MCP51 USB Controller (rev a3) =
(prog-if 20 [EHCI])=0A=
	Subsystem: Dell Unknown device 01ed=0A=
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 0 (750ns min, 250ns max)=0A=
	Interrupt: pin B routed to IRQ 22=0A=
	Region 0: Memory at fe02e000 (32-bit, non-prefetchable) [size=3D256]=0A=
	Capabilities: [44] Debug port=0A=
	Capabilities: [80] Power Management version 2=0A=
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA =
PME(D0+,D1+,D2+,D3hot+,D3cold+)=0A=
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-=0A=
=0A=
00:0e.0 IDE interface: nVidia Corporation MCP51 Serial ATA Controller =
(rev a1) (prog-if 85 [Master SecO PriO])=0A=
	Subsystem: Dell Unknown device 01ed=0A=
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 0 (750ns min, 250ns max)=0A=
	Interrupt: pin A routed to IRQ 21=0A=
	Region 0: I/O ports at 09f0 [size=3D8]=0A=
	Region 1: I/O ports at 0bf0 [size=3D4]=0A=
	Region 2: I/O ports at 0970 [size=3D8]=0A=
	Region 3: I/O ports at 0b70 [size=3D4]=0A=
	Region 4: I/O ports at e000 [size=3D16]=0A=
	Region 5: Memory at fe02d000 (32-bit, non-prefetchable) [size=3D4K]=0A=
	Capabilities: [44] Power Management version 2=0A=
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA =
PME(D0-,D1-,D2-,D3hot-,D3cold-)=0A=
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-=0A=
	Capabilities: [b0] Message Signalled Interrupts: 64bit+ Queue=3D0/2 =
Enable-=0A=
		Address: 0000000000000000  Data: 0000=0A=
	Capabilities: [cc] HyperTransport: MSI Mapping=0A=
=0A=
00:0f.0 IDE interface: nVidia Corporation MCP51 Serial ATA Controller =
(rev a1) (prog-if 85 [Master SecO PriO])=0A=
	Subsystem: Dell Unknown device 01ed=0A=
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 0 (750ns min, 250ns max)=0A=
	Interrupt: pin A routed to IRQ 20=0A=
	Region 0: I/O ports at 09e0 [size=3D8]=0A=
	Region 1: I/O ports at 0be0 [size=3D4]=0A=
	Region 2: I/O ports at 0960 [size=3D8]=0A=
	Region 3: I/O ports at 0b60 [size=3D4]=0A=
	Region 4: I/O ports at cc00 [size=3D16]=0A=
	Region 5: Memory at fe02c000 (32-bit, non-prefetchable) [size=3D4K]=0A=
	Capabilities: [44] Power Management version 2=0A=
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA =
PME(D0-,D1-,D2-,D3hot-,D3cold-)=0A=
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-=0A=
	Capabilities: [b0] Message Signalled Interrupts: 64bit+ Queue=3D0/2 =
Enable-=0A=
		Address: 0000000000000000  Data: 0000=0A=
	Capabilities: [cc] HyperTransport: MSI Mapping=0A=
=0A=
00:10.0 PCI bridge: nVidia Corporation MCP51 PCI Bridge (rev a2) =
(prog-if 01 [Subtractive decode])=0A=
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 0=0A=
	Bus: primary=3D00, secondary=3D04, subordinate=3D04, sec-latency=3D32=0A=
	I/O behind bridge: 00009000-00009fff=0A=
	Memory behind bridge: fdb00000-fdbfffff=0A=
	Prefetchable memory behind bridge: fda00000-fdafffff=0A=
	Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- <SERR- <PERR-=0A=
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-=0A=
	Capabilities: [b8] #0d [0000]=0A=
	Capabilities: [8c] HyperTransport: MSI Mapping=0A=
=0A=
00:10.1 Audio device: nVidia Corporation MCP51 High Definition Audio =
(rev a2)=0A=
	Subsystem: Dell Unknown device 01ed=0A=
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 0 (500ns min, 1250ns max)=0A=
	Interrupt: pin B routed to IRQ 23=0A=
	Region 0: Memory at fe024000 (32-bit, non-prefetchable) [size=3D16K]=0A=
	Capabilities: [44] Power Management version 2=0A=
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA =
PME(D0-,D1-,D2-,D3hot+,D3cold+)=0A=
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-=0A=
	Capabilities: [50] Message Signalled Interrupts: 64bit+ Queue=3D0/0 =
Enable-=0A=
		Address: 0000000000000000  Data: 0000=0A=
	Capabilities: [6c] HyperTransport: MSI Mapping=0A=
=0A=
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] =
HyperTransport Technology Configuration=0A=
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Capabilities: [80] HyperTransport: Host or Secondary Interface=0A=
		!!! Possibly incomplete decoding=0A=
		Command: WarmRst+ DblEnd-=0A=
		Link Control: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=3D0=0A=
		Link Config: MLWI=3D16bit MLWO=3D16bit LWI=3D16bit LWO=3D16bit=0A=
		Revision ID: 1.02=0A=
=0A=
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] =
Address Map=0A=
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
=0A=
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] =
DRAM Controller=0A=
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
=0A=
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] =
Miscellaneous Control=0A=
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Capabilities: [f0] #0f [0010]=0A=
=0A=
01:00.0 Ethernet controller: Intel Corporation 82572EI Gigabit Ethernet =
Controller (Copper) (rev 06)=0A=
	Subsystem: Intel Corporation PRO/1000 PT Desktop Adapter=0A=
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 0, Cache Line Size: 64 bytes=0A=
	Interrupt: pin A routed to IRQ 8412=0A=
	Region 0: Memory at fd8e0000 (32-bit, non-prefetchable) [size=3D128K]=0A=
	Region 1: Memory at fd8c0000 (32-bit, non-prefetchable) [size=3D128K]=0A=
	Region 2: I/O ports at ac00 [size=3D32]=0A=
	[virtual] Expansion ROM at fd700000 [disabled] [size=3D128K]=0A=
	Capabilities: [c8] Power Management version 2=0A=
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA =
PME(D0+,D1-,D2-,D3hot+,D3cold+)=0A=
		Status: D0 PME-Enable- DSel=3D0 DScale=3D1 PME-=0A=
	Capabilities: [d0] Message Signalled Interrupts: 64bit+ Queue=3D0/0 =
Enable+=0A=
		Address: 00000000fee00000  Data: 4081=0A=
	Capabilities: [e0] Express Endpoint IRQ 0=0A=
		Device: Supported: MaxPayload 256 bytes, PhantFunc 0, ExtTag-=0A=
		Device: Latency L0s <512ns, L1 <64us=0A=
		Device: AtnBtn- AtnInd- PwrInd-=0A=
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-=0A=
		Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+=0A=
		Device: MaxPayload 128 bytes, MaxReadReq 512 bytes=0A=
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s, Port 2=0A=
		Link: Latency L0s <4us, L1 <64us=0A=
		Link: ASPM Disabled RCB 64 bytes CommClk+ ExtSynch-=0A=
		Link: Speed 2.5Gb/s, Width x1=0A=
	Capabilities: [100] Advanced Error Reporting=0A=
	Capabilities: [140] Device Serial Number 17-c4-12-ff-ff-17-15-00=0A=
=0A=
04:07.0 Ethernet controller: Broadcom Corporation BCM4401-B0 100Base-TX =
(rev 02)=0A=
	Subsystem: Dell Unknown device 01ed=0A=
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 64=0A=
	Interrupt: pin A routed to IRQ 19=0A=
	Region 0: Memory at fdbfe000 (32-bit, non-prefetchable) [size=3D8K]=0A=
	Capabilities: [40] Power Management version 2=0A=
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA =
PME(D0+,D1+,D2+,D3hot+,D3cold+)=0A=
		Status: D0 PME-Enable- DSel=3D0 DScale=3D2 PME-=0A=
=0A=

------=_NextPart_000_0239_01C73CA0.37D7C530--

