Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261662AbTI0AMC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 20:12:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261736AbTI0AMC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 20:12:02 -0400
Received: from xs.heimsnet.is ([193.4.194.50]:61951 "EHLO cg.c.is")
	by vger.kernel.org with ESMTP id S261662AbTI0ALy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 20:11:54 -0400
From: =?iso-8859-1?q?B=F6rkur=20Ingi=20J=F3nsson?= <bugsy@isl.is>
Reply-To: bugsy@isl.is
To: linux-kernel@vger.kernel.org
Subject: Re: khubd is a Succubus!
Date: Sat, 27 Sep 2003 00:23:37 +0000
User-Agent: KMail/1.5.3
References: <200309261724.56616.bugsy@isl.is> <200309262114.46531.bugsy@isl.is> <20030926211239.GA18220@kroah.com>
In-Reply-To: <20030926211239.GA18220@kroah.com>
Cc: Greg KH <greg@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309270023.37987.bugsy@isl.is>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
> Again, can you do this without the nvidia driver?  With it installed, no
> one here will be able to help you out.
>
> And I didn't see anything unusual in your kernel logs either.  Does the
> USB keyboard work ok?
>
> thanks,
>
> greg k-h
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

alright I removed the nvidia stuff and recompiled an new kernel here is my new 
dmesg: 

bash-2.05b$ dmesg
Linux version 2.6.0-test5 (root@localhost) (gcc version 3.2.3 20030422 (Gentoo 
Linux 1.4 3.2.3-r1, propolice)) #7 Sat Sep 27 00:11:39 GMT 2003
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000002fff0000 (usable)
 BIOS-e820: 000000002fff0000 - 000000002fff3000 (ACPI NVS)
 BIOS-e820: 000000002fff3000 - 0000000030000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
767MB LOWMEM available.
On node 0 totalpages: 196592
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 192496 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
Building zonelist for node : 0
Kernel command line: root /dev/hda3
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 1395.251 MHz processor.
Console: colour VGA+ 80x25
Memory: 773920k/786368k available (2605k kernel code, 11656k reserved, 910k 
data, 128k init, 0k highmem)
Calibrating delay loop... 2744.32 BogoMIPS
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU:     After generic identify, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU:     After vendor identify, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After all inits, caps: 0183f9ff c1c7f9ff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) Processor stepping 04
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb130, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router VIA [1106/0686] at 0000:00:07.0
pty: 256 Unix98 ptys configured
Machine check exception polling timer started.
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.4 [Flags: R/O].
udf: registering filesystem
Applying VIA southbridge workaround.
request_module: failed /sbin/modprobe -- parport_lowlevel. error = -16
lp: driver loaded but no devices found
Linux agpgart interface v0.100 (c) Dave Jones
[drm:drm_init] *ERROR* Cannot initialize the agpgart module.
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 [PCSPP(,...)]
lp0: using parport0 (polling).
parport_pc: Via 686A parallel port: io=0x378
Using anticipatory scheduling io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
PCI: Found IRQ 11 for device 0000:00:0a.0
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:00:0a.0: 3Com PCI 3c900 Boomerang 10Mbps Combo at 0xec00. Vers LK1.1.19
eth0: Dropping NETIF_F_SG since no checksum feature.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hda: WDC WD800BB-00CAA1, ATA DISK drive
hdd: CD-ROM 56X L, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=65535/16/63
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
end_request: I/O error, dev hdd, sector 0
hdd: ATAPI 56X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.12
ohci-hcd: 2003 Feb 24 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci-hcd: block sizes: ed 64 td 64
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver 
v2.1
PCI: Found IRQ 9 for device 0000:00:07.2
PCI: Sharing IRQ 9 with 0000:00:07.3
uhci-hcd 0000:00:07.2: UHCI Host Controller
uhci-hcd 0000:00:07.2: irq 9, io base 0000d400
uhci-hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
drivers/usb/host/uhci-hcd.c: detected 2 ports
uhci-hcd 0000:00:07.2: root hub device address 1
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
drivers/usb/core/message.c: USB device number 1 default language ID 0x409
usb usb1: Product: UHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.0-test5 uhci-hcd
usb usb1: SerialNumber: 0000:00:07.2
drivers/usb/core/usb.c: usb_hotplug
usb usb1: usb_new_device - registering interface 1-0:0
drivers/usb/core/usb.c: usb_hotplug
hub 1-0:0: usb_probe_interface
hub 1-0:0: usb_probe_interface - got id
hub 1-0:0: USB hub found
hub 1-0:0: 2 ports detected
hub 1-0:0: standalone hub
hub 1-0:0: ganged power switching
hub 1-0:0: global over-current protection
hub 1-0:0: Port indicators are not supported
hub 1-0:0: power on to power good time: 2ms
hub 1-0:0: hub controller current requirement: 0mA
hub 1-0:0: local power source is good
hub 1-0:0: no over-current condition exists
hub 1-0:0: enabling power on all ports
PCI: Found IRQ 9 for device 0000:00:07.3
PCI: Sharing IRQ 9 with 0000:00:07.2
uhci-hcd 0000:00:07.3: UHCI Host Controller
uhci-hcd 0000:00:07.3: irq 9, io base 0000d800
uhci-hcd 0000:00:07.3: new USB bus registered, assigned bus number 2
drivers/usb/host/uhci-hcd.c: detected 2 ports
uhci-hcd 0000:00:07.3: root hub device address 1
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
drivers/usb/core/message.c: USB device number 1 default language ID 0x409
usb usb2: Product: UHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.0-test5 uhci-hcd
usb usb2: SerialNumber: 0000:00:07.3
drivers/usb/core/usb.c: usb_hotplug
usb usb2: usb_new_device - registering interface 2-0:0
drivers/usb/core/usb.c: usb_hotplug
hub 2-0:0: usb_probe_interface
hub 2-0:0: usb_probe_interface - got id
hub 2-0:0: USB hub found
hub 2-0:0: 2 ports detected
hub 2-0:0: standalone hub
hub 2-0:0: ganged power switching
hub 2-0:0: global over-current protection
hub 2-0:0: Port indicators are not supported
hub 2-0:0: power on to power good time: 2ms
hub 2-0:0: hub controller current requirement: 0mA
hub 2-0:0: local power source is good
hub 2-0:0: no over-current condition exists
hub 2-0:0: enabling power on all ports
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: PS/2 Generic Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Advanced Linux Sound Architecture Driver Version 0.9.6 (Wed Aug 20 20:27:13 
2003 UTC).
request_module: failed /sbin/modprobe -- snd-card-0. error = -16
PCI: Found IRQ 5 for device 0000:00:07.5
PCI: Setting latency timer of device 0000:00:07.5 to 64
hub 1-0:0: port 1, status 101, change 3, 12 Mb/s
hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x101
hub 1-0:0: new USB device on port 1, assigned address 2
usb 1-1: new device strings: Mfr=1, Product=2, SerialNumber=0
drivers/usb/core/message.c: USB device number 2 default language ID 0x409
usb 1-1: Product: USB Keyboard
usb 1-1: Manufacturer: BTC
drivers/usb/core/usb.c: usb_hotplug
usb 1-1: usb_new_device - registering interface 1-1:0
drivers/usb/core/usb.c: usb_hotplug
hub 1-1:0: usb_probe_interface
hub 1-1:0: usb_probe_interface - got id
hub 1-1:0: USB hub found
hub 1-1:0: 2 ports detected
hub 1-1:0: compound device; port removable status: FR
hub 1-1:0: individual port power switching
hub 1-1:0: individual port over-current protection
hub 1-1:0: Port indicators are not supported
hub 1-1:0: power on to power good time: 44ms
hub 1-1:0: hub controller current requirement: 100mA
hub 1-1:0: local power source is lost (inactive)
hub 1-1:0: no over-current condition exists
hub 1-1:0: enabling power on all ports
hub 1-0:0: port 2, status 100, change 3, 12 Mb/s
hub 1-0:0: port 2 enable change, status 100
hub 2-0:0: port 1, status 100, change 3, 12 Mb/s
hub 2-0:0: port 2, status 100, change 3, 12 Mb/s
hub 2-0:0: port 1 enable change, status 100
hub 2-0:0: port 2 enable change, status 100
hub 1-1:0: port 1, status 101, change 1, 12 Mb/s
ALSA device list:
  #0: VIA 82C686A/B rev50 at 0xdc00, irq 5
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
hub 1-1:0: debounce: port 1: delay 100ms stable 4 status 0x101
hub 1-1:0: new USB device on port 1, assigned address 3
usb 1-1.1: new device strings: Mfr=1, Product=2, SerialNumber=0
drivers/usb/core/message.c: USB device number 3 default language ID 0x409
usb 1-1.1: Product: USB Keyboard
usb 1-1.1: Manufacturer: BTC
drivers/usb/core/usb.c: usb_hotplug
usb 1-1.1: usb_new_device - registering interface 1-1.1:0
drivers/usb/core/usb.c: usb_hotplug
hid 1-1.1:0: usb_probe_interface
hid 1-1.1:0: usb_probe_interface - got id
found reiserfs format "3.6" with standard journal
drivers/usb/host/uhci-hcd.c: d800: suspend_hc
spurious 8259A interrupt: IRQ7.
Reiserfs journal params: device hda3, size 8192, journal first block 18, max 
trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda3) for (hda3)
Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 128k freed
Adding 305224k swap on /dev/hda2.  Priority:-1 extents:1
drivers/usb/input/hid-core.c: ctrl urb status -104 received
drivers/usb/input/hid-core.c: timeout initializing reports

input: USB HID v1.00 Keyboard [BTC USB Keyboard] on usb-0000:00:07.2-1.1
usb 1-1.1: usb_new_device - registering interface 1-1.1:1
drivers/usb/core/usb.c: usb_hotplug
hid 1-1.1:1: usb_probe_interface
hid 1-1.1:1: usb_probe_interface - got id


and My keyboard works fine :)

also here is some other info I thought might be usefull

Linux localhost 2.6.0-test5 #7 Sat Sep 27 00:11:39 GMT 2003 i686 AMD 
Athlon(tm) Processor AuthenticAMD GNU/Linux

Gnu C                  3.2.3
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
e2fsprogs              1.33
reiserfsprogs          3.6.8
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.9
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0.15

