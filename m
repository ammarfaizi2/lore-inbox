Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315417AbSFYABM>; Mon, 24 Jun 2002 20:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315419AbSFYABL>; Mon, 24 Jun 2002 20:01:11 -0400
Received: from CPEdeadbeef0000.cpe.net.cable.rogers.com ([24.100.234.67]:11780
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S315417AbSFYABI>; Mon, 24 Jun 2002 20:01:08 -0400
Subject: Linux 2.5.24 - Strange power off problems (ACPI support on)
From: Shawn Starr <spstarr@sh0n.net>
To: Linux <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-qVWsRMryVXUf6u3YIhgw"
X-Mailer: Evolution/1.0.1.99 (Preview Release)
Date: 24 Jun 2002 20:02:00 -0400
Message-Id: <1024963320.206.6.camel@coredump>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-qVWsRMryVXUf6u3YIhgw
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Briefly, I have an Athlon MP 2000+ Asus A7M266-D (Dual CPU) system:

Here's the dmesg (this may also provide other info on other errors)


When I run /sbin/poweroff it also dumps to console that it had one
preempt left (I forgot the actual message it outputs).

The problem is this:

When I run the halt/poweroff program, it powers off the hard disks, and
displays the 'Poweroff System' message. If I press the power button, It
turns the system off HARD, Ie, i don't see the NIC card's aux power on,
and when I try to turn the machine on again it won't until I physically
remove all power (turn off powerbar) for a few seconds, then It will let
me power it on (or it will power on itself).

This did not happen in the 2.4.x kernel, I assume a new ACPI bug? ;-)

Shawn.


-- 
Shawn Starr, sh0n.net, <spstarr@sh0n.net>
Maintainer: -shawn kernel patches: http://xfs.sh0n.net/2.4/
Developer Support Engineer
Datawire Communication Networks Inc.
10 Carlson Court, Suite 300
Toronto, ON, M9W 6L2
T: 416.213.2001 ext 179 F: 416.213.2008

--=-qVWsRMryVXUf6u3YIhgw
Content-Disposition: attachment; filename=dmesg
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ANSI_X3.4-1968

Linux version 2.5.24 (root@unknown) (gcc version 3.1) #1 Sat Jun 22 14:58:4=
8 EDT 2002
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ffec000 (usable)
 BIOS-e820: 000000001ffec000 - 000000001ffef000 (ACPI data)
 BIOS-e820: 000000001ffef000 - 000000001ffff000 (reserved)
 BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
found SMP MP-table at 000f7d40
hm, page 000f7000 reserved twice.
hm, page 000f8000 reserved twice.
hm, page 000f7000 reserved twice.
hm, page 000f8000 reserved twice.
On node 0 totalpages: 131052
zone(0): 4096 pages.
zone(1): 126956 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 ASUS                       ) @ 0x000f8490
ACPI: RSDT (v001 ASUS   A7M266-D 12336.12337) @ 0x1ffec000
ACPI: FADT (v001 ASUS   A7M266-D 12336.12337) @ 0x1ffec100
ACPI: BOOT (v001 ASUS   A7M266-D 12336.12337) @ 0x1ffec040
ACPI: MADT (v001 ASUS   A7M266-D 12336.12337) @ 0x1ffec080
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:6 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x1] trigger[0x1] lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, IRQ 0-23
ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x=
0])
ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x3] trigger[0x=
3])
Using ACPI (MADT) for SMP configuration information
Kernel command line: BOOT_IMAGE=3Dlinuxnew ro root=3D302 hdc=3Dide-scsi
ide_setup: hdc=3Dide-scsi
Initializing CPU#0
Detected 1680.417 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3355.44 BogoMIPS
Memory: 516556k/524208k available (1725k kernel code, 7264k reserved, 380k =
data, 280k init, 0k highmem)
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: Before vendor init, caps: 0383fbff c1cbfbff 00000000, vendor =3D 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0383fbff c1cbfbff 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Machine check exception polling timer started.
CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
CPU: AMD Athlon(TM) MP 2000+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 n=
ot connected.
..TIMER: vector=3D0x31 pin1=3D2 pin2=3D0
number of MP IRQ sources: 16.
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
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:  =20
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  1    1    0   1   0    1    1    71
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
..... CPU clock speed is 1680.4427 MHz.
..... host bus clock speed is 268.8708 MHz.
cpu: 0, clocks: 2688708, slice: 1344354
CPU0<T0:2688704,T1:1344336,D:14,S:1344354,C:2688708>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xf1dd0, last bus=3D2
PCI: Using configuration type 1
ACPI: Subsystem revision 20020611
__iounmap: bad address e0800100
__iounmap: bad address e0804040
__iounmap: bad address e0806040
__iounmap: bad address e0808080
__iounmap: bad address e080a080
__iounmap: bad address e0802100
__iounmap: bad address e080e180
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S4 S5)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI2._PRT]
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
PnPBIOS: Found PnP BIOS installation structure at 0xc00fc480
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xc4b0, dseg 0xf0000
PnPBIOS: 15 nodes reported by PnP BIOS; 15 recorded by driver
PnPBIOS: PNP0c02: ioport range 0xe400-0xe47f has been reserved
PnPBIOS: PNP0c02: ioport range 0xe4e0-0xe4ff has been reserved
IOAPIC[0]: Set PCI routing entry (2-16 -> 0xa9 -> IRQ 16)
00:00:07[A] -> 2-16 -> vector 0xa9 -> IRQ 16
IOAPIC[0]: Set PCI routing entry (2-17 -> 0xb1 -> IRQ 17)
00:00:07[B] -> 2-17 -> vector 0xb1 -> IRQ 17
IOAPIC[0]: Set PCI routing entry (2-18 -> 0xb9 -> IRQ 18)
00:00:07[C] -> 2-18 -> vector 0xb9 -> IRQ 18
IOAPIC[0]: Set PCI routing entry (2-19 -> 0xc1 -> IRQ 19)
00:00:07[D] -> 2-19 -> vector 0xc1 -> IRQ 19
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
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
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=3Dnoacpi'
__iounmap: bad address e0816100
SBF: Simple Boot Flag extension found and enabled.
__iounmap: bad address e0819040
__iounmap: bad address e081c080
SBF: Setting boot flags 0x1
Starting kswapd
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec: init pool 0, 1 entries, 12 bytes
biovec: init pool 1, 4 entries, 48 bytes
biovec: init pool 2, 16 entries, 192 bytes
biovec: init pool 3, 64 entries, 768 bytes
biovec: init pool 4, 128 entries, 1536 bytes
biovec: init pool 5, 256 entries, 3072 bytes
Journalled Block Device driver loaded
ACPI: Processor [CPU0] (supports C1)
ACPI: Processor [CPU1] (supports C1)
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_P=
CI ISAPNP enabled
ttyS00 at 0x03f8 (irq =3D 4) is a 16550A
ttyS01 at 0x02f8 (irq =3D 3) is a 16550A
lp0: using parport0 (polling).
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: Detected AMD 760MP chipset
agpgart: AGP aperture is 128M @ 0xf0000000
[drm] AGP 0.99 on Unknown @ 0xf0000000 128MB
[drm] Initialized radeon 1.3.0 20020521 on minor 0
block: 256 slots per queue, batch=3D32
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
02:05.0: 3Com PCI 3c980C Python-T at 0xa400. Vers LK1.1.17
phy=3D0, phyx=3D24, mii_status=3D0x780d
ATA/ATAPI device driver v7.0.0
ATA: PCI bus speed 33.3MHz
ATA: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE, PCI slot 00:07.1
ATA: chipset rev.: 4
ATA: non-legacy mode: IRQ probe delayed
AMD_IDE: Bios didn't set cable bits corectly. Enabling workaround.
AMD_IDE: Bios didn't set cable bits corectly. Enabling workaround.
AMD_IDE: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE (rev 04) UDMA100 c=
ontroller on pci00:07.1
    ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:DMA, hdd:DMA
hda: MAXTOR 6L060J3, DISK drive
hdc: YAMAHA CRW2100E, ATAPI CD/DVD-ROM drive
hdd: DVD-ROM DDU1621, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
 hda: 117266688 sectors w/1819KiB Cache, CHS=3D116336/16/63, UDMA(100)
 hda: [PTBL] [7299/255/63] hda1 hda2 hda3
hdd: ATAPI 40X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for ATAPI devices
  Vendor: YAMAHA    Model: CRW2100E          Rev: 1.0N
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
mice: PS/2 mouse device common for all mice
Advanced Linux Sound Architecture Driver Version 0.9.0rc2 (Wed Jun 19 08:56=
:25 2002 UTC).
kmod: failed to exec /sbin/modprobe -s -k snd-card-0, errno =3D 2
cmipci: no OPL device at 0x388, skipping...
ALSA device list:
  #0: C-Media PCI CMI8738-MC6 (model 55) at 0xa800, irq 17
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 280k freed
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,2), internal journal

--=-qVWsRMryVXUf6u3YIhgw--

