Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265391AbUAZB02 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 20:26:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265393AbUAZB02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 20:26:28 -0500
Received: from Hell.WH8.tu-dresden.de ([141.30.225.3]:7342 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id S265391AbUAZB0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 20:26:02 -0500
Date: Mon, 26 Jan 2004 02:25:40 +0100
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [OOPS] Linux-2.6.1 suspend/resume
Message-Id: <20040126022540.315c4f8c@argon.inf.tu-dresden.de>
Organization: Fiasco Core Team
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
X-Mailer: X-Mailer 5.0 Gold
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Mon__26_Jan_2004_02_25_40_+0100_P+S5lxsNvNc.UOET"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Mon__26_Jan_2004_02_25_40_+0100_P+S5lxsNvNc.UOET
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,

I can repeatedly oops my Linux machine running kernel 2.6.1. The oops happe=
ns
during the resume following a suspend-to-disk via: echo 4 > /proc/acpi/sleep
See below.

-Udo.

Stopping tasks: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D|
Freeing memory: ..............|
hdf: start_power_step(step: 0)
hdf: completing PM request, suspend
hde: start_power_step(step: 0)
hde: completing PM request, suspend
hdb: start_power_step(step: 0)
hdb: completing PM request, suspend
hda: start_power_step(step: 0)
hda: completing PM request, suspend
/critical section: Counting pages to copy[nosave c0516000] (pages needed: 6=
905+512=3D7417 free: 189682)
Alloc pagedir
[nosave c0516000]critical section/: done (6905 pages copied)
hda: Wakeup request inited, waiting for !BSY...
hda: start_power_step(step: 1000)
blk: queue efcc5200, I/O limit 4095Mb (mask 0xffffffff)
hda: completing PM request, resume
hdb: Wakeup request inited, waiting for !BSY...
hdb: start_power_step(step: 1000)
blk: queue efc70e00, I/O limit 4095Mb (mask 0xffffffff)
hdb: completing PM request, resume
hde: Wakeup request inited, waiting for !BSY...
hde: start_power_step(step: 1000)
hde: completing PM request, resume
hdf: Wakeup request inited, waiting for !BSY...
hdf: start_power_step(step: 1000)
hdf: completing PM request, resume
Writing data to swap (6905 pages): ........................................=
..............................|
Writing pagedir (27 pages): ...........................HS|
Suspend Machine:  Trying to power down.
shift_state: 0000
acpi_power_off called
Linux version 2.6.1 (root@Corona) (gcc version 3.3.2) #1 Mon Jan 12 03:41:2=
9 CET 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000002ffec000 (usable)
 BIOS-e820: 000000002ffec000 - 000000002ffef000 (ACPI data)
 BIOS-e820: 000000002ffef000 - 000000002ffff000 (reserved)
 BIOS-e820: 000000002ffff000 - 0000000030000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
767MB LOWMEM available.
On node 0 totalpages: 196588
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 192492 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 ASUS                                      ) @ 0x000f6a90
ACPI: RSDT (v001 ASUS   A7V      0x30303031 MSFT 0x31313031) @ 0x2ffec000
ACPI: FADT (v001 ASUS   A7V      0x30303031 MSFT 0x31313031) @ 0x2ffec080
ACPI: BOOT (v001 ASUS   A7V      0x30303031 MSFT 0x31313031) @ 0x2ffec040
ACPI: DSDT (v001   ASUS A7V      0x00001000 MSFT 0x0100000b) @ 0x00000000
Building zonelist for node : 0
Kernel command line: auto BOOT_IMAGE=3DLinux-2.6 ro root=3D341 ide=3Drevers=
e resume=3D/dev/hdb2 parport=3Dauto nmi_watchdog=3D2 video=3Drivafb:off con=
sole=3DttyS0,115200
ide_setup: ide=3Dreverse : Enabled support for IDE inverse scan order.
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 807.228 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 773000k/786352k available (3140k kernel code, 12576k reserved, 1051=
k data, 176k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 1589.24 BogoMIPS
Security Scaffold v1.0.0 initialized
Capability LSM initialized
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) Processor stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
testing NMI watchdog ... OK.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 807.0103 MHz.
..... host bus clock speed is 201.0776 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf1180, last bus=3D1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20031002
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=3Dnoacpi' or even 'a=
cpi=3Doff'
spurious 8259A interrupt: IRQ7.
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
Machine check exception polling timer started.
VFS: Disk quotas dquot_6.5.1
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Initializing Cryptographic API
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1 C2, 16 throttling states)
pty: 256 Unix98 ptys configured
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA Twister-K/KT133x/KM133 chipset
agpgart: Maximum main memory to use for agp memory: 690M
agpgart: AGP aperture is 256M @ 0xd0000000
Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin is 6=
0 seconds).
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
=FFttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,EC=
P,DMA]
lp0: using parport0 (interrupt-driven).
parport_pc: Via 686A parallel port: io=3D0x378, irq=3D7, dma=3D3
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
Intel(R) PRO/100 Network Driver - version 2.3.30-k1
Copyright (c) 2003 Intel Corporation

e100: eth0: Intel(R) PRO/100 Network Connection
  Hardware receive checksums enabled
  cpu cycle saver enabled

Linux video capture interface: v1.00
bttv: driver version 0.9.12 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Bt8xx card found (0).
PCI: Enabling device 0000:00:09.0 (0004 -> 0006)
bttv0: Bt878 (rev 2) at 0000:00:09.0, irq: 9, latency: 32, mmio: 0xc7000000
bttv0: detected: Hauppauge WinTV [card=3D10], PCI subsystem ID is 0070:13eb
bttv0: using: Hauppauge (bt878) [card=3D10,autodetected]
bttv0: Hauppauge/Voodoo msp34xx: reset line init [5]
bttv0: Hauppauge eeprom: model=3D37284, tuner=3DPhilips FM1216 (5), radio=
=3Dyes
bttv0: using tuner=3D5
bttv0: i2c: checking for MSP34xx @ 0x80... found
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: registered device radio0
bttv0: PLL: 28636363 =3D> 35468950 .. ok
msp34xx: init: chip=3DMSP3410D-B4 +nicam +simple
msp3410: daemon started
registering 0-0040
tvaudio: TV audio decoder + audio/video mux driver
tvaudio: known chips: tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,t=
ea6420,tda8425,pic16c54 (PV951),ta8874z
tvaudio: found tda9840 @ 0x84
registering 0-0042
tuner: chip found @ 0xc2
tuner: type set to 5 (Philips PAL_BG (FI1216 and compatibles))
registering 0-0061
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
PDC20265: IDE controller at PCI slot 0000:00:11.0
PDC20265: chipset revision 2
PDC20265: 100% native mode on irq 10
PDC20265: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide0: BM-DMA at 0x8000-0x8007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x8008-0x800f, BIOS settings: hdc:pio, hdd:pio
hda: IBM-DTLA-307030, ATA DISK drive
hdb: IC35L120AVV207-0, ATA DISK drive
ide0 at 0x9400-0x9407,0x9002 on irq 10
VP_IDE: IDE controller at PCI slot 0000:00:04.1
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci0000:00:04.1
    ide2: BM-DMA at 0xd800-0xd807, BIOS settings: hde:pio, hdf:DMA
    ide3: BM-DMA at 0xd808-0xd80f, BIOS settings: hdg:pio, hdh:pio
hde: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
hdf: PLEXTOR CD-R PX-W1210A, ATAPI CD/DVD-ROM drive
ide2 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: 60036480 sectors (30738 MB) w/1916KiB Cache, CHS=3D59560/16/63, UDMA(1=
00)
 hda: hda1
hdb: max request size: 1024KiB
hdb: 241254720 sectors (123522 MB) w/1821KiB Cache, CHS=3D16383/255/63, UDM=
A(100)
 hdb: hdb1 hdb2 hdb3 < hdb5 hdb6 hdb7 hdb8 hdb9 hdb10 hdb11 >
hdf: ATAPI 32X CD-ROM CD-R/RW drive, 2048kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
ide-floppy driver 0.99.newide
hde: No disk in drive
hde: 98304kB, 96/64/32 CHS, 4096 kBps, 512 sector size, 2941 rpm
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver=
 v2.1
uhci_hcd 0000:00:04.2: UHCI Host Controller
uhci_hcd 0000:00:04.2: irq 9, io base 0000d400
uhci_hcd 0000:00:04.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
uhci_hcd 0000:00:04.3: UHCI Host Controller
uhci_hcd 0000:00:04.3: irq 9, io base 0000d000
uhci_hcd 0000:00:04.3: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
drivers/usb/core/usb.c: registered new driver usbscanner
drivers/usb/image/scanner.c: 0.4.16:USB Scanner Driver
mice: PS/2 mouse device common for all mice
input: PC Speaker
PCI: Enabling device 0000:00:0a.1 (0004 -> 0005)
input: Analog 3-axis 4-button joystick at pci0000:00:0a.1/gameport0 [TSC ti=
mer, 794 MHz clock, 843 ns res]
gameport: pci0000:00:0a.1 speed 1296 kHz
serio: i8042 AUX port at 0x60,0x64 irq 12
input: ImExPS/2 Generic Explorer Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
i2c /dev entries driver
registering 1-002d
registering 1-0049
registering 1-0048
tuner: type already set (5)
registering 0-0050
Advanced Linux Sound Architecture Driver Version 0.9.7 (Thu Sep 25 19:16:36=
 2003 UTC).
PCI: Enabling device 0000:00:0a.0 (0004 -> 0005)
ALSA device list:
  #0: Sound Blaster Live! (rev.8) at 0xa400, irq 5
NET: Registered protocol family 2
hub 1-0:1.0: new USB device on port 2, assigned address 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
ip_conntrack version 2.1 (6143 buckets, 49144 max) - 160 bytes per conntrack
hub 1-2:1.0: USB hub found
hub 1-2:1.0: 5 ports detected
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/=
projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
ip6_tables: (C) 2000-2002 Netfilter core team
NET: Registered protocol family 17
NET: Registered protocol family 15
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
BIOS EDD facility v0.10 2003-Oct-11, 2 devices found
Please report your BIOS at http://domsch.com/linux/edd30/results.html
Resume Machine: resuming from /dev/hdb2
Resuming from device hdb2
Resume Machine: Signature found, resuming
Resume Machine: Reading pagedir, Relocating pagedir|
Reading image data (6905 pages): ...<6>hub 1-2:1.0: new USB device on port =
1, assigned address 3
....................<6>hub 2-0:1.0: new USB device on port 2, assigned addr=
ess 2
.<6>hub 2-2:1.0: USB hub found
hub 2-2:1.0: 4 ports detected
..............................................|
Reading resume file was successful
Waiting for DMAs to settle down...
Freeing prev allocated pagedir
bad: scheduling while atomic!
Call Trace:
 [<c011a7d3>] schedule+0x563/0x570
 [<c0356e7d>] pci_read+0x3d/0x50
 [<c0125ff3>] schedule_timeout+0x63/0xc0
 [<c0125f80>] process_timeout+0x0/0x10
 [<c02387b3>] pci_set_power_state+0xd3/0x160
 [<c02fc028>] usb_hcd_pci_resume+0x38/0x90
 [<c023ac54>] pci_device_resume+0x24/0x30
 [<c028a3e7>] resume_device+0x27/0x30
 [<c028a424>] dpm_resume+0x34/0x60
 [<c028a469>] device_resume+0x19/0x30
 [<c01337e9>] drivers_resume+0x39/0x40
 [<c0133aba>] do_magic_resume_2+0x5a/0xe0
 [<c0133ad2>] do_magic_resume_2+0x72/0xe0
 [<c03576af>] do_magic+0x11f/0x130
 [<c0133cfb>] do_software_suspend+0x6b/0x90
 [<c02538e6>] acpi_system_write_sleep+0xb3/0xcd
 [<c0253833>] acpi_system_write_sleep+0x0/0xcd
 [<c0150398>] vfs_write+0xd8/0x140
 [<c01504b2>] sys_write+0x42/0x70
 [<c0109387>] syscall_call+0x7/0xb

bad: scheduling while atomic!
Call Trace:
 [<c011a7d3>] schedule+0x563/0x570
 [<c0356e7d>] pci_read+0x3d/0x50
 [<c0125ff3>] schedule_timeout+0x63/0xc0
 [<c0125f80>] process_timeout+0x0/0x10
 [<c02387b3>] pci_set_power_state+0xd3/0x160
 [<c02fc028>] usb_hcd_pci_resume+0x38/0x90
 [<c023ac54>] pci_device_resume+0x24/0x30
 [<c028a3e7>] resume_device+0x27/0x30
 [<c028a424>] dpm_resume+0x34/0x60
 [<c028a469>] device_resume+0x19/0x30
 [<c01337e9>] drivers_resume+0x39/0x40
 [<c0133aba>] do_magic_resume_2+0x5a/0xe0
 [<c0133ad2>] do_magic_resume_2+0x72/0xe0
 [<c03576af>] do_magic+0x11f/0x130
 [<c0133cfb>] do_software_suspend+0x6b/0x90
 [<c02538e6>] acpi_system_write_sleep+0xb3/0xcd
 [<c0253833>] acpi_system_write_sleep+0x0/0xcd
 [<c0150398>] vfs_write+0xd8/0x140
 [<c01504b2>] sys_write+0x42/0x70
 [<c0109387>] syscall_call+0x7/0xb

bad: scheduling while atomic!
Call Trace:
 [<c011a7d3>] schedule+0x563/0x570
 [<c0356e7d>] pci_read+0x3d/0x50
 [<c0125ff3>] schedule_timeout+0x63/0xc0
 [<c0125f80>] process_timeout+0x0/0x10
 [<c02387b3>] pci_set_power_state+0xd3/0x160
 [<c02a3708>] e100_resume+0x28/0x70
 [<c023ac54>] pci_device_resume+0x24/0x30
 [<c028a3e7>] resume_device+0x27/0x30
 [<c028a424>] dpm_resume+0x34/0x60
 [<c028a469>] device_resume+0x19/0x30
 [<c01337e9>] drivers_resume+0x39/0x40
 [<c0133aba>] do_magic_resume_2+0x5a/0xe0
 [<c0133ad2>] do_magic_resume_2+0x72/0xe0
 [<c03576af>] do_magic+0x11f/0x130
 [<c0133cfb>] do_software_suspend+0x6b/0x90
 [<c02538e6>] acpi_system_write_sleep+0xb3/0xcd
 [<c0253833>] acpi_system_write_sleep+0x0/0xcd
 [<c0150398>] vfs_write+0xd8/0x140
 [<c01504b2>] sys_write+0x42/0x70
 [<c0109387>] syscall_call+0x7/0xb

hda: Wakeup request inited, waiting for !BSY...
hda: start_power_step(step: 1000)
blk: queue efcc5200, I/O limit 4095Mb (mask 0xffffffff)
hda: completing PM request, resume
hdb: Wakeup request inited, waiting for !BSY...
hdb: start_power_step(step: 1000)
blk: queue efc70e00, I/O limit 4095Mb (mask 0xffffffff)
hdb: completing PM request, resume
hde: Wakeup request inited, waiting for !BSY...
hde: start_power_step(step: 1000)
hde: completing PM request, resume
hdf: Wakeup request inited, waiting for !BSY...
hdf: start_power_step(step: 1000)
hdf: completing PM request, resume
Fixing swap signatures... <3>bad: scheduling while atomic!
Call Trace:
 [<c011a7d3>] schedule+0x563/0x570
 [<c02c397d>] do_ide_request+0x1d/0x30
 [<c028c565>] generic_unplug_device+0x75/0x80
 [<c028c704>] blk_run_queues+0xa4/0xb0
 [<c011b70e>] io_schedule+0xe/0x20
 [<c0134c15>] wait_on_page_bit+0x95/0xc0
 [<c011bf90>] autoremove_wake_function+0x0/0x50
 [<c011bf90>] autoremove_wake_function+0x0/0x50
 [<c014b376>] swap_readpage+0x56/0x80
 [<c014b433>] rw_swap_page_sync+0x93/0xe0
 [<c0132efc>] mark_swapfiles+0x7c/0x1b0
 [<c0133af2>] do_magic_resume_2+0x92/0xe0
 [<c03576af>] do_magic+0x11f/0x130
 [<c0133cfb>] do_software_suspend+0x6b/0x90
 [<c02538e6>] acpi_system_write_sleep+0xb3/0xcd
 [<c0253833>] acpi_system_write_sleep+0x0/0xcd
 [<c0150398>] vfs_write+0xd8/0x140
 [<c01504b2>] sys_write+0x42/0x70
 [<c0109387>] syscall_call+0x7/0xb

bad: scheduling while atomic!
Call Trace:
 [<c011a7d3>] schedule+0x563/0x570
 [<c02c397d>] do_ide_request+0x1d/0x30
 [<c028c565>] generic_unplug_device+0x75/0x80
 [<c028c6da>] blk_run_queues+0x7a/0xb0
 [<c011b70e>] io_schedule+0xe/0x20
 [<c0134c15>] wait_on_page_bit+0x95/0xc0
 [<c011bf90>] autoremove_wake_function+0x0/0x50
 [<c011bf90>] autoremove_wake_function+0x0/0x50
 [<c014b2ca>] swap_writepage+0x7a/0xd0
 [<c014b433>] rw_swap_page_sync+0x93/0xe0
 [<c0132f6f>] mark_swapfiles+0xef/0x1b0
 [<c0133af2>] do_magic_resume_2+0x92/0xe0
 [<c03576af>] do_magic+0x11f/0x130
 [<c0133cfb>] do_software_suspend+0x6b/0x90
 [<c02538e6>] acpi_system_write_sleep+0xb3/0xcd
 [<c0253833>] acpi_system_write_sleep+0x0/0xcd
 [<c0150398>] vfs_write+0xd8/0x140
 [<c01504b2>] sys_write+0x42/0x70
 [<c0109387>] syscall_call+0x7/0xb

ok
Restarting tasks...<3>bad: scheduling while atomic!
Call Trace:
 [<c011a7d3>] schedule+0x563/0x570
 [<c0119a27>] try_to_wake_up+0xa7/0x160
 [<c0119afe>] wake_up_process+0x1e/0x20
 [<c0132964>] thaw_processes+0xa4/0x100
 [<c0133ced>] do_software_suspend+0x5d/0x90
 [<c02538e6>] acpi_system_write_sleep+0xb3/0xcd
 [<c0253833>] acpi_system_write_sleep+0x0/0xcd
 [<c0150398>] vfs_write+0xd8/0x140
 [<c01504b2>] sys_write+0x42/0x70
 [<c0109387>] syscall_call+0x7/0xb

 done

--Signature=_Mon__26_Jan_2004_02_25_40_+0100_P+S5lxsNvNc.UOET
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAFGyUnhRzXSM7nSkRAhe9AJsFA7B9xs3yZa9jxg7UagSHXqozLQCeNjTU
QnV8mN4xyO/JQwkiSNYsz/k=
=uayf
-----END PGP SIGNATURE-----

--Signature=_Mon__26_Jan_2004_02_25_40_+0100_P+S5lxsNvNc.UOET--
