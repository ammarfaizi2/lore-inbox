Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263711AbSJJUcW>; Thu, 10 Oct 2002 16:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262212AbSJJUbz>; Thu, 10 Oct 2002 16:31:55 -0400
Received: from gw.glou.org ([62.4.18.209]:62991 "EHLO godet.glou.org")
	by vger.kernel.org with ESMTP id <S263711AbSJJUMs>;
	Thu, 10 Oct 2002 16:12:48 -0400
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: No mouse wheel in 2.5.40
References: <m3fzvpr833.fsf@carrosse.in.glou.org> <20021009132223.B714@ucw.cz>
Organization: Hipss canal alcoolique
From: Arnaud Gomes-do-Vale <arnaud@glou.org>
Date: 10 Oct 2002 22:17:53 +0200
In-Reply-To: <20021009132223.B714@ucw.cz>
Message-ID: <m3r8eyaw0e.fsf@carrosse.in.glou.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik <vojtech@suse.cz> writes:

> What does 'dmesg' report? What do you use in X/gpm as mouse type?

I don't use gpm, and my mouse is configured as a MouseManPlusPS/2 in X
(XFree86 4.2.0 if this matters). Here is my dmesg (including a few
"common" oopses):


Linux version 2.5.40 (arnaud@carrosse.in.glou.org) (gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-112)) #3 SMP mer oct 2 01:11:59 CEST 2002
Video mode to be used for restore is f01
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000018000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
384MB LOWMEM available.
found SMP MP-table at 000f5ae0
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
On node 0 totalpages: 98304
  DMA zone: 4096 pages
  Normal zone: 94208 pages
  HighMem zone: 0 pages
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #0 6:6 APIC version 17
Processor #1 6:6 APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Processors: 2
Building zonelist for node : 0
Kernel command line: auto BOOT_IMAGE=2.5.40 ro root=302 BOOT_FILE=/boot/vmlinuz-2.5.40 apm=power-off
Initializing CPU#0
Detected 434.321 MHz processor.
Console: colour VGA+ 80x50
Calibrating delay loop... 854.01 BogoMIPS
Memory: 385396k/393216k available (1545k kernel code, 7432k reserved, 394k data, 280k init, 0k highmem)
Security Scaffold v1.0.0 initialized
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: Before vendor init, caps: 0183fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
CPU: After vendor init, caps: 0183fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0183fbff 00000000 00000000 00000000
CPU:             Common caps: 0183fbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU: Before vendor init, caps: 0183fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
CPU: After vendor init, caps: 0183fbff 00000000 00000000 00000000
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0183fbff 00000000 00000000 00000000
CPU:             Common caps: 0183fbff 00000000 00000000 00000000
CPU0: Intel Celeron (Mendocino) stepping 05
per-CPU timeslice cutoff: 365.86 usecs.
task migration cache decay timeout: 1 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 866.30 BogoMIPS
CPU: Before vendor init, caps: 0183fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
CPU: After vendor init, caps: 0183fbff 00000000 00000000 00000000
Intel machine check reporting enabled on CPU#1.
CPU:     After generic, caps: 0183fbff 00000000 00000000 00000000
CPU:             Common caps: 0183fbff 00000000 00000000 00000000
CPU1: Intel Celeron (Mendocino) stepping 05
Total of 2 processors activated (1720.32 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-9, 2-11, 2-17, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 17.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
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
 09 000 00  1    0    0   0   0    0    0    00
 0a 001 01  0    0    0   0   0    1    1    71
 0b 000 00  1    0    0   0   0    0    0    00
 0c 001 01  0    0    0   0   0    1    1    79
 0d 001 01  0    0    0   0   0    1    1    81
 0e 001 01  0    0    0   0   0    1    1    89
 0f 001 01  0    0    0   0   0    1    1    91
 10 001 01  1    1    0   1   0    1    1    99
 11 000 00  1    0    0   0   0    0    0    00
 12 001 01  1    1    0   1   0    1    1    A1
 13 001 01  1    1    0   1   0    1    1    99
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
IRQ9 -> 0:16-> 0:19
IRQ10 -> 0:10
IRQ11 -> 0:18
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 434.0232 MHz.
..... host bus clock speed is 66.0804 MHz.
cpu: 0, clocks: 66804, slice: 2024
CPU0<T0:66800,T1:64768,D:8,S:2024,C:66804>
checking TSC synchronization across 2 CPUs: passed.
Starting migration thread for cpu 0
Bringing up 1
cpu: 1, clocks: 66804, slice: 2024
CPU1<T0:66800,T1:62752,D:0,S:2024,C:66804>
CPU 1 IS NOW UP!
Starting migration thread for cpu 1
bad: scheduling while atomic!
d7f31ef8 c0118e0d c028e2a0 00000000 00000000 00000000 00000000 00000000 
       d7f30000 d7f31f94 d7f31f98 d7f31f78 c01196f9 00000000 d7f2f060 c01192f0 
       00000000 00000000 c0118081 d7f31f58 c03354a0 00000001 d7f2f060 c01192f0 
Call Trace:
 [<c0118e0d>]schedule+0x3d/0x4d0
 [<c01196f9>]wait_for_completion+0x129/0x1e0
 [<c01192f0>]default_wake_function+0x0/0x40
 [<c0118081>]try_to_wake_up+0x331/0x340
 [<c01192f0>]default_wake_function+0x0/0x40
 [<c011b21e>]set_cpus_allowed+0x22e/0x250
 [<c011b290>]migration_thread+0x50/0x5b0
 [<c011b240>]migration_thread+0x0/0x5b0
 [<c011b240>]migration_thread+0x0/0x5b0
 [<c01055f9>]kernel_thread_helper+0x5/0xc

CPUS done 4294967295
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: probably your BIOS does not setup all CPUs
PCI: PCI BIOS revision 2.10 entry at 0xfb5c0, last bus=1
PCI: Using configuration type 1
adding '' to cpu class interfaces
adding '' to cpu class interfaces
isapnp: Scanning for PnP cards...
isapnp: SB audio device quirk - increasing port range
isapnp: AWE32 quirk - adding two ports
isapnp: Card 'Creative SB AWE64 PnP'
isapnp: 1 Plug & Play card detected total
PnPBIOS: Found PnP BIOS installation structure at 0xc00fc1e0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xc208, dseg 0xf0000
PnPBIOS: 16 nodes reported by PnP BIOS; 16 recorded by driver
PnPBIOS: PNP0c02: ioport range 0x208-0x20f has been reserved
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)
apm: disabled - APM is not SMP safe (power off active).
Starting kswapd
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
aio_setup: sizeof(struct page) = 40
VFS: Disk quotas vdquot_6.5.1
Journalled Block Device driver loaded
Capability LSM initialized
Limiting direct PCI/PCI transfers.
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 [PCSPP,TRISTATE]
parport0: cpp_daisy: aa5500ff(98)
parport0: assign_addrs: aa5500ff(98)
parport0: cpp_daisy: aa5500ff87(b8)
parport0: assign_addrs: aa5500ff87(b8)
pty: 256 Unix98 ptys configured
lp0: using parport0 (polling).
Real Time Clock Driver v1.11
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 31
 exit congestion at 33
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hda: ST36421A, ATA DISK drive
hdc: Maxtor 92049U6, ATA DISK drive
hdd: DVD-ROM DDU1621, ATAPI CD/DVD-ROM drive
Debug: sleeping function called from illegal context at slab.c:1374
d7f3dea4 c011b8b6 c028e3c0 c0290302 0000055e c03d961c c013e581 c0290302 
       0000055e c010cf22 d7f3c000 d7f3c000 0000000e d7f3c000 c03d961c c03d9654 
       c03d960c c03d961c c01e15e1 d7d41c28 000001d0 c03d9670 00000000 c03d961c 
Call Trace:
 [<c011b8b6>]__might_sleep+0x56/0x5d
 [<c013e581>]kmem_cache_alloc+0x21/0x210
 [<c010cf22>]i8259A_irq_pending+0xc2/0xd0
 [<c01e15e1>]blk_init_free_list+0x61/0x100
 [<c01e168d>]blk_init_queue+0xd/0xf0
 [<c01ed1d8>]ide_init_queue+0x28/0x70
 [<c01f3e20>]do_ide_request+0x0/0x20
 [<c01ed550>]init_irq+0x330/0x410
 [<c01ed90c>]hwif_init+0x10c/0x260
 [<c01edbdd>]ideprobe_init+0x8d/0x120
 [<c01c5913>]put_driver+0x13/0x92
 [<c010511b>]init+0x8b/0x250
 [<c0105090>]init+0x0/0x250
 [<c01055f9>]kernel_thread_helper+0x5/0xc

ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 12596850 sectors (6450 MB) w/256KiB Cache, CHS=784/255/63
 hda: hda1 hda2 hda3
hdc: host protected area => 1
hdc: 40026672 sectors (20494 MB) w/2048KiB Cache, CHS=39709/16/63
 hdc: hdc1 hdc2 hdc3 hdc4 < hdc5 hdc6 hdc7 hdc8 hdc9 hdc10 >
hdd: ATAPI 40X DVD-ROM drive, 512kB Cache
Uniform CD-ROM driver Revision: 3.12
SCSI subsystem driver Revision: 1.00
sym.0.11.0: setting PCI_COMMAND_PARITY...
sym.0.11.0: setting PCI_COMMAND_INVALIDATE.
sym0: <875> rev 0x3 on pci bus 0 device 11 function 0 irq 11
sym0: Tekram NVRAM, ID 7, Fast-20, SE, parity checking
sym0: SCSI BUS has been reset.
scsi0 : sym-2.1.16a
  Vendor: IBM       Model: DDRS-34560D       Rev: DC1B
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: YAMAHA    Model: CRW8824S          Rev: 1.00
  Type:   CD-ROM                             ANSI SCSI revision: 02
sym0:1:0: tagged command queuing enabled, command queue depth 16.
Attached scsi disk sda at scsi0, channel 0, id 1, lun 0
sym0:1: FAST-20 WIDE SCSI 40.0 MB/s ST (50.0 ns, offset 15)
SCSI device sda: 8925000 512-byte hdwr sectors (4570 MB)
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 >
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 2, lun 0
sym0:2: FAST-20 SCSI 20.0 MB/s ST (50.0 ns, offset 15)
sr0: scsi3-mmc drive: 24x/16x writer cd/rw xa/form2 cdda tray
Debug: sleeping function called from illegal context at slab.c:1374
d7f3def8 c011b8b6 c028e3c0 c0290302 0000055e 00001000 c013e7c1 c0290302 
       0000055e c016a4c4 c13c9060 c13cdc00 c13cdc00 d7d274e0 c02dfaf8 d8000000 
       00001000 d7f3c000 00001000 c013ce6d 0000001c 000001d0 d7d03020 00000246 
Call Trace:
 [<c011b8b6>]__might_sleep+0x56/0x5d
 [<c013e7c1>]kmalloc+0x51/0x260
 [<c016a4c4>]alloc_inode+0x54/0x170
 [<c013ce6d>]get_vm_area+0x1d/0x140
 [<c013d1db>]__vmalloc+0x3b/0x120
 [<c013d2d6>]vmalloc+0x16/0x20
 [<c021b829>]sg_init+0xd9/0x180
 [<c02044fd>]scsi_register_device+0x8d/0x130
 [<c010511b>]init+0x8b/0x250
 [<c0105090>]init+0x0/0x250
 [<c01055f9>]kernel_thread_helper+0x5/0xc

register interface 'mouse' with class 'input
mice: PS/2 mouse device common for all mice
register interface 'event' with class 'input
input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 2048 buckets, 32Kbytes
TCP: Hash tables configured (established 16384 bind 21845)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 280k freed
APIC error on CPU1: 00(08)
APIC error on CPU0: 00(08)
APIC error on CPU0: 08(02)
hda: status timeout: status=0xd0 { Busy }

hda: no DRQ after issuing WRITE
ide0: reset: success
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,2), internal journal
Adding 205120k swap on /dev/hdc3.  Priority:-1 extents:1
Adding 102776k swap on /dev/hdc7.  Priority:-2 extents:1
APIC error on CPU0: 02(08)
APIC error on CPU1: 08(02)
APIC error on CPU0: 08(08)
APIC error on CPU1: 02(02)
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on sd(8,3), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on sd(8,5), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide1(22,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide1(22,6), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on sd(8,6), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on sd(8,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide1(22,5), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide1(22,9), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on sd(8,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.


-- 
Amicalement,
Arnaud
