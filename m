Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262424AbTEEPv6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 11:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262439AbTEEPv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 11:51:58 -0400
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:40465 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262424AbTEEPvn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 11:51:43 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: andrew.grover@intel.com
Subject: [2.5.69] ACPI error message on boot
Date: Mon, 5 May 2003 18:03:11 +0200
User-Agent: KMail/1.5.1
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       acpi-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200305051803.22568.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi.

I get some error messages from ACPI on booting 2.5.69:

ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
 exfldio-0140 [25] ex_setup_region       : Field [TOMR] Base+Offset+Width 0+2+1 is beyond end of region [TMEM] (length 2)
 dswexec-0421 [17] ds_exec_end_op        : [ShiftLeft]: Could not resolve operands, AE_AML_REGION_LIMIT
 psparse-1121: *** Error: Method execution failed [\_SB_.PCI0.MDET] (Node c12db9a8), AE_AML_REGION_LIMIT
 psparse-1121: *** Error: Method execution failed [\_SB_.PCI0._CRS] (Node c12dbf28), AE_AML_REGION_LIMIT
  uteval-0098: *** Error: Method execution failed [\_SB_.PCI0._CRS] (Node c12dbf28), AE_AML_REGION_LIMIT
ACPI: PCI Root Bridge [PCI0] (00:00)


[full boot-log:]
Linux version 2.5.69 (mb@lfs) (gcc version 3.2.3) #1 Mon Mai 5 17:31:33 CEST 2003
Video mode to be used for restore is 30b
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d0000 - 00000000000d4000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fff8000 (ACPI data)
 BIOS-e820: 000000000fff8000 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffb00000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
user-defined physical RAM map:
 user: 0000000000000000 - 000000000009fc00 (usable)
 user: 000000000009fc00 - 00000000000a0000 (reserved)
 user: 00000000000d0000 - 00000000000d4000 (reserved)
 user: 00000000000f0000 - 0000000000100000 (reserved)
 user: 0000000000100000 - 000000000fff0000 (usable)
 user: 000000000fff0000 - 000000000fff8000 (ACPI data)
 user: 000000000fff8000 - 0000000010000000 (ACPI NVS)
 user: 00000000fec00000 - 00000000fec01000 (reserved)
 user: 00000000fee00000 - 00000000fee01000 (reserved)
 user: 00000000ffb00000 - 00000000ffc00000 (reserved)
 user: 00000000fff00000 - 0000000100000000 (reserved)
255MB LOWMEM available.
found SMP MP-table at 000fb800
hm, page 000fb000 reserved twice.
hm, page 000fc000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
On node 0 totalpages: 65520
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61424 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v000 AMI                        ) @ 0x000fa300
ACPI: RSDT (v001 AMIINT INTEL845 00000.00016) @ 0x0fff0000
ACPI: FADT (v001 AMIINT INTEL845 00000.00017) @ 0x0fff0030
ACPI: MADT (v001 AMIINT INTEL845 00000.00009) @ 0x0fff00c0
ACPI: DSDT (v001  INTEL BROKDALE 00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 16
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, IRQ 0-23
ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x0])
ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x1] trigger[0x3])
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Building zonelist for node : 0
Kernel command line: console=ttyS1,9600 console=tty0 root=/dev/md0 hdd=ide-scsi hdb=ide-scsi mce vga=779 mem=262080K
ide_setup: hdd=ide-scsi
ide_setup: hdb=ide-scsi
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Console: colour VGA+ 132x50
Calibrating delay loop... 4423.68 BogoMIPS
Memory: 253972k/262080k available (2944k kernel code, 7388k reserved, 1025k data, 368k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
- -> /dev/console
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#0: Thermal monitoring enabled
CPU: Intel(R) Pentium(R) 4 CPU 1.60GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
..TIMER: vector=0x31 pin1=2 pin2=0
testing the IO APIC.......................
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030418
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:....................................................................................................................................................
Table [DSDT] - 495 Objects with 44 Devices 148 Methods 15 Regions
ACPI Namespace successfully loaded at root c055561c
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successful
evgpeblk-0740 [06] ev_create_gpe_block   : GPE Block: [_GPE] 2 registers at 0000000000000828 on interrupt 9
evgpeblk-0745 [06] ev_create_gpe_block   : GPE Block defined as GPE 0x00 to GPE 0x0F
evgpeblk-0262 [08] ev_save_method_info   : Registered GPE method _L0B as GPE number 0x0B
evgpeblk-0262 [08] ev_save_method_info   : Registered GPE method _L03 as GPE number 0x03
evgpeblk-0262 [08] ev_save_method_info   : Registered GPE method _L04 as GPE number 0x04
evgpeblk-0740 [06] ev_create_gpe_block   : GPE Block: [_GPE] 2 registers at 000000000000082C on interrupt 9
evgpeblk-0745 [06] ev_create_gpe_block   : GPE Block defined as GPE 0x10 to GPE 0x1F
evgpeblk-0262 [08] ev_save_method_info   : Registered GPE method _L1C as GPE number 0x1C
Executing all Device _STA and_INI methods:............................................
44 Devices found containing: 44 _STA, 1 _INI methods
Completing Region/Field/Buffer/Package initialization:..................................................................................
Initialized 10/15 Regions 10/10 Fields 50/50 Buffers 12/12 Packages (495 nodes)
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
 exfldio-0140 [25] ex_setup_region       : Field [TOMR] Base+Offset+Width 0+2+1 is beyond end of region [TMEM] (length 2)
 dswexec-0421 [17] ds_exec_end_op        : [ShiftLeft]: Could not resolve operands, AE_AML_REGION_LIMIT
 psparse-1121: *** Error: Method execution failed [\_SB_.PCI0.MDET] (Node c12db9a8), AE_AML_REGION_LIMIT
 psparse-1121: *** Error: Method execution failed [\_SB_.PCI0._CRS] (Node c12dbf28), AE_AML_REGION_LIMIT
  uteval-0098: *** Error: Method execution failed [\_SB_.PCI0._CRS] (Node c12dbf28), AE_AML_REGION_LIMIT
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Transparent bridge - Intel Corp. 82801BA/CA/DB PCI Br
ACPI: Power Resource [URP1] (off)
ACPI: Power Resource [URP2] (off)
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *10 11 12 14 15)
Linux Plug and Play Support v0.96 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f7520
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x65ab, dseg 0xf0000
PnPBIOS: 14 nodes reported by PnP BIOS; 14 recorded by driver
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 15
 exit congestion at 17
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic channels, max=256).
CSLIP: code copyright 1989 Regents of the University of California.
Initializing RT netlink socket
Machine check exception polling timer started.
Enabling SEP on CPU 0
Total HugeTLB memory allocated, 0
Journalled Block Device driver loaded
Initializing Cryptographic API
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU1] (supports C1, 8 throttling states)
pty: 256 Unix98 ptys configured
lp: driver loaded but no devices found
Real Time Clock Driver v1.11
Non-volatile memory driver v1.2
Software Watchdog Timer: 0.06, soft_margin: 60 sec, nowayout: 0
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected Intel i845 chipset
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: AGP aperture is 64M @ 0xe0000000
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
lp0: using parport0 (polling).
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
ne2k-pci.c:v1.02 10/19/2000 D. Becker/P. Gortmaker
  http://www.scyld.com/network/ne2k-pci.html
eth0: RealTek RTL-8029 found at 0xb400, IRQ 17, 52:54:05:FF:F5:EA.
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
Linux video capture interface: v1.00
bttv: driver version 0.9.4 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Host bridge is Intel Corp. 82845 845 (Brookdale
bttv: Bt8xx card found (0).
bttv0: Bt878 (rev 17) at 03:02.0, irq: 18, latency: 32, mmio: 0xddafe000
bttv0: detected: Hauppauge WinTV [card=10], PCI subsystem ID is 0070:13eb
bttv0: using: BT878(Hauppauge (bt878)) [card=10,autodetected]
bttv0: Hauppauge/Voodoo msp34xx: reset line init [5]
bttv0: Hauppauge eeprom: model=44354, tuner=Philips FM1216 (5), radio=yes
bttv0: using tuner=5
bttv0: i2c: checking for MSP34xx @ 0x80... found
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: registered device radio0
bttv0: PLL: 28636363 => 35468950 .. ok
msp34xx: init: chip=MSP3415D-B3, has NICAM support
msp3410: daemon started
bttv0: i2c attach [client=MSP3415D-B3,ok]
registering 0-0040
tvaudio: TV audio decoder + audio/video mux driver
tvaudio: known chips: tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,tea6420,tda8425,pic16c54 (PV951)
tuner: probing bt848 #0 i2c adapter [id=0x10005]
tuner: chip found @ 0xc2
tuner: type set to 5 (Philips PAL_BG (FI1216 and compatibles))
bttv0: i2c attach [client=Philips PAL_BG (FI1216 and compatibles),ok]
registering 0-0061
tda9887: probing bt848 #0 i2c adapter [id=0x10005]
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH2: IDE controller at PCI slot 00:1f.1
ICH2: chipset revision 5
ICH2: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:DMA
hda: IC35L040AVVA07-0, ATA DISK drive
hdb: LG DVD-ROM DRD-8160B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: IC35L040AVVA07-0, ATA DISK drive
hdd: CD-W54E, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 80418240 sectors (41174 MB) w/1863KiB Cache, CHS=79780/16/63, UDMA(100)
 hda: hda1 hda2 hda3 < hda5 hda6 >
hdc: host protected area => 1
hdc: 80418240 sectors (41174 MB) w/1863KiB Cache, CHS=79780/16/63, UDMA(33)
 hdc: hdc1 hdc2 hdc3 < hdc5 hdc6 hdc7 >
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: LG        Model: DVD-ROM DRD8160B  Rev: 1.01
  Type:   CD-ROM                             ANSI SCSI revision: 02
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: TEAC      Model: CD-W54E           Rev: 1.0Y
  Type:   CD-ROM                             ANSI SCSI revision: 02
sr0: scsi3-mmc drive: 0x/48x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
sr1: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
mice: PS/2 mouse device common for all mice
input: PC Speaker
input: GenPS/2 Genius Wheel Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
I2O Core - (C) Copyright 1999 Red Hat Software
I2O: Event thread created as pid 12
i2o: Checking for PCI I2O controllers...
I2O configuration manager v 0.04.
  (C) Copyright 1999 Red Hat Software
I2O Block Storage OSM v0.9
   (c) Copyright 1999-2001 Red Hat Software.
i2o_block: Checking for Boot device...
i2o_block: Checking for I2O Block devices...
i2o_scsi.c: Version 0.1.2
  chain_pool: 0 bytes @ cfdce6a0
  (512 byte buffers X 4 can_queue X 0 i2o controllers)
i2c /dev entries driver module version 2.7.0 (20021208)
md: raid0 personality registered as nr 2
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
ISDN subsystem initialized
PPP BSD Compression module registered
HiSax: Linux Driver for passive ISDN cards
HiSax: Version 3.5 (kernel)
HiSax: Layer1 Revision 2.41.6.5
HiSax: Layer2 Revision 2.25.6.4
HiSax: TeiMgr Revision 2.17.6.3
HiSax: Layer3 Revision 2.17.6.5
HiSax: LinkLayer Revision 2.51.6.6
HiSax: Approval certification failed because of
HiSax: unauthorized source code changes
hisax_isac: ISAC-S/ISAC-SX ISDN driver v0.1.0
hisax_fcpcipnp: Fritz!Card PCI/PCIv2/PnP ISDN driver v0.0.1
get_drv 0: 0 -> 1
HiSax: Card 1 Protocol EDSS1 Id=fcpcipnp0 (0)
**[NOTE: This oops is from hisax-subsystem and has nothing to do with ACPI.]
**[      Just another problem. :) ]
Unable to handle kernel NULL pointer dereference at virtual address 00000004
 printing eip:
c030ec7a
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c030ec7a>]    Not tainted
EFLAGS: 00010286
EIP is at setstack_HiSax+0x85/0xa2
eax: 00000000   ebx: cfd25400   ecx: cfd24000   edx: cfd255e0
esi: cfd24000   edi: cfd2410c   ebp: c1293ddc   esp: c1293dcc
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=c1292000 task=c12ae080)
Stack: cfd25400 cfd2542c cfd25400 cfd24000 c1293e0c c031a63b cfd25400 cfd24000 
       cfd2410c cfd2410c cfd24000 c1293e0c c031a54e cfd24124 cfd2410c cfd24000 
       c1293e28 c031a86a cfd2410c cfd2413c cfd24000 c1293e9a cfd240da c1293e44 
Call Trace:
 [<c031a63b>] init_d_st+0x52/0x11d
 [<c031a54e>] init_PStack+0x20/0xbb
 [<c031a86a>] init_chan+0x10b/0x115
 [<c031a89a>] CallcNewChan+0x26/0xbf
 [<c050240a>] checkcard+0x20f/0x27a
 [<c030cb4f>] hisax_register+0x86/0x12b
 [<c0502f4d>] new_adapter+0xc9/0xd3
 [<c017a10c>] init_dir+0x0/0x1c
 [<c0212efc>] pci_device_probe+0x5a/0x68
 [<c02788b9>] bus_match+0x43/0x6e
 [<c02789bb>] driver_attach+0x5c/0x60
 [<c0278c89>] bus_add_driver+0xb1/0xc6
 [<c02790a7>] driver_register+0x31/0x35
 [<c0503013>] hisax_fcpcipnp_init+0x21/0x4e
 [<c04e46f9>] do_initcalls+0x2b/0x98
 [<c01294e6>] init_workqueues+0x12/0x2c
 [<c01050a3>] init+0x39/0x196
 [<c010506a>] init+0x0/0x196
 [<c0107289>] kernel_thread_helper+0x5/0xb
Code: 8b 50 04 85 d2 75 0a 8b 5d f8 8b 75 fc 89 ec 5d c3 89 74 24 
 <0>Kernel panic: Attempted to kill init!


[.config]
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_EXPERIMENTAL=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_KMOD=y
CONFIG_X86_PC=y
CONFIG_MPENTIUM4=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_HUGETLB_PAGE=y
CONFIG_PREEMPT=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_X86_MCE_P4THERMAL=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_PM=y
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_PC_CML1=y
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
CONFIG_PNP_NAMES=y
CONFIG_PNPBIOS=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDESCSI=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_BLK_DEV_SR=y
CONFIG_CHR_DEV_SG=y
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_RAID0=y
CONFIG_I2O=y
CONFIG_I2O_PCI=y
CONFIG_I2O_BLOCK=y
CONFIG_I2O_SCSI=y
CONFIG_I2O_PROC=y
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_NETFILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_NET_IPGRE=y
CONFIG_SYN_COOKIES=y
CONFIG_IP_NF_CONNTRACK=y
CONFIG_IP_NF_FTP=y
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_LIMIT=y
CONFIG_IP_NF_MATCH_MAC=y
CONFIG_IP_NF_MATCH_PKTTYPE=y
CONFIG_IP_NF_MATCH_MARK=y
CONFIG_IP_NF_MATCH_MULTIPORT=y
CONFIG_IP_NF_MATCH_TOS=y
CONFIG_IP_NF_MATCH_ECN=y
CONFIG_IP_NF_MATCH_LENGTH=y
CONFIG_IP_NF_MATCH_TCPMSS=y
CONFIG_IP_NF_MATCH_STATE=y
CONFIG_IP_NF_MATCH_UNCLEAN=y
CONFIG_IP_NF_MATCH_OWNER=y
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=y
CONFIG_IP_NF_TARGET_MIRROR=y
CONFIG_IP_NF_NAT=y
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=y
CONFIG_IP_NF_TARGET_REDIRECT=y
CONFIG_IP_NF_NAT_FTP=y
CONFIG_IP_NF_MANGLE=y
CONFIG_IP_NF_TARGET_TOS=y
CONFIG_IP_NF_TARGET_MARK=y
CONFIG_IP_NF_TARGET_LOG=y
CONFIG_IP_NF_TARGET_TCPMSS=y
CONFIG_IPV6_SCTP__=y
CONFIG_NETDEVICES=y
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_NE2K_PCI=y
CONFIG_PPP=y
CONFIG_PPP_ASYNC=y
CONFIG_PPP_SYNC_TTY=y
CONFIG_PPP_DEFLATE=y
CONFIG_PPP_BSDCOMP=y
CONFIG_PPPOE=y
CONFIG_SLIP=y
CONFIG_SLIP_COMPRESSED=y
# Token Ring devices (depends on LLC=y)
CONFIG_ISDN_BOOL=y
CONFIG_ISDN=y
CONFIG_ISDN_PPP=y
CONFIG_ISDN_PPP_VJ=y
CONFIG_ISDN_PPP_BSDCOMP=y
CONFIG_ISDN_AUDIO=y
CONFIG_ISDN_TTY_FAX=y
CONFIG_ISDN_DRV_HISAX=y
CONFIG_HISAX_EURO=y
CONFIG_HISAX_FRITZ_PCIPNP=y
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_PRINTER=y
CONFIG_I2C=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_CHARDEV=y
CONFIG_SENSORS_W83781D=y
CONFIG_I2C_SENSOR=y
CONFIG_WATCHDOG=y
CONFIG_SOFT_WATCHDOG=y
CONFIG_NVRAM=y
CONFIG_RTC=y
CONFIG_AGP=y
CONFIG_AGP_INTEL=y
CONFIG_VIDEO_DEV=y
CONFIG_VIDEO_PROC_FS=y
CONFIG_VIDEO_BT848=y
CONFIG_VIDEO_VIDEOBUF=y
CONFIG_VIDEO_TUNER=y
CONFIG_VIDEO_BUF=y
CONFIG_VIDEO_BTCX=y
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_JBD=y
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
CONFIG_FS_POSIX_ACL=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFS_V4=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=y
CONFIG_RPCSEC_GSS_KRB5=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_ISO8859_15=y
CONFIG_VIDEO_SELECT=y
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_SOUND=y
CONFIG_SND=y
CONFIG_SND_SEQUENCER=y
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=y
CONFIG_SND_VERBOSE_PRINTK=y
CONFIG_SND_ENS1371=y
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_KALLSYMS=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
CONFIG_FRAME_POINTER=y
CONFIG_X86_EXTRA_IRQS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_AES=y
CONFIG_CRC32=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_X86_BIOS_REBOOT=y


acpi-devel-list: Please cc me, as I'm not subscribed to acpi-devel.

- -- 
Regards Michael Büsch
http://www.8ung.at/tuxsoft
 17:53:32 up 18 min,  2 users,  load average: 1.08, 1.00, 0.70
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+totKoxoigfggmSgRAvqBAJ9gPICEE7oyJ9IF43jC/2SX+vBnvQCeJlZ1
+zVeoC7NY1vCZ0QzwHrUDeA=
=442c
-----END PGP SIGNATURE-----

