Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267159AbTCAUzC>; Sat, 1 Mar 2003 15:55:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269022AbTCAUzC>; Sat, 1 Mar 2003 15:55:02 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21509 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267159AbTCAUy4>;
	Sat, 1 Mar 2003 15:54:56 -0500
Date: Sat, 1 Mar 2003 21:05:18 +0000
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: linux-kernel@vger.kernel.org
Subject: 2.5.63: 'Debug: sleeping function called from illegal context at mm/slab.c:1617'
Message-ID: <20030301210518.GA740@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.4.18 (i686)
X-Uptime: 21:01:38 up 3 min,  1 user,  load average: 0.16, 0.14, 0.06
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  2.5.63 had a good go at trying to boot for me; the only error during
boot was 'Debug: sleeping function called from illegal context at
mm/slab.c:1617' during the IDE startup.

Full boot messages included (backtrace about halfway down, search for
hdg).

This is a dual Athlon MP on Tyan S2460 board, with a Promise TX100
controller running a pair of drives.

Dave

{<>}{<>}{<>}{<>}{<>}{<>}{<>}{<>}{<>}{<>}{<>}{<>}{<>}{<>}{<>}{<>}{<>}{<>}{<>}{<>}
 check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: AMD Athlon(tm) Processor stepping 02
Total of 2 processors activated (6062.08 BogoMIPS).
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 16.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  0    0    0   0   0    1    1    71
 0a 001 01  0    0    0   0   0    1    1    79
 0b 001 01  0    0    0   0   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  0    0    0   0   0    1    1    99
 0f 001 01  0    0    0   0   0    1    1    A1
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1526.0261 MHz.
..... host bus clock speed is 265.0436 MHz.
checking TSC synchronization across 2 CPUs: passed.
Starting migration thread for cpu 0
Bringing up 1
CPU 1 IS NOW UP!
Starting migration thread for cpu 1
CPUS done 2
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: probably your BIOS does not setup all CPUs.
mtrr: corrected configuration.
PCI: PCI BIOS revision 2.10 entry at 0xfd7e0, last bus=1
PCI: Using configuration type 1
BIO: pool of 256 setup, 15Kb (60 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030122
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:.........................................................................
Table [DSDT] - 300 Objects with 27 Devices 73 Methods 34 Regions
ACPI Namespace successfully loaded at root c05954dc
IOAPIC[0]: Set PCI routing entry (2-9 -> 0x71 -> IRQ 9)
evxfevnt-0092 [04] acpi_enable           : Transition to ACPI mode successful
Executing all Device _STA and_INI methods:...........................
27 Devices found containing: 27 _STA, 0 _INI methods
Completing Region/Field/Buffer/Package initialization:..............................................................
Initialized 30/34 Regions 0/0 Fields 22/22 Buffers 10/10 Packages (300 nodes)
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 *5 10 11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 5 10 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 5 *10 11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 5 10 *11)
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 15
 exit congestion at 17
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
IOAPIC[0]: Set PCI routing entry (2-16 -> 0xa9 -> IRQ 16)
00:00:07[A] -> 2-16 -> IRQ 16
IOAPIC[0]: Set PCI routing entry (2-17 -> 0xb1 -> IRQ 17)
00:00:07[B] -> 2-17 -> IRQ 17
IOAPIC[0]: Set PCI routing entry (2-18 -> 0xb9 -> IRQ 18)
00:00:07[C] -> 2-18 -> IRQ 18
IOAPIC[0]: Set PCI routing entry (2-19 -> 0xc1 -> IRQ 19)
00:00:07[D] -> 2-19 -> IRQ 19
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Starting balanced_irq
Enabling SEP on CPU 0
Enabling SEP on CPU 1
Total HugeTLB memory allocated, 0
aio_setup: sizeof(struct page) = 40
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
udf: registering filesystem
Capability LSM initialized
Initializing Cryptographic API
BIOS failed to enable PCI standards compliance, fixing this error.
I/O APIC: AMD Errata #22 may be present. In the event of instability try
        : booting with the "noapic" option.
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (FF) [SLPF]
ACPI: Processor [CPU0] (supports C1)
ACPI: Processor [CPU1] (supports C1)
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 [PCSPP]
parport0: irq 7 detected
parport0: cpp_mux: aa55f00f52ad51(87)
parport0: cpp_daisy: aa5500ff(80)
parport0: assign_addrs: aa5500ff(80)
parport0: cpp_mux: aa55f00f52ad51(87)
parport0: cpp_daisy: aa5500ff(80)
parport0: assign_addrs: aa5500ff(80)
pty: 256 Unix98 ptys configured
lp0: using parport0 (polling).
Real Time Clock Driver v1.11
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected AMD 760MP chipset
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 64M @ 0xec000000
[drm] Initialized radeon 1.7.0 20020828 on minor 0
ipmi: message handler initialized
ipmi: device interface at char major 254
ipmi_kcs: SPMI table not found.
ipmi_kcs: No KCS @ port 0x0ca2
ipmi_kcs: Unable to find any KCS interfaces
IPMI watchdog by Corey Minyard (minyard@mvista.com)
Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin is 60 seconds).
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
00:0d.0: 3Com PCI 3c905C Tornado at 0x1000. Vers LK1.1.19
Universal TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD7411: IDE controller at PCI slot 00:07.1
AMD7411: chipset revision 1
AMD7411: not 100% native mode: will probe irqs later
AMD_IDE: Advanced Micro Devic AMD-766 [ViperPlus]  (rev 01) UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
hda: IC35L060AVER07-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: Memorex 24MAXX 1040, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
PDC20268: IDE controller at PCI slot 00:0c.0
PDC20268: chipset revision 2
PDC20268: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0x10d0-0x10d7, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0x10d8-0x10df, BIOS settings: hdg:DMA, hdh:pio
hde: Pioneer DVD-ROM ATAPIModel DVD-116 0109, ATAPI CD/DVD-ROM drive
hdf: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
Debug: sleeping function called from illegal context at mm/slab.c:1617
Call Trace:
 [<c0146265>] kmalloc+0x95/0xa0
 [<c0192f1d>] proc_create+0x8d/0x120
 [<c01930eb>] proc_mkdir+0x2b/0x70
 [<c010c99c>] register_irq_proc+0x7c/0xd0
 [<c010c70f>] setup_irq+0x12f/0x170
 [<c02e6770>] ide_intr+0x0/0x2e0
 [<c010bf07>] request_irq+0x97/0xd0
 [<c02e7e88>] init_irq+0x188/0x520
 [<c02e6770>] ide_intr+0x0/0x2e0
 [<c02e8671>] hwif_init+0xe1/0x280
 [<c02e7b8c>] probe_hwif_init+0x2c/0x80
 [<c02fd9be>] ide_setup_pci_device+0x4e/0x80
 [<c02e4f3b>] pdc202new_init_one+0x3b/0x40
 [<c01050a1>] init+0x61/0x190
 [<c0105040>] init+0x0/0x190
 [<c01073b1>] kernel_thread_helper+0x5/0x14

ide2 at 0x10f8-0x10ff,0x10f2 on irq 16
hdg: IC35L060AVER07-0, ATA DISK drive
ide3 at 0x10e8-0x10ef,0x10e6 on irq 16
hda: host protected area => 1
hda: 120103200 sectors (61493 MB) w/1916KiB Cache, CHS=119150/16/63, UDMA(100)
 hda: hda1 hda2 hda3 hda4
hdg: host protected area => 1
hdg: 120103200 sectors (61493 MB) w/1916KiB Cache, CHS=119150/16/63, UDMA(100)
 hdg: hdg1 hdg2 hdg3 hdg4
hde: ATAPI 40X DVD-ROM drive, 256kB Cache
Uniform CD-ROM driver Revision: 3.12
end_request: I/O error, dev hde, sector 0
ide-floppy driver 0.99.newide
hdf: No disk in drive
hdf: 98304kB, 96/64/32 CHS, 4096 kBps, 512 sector size, 2941 rpm
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: Memorex   Model: 24MAXX 1040       Rev: 5WS2
  Type:   CD-ROM                             ANSI SCSI revision: 02
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
drivers/usb/host/ehci-hcd.c: block sizes: qh 128 qtd 96 itd 128 sitd 64
drivers/usb/host/ohci-pci.c: 2002-Sep-17 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
drivers/usb/host/ohci-pci.c: block sizes: ed 64 td 64
ohci-hcd 00:07.4: Advanced Micro Devic AMD-766 [ViperPlus] 
ohci-hcd 00:07.4: irq 19, pci mem c00dc000
Please use the 'usbfs' filetype instead, the 'usbdevfs' name is deprecated.
ohci-hcd 00:07.4: new USB bus registered, assigned bus number 1
ohci-hcd 00:07.4: USB HC TakeOver from BIOS/SMM
ohci-hcd 00:07.4: USB HC reset_hc 00:07.4: ctrl = 0x683 ;
ohci-hcd 00:07.4: root hub device address 1
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: Advanced Micro Devic AMD-766 [ViperPlus] 
usb usb1: Manufacturer: Linux 2.5.63 ohci-hcd
usb usb1: SerialNumber: 00:07.4
drivers/usb/core/usb.c: usb_hotplug
usb usb1: usb_new_device - registering interface 1-0:0
hub 1-0:0: usb_device_probe
hub 1-0:0: usb_device_probe - got id
hub 1-0:0: USB hub found
hub 1-0:0: 4 ports detected
hub 1-0:0: standalone hub
hub 1-0:0: ganged power switching
hub 1-0:0: global over-current protection
hub 1-0:0: Port indicators are not supported
hub 1-0:0: power on to power good time: 2ms
hub 1-0:0: hub controller current requirement: 0mA
hub 1-0:0: local power source is good
hub 1-0:0: no over-current condition exists
hub 1-0:0: enabling power on all ports
drivers/usb/core/usb.c: usb_hotplug
ohci-hcd 00:07.4: created debug files
ohci-hcd 00:07.4: OHCI controller state
ohci-hcd 00:07.4: OHCI 1.0, with legacy support registers
ohci-hcd 00:07.4: control: 0x0000068f RWE RWC HCFS=operational IE PLE CBSR=3
ohci-hcd 00:07.4: cmdstatus: 0x00000000 SOC=0
ohci-hcd 00:07.4: intrstatus: 0x00000004 SF
ohci-hcd 00:07.4: intrenable: 0x80000002 MIE WDH
ohci-hcd 00:07.4: hcca frame #0011
ohci-hcd 00:07.4: roothub.a: 01000204 POTPGT=1 NPS NDP=4
ohci-hcd 00:07.4: roothub.b: 00000000 PPCM=0000 DR=0000
ohci-hcd 00:07.4: roothub.status: 00000000
ohci-hcd 00:07.4:  roothub.portstatus [0] = 0x00000100 PPS
ohci-hcd 00:07.4:  roothub.portstatus [1] = 0x00000100 PPS
ohci-hcd 00:07.4:  roothub.portstatus [2] = 0x00000100 PPS
ohci-hcd 00:07.4:  roothub.portstatus [3] = 0x00000100 PPS
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.0
mice: PS/2 mouse device common for all mice
input: PC Speaker
input: PS/2 Logitech Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
i2c-dev.o: i2c /dev entries driver module version 2.7.0 (20021208)
i2c-proc.o version 2.7.0 (20021208)
i2c-dev.o: Registered 'SMBus AMD75x adapter at 80e0' as minor 0
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
device-mapper: 1.0.6-ioctl (2002-10-15) initialised: dm@uk.sistina.com
Advanced Linux Sound Architecture Driver Version 0.9.0rc7 (Sat Feb 15 15:01:21 2003 UTC).
request_module: failed /sbin/modprobe -- snd-card-0. error = -16
ALSA device list:
  #0: Ensoniq AudioPCI ENS1371 at 0x1080, irq 19
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 2048 buckets, 32Kbytes
TCP: Hash tables configured (established 16384 bind 21845)
ip_conntrack version 2.1 (4095 buckets, 32760 max) - 308 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
arp_tables: (C) 2002 David S. Miller
Initializing IPsec netlink socket
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
BIOS EDD facility v0.09 2003-Jan-22, 2 devices found
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 164k freed
Adding 1052248k swap on /dev/hda2.  Priority:-1 extents:1
Adding 1052248k swap on /dev/hdg2.  Priority:-2 extents:1
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,1), internal journal
md: autorun ...
md: considering hdg4 ...
md:  adding hdg4 ...
md:  adding hda4 ...
md: created md0
md: bind<hda4>
md: bind<hdg4>
md: running: <hdg4><hda4>
md0: max total readahead window set to 128k
md0: 1 data-disks, max readahead per data-disk: 128k
md0: setting max_sectors to 8, segment boundary to 2047
blk_queue_segment_boundary: set to minimum fff
raid1: raid set md0 active with 2 out of 2 mirrors
md: updating md0 RAID superblock on device (in sync 0)
md: hdg4 <6>(write) hdg4's sb offset: 8642880
md: hda4 <6>(write) hda4's sb offset: 8642880
md: ... autorun DONE.
warning: process `update' used the obsolete bdflush system call
Fix your initscripts?
{<>}{<>}{<>}{<>}{<>}{<>}{<>}{<>}{<>}{<>}{<>}{<>}{<>}{<>}{<>}{<>}{<>}{<>}{<>}{<>}
 ---------------- Have a happy GNU millennium! ----------------------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
