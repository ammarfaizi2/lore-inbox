Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318562AbSHPSQD>; Fri, 16 Aug 2002 14:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318631AbSHPSQD>; Fri, 16 Aug 2002 14:16:03 -0400
Received: from ulima.unil.ch ([130.223.144.143]:44690 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S318562AbSHPSQB>;
	Fri, 16 Aug 2002 14:16:01 -0400
Date: Fri, 16 Aug 2002 20:19:57 +0200
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20-pre2-ac3 oops
Message-ID: <20020816181957.GA14157@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Linux version 2.4.20-pre2-ac3 (greg@localhost.localdomain) (gcc version 3.2 (Mandrake Linux 9.0 3.2-0.3mdk)) #5 Fri Aug 16 19:37:27 CEST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff8000 (ACPI data)
 BIOS-e820: 000000001fff8000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffb00000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
511MB LOWMEM available.
found SMP MP-table at 000fb900
hm, page 000fb000 reserved twice.
hm, page 000fc000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
On node 0 totalpages: 131056
zone(0): 4096 pages.
zone(1): 126960 pages.
zone(2): 0 pages.
ACPI: Searched entire block, no RSDP was found.
ACPI: RSDP located at physical address c00fa510
RSD PTR  v0 [AMI   ]
__va_range(0x1fff0000, 0x68): idx=8 mapped at ffff6000
ACPI table found: RSDT v1 [AMIINT INTEL845 0.16]
__va_range(0x1fff0030, 0x24): idx=8 mapped at ffff6000
__va_range(0x1fff0030, 0x81): idx=8 mapped at ffff6000
ACPI table found: FACP v1 [AMIINT INTEL845 0.17]
__va_range(0x1fff00c0, 0x24): idx=8 mapped at ffff6000
__va_range(0x1fff00c0, 0x54): idx=8 mapped at ffff6000
ACPI table found: APIC v1 [AMIINT INTEL845 0.9]
__va_range(0x1fff00c0, 0x54): idx=8 mapped at ffff6000
LAPIC (acpi_id[0x0001] id[0x0] enabled[1])
CPU 0 (0x0000) enabledProcessor #0 Pentium 4(tm) XEON(tm) APIC version 16

IOAPIC (id[0x2] address[0xfec00000] global_irq_base[0x0])
INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x0])
INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x1] trigger[0x3])
1 CPUs total
Local APIC address fee00000
Enabling the CPU's according to the ACPI table
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: INTEL    Product ID: I845E        APIC at: 0xFEE00000
I/O APIC #2 Version 32 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 1
Kernel command line: BOOT_IMAGE=2.4.20-pre2-ac3 rw root=812 video=matrox:1600x1200-16@75 console=ttyS1
Initializing CPU#0
Detected 2220.805 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 4430.23 BogoMIPS
Memory: 514424k/524224k available (1739k kernel code, 9412k reserved, 423k data, 288k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I cache: 0K, L1 D cache: 8K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) 4 CPU 2.20GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
..TIMER: vector=0x31 pin1=2 pin2=0
testing the IO APIC.......................

.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2220.8330 MHz.
..... host bus clock speed is 100.9468 MHz.
cpu: 0, clocks: 1009468, slice: 504734
CPU0<T0:1009456,T1:504720,D:2,S:504734,C:1009468>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfdb81, last
bus=3
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router PIIX [8086/24c0] at 00:1f.0
PCI->APIC IRQ transform: (B0,I29,P0) -> 16
PCI->APIC IRQ transform: (B0,I29,P1) -> 19
PCI->APIC IRQ transform: (B0,I29,P3) -> 23
PCI->APIC IRQ transform: (B0,I31,P0) -> 18
PCI->APIC IRQ transform: (B0,I31,P1) -> 17
PCI->APIC IRQ transform: (B0,I31,P1) -> 17
PCI->APIC IRQ transform: (B1,I0,P0) -> 16
PCI->APIC IRQ transform: (B3,I0,P0) -> 16
PCI->APIC IRQ transform: (B3,I1,P0) -> 17
PCI->APIC IRQ transform: (B3,I2,P0) -> 18
PCI->APIC IRQ transform: (B3,I3,P0) -> 19
PCI->APIC IRQ transform: (B3,I4,P0) -> 16
PCI->APIC IRQ transform: (B3,I8,P0) -> 20
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
PnPBIOS: Found PnP BIOS installation structure at 0xc00f7730
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x678b, dseg 0xf0000
PnPBIOS: 15 nodes reported by PnP BIOS; 15 recorded by driver
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
cpufreq: CPU#0 P4/Xeon(TM) CPU On-Demand Clock Modulation available
CPU clock: 2220.805 MHz (222.080-2220.805 MHz)
Starting kswapd
devfs: v1.12a (20020514) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
matroxfb: Matrox G550 detected
matroxfb: MTRR's turned on
matroxfb: 1600x1200x16bpp (virtual: 1600x5241)
matroxfb: framebuffer at 0xDC000000, mapped to 0xe0805000, size 33554432
Console: switching to colour frame buffer device 200x75
fb0: MATROX VGA frame buffer device
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
Non-volatile memory driver v1.1
i810_rng: RNG not detected
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PCI: Unable to reserve I/O region #1:8@0 for device 00:1f.1
Trying to free nonexistent resource <00000000-00000007>
Trying to free nonexistent resource <00000000-00000003>
Trying to free nonexistent resource <00000000-00000007>
Trying to free nonexistent resource <00000000-00000003>
Trying to free nonexistent resource <0000fc00-0000fc0f>
Trying to free nonexistent resource <20000000-200003ff>
hda: IC35L120AVVA07-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: IOMEGA ZIP 250 ATAPI, ATAPI FLOPPY drive
ide1 at 0x170-0x177,0x376 on irq 15
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c01d7796
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01d7796>]    Not tainted
EFLAGS: 00010282
eax: c16de580   ebx: 00000000   ecx: 00000000   edx: 00000000
esi: c0399a50   edi: c0105000   ebp: dffebf7c   esp: dffebf68
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, stackpage=dffeb000)
Stack: c02d4de8 00000000 c16ec800 c0397260 c0399a50 dffebf84 c0332a72 dffebfa0
       c0332aaf dffee700 c02bc5ce 00000000 c03671e4 00000000 dffebfc0 c0330e93
       c0394520 00000000 000003fc 00022000 00000000 00000000 dffebfc8 c0330eb8
Call Trace:    [<c0105045>] [<c0105000>] [<c010579e>] [<c0105030>]

Code: 8b 13 85 d2 74 bf 80 7b 04 00 74 b9 8b 73 08 85 f6 74 b2 8d
 <0>Kernel panic: Attempted to kill init!

---

which `ksymoops -m System.map -v vmlinux -K -O -L < /tmp/24` gives:

ksymoops 2.3.7 on i686 2.4.20-pre1-ac1.  Options used
     -v vmlinux (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m System.map (specified)

CPU 0 (0x0000) enabledProcessor #0 Pentium 4(tm) XEON(tm) APIC version 16
cpu: 0, clocks: 1009468, slice: 504734
Unable to handle kernel NULL pointer dereference at virtual address 00000000
c01d7796
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01d7796>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: c16de580   ebx: 00000000   ecx: 00000000   edx: 00000000
esi: c0399a50   edi: c0105000   ebp: dffebf7c   esp: dffebf68
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, stackpage=dffeb000)
Stack: c02d4de8 00000000 c16ec800 c0397260 c0399a50 dffebf84 c0332a72 dffebfa0 
       c0332aaf dffee700 c02bc5ce 00000000 c03671e4 00000000 dffebfc0 c0330e93 
       c0394520 00000000 000003fc 00022000 00000000 00000000 dffebfc8 c0330eb8 
Call Trace:    [<c0105045>] [<c0105000>] [<c010579e>] [<c0105030>]
Code: 8b 13 85 d2 74 bf 80 7b 04 00 74 b9 8b 73 08 85 f6 74 b2 8d 

>>EIP; c01d7796 <proc_ide_create+66/e0>   <=====
Trace; c0105045 <init+15/140>
Trace; c0105000 <_stext+0/0>
Trace; c010579e <kernel_thread+2e/40>
Trace; c0105030 <init+0/140>
Code;  c01d7796 <proc_ide_create+66/e0>
00000000 <_EIP>:
Code;  c01d7796 <proc_ide_create+66/e0>   <=====
   0:   8b 13                     mov    (%ebx),%edx   <=====
Code;  c01d7798 <proc_ide_create+68/e0>
   2:   85 d2                     test   %edx,%edx
Code;  c01d779a <proc_ide_create+6a/e0>
   4:   74 bf                     je     ffffffc5 <_EIP+0xffffffc5> c01d775b <proc_ide_create+2b/e0>
Code;  c01d779c <proc_ide_create+6c/e0>
   6:   80 7b 04 00               cmpb   $0x0,0x4(%ebx)
Code;  c01d77a0 <proc_ide_create+70/e0>
   a:   74 b9                     je     ffffffc5 <_EIP+0xffffffc5> c01d775b <proc_ide_create+2b/e0>
Code;  c01d77a2 <proc_ide_create+72/e0>
   c:   8b 73 08                  mov    0x8(%ebx),%esi
Code;  c01d77a5 <proc_ide_create+75/e0>
   f:   85 f6                     test   %esi,%esi
Code;  c01d77a7 <proc_ide_create+77/e0>
  11:   74 b2                     je     ffffffc5 <_EIP+0xffffffc5> c01d775b <proc_ide_create+2b/e0>
Code;  c01d77a9 <proc_ide_create+79/e0>
  13:   8d 00                     lea    (%eax),%eax

 <0>Kernel panic: Attempted to kill init!

---

And from scripts/ver_linux:

Gnu C                  gcc-3.2 (GCC) 3.2 (Mandrake Linux 9.0 3.2-0.3mdk) Copyright (C) 2002 Free Software Foundation, Inc. This is free software; see the source for copying conditions. There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
Gnu make               3.79.1
util-linux             2.11t
mount                  2.11t
modutils               2.4.19
e2fsprogs              1.27
PPP                    2.4.1
isdn4k-utils           3.1pre1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.15

---

Should I sent other tings?

Thank you very much,

	Greg
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
