Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266975AbTAOUDI>; Wed, 15 Jan 2003 15:03:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266976AbTAOUDI>; Wed, 15 Jan 2003 15:03:08 -0500
Received: from d12lmsgate-2.de.ibm.com ([194.196.100.235]:46530 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id <S266975AbTAOUDE> convert rfc822-to-8bit; Wed, 15 Jan 2003 15:03:04 -0500
Importance: High
Subject: Cannot boot Linux 2.4.19 for IA 64 on an Itanium 2 single processor box
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF0794B936.F3CDF81C-ONC1256CAF.006E9154@megacenter.de.ibm.com>
From: "Jose Rodriguez Ruibal" <Jose.Rodriguez.Ruibal@fr.ibm.com>
Date: Wed, 15 Jan 2003 21:11:52 +0100
X-MIMETrack: Serialize by Router on D12ML705/12/M/IBM(Release 5.0.10 |March 22, 2002) at
 15/01/2003 21:11:52
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm trying to boot SuSE SLES 8 kernel 2.4.19 on an Itanium 2 box. The
kernel starts to load, but then it stops while loading the module
"mptbase". Why? What can I do to resolve this? Thanks in advance for your
help. Here it is the full log of the boot process.

****************************************************************************
Full log of the boot process.
Contact Jose Rodriguez Ruibal <jose.rodriguez.ruibal@fr.ibm.com> for
feedback
*****************************************************************************

EFI version 1.10 [14.60] Build flags: EFI64 Running on Intel(R) Itanium
Processor

EFI Boot Manager ver 1.10 [14.60]

Loading device drivers

EFI Boot Manager ver 1.10 [14.60]

Please select a boot option

    SuSE SLES
    EFI Shell [Built-in]
    Acpi(PNP0A03,0)/Pci(5|1)/Ata(Primary,Master)
    MemMap(0:FF000000-FFFFFFFF)
    MemMap(0:FF800200-FFBFFFFF)
    Acpi(PNP0A03,1)/Pci(4|0)/Mac(0002551F0113)
    Acpi(PNP0A03,1)/Pci(4|1)/Mac(0002559F0113)
    Flash Update
    Configuration/Setup
    Diagnostic
    Boot option maintenance menu

    Use  and  to change option(s). Use Enter to select an option
Loading.: SuSE SLES
Starting: SuSE SLES

ELILO boot: Uncompressing Linux... done
Loading initrd \initrd...done
Linux version 2.4.19 (root@ITANIUM2.suse.de) (gcc version 3.2) #1 Thu Dec
12 19:
33:22 UTC 2002
Total HugeTLB_Page memory pages requested  0x20
EFI v1.10 by INTEL: SALsystab=0x1efc2000 ACPI 2.0=0xf1100 SMBIOS=0xf1000
CPU 0: mapping PAL code [0x1f000000-0x1f100000) into
[0xe00000001f000000-0xe0000
00020000000)
Initial ramdisk at: 0xe00000001ce6d000 (1138688 bytes)
SAL v3.00: oem= IBM                            , product= XXX X XXX

SAL: entry: pal_proc=0x1f008010, sal_proc=0x1f703970
SAL: Platform features
booting generic kernel on platform dig
CPU 0: 61 virtual and 50 physical address bits
ACPI: RSDP (v002 IBM                        ) @ 0x00000000000f1100
ACPI: XSDT (v001 IBM    SERMOW   00000.00001) @ 0x000000001efe0040
ACPI: FADT (v003 IBM    SERMOW   00000.00003) @ 0x000000001efe0120
ACPI: DBGP (v001 IBM    SERMOW   00000.00001) @ 0x000000001efe0220
ACPI: MADT (v001 IBM    SERMOW   00000.00001) @ 0x000000001efe8140
ACPI: SRAT (v001 IBM    SERMOW   00000.00001) @ 0x000000001efe82f0
ACPI: OEM0 (v001 IBM    RIOTABLE 00000.00003) @ 0x000000001efe8400
ACPI: Local APIC address 0xc0000000fee00000
ACPI: LSAPIC (acpi_id[0x00] lsapic_id[0x00] lsapic_eid[0x00] enabled)
CPU 0 (0x0000) enabled
ACPI: LSAPIC (acpi_id[0x01] lsapic_id[0x00] lsapic_eid[0x00] disabled)
ACPI: Ignoring CPU (0x0000) (NR_CPUS == 1)
ACPI: LSAPIC (acpi_id[0x02] lsapic_id[0x00] lsapic_eid[0x00] disabled)
ACPI: Ignoring CPU (0x0000) (NR_CPUS == 1)
ACPI: LSAPIC (acpi_id[0x03] lsapic_id[0x00] lsapic_eid[0x00] disabled)
ACPI: Ignoring CPU (0x0000) (NR_CPUS == 1)
ACPI: LSAPIC (acpi_id[0x04] lsapic_id[0x00] lsapic_eid[0x00] disabled)
ACPI: Ignoring CPU (0x0000) (NR_CPUS == 1)
ACPI: LSAPIC (acpi_id[0x05] lsapic_id[0x00] lsapic_eid[0x00] disabled)
ACPI: Ignoring CPU (0x0000) (NR_CPUS == 1)
ACPI: LSAPIC (acpi_id[0x06] lsapic_id[0x00] lsapic_eid[0x00] disabled)
ACPI: Ignoring CPU (0x0000) (NR_CPUS == 1)
ACPI: LSAPIC (acpi_id[0x07] lsapic_id[0x00] lsapic_eid[0x00] disabled)
ACPI: Ignoring CPU (0x0000) (NR_CPUS == 1)
ACPI: LSAPIC (acpi_id[0x08] lsapic_id[0x00] lsapic_eid[0x00] disabled)
ACPI: Ignoring CPU (0x0000) (NR_CPUS == 1)
ACPI: LSAPIC (acpi_id[0x09] lsapic_id[0x00] lsapic_eid[0x00] disabled)
ACPI: Ignoring CPU (0x0000) (NR_CPUS == 1)
ACPI: LSAPIC (acpi_id[0x0a] lsapic_id[0x00] lsapic_eid[0x00] disabled)
ACPI: Ignoring CPU (0x0000) (NR_CPUS == 1)
ACPI: LSAPIC (acpi_id[0x0b] lsapic_id[0x00] lsapic_eid[0x00] disabled)
ACPI: Ignoring CPU (0x0000) (NR_CPUS == 1)
ACPI: LSAPIC (acpi_id[0x0c] lsapic_id[0x00] lsapic_eid[0x00] disabled)
ACPI: Ignoring CPU (0x0000) (NR_CPUS == 1)
ACPI: LSAPIC (acpi_id[0x0d] lsapic_id[0x00] lsapic_eid[0x00] disabled)
ACPI: Ignoring CPU (0x0000) (NR_CPUS == 1)
ACPI: LSAPIC (acpi_id[0x0e] lsapic_id[0x00] lsapic_eid[0x00] disabled)
ACPI: Ignoring CPU (0x0000) (NR_CPUS == 1)
ACPI: LSAPIC (acpi_id[0x0f] lsapic_id[0x00] lsapic_eid[0x00] disabled)
ACPI: Ignoring CPU (0x0000) (NR_CPUS == 1)
ACPI: IOSAPIC (id[0x0] global_irq_base[0x33] address[00000000fec01000])
iosapic_init: Disabling PC-AT compatible 8259 interrupts
IOSAPIC: version 1.1, address 0xfec01000, GSIs 0x33-0x65
ACPI: IOSAPIC (id[0x0] global_irq_base[0x0] address[00000000fec00000])
iosapic_init: Disabling PC-AT compatible 8259 interrupts
IOSAPIC: version 1.1, address 0xfec00000, GSIs 0x0-0x32
ACPI: PLAT_INT_SRC (polarity[0x3] trigger[0x1] type[0x2] id[0x0000]
eid[0x0] ios
apic_vector[0x0] global_irq[0x5b]
PLATFORM int 0x2: GSI 0x5b(low,edge) -> CPU 0x0000 vector 48
ACPI: PLAT_INT_SRC (polarity[0x3] trigger[0x1] type[0x2] id[0x0000]
eid[0x0] ios
apic_vector[0x0] global_irq[0x5c]
PLATFORM int 0x2: GSI 0x5c(low,edge) -> CPU 0x0000 vector 49
ACPI: PLAT_INT_SRC (polarity[0x3] trigger[0x1] type[0x2] id[0x0000]
eid[0x0] ios
apic_vector[0x0] global_irq[0x5d]
PLATFORM int 0x2: GSI 0x5d(low,edge) -> CPU 0x0000 vector 50
ACPI: PLAT_INT_SRC (polarity[0x3] trigger[0x1] type[0x2] id[0x0000]
eid[0x0] ios
apic_vector[0x0] global_irq[0x5e]
PLATFORM int 0x2: GSI 0x5e(low,edge) -> CPU 0x0000 vector 51
ACPI: PLAT_INT_SRC (polarity[0x3] trigger[0x1] type[0x2] id[0x0000]
eid[0x0] ios
apic_vector[0x0] global_irq[0x5f]
PLATFORM int 0x2: GSI 0x5f(low,edge) -> CPU 0x0000 vector 52
ACPI: PLAT_INT_SRC (polarity[0x3] trigger[0x1] type[0x2] id[0x0000]
eid[0x0] ios
apic_vector[0x0] global_irq[0x60]
PLATFORM int 0x2: GSI 0x60(low,edge) -> CPU 0x0000 vector 53
ACPI: PLAT_INT_SRC (polarity[0x3] trigger[0x1] type[0x2] id[0x0000]
eid[0x0] ios
apic_vector[0x0] global_irq[0x61]
PLATFORM int 0x2: GSI 0x61(low,edge) -> CPU 0x0000 vector 54
ACPI: PLAT_INT_SRC (polarity[0x3] trigger[0x1] type[0x2] id[0x0000]
eid[0x0] ios
apic_vector[0x0] global_irq[0x62]
PLATFORM int 0x2: GSI 0x62(low,edge) -> CPU 0x0000 vector 55
ACPI: PLAT_INT_SRC (polarity[0x3] trigger[0x1] type[0x1] id[0x0000]
eid[0x0] ios
apic_vector[0x3] global_irq[0x2e]
PLATFORM int 0x1: GSI 0x2e(low,edge) -> CPU 0x0000 vector 3
ACPI: NMI_SRC (polarity[0x1] trigger[0x1] global_irq[0xd])
1 CPUs available, 1 CPUs total
Mca related initialization done
On node 0 totalpages: 62407
zone(0): 65536 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=scsi0:/vmlinuz root=805 hda=ide-scsi
console=tty
S0,115200 ro
ide_setup: hda=ide-scsi
FPSWA interface at 0x1de72010, revision 1.12
CPU 0: base freq=200.000MHz, ITC ratio=9/2, ITC freq=900.000MHz
Console: colour VGA+ 80x25
Calibrating delay loop... 1133.40 BogoMIPS
Placing software IO TLB between 0xe000000001598000 - 0xe000000003598000
Memory: 952608k/998512k available (3916k code, 45904k reserved, 1847k data,
256k
 init)
Total Huge_TLB_Page memory pages allocated 32
Dentry cache hash table entries: 65536 (order: 6, 1048576 bytes)
Inode cache hash table entries: 65536 (order: 6, 1048576 bytes)
Mount-cache hash table entries: 1024 (order: 0, 16384 bytes)
Buffer-cache hash table entries: 65536 (order: 5, 524288 bytes)
Page-cache hash table entries: 65536 (order: 5, 524288 bytes)
POSIX conformance testing by UNIFIX
ACPI: Subsystem revision 20020815
PCI: Using SAL to access configuration space
ACPI: Interpreter enabled
ACPI: Using IOSAPIC for interrupt routing
ACPI: System [ACPI] (supports    ACPI-0175: *** Error: Sleep State package
eleme
nts are not both Integers (Integer, [NULL Object Descriptor])
    ACPI-0175: *** Error: Sleep State package elements are not both
Integers (In
teger, [NULL Object Descriptor])
    ACPI-0175: *** Error: Sleep State package elements are not both
Integers (In
teger, [NULL Object Descriptor])
)
ACPI: PCI Root Bridge [P000] (00:00)
PCI: Probing PCI hardware on bus (00:00)
ACPI: PCI Root Bridge [P001] (00:01)
PCI: Probing PCI hardware on bus (00:01)
ACPI: PCI Root Bridge [P002] (00:02)
PCI: Probing PCI hardware on bus (00:02)
ACPI: PCI Root Bridge [P010] (00:05)
PCI: Probing PCI hardware on bus (00:05)
ACPI: PCI Root Bridge [P011] (00:07)
PCI: Probing PCI hardware on bus (00:07)
ACPI: PCI Root Bridge [P012] (00:09)
PCI: Probing PCI hardware on bus (00:09)
PCI: Probing PCI hardware
PCI->APIC IRQ transform: (00:03.0 INTA) -> CPU 0x0000 vector 56
PCI->APIC IRQ transform: (00:04.0 INTA) -> CPU 0x0000 vector 57
PCI: no interrupt route for 00:00:05 pin A
PCI->APIC IRQ transform: (00:05.2 INTD) -> CPU 0x0000 vector 58
PCI->APIC IRQ transform: (00:05.3 INTD) -> CPU 0x0000 vector 58
PCI->APIC IRQ transform: (01:03.0 INTA) -> CPU 0x0000 vector 59
PCI->APIC IRQ transform: (01:03.1 INTB) -> CPU 0x0000 vector 60
PCI->APIC IRQ transform: (01:04.0 INTA) -> CPU 0x0000 vector 61
iosapic_fixup_pci_interrupt: changing vector 37 from IO-SAPIC-edge to
IO-SAPIC-l
evel
PCI->APIC IRQ transform: (01:04.1 INTB) -> CPU 0x0000 vector 37
PCI: Via IRQ fixup for 00:05.2, from 0 to 10
PCI: Via IRQ fixup for 00:05.3, from 0 to 10
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
perfmon: version 1.0 (sampling format v1.0) IRQ 238
perfmon: 47 bits counters
perfmon: 4 PMC/PMD pairs, 16 PMCs, 18 PMDs
PAL Information Facility v0.5
EFI Variables Facility v0.05 2002-Mar-26
Starting kswapd
kinoded started
VFS: Diskquotas version dquot_6.5.0 initialized
aio_setup: num_physpages = 15601
aio_setup: sizeof(struct page) = 88
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with HUB-6 MANY_PORTS MULTIPORT
SHARE_I
RQ DETECT_IRQ SERIAL_PCI enabled
ÿttyS00 at 0x03f8 (irq = 44) is a 16550A
EFI Time Services Driver v0.3
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 29
VP_IDE: detected chipset, but driver not compiled in!
PCI: Found IRQ 0 for device 00:05.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x0700-0x0707, BIOS settings: hda:DMA, hdb:DMA
hda: HL-DT-STCD-RW/DVD DRIVE GCC-4160N, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 34
ide-floppy driver 0.99.newide
RAMDISK driver initialized: 16 RAM disks of 128000K size 1024 blocksize
loop: loaded (max 16 devices)
ide-floppy driver 0.99.newide
SCSI subsystem driver Revision: 1.00
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 32768 buckets, 256Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 1088kB freed
VFS: Mounted root (ext2 filesystem).
Loading module mptbase ...


********************
and then the boot process stops.
********************

Un saludo / Best regards / Bien Cordialement,

José RODRIGUEZ RUIBAL
Linux specialist - RHCE (Red Hat Certified Engineer)
IBM EMEA PSSC - Montpellier (France)
tel/fax: +33 (0) 467 34 42 50 / 62 45
Jose.Rodriguez.Ruibal@fr.ibm.com



