Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267436AbTBIUu3>; Sun, 9 Feb 2003 15:50:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267437AbTBIUu2>; Sun, 9 Feb 2003 15:50:28 -0500
Received: from pintail.mail.pas.earthlink.net ([207.217.120.122]:8885 "EHLO
	pintail.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S267436AbTBIUuX>; Sun, 9 Feb 2003 15:50:23 -0500
From: Glen Kaukola <glen@earthlink.net>
To: linux-kernel@vger.kernel.org
Subject: Kernel panic: Attempted to kill the idle task
Date: Sun, 9 Feb 2003 05:00:21 -0800
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_lDlR+O3zUXj11Gq"
Message-Id: <200302090500.21193.glen@earthlink.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_lDlR+O3zUXj11Gq
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

On my Gentoo system, I installed a 2.5.59 kernel, and when I boot it, it tells 
me this:

Kernel panic: Attempted to kill the idle task
In idle task - not syncing
 Stuck ??
CPU #1 not responding - cannot use it

But then it goes ahead and boots anyway, and I just have one cpu missing from 
programs like top.  My system is a supermicro P4DC6+ motherboard with two 2.2 
Ghz pentium 4 xeons.  I've attached the output of dmesg.  If you need 
anything else from me that would be of help then let me know.

Thanks for your time.
--Boundary-00=_lDlR+O3zUXj11Gq
Content-Type: text/plain;
  charset="us-ascii";
  name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="dmesg.txt"

Linux version 2.5.59-mm8 (root@cheetah) (gcc version 3.2.1 20021207 (Gentoo Linux 3.2.1-20021207)) #2 SMP Sat Feb 8 12:51:46 PST 2003
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
511MB LOWMEM available.
found SMP MP-table at 000f5010
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126960 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v000 IntelR                     ) @ 0x000f6bf0
ACPI: RSDT (v001 IntelR AWRDACPI 16944.11825) @ 0x1fff3000
ACPI: FADT (v001 IntelR AWRDACPI 16944.11825) @ 0x1fff3040
ACPI: MADT (v001 IntelR AWRDACPI 16944.11825) @ 0x1fff6a80
ACPI: DSDT (v001 INTELR AWRDACPI 00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:2 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
Processor #2 15:2 APIC version 16
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] enabled)
Processor #3 15:2 APIC version 16
Using ACPI for processor (LAPIC) configuration information
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 4
Building zonelist for node : 0
Kernel command line: 
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
sched_init().
smp_processor_id(): 0.
rq_idx(smp_processor_id()): 0.
this_rq(): c043c580.
Detected 2180.049 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 4292.60 BogoMIPS
Memory: 514504k/524224k available (2567k kernel code, 8936k reserved, 759k data, 124k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#0: Thermal monitoring enabled
Machine check exception polling timer started.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel(R) XEON(TM) CPU 2.20GHz stepping 04
per-CPU timeslice cutoff: 1462.23 usecs.
task migration cache decay timeout: 2 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... <1>Unable to handle kernel paging request at virtual address f000e822
 printing eip:
c011ddee
*pde = 00000000
Oops: 0000
CPU:    1
EIP:    0060:[<c011ddee>]    Not tainted
EFLAGS: 00010086
eax: f000e816   ebx: 00000000   ecx: 00000001   edx: 00000000
esi: dff8c000   edi: 00000000   ebp: dff8deb8   esp: dff8dea8
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=dff8c000 task=dff8e680)
Stack: 00000000 00000000 00000000 00000000 dff8dee8 c011aafe 00000000 dff8ded8 
       00000000 c043cf00 00000000 00000000 00000082 00000000 c043c580 00000000 
       dff8def8 c011acf6 00000000 00000000 dff8df18 c011b3ad 00000000 dff8c000 
Call Trace: [<c011aafe>]  [<c011acf6>]  [<c011b3ad>]  [<c011bffe>]  [<c022d985>]  [<c011c0b1>]  [<c0121029>]  [<c0121067>] 
Code: 8b 40 0c 8b 3c 85 80 c4 43 c0 83 46 10 01 69 ff 80 09 00 00 
 <0>Kernel panic: Attempted to kill the idle task!
In idle task - not syncing
 Stuck ??
CPU #1 not responding - cannot use it.
Booting processor 1/2 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 4358.14 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU#1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#1: Thermal monitoring enabled
CPU1: Intel(R) XEON(TM) CPU 2.20GHz stepping 04
Booting processor 2/3 eip 2000
Initializing CPU#2
masked ExtINT on CPU#2
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 4358.14 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 3
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#2.
CPU#2: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#2: Thermal monitoring enabled
CPU2: Intel(R) XEON(TM) CPU 2.20GHz stepping 04
Total of 3 processors activated (13008.89 BogoMIPS).
ENABLING IO-APIC IRQs
BIOS bug, IO-APIC#0 ID 2 is already used!...
... fixing up to 4. (tell your hw vendor)
...changing IO-APIC physical APIC ID to 4 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 4-0, 4-5, 4-9, 4-10, 4-11, 4-12, 4-20, 4-21 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 19.
number of IO-APIC #4 registers: 24.
testing the IO APIC.......................

IO APIC #4......
.... register #00: 04000000
.......    : physical APIC id: 04
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 000 00  1    0    0   0   0    0    0    00
 06 001 01  0    0    0   0   0    1    1    51
 07 001 01  0    0    0   0   0    1    1    59
 08 001 01  0    0    0   0   0    1    1    61
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 001 01  0    0    0   0   0    1    1    69
 0e 001 01  0    0    0   0   0    1    1    71
 0f 001 01  0    0    0   0   0    1    1    79
 10 001 01  1    1    0   1   0    1    1    81
 11 001 01  1    1    0   1   0    1    1    89
 12 001 01  1    1    0   1   0    1    1    91
 13 001 01  1    1    0   1   0    1    1    99
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 001 01  1    1    0   1   0    1    1    A1
 17 001 01  1    1    0   1   0    1    1    A9
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
IRQ22 -> 0:22
IRQ23 -> 0:23
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2180.0483 MHz.
..... host bus clock speed is 99.0112 MHz.
checking TSC synchronization across 3 CPUs: passed.
cpu_has_ht: 1, smp_num_siblings: 2, num_online_cpus(): 1.
cpu_sibling_map[0] = 1
cpu_sibling_map[1] = 0
WARNING: No sibling found for CPU 2.
sched_merge_runqueues: CPU#0 <=> CPU#1, on CPU#0.
Starting migration thread for cpu 0
Bringing up 1
CPU 1 IS NOW UP!
Starting migration thread for cpu 1
Bringing up 2
CPU 2 IS NOW UP!
Starting migration thread for cpu 2
CPUS done 4
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: probably your BIOS does not setup all CPUs
PCI: PCI BIOS revision 2.10 entry at 0xfb3e0, last bus=4
PCI: Using configuration type 1
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
Linux Plug and Play Support v0.94 (c) Adam Belay
pnp: Enabling Plug and Play Card Services.
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 15
 exit congestion at 17
SCSI subsystem driver Revision: 1.00
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Transparent bridge - Intel Corp. 82801BA/CA/DB PCI Br
PCI: Using IRQ router PIIX [8086/2440] at 00:1f.0
PCI->APIC IRQ transform: (B0,I31,P3) -> 19
PCI->APIC IRQ transform: (B0,I31,P1) -> 17
PCI->APIC IRQ transform: (B0,I31,P2) -> 23
PCI->APIC IRQ transform: (B0,I31,P1) -> 17
PCI->APIC IRQ transform: (B1,I0,P0) -> 22
PCI->APIC IRQ transform: (B3,I4,P0) -> 18
PCI->APIC IRQ transform: (B3,I4,P1) -> 18
PCI->APIC IRQ transform: (B4,I4,P0) -> 16
IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
Starting balanced_irq
Enabling SEP on CPU 1
Enabling SEP on CPU 0
Enabling SEP on CPU 2
aio_setup: sizeof(struct page) = 40
Journalled Block Device driver loaded
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.0 [Flags: R/O].
udf: registering filesystem
Real Time Clock Driver v1.11
i810_rng hardware driver 0.9.8 loaded
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected Intel i860 chipset
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 64M @ 0xe0000000
Intel(R) PRO/100 Network Driver - version 2.1.29-k4
Copyright (c) 2002 Intel Corporation

e100: selftest OK.
Freeing alive device dfd26000, eth%d
e100: eth0: Intel(R) PRO/100+ Server Adapter (PILA8470B)
  Hardware receive checksums enabled
  cpu cycle saver enabled

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH2: IDE controller at PCI slot 00:1f.1
ICH2: chipset revision 4
ICH2: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
hda: DVD+RW RW5120, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ATAPI 32X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
end_request: I/O error, dev hda, sector 0
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.28
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

(scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
  Vendor: SEAGATE   Model: ST318452LW        Rev: 0004
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:0:0: Tagged Queuing enabled.  Depth 64
(scsi0:A:1): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
  Vendor: SEAGATE   Model: ST318452LW        Rev: 0004
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:1:0: Tagged Queuing enabled.  Depth 64
scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.28
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs

SCSI device sda: 35843670 512-byte hdwr sectors (18352 MB)
SCSI device sda: drive cache: write back
 /dev/scsi/host0/bus0/target0/lun0: p1
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 35843670 512-byte hdwr sectors (18352 MB)
SCSI device sdb: drive cache: write back
 /dev/scsi/host0/bus0/target1/lun0: p1 p2 p3 < p5 >
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.0
PCI: Setting latency timer of device 00:1f.2 to 64
uhci-hcd 00:1f.2: Intel Corp. 82801BA/BAM USB (Hub
uhci-hcd 00:1f.2: irq 19, io base 0000b000
Please use the 'usbfs' filetype instead, the 'usbdevfs' name is deprecated.
uhci-hcd 00:1f.2: new USB bus registered, assigned bus number 1
hub 1-0:0: USB hub found
hub 1-0:0: 2 ports detected
PCI: Setting latency timer of device 00:1f.4 to 64
uhci-hcd 00:1f.4: Intel Corp. 82801BA/BAM USB (Hub
uhci-hcd 00:1f.4: irq 23, io base 0000b400
uhci-hcd 00:1f.4: new USB bus registered, assigned bus number 2
hub 2-0:0: USB hub found
hub 2-0:0: 2 ports detected
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x301
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
Advanced Linux Sound Architecture Driver Version 0.9.0rc6 (Tue Jan 28 12:17:23 2003 UTC).
PCI: Setting latency timer of device 00:1f.5 to 64
hub 1-0:0: new USB device on port 1, assigned address 2
intel8x0: clocking to 48000
ALSA device list:
  #0: Intel 82801BA-ICH2 at 0xb800, irq 17
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 124k freed
input: USB HID v1.10 Mouse [Microsoft Microsoft 3-Button Mouse with IntelliEye(TM)] on usb-00:1f.2-1
hub 1-0:0: debounce: port 2: delay 100ms stable 4 status 0x301
hub 1-0:0: new USB device on port 2, assigned address 3
HID device not claimed by input or hiddev
Adding 2000052k swap on /dev/sdb1.  Priority:-1 extents:1
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on sd(8,18), internal journal
e100: eth0 NIC Link is Up 100 Mbps Full duplex
mtrr: MTRR 1 not used

--Boundary-00=_lDlR+O3zUXj11Gq--

