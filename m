Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267480AbSLRU3h>; Wed, 18 Dec 2002 15:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267484AbSLRU3h>; Wed, 18 Dec 2002 15:29:37 -0500
Received: from [64.246.18.23] ([64.246.18.23]:21479 "EHLO ensim.2hosting.net")
	by vger.kernel.org with ESMTP id <S267480AbSLRU3a>;
	Wed, 18 Dec 2002 15:29:30 -0500
From: "Steve Lee" <steve@tuxsoft.com>
To: <mush@monrif.net>, <linux-kernel@vger.kernel.org>
Subject: RE: A7M266-D problems with integrate sound device and USB 2.0 PCI card
Date: Wed, 18 Dec 2002 14:40:31 -0600
Message-ID: <000301c2a6d5$bc9bfee0$0201a8c0@pluto>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
In-Reply-To: <200212182057.33880.mush@monrif.net>
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One of my systems uses the A7M266-D and I've never had any issues with
the onboard sound or the usb 2.0 pci card.  I'm wondering if something
else in your system could be causing the conflict?

Steve


-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of marco mascherpa
aka mush (by way of marcomascherpa aka mush <mush@monrif.net>)
Sent: Wednesday, December 18, 2002 1:58 PM
To: linux-kernel@vger.kernel.org
Subject: A7M266-D problems with integrate sound device and USB 2.0 PCI
card

hi,
i have got a dueal athlon MP system with asus' A7M266-D motherboard wich
has
an integrated soundcard and is provided with a pci usb 2.0 expansion
card.
the problem is that my kernel 2.4.19 can't assign the right IRQ to the
soundcard and to the usb ports. to be more clear i append the dmsg. i
tried
to use some kernel parameters to tweak the configuration (like pirq, pci
and
noapic) but i couldn't resolve anything. how can my devices be assigned
a
valid irq and work correctly?

Please Cc: me. I am not subscribed to the list.

dmesg:

            Common caps: 0383fbf7 c1cbfbff 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Before vendor init, caps: 0383fbff c1cbfbff 00000000, vendor = 2
Advanced speculative caching feature present
Disabling advanced speculative caching
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0383fbf7 c1cbfbff 00000000 00000000
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbf7 c1cbfbff 00000000 00000000
CPU:             Common caps: 0383fbf7 c1cbfbff 00000000 00000000
CPU0: AMD Athlon(TM) MP 1800+ stepping 02
per-CPU timeslice cutoff: 731.53 usecs.
task migration cache decay timeout: 10 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 3086.74 BogoMIPS
CPU: Before vendor init, caps: 0383fbff c1cbfbff 00000000, vendor = 2
Advanced speculative caching feature present
Disabling advanced speculative caching
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0383fbf7 c1cbfbff 00000000 00000000
Intel machine check reporting enabled on CPU#1.
CPU:     After generic, caps: 0383fbf7 c1cbfbff 00000000 00000000
CPU:             Common caps: 0383fbf7 c1cbfbff 00000000 00000000
CPU1: AMD Athlon(TM) MP 1800+ stepping 02
Total of 2 processors activated (6173.49 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-5, 2-9, 2-10, 2-11, 2-20, 2-21, 2-22, 2-23
not
connected.
..TIMER: vector=0x31 pin1=2 pin2=0
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
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 000 00  1    0    0   0   0    0    0    00
 01 003 03  0    0    0   0   0    1    1    39
 02 003 03  0    0    0   0   0    1    1    31
 03 003 03  0    0    0   0   0    1    1    41
 04 003 03  0    0    0   0   0    1    1    49
 05 000 00  1    0    0   0   0    0    0    00
 06 003 03  0    0    0   0   0    1    1    51
 07 003 03  0    0    0   0   0    1    1    59
 08 003 03  0    0    0   0   0    1    1    61
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 003 03  0    0    0   0   0    1    1    69
 0d 003 03  0    0    0   0   0    1    1    71
 0e 003 03  0    0    0   0   0    1    1    79
 0f 003 03  0    0    0   0   0    1    1    81
 10 003 03  1    1    0   1   0    1    1    89
 11 003 03  1    1    0   1   0    1    1    91
 12 003 03  1    1    0   1   0    1    1    99
 13 003 03  1    1    0   1   0    1    1    A1
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1545.9771 MHz.
..... host bus clock speed is 268.8660 MHz.
cpu: 0, clocks: 2688660, slice: 896220
CPU0<T0:2688656,T1:1792432,D:4,S:896220,C:2688660>
cpu: 1, clocks: 2688660, slice: 896220
CPU1<T0:2688656,T1:896208,D:8,S:896220,C:2688660>
checking TSC synchronization across CPUs: passed.
migration_task 0 on cpu=0
migration_task 1 on cpu=1
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: probably your BIOS does not setup all CPUs
PCI: PCI BIOS revision 2.10 entry at 0xf1f20, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router AMD768 [1022/7443] at 00:07.3
PCI->APIC IRQ transform: (B0,I9,P0) -> 17
PCI->APIC IRQ transform: (B1,I5,P0) -> 16
PCI->APIC IRQ transform: (B2,I0,P3) -> 19
PCI->APIC IRQ transform: (B2,I5,P0) -> 18
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
devfs: v1.12a (20020514) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
udf: registering filesystem
ACPI: Core Subsystem version [20011018]
ACPI: Subsystem enabled
ACPI: System firmware supports S0 S1 S4 S5
Processor[0]: C0 C1
Processor[1]: C0 C1
ACPI: Power Button (FF) found
ACPI: Multiple power buttons detected, ignoring fixed-feature
ACPI: Power Button (CM) found
ACPI: Sleep Button (FF) found
parport0: PC-style at 0x378 (0x778) [PCSPP(,...)]
parport0: irq 7 detected
matroxfb: Matrox Millennium G400 MAX (AGP) detected
matroxfb: MTRR's turned on
matroxfb: 640x480x8bpp (virtual: 640x26208)
matroxfb: framebuffer at 0xF8000000, mapped to 0xe0825000, size 33554432
Console: switching to colour frame buffer device 80x30
fb0: MATROX VGA frame buffer device
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI
enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
lp0: using parport0 (polling).
lp0: console ready
Real Time Clock Driver v1.10e
Non-volatile memory driver v1.1
amd768_rng: AMD768 system management I/O registers at 0xE400.
amd768_rng hardware driver 0.1.0 loaded
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
AMD7441: IDE controller on PCI bus 00 dev 39
AMD7441: chipset revision 4
AMD7441: not 100% native mode: will probe irqs later
AMD7441: disabling single-word DMA support (revision < C4)
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:pio, hdd:DMA
hda: SHUTTLE, ATAPI CD/DVD-ROM drive
hdd: Pioneer DVD-ROM ATAPIModel DVD-105S 011, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: ATAPI 32X CD-ROM CD-R/RW drive, 2048kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
hdd: ATAPI DVD-ROM drive, 512kB Cache, UDMA(33)
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
via-rhine.c:v1.10-LK1.1.14  May-3-2002  Written by Donald Becker
  http://www.scyld.com/network/via-rhine.html
eth0: VIA VT86C100A Rhine at 0xc400, 00:50:ba:c8:9f:e8, IRQ 18.
eth0: MII PHY found at address 8, status 0x782d advertising 05e1 Link
41e1.
Linux video capture interface: v1.00
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: Detected AMD 760MP chipset
agpgart: AGP aperture is 32M @ 0xfc000000
[drm] AGP 0.99 on AMD Irongate @ 0xfc000000 32MB
[drm] Initialized mga 3.0.2 20010321 on minor 0
SCSI subsystem driver Revision: 1.00
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
        <Adaptec 29160 Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

  Vendor: IBM       Model: IC35L036UWD210-0  Rev: S5BS
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: IBM       Model: IC35L036UWD210-0  Rev: S5BS
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
scsi0:A:1:0: Tagged Queuing enabled.  Depth 253
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
(scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
SCSI device sda: 71687340 512-byte hdwr sectors (36704 MB)
Partition check:
 /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 >
(scsi0:A:1): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
SCSI device sdb: 71687340 512-byte hdwr sectors (36704 MB)
 /dev/scsi/host0/bus0/target1/lun0: p1 p2 p3 p4 < p5 p6 >
cmpci: version $Revision: 5.64 $ time 17:50:35 Dec 18 2002
PCI: Enabling device 02:04.0 (0084 -> 0085)
PCI: No IRQ known for interrupt pin A of device 02:04.0. Probably buggy
MP
table.
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
hcd/ehci-hcd.c: 2002-May-07 USB 2.0 'Enhanced' Host Controller (EHCI)
Driver
hcd/ehci-hcd.c: block sizes: qh 96 qtd 96 itd 128 sitd 64
PCI: Enabling device 02:08.2 (0014 -> 0016)
PCI: No IRQ known for interrupt pin C of device 02:08.2. Probably buggy
MP
table.
hcd.c: Found HC with no IRQ.  Check BIOS/PCI 02:08.2 setup!
usb-ohci.c: USB OHCI at membase 0xe2845000, IRQ 19
usb-ohci.c: usb-02:00.0, Advanced Micro Devices [AMD] AMD-768 [Opus] USB
usb.c: new USB bus registered, assigned bus number 1
usb.c: kmalloc IF c16d28c0, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Product: USB OHCI Root Hub
SerialNumber: e2845000
hub.c: USB hub found
hub.c: 4 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: Port indicators are not supported
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RRRR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface c16d28c0
usb.c: kusbd: /sbin/hotplug add 1
usb.c: kusbd policy returned 0xfffffffe
PCI: Enabling device 02:08.0 (0014 -> 0016)
PCI: No IRQ known for interrupt pin A of device 02:08.0. Probably buggy
MP
table.
usb-ohci.c: found OHCI device with no IRQ assigned. check BIOS settings!
PCI: Enabling device 02:08.1 (0014 -> 0016)
PCI: No IRQ known for interrupt pin B of device 02:08.1. Probably buggy
MP
table.
usb-ohci.c: found OHCI device with no IRQ assigned. check BIOS settings!
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
USB Mass Storage support registered.
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
IPv4 over IPv4 tunneling driver
GRE over IPv4 tunneling driver
Linux IP multicast router 0.06 plus PIM-SM
klips_info:ipsec_init: KLIPS startup, FreeS/WAN IPSec version: 1.98b
ip_conntrack version 2.1 (4095 buckets, 32760 max) - 304 bytes per
conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_random match loaded
netfilter PSD loaded - (c) astaro AG
ipt_nth match loaded
ipt_ipv4options loading
ipt_IPV4OPTSSTRIP loaded
arp_tables: (C) 2002 David S. Miller
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
ip6_tables: (C) 2000-2002 Netfilter core team
registering ipv6 mark target
cryptoapi: loaded
cryptoloop: loaded
cryptoapi: Registered aes-ecb (0)
cryptoapi: Registered aes-cbc (65536)
cryptoapi: Registered aes-cfb (262144)
cryptoapi: Registered blowfish-ecb (0)
cryptoapi: Registered blowfish-cbc (65536)
cryptoapi: Registered blowfish-cfb (262144)
cryptoapi: Registered cast5-ecb (0)
cryptoapi: Registered cast5-cbc (65536)
cryptoapi: Registered cast5-cfb (262144)
cryptoapi: Registered des-ecb (0)
cryptoapi: Registered des-cbc (65536)
cryptoapi: Registered des-cfb (262144)
cryptoapi: Registered des_ede3-ecb (0)
cryptoapi: Registered des_ede3-cbc (65536)
cryptoapi: Registered des_ede3-cfb (262144)
cryptoapi: Registered dfc-ecb (0)
cryptoapi: Registered dfc-cbc (65536)
cryptoapi: Registered dfc-cfb (262144)
cryptoapi: Registered idea-ecb (0)
cryptoapi: Registered idea-cbc (65536)
cryptoapi: Registered idea-cfb (262144)
cryptoapi: Registered mars-ecb (0)
cryptoapi: Registered mars-cbc (65536)
cryptoapi: Registered mars-cfb (262144)
cryptoapi: Registered rc5-ecb (0)
cryptoapi: Registered rc5-cbc (65536)
cryptoapi: Registered rc6-ecb (0)
cryptoapi: Registered rc6-cbc (65536)
cryptoapi: Registered rc6-cfb (262144)
cryptoapi: Registered serpent-ecb (0)
cryptoapi: Registered serpent-cbc (65536)
cryptoapi: Registered serpent-cfb (262144)
cryptoapi: Registered twofish-ecb (0)
cryptoapi: Registered twofish-cbc (65536)
cryptoapi: Registered twofish-cfb (262144)
MD5 Message Digest Algorithm (c) RSA Systems, Inc
cryptoapi: Registered md5 (0)
cryptoapi: Registered sha1 (0)
cramfs: wrong magic
FAT: bogus logical sector size 0
UMSDOS: msdos_read_super failed, mount aborted.
FAT: bogus logical sector size 0
FAT: bogus logical sector size 0
UDF-fs DEBUG lowlevel.c:65:udf_get_last_session: CDROMMULTISESSION not
supported: rc=-22
UDF-fs DEBUG super.c:1421:udf_read_super: Multi-session=0
UDF-fs DEBUG super.c:410:udf_vrs: Starting at sector 16 (2048 byte
sectors)
UDF-fs DEBUG super.c:1157:udf_check_valid: Failed to read byte 32768.
 Assuming open disc. Skipping validity check
UDF-fs DEBUG misc.c:285:udf_read_tagged: location mismatch block 256,
tag
195051 != 256
UDF-fs DEBUG super.c:1211:udf_load_partition: No Anchor block found
UDF-fs: No partition found (1)
reiserfs: checking transaction log (device 08:03) ...
Warning, log replay starting on readonly filesystem
reiserfs: replayed 2 transactions in 1 seconds
Using r5 hash to sort names
ReiserFS version 3.6.25
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 136k freed
Adding Swap: 514072k swap-space (priority -1)
Adding Swap: 514072k swap-space (priority -2)
reiserfs: checking transaction log (device 08:13) ...
reiserfs: replayed 3 transactions in 0 seconds
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 08:15) ...
reiserfs: replayed 3 transactions in 1 seconds
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 08:16) ...
reiserfs: replayed 3 transactions in 1 seconds
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 08:05) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 08:06) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
eth0: Setting full-duplex based on MII #8 link partner capability of
41e1.
eth0: no IPv6 routers present

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


