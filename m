Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264377AbTFKLn2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 07:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264379AbTFKLn2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 07:43:28 -0400
Received: from rumms.uni-mannheim.de ([134.155.50.52]:13507 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S264377AbTFKLnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 07:43:18 -0400
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: Andrew Morton <akpm@digeo.com>
Subject: [2.5.70-mm8] NETDEV WATCHDOG: eth0: transmit timed out
Date: Wed, 11 Jun 2003 13:56:52 +0200
User-Agent: KMail/1.5.9
References: <20030611013325.355a6184.akpm@digeo.com>
In-Reply-To: <20030611013325.355a6184.akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-03=_Ekx5+AYkl+zvZIX";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200306111356.52950.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-03=_Ekx5+AYkl+zvZIX
Content-Type: multipart/mixed;
  boundary="Boundary-01=_Ekx5+jFwt3ksOtw"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_Ekx5+jFwt3ksOtw
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I compiled 2.5.70-mm8 with the same .config I used for -mm7 which worked fi=
ne=20
for me. Now I can not use my RTL8139C based network card with the 8139too=20
module anymore and the message above displays. I attached the dmesg message=
s,=20
the list of loaded modules, the contents of /proc/interrupts and what=20
ifconfig says. If anything else is needed, just ask...

Best regards
  Thomas Schlichter

--Boundary-01=_Ekx5+jFwt3ksOtw
Content-Type: text/plain;
  charset="iso-8859-1";
  name="ifconfig.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline; filename="ifconfig.txt"

eth0      Link encap:Ethernet  HWaddr 00:E0:7D:B5:8B:2A =20
          inet addr:192.168.0.7  Bcast:192.168.0.255  Mask:255.255.255.0
          inet6 addr: fe80::2e0:7dff:feb5:8b2a/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100=20
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
          Interrupt:11 Base address:0x9000=20

lo        Link encap:Local Loopback =20
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:82 errors:0 dropped:0 overruns:0 frame:0
          TX packets:82 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0=20
          RX bytes:6736 (6.5 Kb)  TX bytes:6736 (6.5 Kb)


--Boundary-01=_Ekx5+jFwt3ksOtw
Content-Type: text/plain;
  charset="iso-8859-1";
  name="interrupts.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline; filename="interrupts.txt"

           CPU0      =20
  0:      12249    IO-APIC-edge  timer
  1:        295    IO-APIC-edge  i8042
  2:          0          XT-PIC  cascade
  4:         11    IO-APIC-edge  serial
  8:          2    IO-APIC-edge  rtc
  9:          0    IO-APIC-edge  acpi
 10:          0    IO-APIC-edge  ehci-hcd
 11:          0    IO-APIC-edge  eth0
 12:         79    IO-APIC-edge  i8042
 14:       5138    IO-APIC-edge  ide0
 15:         10    IO-APIC-edge  ide1
NMI:          0=20
LOC:      12206=20
ERR:          0
MIS:          0

--Boundary-01=_Ekx5+jFwt3ksOtw
Content-Type: text/plain;
  charset="iso-8859-1";
  name="lsmod.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline; filename="lsmod.txt"

Module                  Size  Used by
mousedev                5720  1=20
psmouse                 6020  0=20
nfsd                  116096  4 [unsafe]
exportfs                3840  1 nfsd
lockd                  50512  2 nfsd,[unsafe]
sunrpc                 89540  2 nfsd,lockd
md5                     3200  1=20
ipv6                  184324  6=20
parport_pc             27400  1=20
lp                      7108  0=20
parport                24640  2 parport_pc,lp
ehci_hcd               16896  0=20
usbcore                71252  3 ehci_hcd
8139too                16256  0=20
mii                     3072  1 8139too
crc32                   3328  1 8139too
kernelcapi             27360  0=20
8250                   21600  2=20
core                   13952  1 8250
rtc                     7364  0=20
unix                   17164  26=20

--Boundary-01=_Ekx5+jFwt3ksOtw
Content-Type: text/plain;
  charset="iso-8859-1";
  name="dmesg.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline; filename="dmesg.txt"

Linux version 2.5.70-mm8 (schlicht@bigboss) (gcc version 2.95.3 20010315 (S=
uSE)) #2 Wed Jun 11 13:04:03 CEST 2003
Video mode to be used for restore is 317
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fff3000 (ACPI NVS)
 BIOS-e820: 000000000fff3000 - 0000000010000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
255MB LOWMEM available.
found SMP MP-table at 000f5a30
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
On node 0 totalpages: 65520
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61424 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v000 KT400                      ) @ 0x000f7460
ACPI: RSDT (v001 KT400  AWRDACPI 16944.11825) @ 0x0fff3000
ACPI: FADT (v001 KT400  AWRDACPI 16944.11825) @ 0x0fff3040
ACPI: MADT (v001 KT400  AWRDACPI 16944.11825) @ 0x0fff7000
ACPI: DSDT (v001 KT400  AWRDACPI 00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:7 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x1] trigger[0x1] lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, IRQ 0-23
ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x=
0])
ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x0] trigger[0x=
0])
ACPI: INT_SRC_OVR (bus[0] irq[0xe] global_irq[0xe] polarity[0x1] trigger[0x=
1])
ACPI: INT_SRC_OVR (bus[0] irq[0xf] global_irq[0xf] polarity[0x1] trigger[0x=
1])
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Building zonelist for node : 0
Kernel command line: auto BOOT_IMAGE=3Dlinux ro root=3D305 BOOT_FILE=3D/boo=
t/vmlinuz video=3Dvesafb:mtrr,pmipal,ywrap 3
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 1307.251 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 2608.33 BogoMIPS
Memory: 255212k/262080k available (1782k kernel code, 6144k reserved, 736k =
data, 168k init, 0k highmem)
Security Scaffold v1.0.0 initialized
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
=2D> /dev
=2D> /dev/console
=2D> /root
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 64K (64 bytes/line)
CPU:     After generic, caps: 0383fbff c1c3fbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Duron(tm) processor stepping 01
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
=2E.TIMER: vector=3D0x31 pin1=3D2 pin2=3D0
number of MP IRQ sources: 16.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
=2E... register #00: 02000000
=2E......    : physical APIC id: 02
=2E......    : Delivery Type: 0
=2E......    : LTS          : 0
=2E... register #01: 00178003
=2E......     : max redirection entries: 0017
=2E......     : PRQ implemented: 1
=2E......     : IO APIC version: 0003
=2E... IRQ redirection table:
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
=2E................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
=2E.... CPU clock speed is 1307.2402 MHz.
=2E.... host bus clock speed is 201.1137 MHz.
Registering sysdev class 'cpu'
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfb3b0, last bus=3D1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router VIA [1106/3177] at 00:11.0
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 1!
PCI BIOS passed nonexistent PCI bus 0!
mtrr: v2.0 (20020519)
Registering sys device 'cpu0'
BIO: pool of 256 setup, 15Kb (60 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030522
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [ALKA] (IRQs 20, disabled)
ACPI: PCI Interrupt Link [ALKB] (IRQs 21, disabled)
ACPI: PCI Interrupt Link [ALKC] (IRQs 22, disabled)
ACPI: PCI Interrupt Link [ALKD] (IRQs 23, disabled)
Linux Plug and Play Support v0.96 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fbe80
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xbeb0, dseg 0xf0000
PnPBIOS: 16 nodes reported by PnP BIOS; 16 recorded by driver
vesafb: framebuffer at 0xd8000000, mapped to 0xd080b000, size 65536k
vesafb: mode is 1024x768x16, linelength=3D2048, pages=3D0
vesafb: protected mode interface info at c000:c2c0
vesafb: pmi: set display start =3D c00cc305, set palette =3D c00cc38a
vesafb: pmi: ports =3D b4c3 b503 ba03 c003 c103 c403 c503 c603 c703 c803 c9=
03 cc03 ce03 cf03 d003 d103 d203 d303 d403 d503 da03 ff03=20
vesafb: scrolling: ywrap using protected mode interface, yres_virtual=3D327=
68
vesafb: directcolor: size=3D0:5:6:5, shift=3D0:11:5:0
fb0: VESA VGA frame buffer device
Console: switching to colour frame buffer device 128x48
pty: 256 Unix98 ptys configured
Registering sysdev class 'i8259'
Registering sys device 'i82590'
Registering sysdev class 'timer'
Registering sys device 'timer0'
Registering sysdev class 'rtc'
Registering sys device 'rtc0'
Machine check exception polling timer started.
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
apm: overridden by ACPI.
Registering sysdev class 'lapic'
Registering sys device 'lapic0'
Enabling SEP on CPU 0
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Journalled Block Device driver loaded
Initializing Cryptographic API
ACPI: Power Button (FF) [PWRF]
ACPI: Fan [FAN] (on)
ACPI: Processor [CPU0] (supports C1 C2)
ACPI: Thermal Zone [THRM] (57 C)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
VP_IDE: IDE controller at PCI slot 00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci00:11.1
    ide0: BM-DMA at 0xec00-0xec07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xec08-0xec0f, BIOS settings: hdc:DMA, hdd:pio
hda: IBM-DTLA-307030, ATA DISK drive
hdb: Pioneer DVD-ROM ATAPIModel DVD-105S 013, ATAPI CD/DVD-ROM drive
anticipatory scheduling elevator
anticipatory scheduling elevator
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: PLEXTOR CD-R PX-W8432T, ATAPI CD/DVD-ROM drive
anticipatory scheduling elevator
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: host protected area =3D> 1
hda: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=3D59560/16/63, UDMA(1=
00)
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
end_request: I/O error, dev hdb, sector 0
hdb: ATAPI 40X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
hdc: ATAPI 32X CD-ROM CD-R/RW drive, 4096kB Cache, DMA
Console: switching to colour frame buffer device 128x48
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET4: Frame Diverter 0.46
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
Linux IP multicast router 0.06 plus PIM-SM
BIOS EDD facility v0.09 2003-Jan-22, 1 devices found
ACPI: (supports S0 S1 S3 S4 S5)
found reiserfs format "3.5" with standard journal
Reiserfs journal params: device hda5, size 8192, journal first block 18, ma=
x trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda5) for (hda5)
Using r5 hash to sort names
reiserfs: using 3.5.x disk format
VFS: Mounted root (reiserfs filesystem) readonly.
=46reeing unused kernel memory: 168k freed
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Adding 265032k swap on /dev/hda1.  Priority:-1 extents:1
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on hda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Real Time Clock Driver v1.11
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
CAPI Subsystem Rev 1.21.6.8
8139too Fast Ethernet driver 0.9.26
divert: allocating divert_blk for eth0
eth0: RealTek RTL8139 Fast Ethernet at 0xd48f9000, 00:e0:7d:b5:8b:2a, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8139C'
eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability =
45e1.
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
Please use the 'usbfs' filetype instead, the 'usbdevfs' name is deprecated.
ehci-hcd 0000:00:10.3: VIA Technologies, In USB 2.0
ehci-hcd 0000:00:10.3: irq 10, pci mem d490e000
Please use the 'usbfs' filetype instead, the 'usbdevfs' name is deprecated.
ehci-hcd 0000:00:10.3: new USB bus registered, assigned bus number 1
ehci-hcd 0000:00:10.3: USB 2.0 enabled, EHCI 1.00, driver 2003-Jan-22
hub 1-0:0: USB hub found
hub 1-0:0: 6 ports detected
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
lp0: using parport0 (polling).
lp0: console ready
IPv6 v0.8 for NET4.0
Disabled Privacy Extensions on device c035fa60(lo)
IPv6 over IPv4 tunneling driver
divert: not allocating divert_blk for non-ethernet device sit0
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Module nfsd cannot be unloaded due to unsafe usage in include/linux/module.=
h:479
Module lockd cannot be unloaded due to unsafe usage in include/linux/module=
=2Eh:479
input: PS2++ Logitech Wheel Mouse on isa0060/serio1
mice: PS/2 mouse device common for all mice
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Tx queue start entry 4  dirty entry 0.
eth0:  Tx descriptor 0 is 00002000. (queue head)
eth0:  Tx descriptor 1 is 00002000.
eth0:  Tx descriptor 2 is 00002000.
eth0:  Tx descriptor 3 is 00002000.
eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability =
45e1.
eth0: no IPv6 routers present
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Tx queue start entry 4  dirty entry 0.
eth0:  Tx descriptor 0 is 00002000. (queue head)
eth0:  Tx descriptor 1 is 00002000.
eth0:  Tx descriptor 2 is 00002000.
eth0:  Tx descriptor 3 is 00002000.
eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability =
45e1.
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Tx queue start entry 4  dirty entry 0.
eth0:  Tx descriptor 0 is 00002000. (queue head)
eth0:  Tx descriptor 1 is 00002000.
eth0:  Tx descriptor 2 is 00002000.
eth0:  Tx descriptor 3 is 00002000.
eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability =
45e1.
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Tx queue start entry 4  dirty entry 0.
eth0:  Tx descriptor 0 is 00002000. (queue head)
eth0:  Tx descriptor 1 is 00002000.
eth0:  Tx descriptor 2 is 00002000.
eth0:  Tx descriptor 3 is 00002000.
eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability =
45e1.
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Tx queue start entry 4  dirty entry 0.
eth0:  Tx descriptor 0 is 00002000. (queue head)
eth0:  Tx descriptor 1 is 00002000.
eth0:  Tx descriptor 2 is 00002000.
eth0:  Tx descriptor 3 is 00002000.
eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability =
45e1.
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Tx queue start entry 4  dirty entry 0.
eth0:  Tx descriptor 0 is 00002000. (queue head)
eth0:  Tx descriptor 1 is 00002000.
eth0:  Tx descriptor 2 is 00002000.
eth0:  Tx descriptor 3 is 00002000.
eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability =
45e1.

--Boundary-01=_Ekx5+jFwt3ksOtw--

--Boundary-03=_Ekx5+AYkl+zvZIX
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+5xkEYAiN+WRIZzQRAnmYAJwPS7bUXf8E5rzVc/KbybyY7F8b6wCcC4mu
oKOyWH9mY65L8RfhXBoiDy4=
=3Rs5
-----END PGP SIGNATURE-----

--Boundary-03=_Ekx5+AYkl+zvZIX--
