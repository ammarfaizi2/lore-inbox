Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267022AbSKVJVs>; Fri, 22 Nov 2002 04:21:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267099AbSKVJVs>; Fri, 22 Nov 2002 04:21:48 -0500
Received: from web12405.mail.yahoo.com ([216.136.173.132]:41863 "HELO
	web12405.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S267022AbSKVJVm>; Fri, 22 Nov 2002 04:21:42 -0500
Message-ID: <20021122092846.38949.qmail@web12405.mail.yahoo.com>
Date: Fri, 22 Nov 2002 01:28:46 -0800 (PST)
From: Luming <m_i_c_y_u@yahoo.com>
Subject: 2.5.48 PCMCIA network device  doesn't work
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-128782083-1037957326=:38806"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-128782083-1037957326=:38806
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Machine: IBM T600E
Net Card: Xircom PCMCIA ethernet card

After booting up, I fount eth0 wasn't up.
So I retry.
#/etc/init.d/pcmcia stop
#/etc/init.d/pcmcia start

See output of dmesg in attached file pls.


__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus – Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com
--0-128782083-1037957326=:38806
Content-Type: text/plain; name="dmesg.txt"
Content-Description: dmesg.txt
Content-Disposition: inline; filename="dmesg.txt"

 name = ISA Plug and Play
kobject pnp0: registering
dev_hotplug
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
subsystem usb: registering
  parent is bus
kobject usb: registering
  parent is bus
subsystem devices: registering
  parent is usb
kobject devices: registering
  parent is usb
subsystem drivers: registering
  parent is usb
kobject drivers: registering
  parent is usb
bus type 'usb' registered
driver usb:usbfs: registering
kobject usbfs: registering
bus usb: add driver usbfs
drivers/usb/core/usb.c: registered new driver usbfs
driver usb:hub: registering
kobject hub: registering
bus usb: add driver hub
drivers/usb/core/usb.c: registered new driver hub
driver usb:usb: registering
kobject usb: registering
bus usb: add driver usb
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
DEV: registering device: ID = 'pci0', name = Host/PCI Bridge
kobject pci0: registering
dev_hotplug
DEV: registering device: ID = '00:00.0', name = Intel Corp. 440BX/ZX/DX - 82443B
kobject 00:00.0: registering
  parent is pci0
bus pci: add device 00:00.0
dev_hotplug
do_hotplug
fill_devpath: path = 'root/pci0/00:00.0'
do_hotplug: /sbin/hotplug pci HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=root/pci0/00:00.0
do_hotplug - call_usermodehelper returned -16
DEV: registering device: ID = '00:01.0', name = Intel Corp. 440BX/ZX/DX - 82443B
kobject 00:01.0: registering
  parent is pci0
bus pci: add device 00:01.0
dev_hotplug
do_hotplug
fill_devpath: path = 'root/pci0/00:01.0'
do_hotplug: /sbin/hotplug pci HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=root/pci0/00:01.0
do_hotplug - call_usermodehelper returned -16
DEV: registering device: ID = '00:02.0', name = Texas Instruments PCI1251A
kobject 00:02.0: registering
  parent is pci0
bus pci: add device 00:02.0
dev_hotplug
do_hotplug
fill_devpath: path = 'root/pci0/00:02.0'
do_hotplug: /sbin/hotplug pci HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=root/pci0/00:02.0
do_hotplug - call_usermodehelper returned -16
DEV: registering device: ID = '00:02.1', name = Texas Instruments PCI1251A (#2)
kobject 00:02.1: registering
  parent is pci0
bus pci: add device 00:02.1
dev_hotplug
do_hotplug
fill_devpath: path = 'root/pci0/00:02.1'
do_hotplug: /sbin/hotplug pci HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=root/pci0/00:02.1
do_hotplug - call_usermodehelper returned -16
DEV: registering device: ID = '00:06.0', name = Cirrus Logic CS 4610/11 [CrystalC
kobject 00:06.0: registering
  parent is pci0
bus pci: add device 00:06.0
dev_hotplug
do_hotplug
fill_devpath: path = 'root/pci0/00:06.0'
do_hotplug: /sbin/hotplug pci HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=root/pci0/00:06.0
do_hotplug - call_usermodehelper returned -16
DEV: registering device: ID = '00:07.0', name = Intel Corp. 82371AB/EB/MB PIIX4 
kobject 00:07.0: registering
  parent is pci0
bus pci: add device 00:07.0
dev_hotplug
do_hotplug
fill_devpath: path = 'root/pci0/00:07.0'
do_hotplug: /sbin/hotplug pci HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=root/pci0/00:07.0
do_hotplug - call_usermodehelper returned -16
DEV: registering device: ID = '00:07.1', name = Intel Corp. 82371AB/EB/MB PIIX4 
kobject 00:07.1: registering
  parent is pci0
bus pci: add device 00:07.1
dev_hotplug
do_hotplug
fill_devpath: path = 'root/pci0/00:07.1'
do_hotplug: /sbin/hotplug pci HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=root/pci0/00:07.1
do_hotplug - call_usermodehelper returned -16
DEV: registering device: ID = '00:07.2', name = Intel Corp. 82371AB/EB/MB PIIX4 
kobject 00:07.2: registering
  parent is pci0
bus pci: add device 00:07.2
dev_hotplug
do_hotplug
fill_devpath: path = 'root/pci0/00:07.2'
do_hotplug: /sbin/hotplug pci HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=root/pci0/00:07.2
do_hotplug - call_usermodehelper returned -16
DEV: registering device: ID = '00:07.3', name = Intel Corp. 82371AB/EB/MB PIIX4 
kobject 00:07.3: registering
  parent is pci0
bus pci: add device 00:07.3
dev_hotplug
do_hotplug
fill_devpath: path = 'root/pci0/00:07.3'
do_hotplug: /sbin/hotplug pci HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=root/pci0/00:07.3
do_hotplug - call_usermodehelper returned -16
DEV: registering device: ID = '01:00.0', name = Neomagic Corporation [MagicMedia 256AV]
kobject 01:00.0: registering
  parent is 00:01.0
bus pci: add device 01:00.0
dev_hotplug
do_hotplug
fill_devpath: path = 'root/pci0/00:01.0/01:00.0'
do_hotplug: /sbin/hotplug pci HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=root/pci0/00:01.0/01:00.0
do_hotplug - call_usermodehelper returned -16
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
driver system:pic: registering
kobject pic: registering
bus system: add driver pic
Registering system device pic0
DEV: registering device: ID = 'pic0', name = i8259A PIC
kobject pic0: registering
  parent is sys
bus system: add device pic0
bound device 'pic0' to driver 'pic'
dev_hotplug
do_hotplug
fill_devpath: path = 'root/sys/pic0'
do_hotplug: /sbin/hotplug system HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=root/sys/pic0
do_hotplug - call_usermodehelper returned -16
Registering system device rtc0
DEV: registering device: ID = 'rtc0', name = i8253 Real Time Clock
kobject rtc0: registering
  parent is sys
bus system: add device rtc0
dev_hotplug
do_hotplug
fill_devpath: path = 'root/sys/rtc0'
do_hotplug: /sbin/hotplug system HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=root/sys/rtc0
do_hotplug - call_usermodehelper returned -16
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
Starting kswapd
aio_setup: sizeof(struct page) = 40
[c7f7e040] eventpoll: successfully initialized.
subsystem : registering
  parent is block
kobject : registering
  parent is block
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
udf: registering filesystem
Capability LSM initialized
Limiting direct PCI/PCI transfers.
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
driver pci:serial: registering
kobject serial: registering
bus pci: add driver serial
driver pnp:serial: registering
kobject serial: registering
bus pnp: add driver serial
driver pnp:parport_pc: registering
kobject parport_pc: registering
bus pnp: add driver parport_pc
driver pci:parport_pc: registering
kobject parport_pc: registering
bus pci: add driver parport_pc
pty: 256 Unix98 ptys configured
request_module[parport_lowlevel]: not ready
lp: driver loaded but no devices found
Linux agpgart interface v0.99 (c) Jeff Hartmann
driver pci:agpgart: registering
kobject agpgart: registering
bus pci: add driver agpgart
agpgart: Maximum main memory to use for agp memory: 94M
agpgart: Detected Intel 440BX chipset
agpgart: AGP aperture is 64M @ 0x40000000
bound device '00:00.0' to driver 'agpgart'
[drm] AGP 0.99 on Intel 440BX @ 0x40000000 64MB
[drm] Initialized radeon 1.7.0 20020828 on minor 0
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
kobject fd0: registering
kobject fd1: registering
DEV: registering device: ID = 'floppy0', name = Floppy Drive
kobject floppy0: registering
  parent is legacy
bus platform: add device floppy0
dev_hotplug
do_hotplug
fill_devpath: path = 'root/legacy/floppy0'
do_hotplug: /sbin/hotplug platform HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=root/legacy/floppy0
do_hotplug - call_usermodehelper returned -16
driver pci:e100: registering
kobject e100: registering
bus pci: add driver e100
xirc2ps_cs.c 1.31 1998/12/09 19:32:55 (dd9jn+kvh)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
subsystem ide: registering
  parent is bus
kobject ide: registering
  parent is bus
subsystem devices: registering
  parent is ide
kobject devices: registering
  parent is ide
subsystem drivers: registering
  parent is ide
kobject drivers: registering
  parent is ide
bus type 'ide' registered
PIIX4: IDE controller at PCI slot 00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfcf0-0xfcf7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfcf8-0xfcff, BIOS settings: hdc:DMA, hdd:pio
hda: IBM-DCXA-210000, ATA DISK drive
DEV: registering device: ID = 'ide0', name = IDE Controller
kobject ide0: registering
  parent is 00:07.1
dev_hotplug
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
DEV: registering device: ID = '0.0', name = IDE Drive
kobject 0.0: registering
  parent is ide0
bus ide: add device 0.0
dev_hotplug
do_hotplug
fill_devpath: path = 'root/pci0/00:07.1/ide0/0.0'
do_hotplug: /sbin/hotplug ide HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=root/pci0/00:07.1/ide0/0.0
do_hotplug - call_usermodehelper returned -16
hdc: CRN-8241B, ATAPI CD/DVD-ROM drive
DEV: registering device: ID = 'ide1', name = IDE Controller
kobject ide1: registering
  parent is 00:07.1
dev_hotplug
ide1 at 0x170-0x177,0x376 on irq 15
DEV: registering device: ID = '1.0', name = IDE Drive
kobject 1.0: registering
  parent is ide1
bus ide: add device 1.0
dev_hotplug
do_hotplug
fill_devpath: path = 'root/pci0/00:07.1/ide1/1.0'
do_hotplug: /sbin/hotplug ide HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=root/pci0/00:07.1/ide1/1.0
do_hotplug - call_usermodehelper returned -16
driver pci:PIIX IDE: registering
kobject PIIX IDE: registering
bus pci: add driver PIIX IDE
bound device '00:07.1' to driver 'PIIX IDE'
driver pci:RZ1000 IDE: registering
kobject RZ1000 IDE: registering
bus pci: add driver RZ1000 IDE
driver pci:PCI IDE: registering
kobject PCI IDE: registering
bus pci: add driver PCI IDE
hda: host protected area => 1
hda: 19640880 sectors (10056 MB) w/420KiB Cache, CHS=1299/240/63, UDMA(33)
kobject hda: registering
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
kobject hda1: registering
  parent is hda
kobject hda2: registering
  parent is hda
kobject hda3: registering
  parent is hda
kobject hda4: registering
  parent is hda
kobject hda5: registering
  parent is hda
kobject hda6: registering
  parent is hda
driver ide:ide-disk: registering
kobject ide-disk: registering
bus ide: add driver ide-disk
hdc: ATAPI 24X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
end_request: I/O error, dev hdc, sector 0
kobject hdc: registering
driver ide:ide-cdrom: registering
kobject ide-cdrom: registering
bus ide: add driver ide-cdrom
SCSI subsystem driver Revision: 1.00
subsystem scsi: registering
  parent is bus
kobject scsi: registering
  parent is bus
subsystem devices: registering
  parent is scsi
kobject devices: registering
  parent is scsi
subsystem drivers: registering
  parent is scsi
kobject drivers: registering
  parent is scsi
bus type 'scsi' registered
driver pci:aic7xxx: registering
kobject aic7xxx: registering
bus pci: add driver aic7xxx
request_module[scsi_hostadapter]: not ready
driver scsi:sd: registering
kobject sd: registering
bus scsi: add driver sd
request_module[scsi_hostadapter]: not ready
driver scsi:sr: registering
kobject sr: registering
bus scsi: add driver sr
request_module[scsi_hostadapter]: not ready
driver scsi:sg: registering
kobject sg: registering
bus scsi: add driver sg
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
driver pci:cardbus: registering
kobject cardbus: registering
bus pci: add driver cardbus
PCI: Found IRQ 11 for device 00:02.0
PCI: Sharing IRQ 11 with 00:06.0
PCI: Sharing IRQ 11 with 01:00.0
bound device '00:02.0' to driver 'cardbus'
PCI: Found IRQ 11 for device 00:02.1
bound device '00:02.1' to driver 'cardbus'
driver pci:ehci-hcd: registering
kobject ehci-hcd: registering
bus pci: add driver ehci-hcd
Initializing USB Mass Storage driver...
driver usb:usb-storage: registering
kobject usb-storage: registering
bus usb: add driver usb-storage
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
subsystem input: registering
  parent is class
kobject input: registering
  parent is class
subsystem devices: registering
  parent is input
kobject devices: registering
  parent is input
subsystem drivers: registering
  parent is input
kobject drivers: registering
  parent is input
register interface 'mouse' with class 'input
kobject mouse: registering
mice: PS/2 mouse device common for all mice
input: PS/2 Generic Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
Advanced Linux Sound Architecture Driver Version 0.9.0rc5 (Sun Nov 10 19:48:18 2002 UTC).
request_module[snd-card-0]: not ready
request_module[snd-card-1]: not ready
request_module[snd-card-2]: not ready
request_module[snd-card-3]: not ready
request_module[snd-card-4]: not ready
request_module[snd-card-5]: not ready
request_module[snd-card-6]: not ready
request_module[snd-card-7]: not ready
driver pci:Intel ICH: registering
kobject Intel ICH: registering
bus pci: add driver Intel ICH
driver pci:Intel ICH Joystick: registering
kobject Intel ICH Joysti: registering
bus pci: add driver Intel ICH Joystick
ALSA device list:
  No soundcards found.
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Yenta IRQ list 06b8, PCI irq11
Socket status: 30000010
Yenta IRQ list 06b8, PCI irq11
Socket status: 30000006
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 100k freed
Adding 128480k swap on /dev/hda5.  Priority:-1 extents:1
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x3c0-0x3df 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: excluding 0xa0000000-0xa0ffffff
cs: memory probe 0x60000000-0x60ffffff: clean.
eth0: Xircom: port 0x300, irq 3, hwaddr 00:80:C7:F8:E1:26
Uninitialised timer!
This is just a warning.  Your computer is OK
function=0xc022dba0, data=0xc7bce800
Call Trace: [<c011a8f0>]  [<c022dba0>]  [<c011ac47>]  [<c0108bec>]  [<c022cfe5>]  [<c027b4a4>]  [<c027bd1b>]  [<c0112b65>]  [<c02cd609>]  [<c030bd9a>]  [<c0126842>]  [<c013a8cb>]  [<c02caadf>]  [<c013bd94>]  [<c02cab7b>]  [<c012cdfe>]  [<c012ec7c>]  [<c012ed0b>]  [<c012bd2b>]  [<c012bd2b>]  [<c012bd2b>]  [<c01239cc>]  [<c0123a20>]  [<c012bd2b>]  [<c0125be5>]  [<c0125b4a>]  [<c0125e3c>]  [<c0146e18>]  [<c0108aa7>] 
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x3c0-0x3df 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
xirc2ps_cs: RequestIO: Configuration locked
Uninitialised timer!
This is just a warning.  Your computer is OK
function=0xc022dba0, data=0xc135ec00
Call Trace: [<c011a8f0>]  [<c022dba0>]  [<c011ac47>]  [<c027860f>]  [<c022cfe5>]  [<c027b4a4>]  [<c027bd1b>]  [<c02cf3b8>]  [<c030bd9a>]  [<c01248f3>]  [<c02caadf>]  [<c02cab7b>]  [<c012ec7c>]  [<c012ed0b>]  [<c02ca921>]  [<c02cbc30>]  [<c02cbc3f>]  [<c012bd2b>]  [<c01239cc>]  [<c0123a20>]  [<c012bd2b>]  [<c01dc9ef>]  [<c011d7d3>]  [<c0146e18>]  [<c0108aa7>] 

--0-128782083-1037957326=:38806--
