Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265517AbUANJP2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 04:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265660AbUANJOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 04:14:39 -0500
Received: from [213.69.232.58] ([213.69.232.58]:31241 "HELO
	mobilemail.schottelius.org") by vger.kernel.org with SMTP
	id S265517AbUANJMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 04:12:21 -0500
Date: Wed, 14 Jan 2004 10:12:07 +0100
From: Nico Schottelius <nico-kernel@schottelius.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linux-net@vger.kernel.org
Subject: Slow Networking in 2.5/2.6
Message-ID: <20040114091207.GA8207@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-net@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rS8CxjVDS/+yyDmU"
Content-Disposition: inline
X-MSMail-Priority: gibbet nicht.
X-Mailer: cat << EOF | netcat mailhost 110
Organization: http://nerd-hosting.net/
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux scice 2.6.1
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--rS8CxjVDS/+yyDmU
Content-Type: multipart/mixed; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

I am having problems with several cards in Linux 2.6:
   - 3com 3c905
   - rtl8139

The rates in a 100Mbit/s network I get are nearly exaclty
1MB/s.

Currently I am sitting on the notebook with the rtl8139 card,
so if someone has hints to debug this I can respond very fast.

Btw, yes, other hosts have better rates. Normally we have 8MB/s
when scp-ing:

Host me ---> fileserver: 1MB/s
Host me ---> host test: 1MB/s
Host other ---> fileserver: 8MB/s
Host test ---> fileserver: 5-7MB/s

Greetings,

Nico

ps: dmesg attached

--=20
Keep it simple & stupid, use what's available.
pgp: 8D0E E27A          | Nico Schottelius
http://nerd-hosting.net | http://linux.schottelius.org

--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg

Linux version 2.6.1 (root@scice) (gcc version 3.3.3 20031206 (prerelease) (Debian)) #4 Sun Jan 11 23:36:18 CET 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 0000000000095c00 (usable)
 BIOS-e820: 0000000000095c00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000016ff0000 (usable)
 BIOS-e820: 0000000016ff0000 - 0000000016ff8000 (ACPI data)
 BIOS-e820: 0000000016ff8000 - 0000000017000000 (ACPI NVS)
 BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
367MB LOWMEM available.
On node 0 totalpages: 94192
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 90096 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 AMI                                       ) @ 0x000fad50
ACPI: RSDT (v001 AMIINT AMIINT09 0x00000011 MSFT 0x00000097) @ 0x16ff0000
ACPI: FADT (v001 AMIINT AMIINT09 0x00000011 MSFT 0x00000097) @ 0x16ff0030
ACPI: DSDT (v001 TM5600    TMx86 0x00001000 MSFT 0x0100000d) @ 0x00000000
Building zonelist for node : 0
Kernel command line: video=sisfb:mode:1024x768x16,rate:60 init=/sbin/minit
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 599.093 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 369088k/376768k available (2236k kernel code, 6848k reserved, 534k data, 128k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 1101.82 BogoMIPS
Security Scaffold v1.0.0 initialized
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0084893f 0081813f 00000000 00000000
CPU:     After vendor identify, caps: 0084893f 0081813f 0000000e 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (32 bytes/line)
CPU: L2 Cache: 512K (128 bytes/line)
CPU: Processor revision 1.3.2.1, 600 MHz
CPU: Code Morphing Software revision 4.2.7-8-278
CPU: 20011004 02:04 official release 4.2.7#7
CPU serial number disabled.
CPU:     After all inits, caps: 0080893f 0081813f 0000000e 00000000
CPU: Transmeta(tm) Crusoe(tm) Processor TM5600 stepping 03
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfda61, last bus=0
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20031002
ACPI: IRQ 4 was Edge Triggered, setting to Level Triggerd
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Power Resource [URP1] (off)
ACPI: Power Resource [URP2] (off)
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 *5 6 7 14 15)
ACPI: PCI Interrupt Link [LNKP] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 9
ACPI: No IRQ known for interrupt pin A of device 0000:00:10.0
ACPI: PCI Interrupt Link [LNKP] enabled at IRQ 10
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
ikconfig 0.7 with /proc/config*
VFS: Disk quotas dquot_6.5.1
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
SGI XFS for Linux with ACLs, no debug enabled
SGI XFS Quota Management subsystem
Initializing Cryptographic API
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID0]
ACPI: Processor [CPU1] (supports C1, 8 throttling states)
pty: 256 Unix98 ptys configured
Linux agpgart interface v0.100 (c) Dave Jones
[drm] Initialized sis 1.1.0 20030826 on minor 0
loop: loaded (max 8 devices)
8139too Fast Ethernet driver 0.9.26
eth0: RealTek RTL8139 at 0xd7806e00, 00:0a:e6:ba:f6:c2, IRQ 5
eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ALI15X3: IDE controller at PCI slot 0000:00:10.0
ACPI: No IRQ known for interrupt pin A of device 0000:00:10.0
ALI15X3: chipset revision 196
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:pio
hda: FUJITSU MHS2030AT, ATA DISK drive
Using deadline io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: QSI CD-RW/DVD-ROM SBW-242, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 58605120 sectors (30005 MB) w/2048KiB Cache, CHS=58140/16/63, UDMA(100)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4
mice: PS/2 mouse device common for all mice
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
Synaptics Touchpad, model: 1
 Firmware: 5.8
 Sensor: 29
 new absolute packet format
 Touchpad has extended capability bits
 -> 4 multi-buttons, i.e. besides standard buttons
 -> multifinger detection
 -> palm detection
input: SynPS/2 Synaptics TouchPad on isa0060/serio4
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
NET: Registered protocol family 15
BIOS EDD facility v0.10 2003-Oct-11, 1 devices found
Please report your BIOS at http://domsch.com/linux/edd30/results.html
ACPI: (supports S0 S1 S3 S4 S5)
XFS mounting filesystem hda3
Ending clean XFS mount for filesystem: hda3
VFS: Mounted root (xfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 128k freed
XFS mounting filesystem hda1
Ending clean XFS mount for filesystem: hda1
XFS mounting filesystem loop0
Ending clean XFS mount for filesystem: loop0
eth0: link up, 100Mbps, full-duplex, lpa 0x41E1
Disabled Privacy Extensions on device c03ab2a0(lo)
hdc: ATAPI 12X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ehci_hcd 0000:00:0a.2: EHCI Host Controller
ehci_hcd 0000:00:0a.2: irq 9, pci mem d7819f00
ehci_hcd 0000:00:0a.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:0a.2: USB 2.0 enabled, EHCI 0.95, driver 2003-Jun-13
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
ohci_hcd: 2003 Oct 13 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
ohci_hcd 0000:00:14.0: OHCI Host Controller
ohci_hcd 0000:00:14.0: irq 10, pci mem d7867000
ohci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
uhci_hcd 0000:00:0a.0: UHCI Host Controller
uhci_hcd 0000:00:0a.0: irq 11, io base 0000de80
uhci_hcd 0000:00:0a.0: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
uhci_hcd 0000:00:0a.1: UHCI Host Controller
uhci_hcd 0000:00:0a.1: irq 5, io base 0000df00
uhci_hcd 0000:00:0a.1: new USB bus registered, assigned bus number 4
hub 2-0:1.0: new USB device on port 1, assigned address 2
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
prism2_init: prism2_usb.o: 0.2.1-pre16 Loaded
prism2_init: dev_info is: prism2_usb
drivers/usb/core/usb.c: registered new driver prism2_usb
ident: nic h/w: id=0x8026 1.0.0
ident: pri f/w: id=0x15 1.1.3
ident: sta f/w: id=0x1f 1.5.6
MFI:SUP:role=0x00:id=0x01:var=0x01:b/t=1/1
CFI:SUP:role=0x00:id=0x02:var=0x02:b/t=1/1
PRI:SUP:role=0x00:id=0x03:var=0x01:b/t=1/4
STA:SUP:role=0x00:id=0x04:var=0x01:b/t=1/10
PRI-CFI:ACT:role=0x01:id=0x02:var=0x02:b/t=1/1
STA-CFI:ACT:role=0x01:id=0x02:var=0x02:b/t=1/1
STA-MFI:ACT:role=0x01:id=0x01:var=0x01:b/t=1/1
Prism2 card SN: \x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00
eth0: link up, 100Mbps, full-duplex, lpa 0x41E1
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
spurious 8259A interrupt: IRQ7.
eth0: link down
ident: nic h/w: id=0x8026 1.0.0
ident: pri f/w: id=0x15 1.1.3
ident: sta f/w: id=0x1f 1.5.6
MFI:SUP:role=0x00:id=0x01:var=0x01:b/t=1/1
CFI:SUP:role=0x00:id=0x02:var=0x02:b/t=1/1
PRI:SUP:role=0x00:id=0x03:var=0x01:b/t=1/4
STA:SUP:role=0x00:id=0x04:var=0x01:b/t=1/10
PRI-CFI:ACT:role=0x01:id=0x02:var=0x02:b/t=1/1
STA-CFI:ACT:role=0x01:id=0x02:var=0x02:b/t=1/1
STA-MFI:ACT:role=0x01:id=0x01:var=0x01:b/t=1/1
Prism2 card SN: \x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00
monitor mode enabled
device wlan0 entered promiscuous mode
eth0: link up, 100Mbps, full-duplex, lpa 0x41E1
eth0: link up, 100Mbps, full-duplex, lpa 0x41E1
eth0: no IPv6 routers present
eth0: link up, 100Mbps, full-duplex, lpa 0x41E1
eth0: no IPv6 routers present
eth0: link down
eth0: link up, 100Mbps, full-duplex, lpa 0x41E1
eth0: link up, 100Mbps, full-duplex, lpa 0x41E1
monitor mode disabled
eth0: link up, 100Mbps, full-duplex, lpa 0x41E1

--1yeeQ81UyVL57Vl7--

--rS8CxjVDS/+yyDmU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFABQfnzGnTqo0OJ6QRAqJxAJ9ngZ1LCmzTxkg4jpZOTBsEPxsv1gCdGxKL
uSgjB9JrXbtOFiKJne2XjUY=
=EIbE
-----END PGP SIGNATURE-----

--rS8CxjVDS/+yyDmU--
