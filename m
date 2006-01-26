Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751190AbWAZNjq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbWAZNjq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 08:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWAZNjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 08:39:46 -0500
Received: from vmailb.mclink.it ([195.110.128.107]:5387 "EHLO vmailb.mclink.it")
	by vger.kernel.org with ESMTP id S1751190AbWAZNjo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 08:39:44 -0500
From: "Mauro Tassinari" <mtassinari@cmanet.it>
To: <linux-kernel@vger.kernel.org>
Subject: Xorg  freezes 2.6.16-rc1
Date: Thu, 26 Jan 2006 14:39:33 +0100
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA//gP36uv0hG9NQDAJogAp8KAAAAQAAAAwPo5BClV1USIJnF2WU6HIAEAAAAA@cmanet.it>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My test system running vanilla 2.6.16-rc1 (slackware-current config) freezes
dead as soon as Xorg is started.

Only a reset is possible, so no info can be gathered after the crash.

Kernel 2.6.15 works flawlessy.

Some info follows.

Regards

Mauro Tassinari


root@test:/var/log# X -version

X Window System Version 6.9.0
Release Date: 21 December 2005
X Protocol Version 11, Revision 0, Release 6.9
Build Operating System: Linux 2.6.14.6 i686 [ELF]
Current Operating System: Linux test 2.6.15-abi-sata #3 PREEMPT Tue Jan 10
18:08:55 Local time zone must be set--see  i686 Build Date: 14 January 2006
        Before reporting problems, check http://wiki.X.Org
        to make sure that you have the latest version.
Module Loader present


root@test:/var/log# cat messages

........snip..........

Jan 26 13:33:41 test syslogd 1.4.1: restart.
Jan 26 13:33:42 test kernel: klogd 1.4.1, log source = /proc/kmsg started.
Jan 26 13:33:42 test kernel: Linux version 2.6.16-rc1-sata (root@test) (gcc
version 3.4.5) #1 PREEMPT Tue Jan 24 21:05:48 Local time zone must be
set--see 
Jan 26 13:33:42 test kernel: BIOS-provided physical RAM map:
Jan 26 13:33:42 test kernel: 127MB HIGHMEM available.
Jan 26 13:33:42 test kernel: 896MB LOWMEM available.
Jan 26 13:33:42 test kernel: found SMP MP-table at 000ff780
Jan 26 13:33:42 test kernel: DMI 2.3 present.
Jan 26 13:33:42 test kernel: ACPI: PM-Timer IO Port: 0x808
Jan 26 13:33:42 test kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00]
enabled)
Jan 26 13:33:42 test kernel: ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01]
enabled)
Jan 26 13:33:42 test kernel: ACPI: IOAPIC (id[0x02] address[0xfec00000]
gsi_base[0])
Jan 26 13:33:42 test kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2
dfl dfl)
Jan 26 13:33:42 test kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9
high level)
Jan 26 13:33:42 test kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2
dfl dfl)
Jan 26 13:33:42 test kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9
high level)
Jan 26 13:33:42 test kernel: Using ACPI (MADT) for SMP configuration
information
Jan 26 13:33:42 test kernel: Kernel command line: BOOT_IMAGE=2.6.16-sata ro
root=802
Jan 26 13:33:42 test kernel: Enabling fast FPU save and restore... done.
Jan 26 13:33:42 test kernel: Enabling unmasked SIMD FPU exception support...
done.
Jan 26 13:33:42 test kernel: Initializing CPU#0
Jan 26 13:33:42 test kernel: Using pmtmr for high-res timesource
Jan 26 13:33:42 test kernel: Memory: 1035776k/1048256k available (1751k
kernel code, 11884k reserved, 689k data, 156k init, 130752k highmem)
Jan 26 13:33:42 test kernel: CPU: Trace cache: 12K uops, L1 D cache: 16K
Jan 26 13:33:42 test kernel: CPU: L2 cache: 1024K
Jan 26 13:33:42 test kernel: Intel machine check architecture supported.
Jan 26 13:33:42 test kernel: Intel machine check reporting enabled on CPU#0.
Jan 26 13:33:42 test kernel: CPU0: Intel P4/Xeon Extended MCE MSRs (12)
available
Jan 26 13:33:42 test kernel: mtrr: v2.0 (20020519)
Jan 26 13:33:42 test kernel: Checking 'hlt' instruction... OK.
Jan 26 13:33:42 test kernel: ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1
pin2=-1
Jan 26 13:33:42 test kernel: NET: Registered protocol family 16
Jan 26 13:33:42 test kernel: ACPI: bus type pci registered
Jan 26 13:33:42 test kernel: PCI: PCI BIOS revision 2.10 entry at 0xf0031,
last bus=4
Jan 26 13:33:42 test kernel: PCI: Using MMCONFIG
Jan 26 13:33:42 test kernel: ACPI: Subsystem revision 20050902
Jan 26 13:33:42 test kernel: ACPI: Interpreter enabled
Jan 26 13:33:42 test kernel: ACPI: Using IOAPIC for interrupt routing
Jan 26 13:33:42 test kernel: ACPI: PCI Root Bridge [PCI0] (0000:00)
Jan 26 13:33:42 test kernel: PCI: Ignoring BAR0-3 of IDE controller
0000:00:1f.1
Jan 26 13:33:42 test kernel: PCI: Transparent bridge - 0000:00:1e.0
Jan 26 13:33:42 test kernel: Linux Plug and Play Support v0.97 (c) Adam
Belay
Jan 26 13:33:42 test kernel: pnp: PnP ACPI init
Jan 26 13:33:42 test kernel: pnp: PnP ACPI: found 19 devices
Jan 26 13:33:42 test kernel: SCSI subsystem initialized
Jan 26 13:33:42 test kernel: PCI: Using ACPI for IRQ routing
Jan 26 13:33:42 test kernel: PCI: If a device doesn't work, try
"pci=routeirq".  If it helps, post a report
Jan 26 13:33:42 test kernel: pnp: 00:07: ioport range 0x290-0x297 has been
reserved
Jan 26 13:33:42 test kernel: PCI: Bridge: 0000:00:01.0
Jan 26 13:33:42 test kernel:   IO window: e000-efff
Jan 26 13:33:42 test kernel:   MEM window: d7f00000-d7ffffff
Jan 26 13:33:42 test kernel:   PREFETCH window: d8000000-dfffffff
Jan 26 13:33:42 test kernel: PCI: Bridge: 0000:00:1c.0
Jan 26 13:33:42 test kernel:   IO window: d000-dfff
Jan 26 13:33:42 test kernel:   MEM window: disabled.
Jan 26 13:33:42 test kernel:   PREFETCH window: disabled.
Jan 26 13:33:42 test kernel: PCI: Bridge: 0000:00:1c.1
Jan 26 13:33:42 test kernel:   IO window: c000-cfff
Jan 26 13:33:42 test kernel:   MEM window: d7e00000-d7efffff
Jan 26 13:33:42 test kernel:   PREFETCH window: disabled.
Jan 26 13:33:42 test kernel: PCI: Bridge: 0000:00:1e.0
Jan 26 13:33:42 test kernel:   IO window: b000-bfff
Jan 26 13:33:42 test kernel:   MEM window: disabled.
Jan 26 13:33:42 test kernel:   PREFETCH window: disabled.
Jan 26 13:33:42 test kernel: ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16
(level, low) -> IRQ 16
Jan 26 13:33:42 test kernel: ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16
(level, low) -> IRQ 16
Jan 26 13:33:42 test kernel: ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 17
(level, low) -> IRQ 17
Jan 26 13:33:42 test kernel: apm: BIOS version 1.2 Flags 0x03 (Driver
version 1.16ac)
Jan 26 13:33:42 test kernel: apm: overridden by ACPI.
Jan 26 13:33:42 test kernel: VFS: Disk quotas dquot_6.5.1
Jan 26 13:33:42 test kernel: Initializing Cryptographic API
Jan 26 13:33:42 test kernel: io scheduler noop registered
Jan 26 13:33:42 test kernel: io scheduler anticipatory registered
Jan 26 13:33:42 test kernel: io scheduler deadline registered
Jan 26 13:33:42 test kernel: io scheduler cfq registered
Jan 26 13:33:42 test kernel: ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16
(level, low) -> IRQ 16
Jan 26 13:33:42 test kernel: ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16
(level, low) -> IRQ 16
Jan 26 13:33:42 test kernel: ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 17
(level, low) -> IRQ 17
Jan 26 13:33:42 test kernel: Real Time Clock Driver v1.12ac
Jan 26 13:33:42 test kernel: Linux agpgart interface v0.101 (c) Dave Jones
Jan 26 13:33:42 test kernel: [drm] Initialized drm 1.0.1 20051102
Jan 26 13:33:42 test kernel: PNP: PS/2 Controller
[PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
Jan 26 13:33:42 test kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Jan 26 13:33:42 test kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Jan 26 13:33:42 test kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 4
ports, IRQ sharing enabled
Jan 26 13:33:42 test kernel: serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a
16550A
Jan 26 13:33:42 test kernel: 00:0f: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Jan 26 13:33:42 test kernel: Floppy drive(s): fd0 is 1.44M
Jan 26 13:33:42 test kernel: FDC 0 is a post-1991 82077
Jan 26 13:33:42 test kernel: Uniform Multi-Platform E-IDE driver Revision:
7.00alpha2
Jan 26 13:33:42 test kernel: ide: Assuming 33MHz system bus speed for PIO
modes; override with idebus=xx
Jan 26 13:33:42 test kernel: ICH6: IDE controller at PCI slot 0000:00:1f.1
Jan 26 13:33:42 test kernel: ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18
(level, low) -> IRQ 18
Jan 26 13:33:42 test kernel: ICH6: chipset revision 3
Jan 26 13:33:42 test kernel: ICH6: not 100%% native mode: will probe irqs
later
Jan 26 13:33:42 test kernel:     ide0: BM-DMA at 0xffa0-0xffa7, BIOS
settings: hda:pio, hdb:DMA
Jan 26 13:33:42 test kernel: hdb: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive,
2048kB Cache, UDMA(33)
Jan 26 13:33:42 test kernel: Uniform CD-ROM driver Revision: 3.20
Jan 26 13:33:42 test kernel: ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19
(level, low) -> IRQ 19
Jan 26 13:33:42 test kernel: ata1: SATA max UDMA/133 cmd 0xAC00 ctl 0xA882
bmdma 0xA400 irq 19
Jan 26 13:33:42 test kernel: ata2: SATA max UDMA/133 cmd 0xA800 ctl 0xA482
bmdma 0xA408 irq 19
Jan 26 13:33:42 test kernel: ata1: dev 0 ATA-6, max UDMA/100, 321672960
sectors: LBA48
Jan 26 13:33:42 test kernel: ata1: dev 0 configured for UDMA/100
Jan 26 13:33:42 test kernel: scsi0 : ata_piix
Jan 26 13:33:42 test kernel: scsi1 : ata_piix
Jan 26 13:33:42 test kernel:   Vendor: ATA       Model: HDS722516VLSA80
Rev: V34O
Jan 26 13:33:42 test kernel:   Type:   Direct-Access
ANSI SCSI revision: 05
Jan 26 13:33:42 test kernel: SCSI device sda: 321672960 512-byte hdwr
sectors (164697 MB)
Jan 26 13:33:42 test kernel: sda: Write Protect is off
Jan 26 13:33:42 test kernel: SCSI device sda: drive cache: write back
Jan 26 13:33:42 test kernel: SCSI device sda: 321672960 512-byte hdwr
sectors (164697 MB)
Jan 26 13:33:42 test kernel: sda: Write Protect is off
Jan 26 13:33:42 test kernel: SCSI device sda: drive cache: write back
Jan 26 13:33:42 test kernel:  sda: sda1 sda2 sda3 sda4
Jan 26 13:33:42 test kernel: sd 0:0:0:0: Attached scsi disk sda
Jan 26 13:33:42 test kernel: mice: PS/2 mouse device common for all mice
Jan 26 13:33:42 test kernel: NET: Registered protocol family 2
Jan 26 13:33:42 test kernel: input: AT Translated Set 2 keyboard as
/class/input/input0
Jan 26 13:33:42 test kernel: TCP: Hash tables configured (established 262144
bind 65536)
Jan 26 13:33:42 test kernel: TCP reno registered
Jan 26 13:33:42 test kernel: TCP bic registered
Jan 26 13:33:42 test kernel: Initializing IPsec netlink socket
Jan 26 13:33:42 test kernel: NET: Registered protocol family 1
Jan 26 13:33:42 test kernel: NET: Registered protocol family 17
Jan 26 13:33:42 test kernel: ACPI: (supports S0 S1 S3 S4 S5)
Jan 26 13:33:42 test kernel: Freeing unused kernel memory: 156k freed
Jan 26 13:33:42 test kernel: Adding 506008k swap on /dev/sda1.  Priority:-1
extents:1 across:506008k
Jan 26 13:33:42 test kernel: Adding 506036k swap on /dev/sda3.  Priority:-2
extents:1 across:506036k
Jan 26 13:33:42 test kernel: parport: PnPBIOS parport detected.
Jan 26 13:33:42 test kernel: parport0: PC-style at 0x378, irq 7 [PCSPP]
Jan 26 13:33:42 test kernel: lp0: using parport0 (interrupt-driven).
Jan 26 13:33:42 test kernel: lp0: console ready
Jan 26 13:33:42 test kernel: input: ImPS/2 Generic Wheel Mouse as
/class/input/input1
Jan 26 13:33:42 test kernel: ts: Compaq touchscreen protocol output
Jan 26 13:33:42 test logger: /etc/rc.d/rc.inet1:  /sbin/ifconfig lo
127.0.0.1
Jan 26 13:33:42 test logger: /etc/rc.d/rc.inet1:  /sbin/route add -net
127.0.0.0 netmask 255.0.0.0 lo
Jan 26 13:33:43 test logger: /etc/rc.d/rc.inet1:  /sbin/route add default gw
10.10.0.245 metric 1
Jan 26 13:33:43 test logger: SIOCADDRT: Network is unreachable
Jan 26 13:33:43 test logger: /etc/rc.d/rc.hotplug start (entering script)
Jan 26 13:33:43 test kernel: ACPI: PCI Interrupt 0000:01:0b.0[A] -> GSI 22
(level, low) -> IRQ 20
Jan 26 13:33:44 test kernel: ACPI: PCI Interrupt 0000:01:0a.0[A] -> GSI 21
(level, low) -> IRQ 21
Jan 26 13:33:44 test kernel: Cronyx Ltd, Synchronous PPP and CISCO HDLC (c)
1994
Jan 26 13:33:44 test kernel: Linux port (c) 1998 Building Number Three Ltd &
Jan "Yenya" Kasprzak.
Jan 26 13:33:44 test kernel: HDLC support module revision 1.18
Jan 26 13:33:44 test kernel: Goramo PCI200SYN driver version: 1.16
Jan 26 13:33:44 test kernel: ACPI: PCI Interrupt 0000:01:0a.0[A] -> GSI 21
(level, low) -> IRQ 21
Jan 26 13:33:44 test kernel: ACPI: PCI interrupt for device 0000:01:0a.0
disabled
Jan 26 13:33:44 test kernel: ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 17
(level, low) -> IRQ 17
Jan 26 13:33:44 test kernel: sky2 v0.11 addr 0xd7efc000 irq 17 Yukon-EC
(0xb6) rev 1
Jan 26 13:33:44 test kernel: sky2 eth0: addr 00:11:d8:49:a3:68
Jan 26 13:33:44 test logger: /etc/rc.d/rc.inet1:  /sbin/ifconfig eth0
10.10.0.10 broadcast 10.10.255.255 netmask 255.255.0.0
Jan 26 13:33:44 test kernel: sky2 eth0: enabling interface
Jan 26 13:33:44 test logger: /etc/rc.d/rc.inet1:  /sbin/route add default gw
10.10.0.245 metric 1
Jan 26 13:33:44 test kernel: i8xx TCO timer: heartbeat value must be
2<heartbeat<39, using 30
Jan 26 13:33:45 test kernel: i8xx TCO timer: initialized (0x0860).
heartbeat=30 sec (nowayout=0)
Jan 26 13:33:45 test modprobe: FATAL: Error inserting hw_random
(/lib/modules/2.6.16-rc1-sata/kernel/drivers/char/hw_random.ko): No such
device 
Jan 26 13:33:45 test kernel: usbcore: registered new driver usbfs
Jan 26 13:33:45 test kernel: usbcore: registered new driver hub
Jan 26 13:33:45 test kernel: ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23
(level, low) -> IRQ 22
Jan 26 13:33:45 test kernel: ehci_hcd 0000:00:1d.7: EHCI Host Controller
Jan 26 13:33:45 test kernel: ehci_hcd 0000:00:1d.7: debug port 1
Jan 26 13:33:45 test kernel: ehci_hcd 0000:00:1d.7: new USB bus registered,
assigned bus number 1
Jan 26 13:33:45 test kernel: ehci_hcd 0000:00:1d.7: irq 22, io mem
0xd7dff800
Jan 26 13:33:45 test kernel: ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI
1.00, driver 10 Dec 2004
Jan 26 13:33:45 test kernel: usb usb1: configuration #1 chosen from 1 choice
Jan 26 13:33:45 test kernel: hub 1-0:1.0: USB hub found
Jan 26 13:33:45 test kernel: hub 1-0:1.0: 8 ports detected
Jan 26 13:33:45 test kernel: USB Universal Host Controller Interface driver
v2.3
Jan 26 13:33:45 test kernel: ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23
(level, low) -> IRQ 22
Jan 26 13:33:45 test kernel: uhci_hcd 0000:00:1d.0: UHCI Host Controller
Jan 26 13:33:45 test kernel: uhci_hcd 0000:00:1d.0: new USB bus registered,
assigned bus number 2
Jan 26 13:33:45 test kernel: uhci_hcd 0000:00:1d.0: irq 22, io base
0x00009880
Jan 26 13:33:45 test kernel: usb usb2: configuration #1 chosen from 1 choice
Jan 26 13:33:45 test kernel: hub 2-0:1.0: USB hub found
Jan 26 13:33:45 test kernel: hub 2-0:1.0: 2 ports detected
Jan 26 13:33:46 test kernel: ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19
(level, low) -> IRQ 19
Jan 26 13:33:46 test kernel: uhci_hcd 0000:00:1d.1: UHCI Host Controller
Jan 26 13:33:46 test kernel: uhci_hcd 0000:00:1d.1: new USB bus registered,
assigned bus number 3
Jan 26 13:33:46 test kernel: uhci_hcd 0000:00:1d.1: irq 19, io base
0x00009c00
Jan 26 13:33:46 test kernel: usb usb3: configuration #1 chosen from 1 choice
Jan 26 13:33:46 test kernel: hub 3-0:1.0: USB hub found
Jan 26 13:33:46 test kernel: hub 3-0:1.0: 2 ports detected
Jan 26 13:33:46 test kernel: usb 2-1: new full speed USB device using
uhci_hcd and address 2
Jan 26 13:33:46 test kernel: usb 2-1: configuration #1 chosen from 1 choice
Jan 26 13:33:46 test kernel: sky2 eth0: phy interrupt status 0x1c40 0x7d40
Jan 26 13:33:46 test kernel: sky2 eth0: Link is up at 100 Mbps, full duplex,
flow control none
Jan 26 13:33:47 test kernel: ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18
(level, low) -> IRQ 18
Jan 26 13:33:47 test kernel: uhci_hcd 0000:00:1d.2: UHCI Host Controller
Jan 26 13:33:47 test kernel: uhci_hcd 0000:00:1d.2: new USB bus registered,
assigned bus number 4
Jan 26 13:33:47 test kernel: uhci_hcd 0000:00:1d.2: irq 18, io base
0x0000a000
Jan 26 13:33:47 test kernel: usb usb4: configuration #1 chosen from 1 choice
Jan 26 13:33:47 test kernel: hub 4-0:1.0: USB hub found
Jan 26 13:33:47 test kernel: hub 4-0:1.0: 2 ports detected
Jan 26 13:33:47 test kernel: ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16
(level, low) -> IRQ 16
Jan 26 13:33:47 test kernel: uhci_hcd 0000:00:1d.3: UHCI Host Controller
Jan 26 13:33:47 test kernel: uhci_hcd 0000:00:1d.3: new USB bus registered,
assigned bus number 5
Jan 26 13:33:47 test kernel: uhci_hcd 0000:00:1d.3: irq 16, io base
0x0000a080
Jan 26 13:33:47 test kernel: usb usb5: configuration #1 chosen from 1 choice
Jan 26 13:33:47 test kernel: hub 5-0:1.0: USB hub found
Jan 26 13:33:47 test kernel: hub 5-0:1.0: 2 ports detected
Jan 26 13:33:48 test kernel: usbcore: registered new driver usbserial
Jan 26 13:33:48 test kernel: drivers/usb/serial/usb-serial.c: USB Serial
support registered for generic
Jan 26 13:33:48 test kernel: usbcore: registered new driver
usbserial_generic
Jan 26 13:33:48 test kernel: drivers/usb/serial/usb-serial.c: USB Serial
Driver core
Jan 26 13:33:48 test kernel: drivers/usb/serial/usb-serial.c: USB Serial
support registered for pl2303
Jan 26 13:33:48 test kernel: pl2303 2-1:1.0: pl2303 converter detected
Jan 26 13:33:48 test kernel: usb 2-1: pl2303 converter now attached to
ttyUSB0
Jan 26 13:33:48 test kernel: usbcore: registered new driver pl2303
Jan 26 13:33:48 test kernel: drivers/usb/serial/pl2303.c: Prolific PL2303
USB to serial adaptor driver
Jan 26 13:33:49 test kernel: pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Jan 26 13:33:49 test kernel: shpchp: Standard Hot Plug PCI Controller Driver
version: 0.4
Jan 26 13:33:49 test kernel: agpgart: Detected an Intel 915G Chipset.
Jan 26 13:33:49 test kernel: agpgart: AGP aperture is 256M @ 0x0
Jan 26 13:33:49 test modprobe: FATAL: Error inserting hw_random
(/lib/modules/2.6.16-rc1-sata/kernel/drivers/char/hw_random.ko): No such
device 
Jan 26 13:33:52 test last message repeated 17 times
Jan 26 13:33:52 test kernel: input: PC Speaker as /class/input/input2
Jan 26 13:33:58 test logger: /etc/rc.d/rc.hotplug start (exiting script)
Jan 26 13:33:59 test kernel: NET: Registered protocol family 10
Jan 26 13:33:59 test kernel: lo: Disabled Privacy Extensions
Jan 26 13:33:59 test kernel: IPv6 over IPv4 tunneling driver
Jan 26 13:33:59 test sshd[5940]: Server listening on :: port 22.
Jan 26 13:33:59 test named[5943]: starting BIND 9.3.1
Jan 26 13:33:59 test named[5943]: loading configuration from
'/etc/named.conf'
Jan 26 13:33:59 test named[5943]: command channel listening on 127.0.0.1#953
Jan 26 13:33:59 test named[5943]: command channel listening on ::1#953
Jan 26 13:33:59 test named[5943]: zone 10.10.in-addr.arpa/IN: loaded serial
199802151
Jan 26 13:33:59 test named[5943]: zone 0.0.127.in-addr.arpa/IN: loaded
serial 1997022700
Jan 26 13:33:59 test named[5943]: zone localhost/IN: loaded serial 42
Jan 26 13:33:59 test named[5943]: zone intracma.net/IN: loaded serial
199802151
Jan 26 13:33:59 test named[5943]: running
Jan 26 13:33:59 test kernel: Installing knfsd (copyright (C) 1996
okir@monad.swb.de).
Jan 26 13:33:59 test rpc.statd[5999]: Version 1.0.7 Starting
Jan 26 13:33:59 test rpc.statd[5999]: statd running as root. chown
/var/lib/nfs/sm to choose different user 

........snip..........


root@test:/var/log# cat syslog

........snip..........

Jan 26 13:33:42 test kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00
(usable)
Jan 26 13:33:42 test kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000
(reserved)
Jan 26 13:33:42 test kernel:  BIOS-e820: 00000000000e4000 - 0000000000100000
(reserved)
Jan 26 13:33:42 test kernel:  BIOS-e820: 0000000000100000 - 000000003ffb0000
(usable)
Jan 26 13:33:42 test kernel:  BIOS-e820: 000000003ffb0000 - 000000003ffbe000
(ACPI data)
Jan 26 13:33:42 test kernel:  BIOS-e820: 000000003ffbe000 - 000000003fff0000
(ACPI NVS)
Jan 26 13:33:42 test kernel:  BIOS-e820: 000000003fff0000 - 0000000040000000
(reserved)
Jan 26 13:33:42 test kernel:  BIOS-e820: 00000000ffb80000 - 0000000100000000
(reserved)
Jan 26 13:33:42 test kernel: Processor #0 15:4 APIC version 20
Jan 26 13:33:42 test kernel: Processor #1 15:4 APIC version 20
Jan 26 13:33:42 test kernel: WARNING: NR_CPUS limit of 1 reached.  Processor
ignored.
Jan 26 13:33:42 test kernel: IOAPIC[0]: apic_id 2, version 32, address
0xfec00000, GSI 0-23
Jan 26 13:33:42 test kernel: Enabling APIC mode:  Flat.  Using 1 I/O APICs
Jan 26 13:33:42 test kernel: Allocating PCI resources starting at 50000000
(gap: 40000000:bfb80000)
Jan 26 13:33:42 test kernel: Built 1 zonelists
Jan 26 13:33:42 test kernel: PID hash table entries: 4096 (order: 12, 65536
bytes)
Jan 26 13:33:42 test kernel: Detected 3211.980 MHz processor.
Jan 26 13:33:42 test kernel: Console: colour VGA+ 80x25
Jan 26 13:33:42 test kernel: Dentry cache hash table entries: 131072 (order:
7, 524288 bytes)
Jan 26 13:33:42 test kernel: Inode-cache hash table entries: 65536 (order:
6, 262144 bytes)
Jan 26 13:33:42 test kernel: Checking if this processor honours the WP bit
even in supervisor mode... Ok.
Jan 26 13:33:42 test kernel: Calibrating delay using timer specific
routine.. 6435.46 BogoMIPS (lpj=12870936)
Jan 26 13:33:42 test kernel: Mount-cache hash table entries: 512
Jan 26 13:33:42 test kernel: monitor/mwait feature present.
Jan 26 13:33:42 test kernel: using mwait in idle threads.
Jan 26 13:33:42 test kernel: CPU: Intel(R) Pentium(R) 4 CPU 3.20GHz stepping
01
Jan 26 13:33:42 test kernel: ENABLING IO-APIC IRQs
Jan 26 13:33:42 test kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7
10 *11 12 14 15)
Jan 26 13:33:42 test kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7
*10 11 12 14 15)
Jan 26 13:33:42 test kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6
7 10 11 12 14 15)
Jan 26 13:33:42 test kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 6
7 10 11 12 14 15)
Jan 26 13:33:42 test kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7
10 11 12 14 15) *0, disabled.
Jan 26 13:33:42 test kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7
*10 11 12 14 15)
Jan 26 13:33:42 test kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 *5 6
7 10 11 12 14 15)
Jan 26 13:33:42 test kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7
*10 11 12 14 15)
Jan 26 13:33:42 test kernel: highmem bounce pool size: 64 pages
Jan 26 13:33:42 test kernel: Dquot-cache hash table entries: 1024 (order 0,
4096 bytes)
Jan 26 13:33:42 test kernel: assign_interrupt_mode Found MSI capability
Jan 26 13:33:42 test last message repeated 2 times
Jan 26 13:33:42 test kernel: hdb: TSSTcorpCD/DVDW TS-H552U, ATAPI CD/DVD-ROM
drive
Jan 26 13:33:42 test kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Jan 26 13:33:42 test kernel: ATA: abnormal status 0x7F on port 0xA807
Jan 26 13:33:42 test kernel: ata2: disabling port
Jan 26 13:33:42 test kernel: IP route cache hash table entries: 65536
(order: 6, 262144 bytes)
Jan 26 13:33:42 test kernel: TCP established hash table entries: 262144
(order: 8, 1048576 bytes)
Jan 26 13:33:42 test kernel: TCP bind hash table entries: 65536 (order: 6,
262144 bytes)
Jan 26 13:33:42 test kernel: Using IPI Shortcut mode
Jan 26 13:33:42 test kernel: ACPI wakeup devices: 
Jan 26 13:33:42 test kernel: P0P1 P0P3 P0P4 P0P5 P0P6 P0P7 PS2K PS2M UAR1
USB1 USB2 USB3 USB4 EUSB MC97 
Jan 26 13:33:42 test kernel: VFS: Mounted root (ext2 filesystem) readonly.
Jan 26 13:33:42 test cardmgr[1149]: no sockets found!
Jan 26 13:33:44 test kernel: arcnet: v3.93 BETA 2000/04/29 - by Avery
Pennarun et al.
Jan 26 13:33:44 test kernel: arcnet: COM20020 chipset support (by David
Woodhouse et al.)
Jan 26 13:33:44 test kernel: arcnet: COM20020 PCI support
Jan 26 13:33:44 test kernel:  arc%%d: SOHARD
Jan 26 13:33:44 test kernel: com20020: probe of 0000:01:0a.0 failed with
error -16
Jan 26 13:33:44 test kernel: pci200syn: invalid card EEPROM parameters
Jan 26 13:33:44 test kernel: PCI200SYN: probe of 0000:01:0a.0 failed with
error -14
Jan 26 13:33:45 test kernel: hw_random: RNG not detected
Jan 26 13:33:52 test last message repeated 18 times
Jan 26 13:33:59 test sshd[5940]: error: Bind to port 22 on 0.0.0.0 failed:
Address already in use.
Jan 26 13:33:59 test named[5943]: /proc/net/if_inet6:sscanf() -> 1 (expected
6)
Jan 26 13:33:59 test named[5943]: interfacemgr.c:827: unexpected error:
Jan 26 13:33:59 test named[5943]: interface iteration failed: failure
Jan 26 13:33:59 test named[5943]: not listening on any interfaces
Jan 26 13:33:59 test kernel: process `named' is using obsolete setsockopt
SO_BSDCOMPAT
Jan 26 13:33:59 test named[5943]: /proc/net/if_inet6:sscanf() -> 1 (expected
6)
Jan 26 13:33:59 test named[5943]: interfacemgr.c:827: unexpected error:
Jan 26 13:33:59 test named[5943]: interface iteration failed: failure
Jan 26 13:33:59 test kernel: NFSD: Using /var/lib/nfs/v4recovery as the
NFSv4 state recovery directory
Jan 26 13:33:59 test kernel: NFSD: starting 90-second grace period

........snip..........

root@test:/var/lspci -v
00:00.0 Host bridge: Intel Corporation 915G/P/GV/GL/PL/910GL Processor to
I/O Controller (rev 04)
	Subsystem: Intel Corporation 915G/P/GV/GL/PL/910GL Processor to I/O
Controller
	Flags: bus master, fast devsel, latency 0
	Capabilities: [e0] #09 [2109]

00:01.0 PCI bridge: Intel Corporation 915G/P/GV/GL/PL/910GL PCI Express Root
Port (rev 04) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: d7f00000-d7ffffff
	Prefetchable memory behind bridge: d8000000-dfffffff
	Capabilities: [88] #0d [0000]
	Capabilities: [80] Power Management version 2
	Capabilities: [90] Message Signalled Interrupts: 64bit- Queue=0/0
Enable-
	Capabilities: [a0] #10 [0141]

00:1c.0 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family)
PCI Express Port 1 (rev 03) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	I/O behind bridge: 0000d000-0000dfff
	Capabilities: [40] #10 [0141]
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0
Enable-
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2

00:1c.1 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family)
PCI Express Port 2 (rev 03) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: d7e00000-d7efffff
	Capabilities: [40] #10 [0141]
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0
Enable-
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2

00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #1 (rev 03) (prog-if 00 [UHCI])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 80a6
	Flags: bus master, medium devsel, latency 0, IRQ 22
	I/O ports at 9880 [size=32]

00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #2 (rev 03) (prog-if 00 [UHCI])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 80a6
	Flags: bus master, medium devsel, latency 0, IRQ 19
	I/O ports at 9c00 [size=32]

00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #3 (rev 03) (prog-if 00 [UHCI])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 80a6
	Flags: bus master, medium devsel, latency 0, IRQ 18
	I/O ports at a000 [size=32]

00:1d.3 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #4 (rev 03) (prog-if 00 [UHCI])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 80a6
	Flags: bus master, medium devsel, latency 0, IRQ 16
	I/O ports at a080 [size=32]

00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB2 EHCI Controller (rev 03) (prog-if 20 [EHCI])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 80a6
	Flags: bus master, medium devsel, latency 0, IRQ 22
	Memory at d7dff800 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
	Capabilities: [58] #0a [20a0]

00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev d3) (prog-if 01
[Subtractive decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000b000-0000bfff
	Capabilities: [50] #0d [0000]

00:1f.0 ISA bridge: Intel Corporation 82801FB/FR (ICH6/ICH6R) LPC Interface
Bridge (rev 03)
	Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family)
IDE Controller (rev 03) (prog-if 8a [Master SecP PriP])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 80a6
	Flags: bus master, medium devsel, latency 0, IRQ 18
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at ffa0 [size=16]

00:1f.2 IDE interface: Intel Corporation 82801FR/FRW (ICH6R/ICH6RW) SATA
Controller (rev 03) (prog-if 8f [Master SecP SecO PriP PriO])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 2601
	Flags: bus master, 66Mhz, medium devsel, latency 0, IRQ 19
	I/O ports at ac00 [size=8]
	I/O ports at a880 [size=4]
	I/O ports at a800 [size=8]
	I/O ports at a480 [size=4]
	I/O ports at a400 [size=16]
	Memory at d7dffc00 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [70] Power Management version 2

00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) SMBus
Controller (rev 03)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 80a6
	Flags: medium devsel
	I/O ports at 0400 [size=32]

01:0a.0 Communication controller: PLX Technology, Inc. PCI <-> IOBus Bridge
(rev 01)
	Subsystem: PLX Technology, Inc.: Unknown device 1588
	Flags: medium devsel, IRQ 21
	I/O ports at b880 [size=128]
	I/O ports at b800 [size=64]
	I/O ports at b480 [size=8]

01:0b.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
	Subsystem: Ensoniq Creative Sound Blaster AudioPCI128
	Flags: bus master, slow devsel, latency 64, IRQ 20
	I/O ports at bc00 [size=64]
	Capabilities: [dc] Power Management version 1

02:00.0 Ethernet controller: Marvell Technology Group Ltd. 88E8053 Gigabit
Ethernet Controller (rev 15)
	Subsystem: ASUSTeK Computer Inc. Marvell 88E8053 Gigabit Ethernet
Controller (Asus)
	Flags: bus master, fast devsel, latency 0, IRQ 17
	Memory at d7efc000 (64-bit, non-prefetchable) [size=16K]
	I/O ports at c800 [size=256]
	Expansion ROM at d7ec0000 [disabled] [size=128K]
	Capabilities: [48] Power Management version 2
	Capabilities: [50] Vital Product Data
	Capabilities: [5c] Message Signalled Interrupts: 64bit+ Queue=0/1
Enable-
	Capabilities: [e0] #10 [0011]

04:00.0 VGA compatible controller: ATI Technologies Inc RV370 5B60 [Radeon
X300 (PCIE)] (prog-if 00 [VGA])
	Subsystem: ASUSTeK Computer Inc. Extreme AX300SE-X
	Flags: bus master, fast devsel, latency 0
	Memory at d8000000 (32-bit, prefetchable) [size=128M]
	I/O ports at e000 [size=256]
	Memory at d7fe0000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at d7fc0000 [disabled] [size=128K]
	Capabilities: [50] Power Management version 2
	Capabilities: [58] #10 [0001]
	Capabilities: [80] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-

04:00.1 Display controller: ATI Technologies Inc RV370 [Radeon X300SE]
	Subsystem: ASUSTeK Computer Inc.: Unknown device 002b
	Flags: bus master, fast devsel, latency 0
	Memory at d7ff0000 (32-bit, non-prefetchable) [size=64K]
	Capabilities: [50] Power Management version 2
	Capabilities: [58] #10 [0001]


root@test:/var/log# /usr/src/linux/scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux test 2.6.16-rc1-sata #1 PREEMPT Tue Jan 24 21:05:48 Local time zone
must be set--see  i686 unknown unknown GNU/Linux
 
Gnu C                  3.4.5
Gnu make               3.80
binutils               2.15.92.0.2
util-linux             2.12p
mount                  2.12p
module-init-tools      3.1
e2fsprogs              1.38
jfsutils               1.1.8
reiserfsprogs          3.6.19
reiser4progs           line
xfsprogs               2.6.13
pcmcia-cs              3.2.8
quota-tools            3.12.
PPP                    2.4.4b1
nfs-utils              1.0.7
Linux C Library        2.3.6
Dynamic linker (ldd)   2.3.6
Linux C++ Library      6.0.3
Procps                 3.2.5
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
udev                   064
Modules Loaded         binfmt_aout snd_seq_dummy snd_seq_oss
snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss nfsd exportfs lockd
sunrpc ipv6 ohci_hcd pcspkr intel_agp shpchp pci_hotplug pl2303 usbserial
uhci_hcd ehci_hcd usbcore i8xx_tco ahci i2c_i801 i2c_core sky2 pci200syn
hdlc syncppp com20020_pci com20020 arcnet snd_ens1371 gameport snd_rawmidi
snd_seq_device snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd soundcore
snd_page_alloc pcmcia firmware_class yenta_socket rsrc_nonstatic pcmcia_core
tsdev lp parport_pc parport psmouse


root@test:/var/log# cat /usr/src/linux/.config
#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.16-rc1
# Sat Jan 21 00:37:03 2006
#
CONFIG_X86_32=y
CONFIG_SEMAPHORE_SLEEPERS=y
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_DMI=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_LOCK_KERNEL=y
CONFIG_INIT_ENV_ARG_LIMIT=32

#
# General setup
#
CONFIG_LOCALVERSION="-abi-sata"
CONFIG_LOCALVERSION_AUTO=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_UID16=y
CONFIG_VM86=y
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_HOTPLUG=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_CC_ALIGN_FUNCTIONS=0
CONFIG_CC_ALIGN_LABELS=0
CONFIG_CC_ALIGN_LOOPS=0
CONFIG_CC_ALIGN_JUMPS=0
CONFIG_SLAB=y
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0
# CONFIG_SLOB is not set
CONFIG_OBSOLETE_INTERMODULE=m

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=y

#
# Block layer
#
CONFIG_LBD=y

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
CONFIG_DEFAULT_AS=y
# CONFIG_DEFAULT_DEADLINE is not set
# CONFIG_DEFAULT_CFQ is not set
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="anticipatory"
CONFIG_DOUBLEFAULT=y

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_ELAN is not set
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
CONFIG_MPENTIUM4=y
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
# CONFIG_SMP is not set
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_BKL=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_MCE=y
# CONFIG_X86_MCE_NONFATAL is not set
# CONFIG_X86_MCE_P4THERMAL is not set
CONFIG_TOSHIBA=m
CONFIG_I8K=m
CONFIG_X86_REBOOTFIXUPS=y
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m

#
# Firmware Drivers
#
CONFIG_EDD=m
CONFIG_DELL_RBU=m
CONFIG_DCDBAS=m
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_HIGHMEM=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_SPLIT_PTLOCK_CPUS=4
# CONFIG_HIGHPTE is not set
CONFIG_MATH_EMULATION=y
CONFIG_MTRR=y
# CONFIG_EFI is not set
# CONFIG_REGPARM is not set
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
CONFIG_KEXEC=y
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x100000

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
CONFIG_PM_LEGACY=y
# CONFIG_PM_DEBUG is not set
# CONFIG_SOFTWARE_SUSPEND is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
# CONFIG_ACPI_SLEEP_PROC_SLEEP is not set
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_HOTKEY=m
CONFIG_ACPI_FAN=m
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_THERMAL=m
CONFIG_ACPI_ASUS=m
CONFIG_ACPI_IBM=m
CONFIG_ACPI_TOSHIBA=m
CONFIG_ACPI_BLACKLIST_YEAR=0
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SYSTEM=y
CONFIG_X86_PM_TIMER=y
CONFIG_ACPI_CONTAINER=m

#
# APM (Advanced Power Management) BIOS Support
#
CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
# CONFIG_APM_CPU_IDLE is not set
# CONFIG_APM_DISPLAY_BLANK is not set
CONFIG_APM_RTC_IS_GMT=y
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_TABLE=m
# CONFIG_CPU_FREQ_DEBUG is not set
CONFIG_CPU_FREQ_STAT=m
CONFIG_CPU_FREQ_STAT_DETAILS=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_PERFORMANCE=m
CONFIG_CPU_FREQ_GOV_POWERSAVE=m
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=m
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m

#
# CPUFreq processor drivers
#
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_POWERNOW_K6=m
CONFIG_X86_POWERNOW_K7=m
CONFIG_X86_POWERNOW_K7_ACPI=y
CONFIG_X86_POWERNOW_K8=m
CONFIG_X86_POWERNOW_K8_ACPI=y
CONFIG_X86_GX_SUSPMOD=m
CONFIG_X86_SPEEDSTEP_CENTRINO=m
CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI=y
CONFIG_X86_SPEEDSTEP_CENTRINO_TABLE=y
CONFIG_X86_SPEEDSTEP_ICH=m
CONFIG_X86_SPEEDSTEP_SMI=m
CONFIG_X86_P4_CLOCKMOD=m
CONFIG_X86_CPUFREQ_NFORCE2=m
CONFIG_X86_LONGRUN=m
CONFIG_X86_LONGHAUL=m

#
# shared options
#
# CONFIG_X86_ACPI_CPUFREQ_PROC_INTF is not set
CONFIG_X86_SPEEDSTEP_LIB=m
# CONFIG_X86_SPEEDSTEP_RELAXED_CAP_CHECK is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=m
# CONFIG_HOTPLUG_PCI_PCIE_POLL_EVENT_MODE is not set
# CONFIG_PCI_MSI is not set
# CONFIG_PCI_LEGACY_PROC is not set
# CONFIG_PCI_DEBUG is not set
CONFIG_ISA_DMA_API=y
# CONFIG_ISA is not set
# CONFIG_MCA is not set
CONFIG_SCx200=m

#
# PCCARD (PCMCIA/CardBus) support
#
CONFIG_PCCARD=m
# CONFIG_PCMCIA_DEBUG is not set
CONFIG_PCMCIA=m
CONFIG_PCMCIA_LOAD_CIS=y
CONFIG_PCMCIA_IOCTL=y
CONFIG_CARDBUS=y

#
# PC-card bridges
#
CONFIG_YENTA=m
CONFIG_YENTA_O2=y
CONFIG_YENTA_RICOH=y
CONFIG_YENTA_TI=y
CONFIG_YENTA_ENE_TUNE=y
CONFIG_YENTA_TOSHIBA=y
CONFIG_PD6729=m
CONFIG_I82092=m
CONFIG_PCCARD_NONSTATIC=m

#
# PCI Hotplug Support
#
CONFIG_HOTPLUG_PCI=m
CONFIG_HOTPLUG_PCI_FAKE=m
CONFIG_HOTPLUG_PCI_COMPAQ=m
# CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM is not set
CONFIG_HOTPLUG_PCI_IBM=m
CONFIG_HOTPLUG_PCI_ACPI=m
# CONFIG_HOTPLUG_PCI_ACPI_IBM is not set
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=m
# CONFIG_HOTPLUG_PCI_SHPC_POLL_EVENT_MODE is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_MISC=m
CONFIG_ABI=y
CONFIG_ABI_SVR4=m

#
# SVR3/SVR4 based syscall support for x86: (please check one or more)
#
CONFIG_ABI_IBCS=m
CONFIG_ABI_ISC=m
CONFIG_ABI_SCO=m
CONFIG_ABI_SOLARIS=m
CONFIG_ABI_UW7=m
CONFIG_ABI_WYSE=m

#
# SVR3/SVR4 related binary format support for x86:
#
CONFIG_BINFMT_COFF=m
CONFIG_BINFMT_XOUT=m
CONFIG_BINFMT_XOUT_X286=y
CONFIG_ABI_LATE_PROBING=y
CONFIG_ABI_TRACE=y
CONFIG_ABI_UTIL=m
CONFIG_ABI_SPX=y
CONFIG_ABI_XTI=y
CONFIG_ABI_TLI_OPTMGMT=y
# CONFIG_ABI_XTI_OPTMGMT is not set
# CONFIG_ABI_SYSCALL_STATICS is not set
CONFIG_ABI_SYSCALL_MODULES=y
CONFIG_ABI_LCALL7=m

#
# Networking
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=y
CONFIG_XFRM=y
CONFIG_XFRM_USER=y
CONFIG_NET_KEY=m
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_ASK_IP_FIB_HASH=y
# CONFIG_IP_FIB_TRIE is not set
CONFIG_IP_FIB_HASH=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_FWMARK=y
CONFIG_IP_ROUTE_MULTIPATH=y
# CONFIG_IP_ROUTE_MULTIPATH_CACHED is not set
CONFIG_IP_ROUTE_VERBOSE=y
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
# CONFIG_ARPD is not set
CONFIG_SYN_COOKIES=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_IPCOMP=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_BIC=y

#
# IP: Virtual Server Configuration
#
CONFIG_IP_VS=m
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IPV6=m
CONFIG_IPV6_PRIVACY=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_IPCOMP=m
CONFIG_INET6_TUNNEL=m
CONFIG_IPV6_TUNNEL=m
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_BRIDGE_NETFILTER=y

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_XTABLES=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
# CONFIG_IP_NF_CT_ACCT is not set
# CONFIG_IP_NF_CONNTRACK_MARK is not set
# CONFIG_IP_NF_CONNTRACK_EVENTS is not set
CONFIG_IP_NF_CONNTRACK_NETLINK=m
CONFIG_IP_NF_CT_PROTO_SCTP=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_NETBIOS_NS=m
CONFIG_IP_NF_TFTP=m
CONFIG_IP_NF_AMANDA=m
CONFIG_IP_NF_PPTP=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_IPRANGE=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_RECENT=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_MATCH_ADDRTYPE=m
CONFIG_IP_NF_MATCH_HASHLIMIT=m
CONFIG_IP_NF_MATCH_POLICY=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_SAME=m
CONFIG_IP_NF_NAT_SNMP_BASIC=m
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_NAT_TFTP=m
CONFIG_IP_NF_NAT_AMANDA=m
CONFIG_IP_NF_NAT_PPTP=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m

#
# IPv6: Netfilter Configuration (EXPERIMENTAL)
#
CONFIG_IP6_NF_QUEUE=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_RT=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_MULTIPORT=m
CONFIG_IP6_NF_MATCH_OWNER=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_AHESP=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_POLICY=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_LOG=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_TARGET_HL=m
CONFIG_IP6_NF_RAW=m

#
# DECnet: Netfilter Configuration
#
CONFIG_DECNET_NF_GRABULATOR=m

#
# Bridge: Netfilter Configuration
#
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_ULOG=m

#
# DCCP Configuration (EXPERIMENTAL)
#
CONFIG_IP_DCCP=m
CONFIG_INET_DCCP_DIAG=m

#
# DCCP CCIDs Configuration (EXPERIMENTAL)
#
CONFIG_IP_DCCP_CCID3=m
CONFIG_IP_DCCP_TFRC_LIB=m

#
# DCCP Kernel Hacking
#
# CONFIG_IP_DCCP_DEBUG is not set
# CONFIG_IP_DCCP_UNLOAD_HACK is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_MSG is not set
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_HMAC_NONE is not set
# CONFIG_SCTP_HMAC_SHA1 is not set
CONFIG_SCTP_HMAC_MD5=y
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
CONFIG_ATM_MPOA=m
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_BRIDGE=m
CONFIG_VLAN_8021Q=m
CONFIG_DECNET=m
CONFIG_DECNET_ROUTER=y
CONFIG_DECNET_ROUTE_FWMARK=y
CONFIG_LLC=y
CONFIG_LLC2=m
CONFIG_IPX=m
# CONFIG_IPX_INTERN is not set
CONFIG_ATALK=m
CONFIG_DEV_APPLETALK=y
CONFIG_IPDDP=m
CONFIG_IPDDP_ENCAP=y
CONFIG_IPDDP_DECAP=y
CONFIG_X25=m
CONFIG_LAPB=m

#
# TIPC Configuration (EXPERIMENTAL)
#
CONFIG_TIPC=m
# CONFIG_TIPC_ADVANCED is not set
# CONFIG_TIPC_DEBUG is not set
CONFIG_NET_DIVERT=y
CONFIG_ECONET=m
# CONFIG_ECONET_AUNUDP is not set
# CONFIG_ECONET_NATIVE is not set
CONFIG_WAN_ROUTER=m

#
# QoS and/or fair queueing
#
CONFIG_NET_SCHED=y
CONFIG_NET_SCH_CLK_JIFFIES=y
# CONFIG_NET_SCH_CLK_GETTIMEOFDAY is not set
# CONFIG_NET_SCH_CLK_CPU is not set

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_INGRESS=m

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_ROUTE=y
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
# CONFIG_CLS_U32_PERF is not set
# CONFIG_CLS_U32_MARK is not set
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
# CONFIG_NET_EMATCH is not set
# CONFIG_NET_CLS_ACT is not set
CONFIG_NET_CLS_POLICE=y
# CONFIG_NET_CLS_IND is not set
CONFIG_NET_ESTIMATOR=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
CONFIG_HAMRADIO=y

#
# Packet Radio protocols
#
CONFIG_AX25=m
# CONFIG_AX25_DAMA_SLAVE is not set
CONFIG_NETROM=m
CONFIG_ROSE=m

#
# AX.25 network device drivers
#
CONFIG_MKISS=m
CONFIG_6PACK=m
CONFIG_BPQETHER=m
CONFIG_BAYCOM_SER_FDX=m
CONFIG_BAYCOM_SER_HDX=m
CONFIG_BAYCOM_PAR=m
CONFIG_BAYCOM_EPP=m
CONFIG_YAM=m
CONFIG_IRDA=m

#
# IrDA protocols
#
CONFIG_IRLAN=m
CONFIG_IRNET=m
CONFIG_IRCOMM=m
# CONFIG_IRDA_ULTRA is not set

#
# IrDA options
#
CONFIG_IRDA_CACHE_LAST_LSAP=y
CONFIG_IRDA_FAST_RR=y
# CONFIG_IRDA_DEBUG is not set

#
# Infrared-port device drivers
#

#
# SIR device drivers
#
CONFIG_IRTTY_SIR=m

#
# Dongle support
#
CONFIG_DONGLE=y
CONFIG_ESI_DONGLE=m
CONFIG_ACTISYS_DONGLE=m
CONFIG_TEKRAM_DONGLE=m
CONFIG_LITELINK_DONGLE=m
CONFIG_MA600_DONGLE=m
CONFIG_GIRBIL_DONGLE=m
CONFIG_MCP2120_DONGLE=m
CONFIG_OLD_BELKIN_DONGLE=m
CONFIG_ACT200L_DONGLE=m

#
# Old SIR device drivers
#
CONFIG_IRPORT_SIR=m

#
# Old Serial dongle support
#
# CONFIG_DONGLE_OLD is not set

#
# FIR device drivers
#
CONFIG_USB_IRDA=m
CONFIG_SIGMATEL_FIR=m
CONFIG_NSC_FIR=m
CONFIG_WINBOND_FIR=m
CONFIG_TOSHIBA_FIR=m
CONFIG_SMC_IRCC_FIR=m
CONFIG_ALI_FIR=m
CONFIG_VLSI_FIR=m
CONFIG_VIA_FIR=m
CONFIG_BT=m
CONFIG_BT_L2CAP=m
CONFIG_BT_SCO=m
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
CONFIG_BT_CMTP=m
CONFIG_BT_HIDP=m

#
# Bluetooth device drivers
#
CONFIG_BT_HCIUSB=m
CONFIG_BT_HCIUSB_SCO=y
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIBCM203X=m
CONFIG_BT_HCIBPA10X=m
CONFIG_BT_HCIBFUSB=m
CONFIG_BT_HCIDTL1=m
CONFIG_BT_HCIBT3C=m
CONFIG_BT_HCIBLUECARD=m
CONFIG_BT_HCIBTUART=m
CONFIG_BT_HCIVHCI=m
CONFIG_IEEE80211=m
# CONFIG_IEEE80211_DEBUG is not set
CONFIG_IEEE80211_CRYPT_WEP=m
CONFIG_IEEE80211_CRYPT_CCMP=m
CONFIG_IEEE80211_CRYPT_TKIP=m

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=m
# CONFIG_DEBUG_DRIVER is not set

#
# Connector - unified userspace <-> kernelspace linker
#
CONFIG_CONNECTOR=m

#
# Memory Technology Devices (MTD)
#
CONFIG_MTD=m
# CONFIG_MTD_DEBUG is not set
CONFIG_MTD_CONCAT=m
CONFIG_MTD_PARTITIONS=y
CONFIG_MTD_REDBOOT_PARTS=m
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED=y
# CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
# CONFIG_MTD_CMDLINE_PARTS is not set

#
# User Modules And Translation Layers
#
CONFIG_MTD_CHAR=m
CONFIG_MTD_BLOCK=m
CONFIG_MTD_BLOCK_RO=m
CONFIG_FTL=m
CONFIG_NFTL=m
CONFIG_NFTL_RW=y
CONFIG_INFTL=m
CONFIG_RFD_FTL=m

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=m
CONFIG_MTD_JEDECPROBE=m
CONFIG_MTD_GEN_PROBE=m
CONFIG_MTD_CFI_ADV_OPTIONS=y
CONFIG_MTD_CFI_NOSWAP=y
# CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
# CONFIG_MTD_CFI_LE_BYTE_SWAP is not set
CONFIG_MTD_CFI_GEOMETRY=y
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_MAP_BANK_WIDTH_8=y
CONFIG_MTD_MAP_BANK_WIDTH_16=y
CONFIG_MTD_MAP_BANK_WIDTH_32=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
CONFIG_MTD_CFI_I4=y
CONFIG_MTD_CFI_I8=y
# CONFIG_MTD_OTP is not set
CONFIG_MTD_CFI_INTELEXT=m
CONFIG_MTD_CFI_AMDSTD=m
CONFIG_MTD_CFI_AMDSTD_RETRY=0
CONFIG_MTD_CFI_STAA=m
CONFIG_MTD_CFI_UTIL=m
CONFIG_MTD_RAM=m
CONFIG_MTD_ROM=m
CONFIG_MTD_ABSENT=m
# CONFIG_MTD_OBSOLETE_CHIPS is not set

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
CONFIG_MTD_PHYSMAP=m
CONFIG_MTD_PHYSMAP_START=0x8000000
CONFIG_MTD_PHYSMAP_LEN=0x4000000
CONFIG_MTD_PHYSMAP_BANKWIDTH=2
CONFIG_MTD_PNC2000=m
CONFIG_MTD_SC520CDP=m
CONFIG_MTD_NETSC520=m
CONFIG_MTD_TS5500=m
CONFIG_MTD_SCx200_DOCFLASH=m
CONFIG_MTD_AMD76XROM=m
CONFIG_MTD_ICHXROM=m
CONFIG_MTD_SCB2_FLASH=m
CONFIG_MTD_NETtel=m
CONFIG_MTD_DILNETPC=m
CONFIG_MTD_DILNETPC_BOOTSIZE=0x80000
CONFIG_MTD_L440GX=m
CONFIG_MTD_PLATRAM=m

#
# Self-contained MTD device drivers
#
CONFIG_MTD_PMC551=m
CONFIG_MTD_PMC551_BUGFIX=y
CONFIG_MTD_PMC551_DEBUG=y
CONFIG_MTD_SLRAM=m
CONFIG_MTD_PHRAM=m
CONFIG_MTD_MTDRAM=m
CONFIG_MTDRAM_TOTAL_SIZE=4096
CONFIG_MTDRAM_ERASE_SIZE=128
CONFIG_MTD_BLKMTD=m
CONFIG_MTD_BLOCK2MTD=m

#
# Disk-On-Chip Device Drivers
#
CONFIG_MTD_DOC2000=m
CONFIG_MTD_DOC2001=m
CONFIG_MTD_DOC2001PLUS=m
CONFIG_MTD_DOCPROBE=m
CONFIG_MTD_DOCECC=m
CONFIG_MTD_DOCPROBE_ADVANCED=y
CONFIG_MTD_DOCPROBE_ADDRESS=0x0000
CONFIG_MTD_DOCPROBE_HIGH=y
CONFIG_MTD_DOCPROBE_55AA=y

#
# NAND Flash Device Drivers
#
CONFIG_MTD_NAND=m
CONFIG_MTD_NAND_VERIFY_WRITE=y
CONFIG_MTD_NAND_IDS=m
CONFIG_MTD_NAND_DISKONCHIP=m
CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADVANCED=y
CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADDRESS=0x0
CONFIG_MTD_NAND_DISKONCHIP_PROBE_HIGH=y
CONFIG_MTD_NAND_DISKONCHIP_BBTWRITE=y
CONFIG_MTD_NAND_NANDSIM=y

#
# OneNAND Flash Device Drivers
#
CONFIG_MTD_ONENAND=m
# CONFIG_MTD_ONENAND_VERIFY_WRITE is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
CONFIG_PARPORT_PC_FIFO=y
# CONFIG_PARPORT_PC_SUPERIO is not set
CONFIG_PARPORT_PC_PCMCIA=m
CONFIG_PARPORT_NOT_PC=y
# CONFIG_PARPORT_GSC is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play support
#
CONFIG_PNP=y
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
CONFIG_PNPACPI=y

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
CONFIG_PARIDE=m
CONFIG_PARIDE_PARPORT=m

#
# Parallel IDE high-level drivers
#
CONFIG_PARIDE_PD=m
CONFIG_PARIDE_PCD=m
CONFIG_PARIDE_PF=m
CONFIG_PARIDE_PT=m
CONFIG_PARIDE_PG=m

#
# Parallel IDE protocol modules
#
CONFIG_PARIDE_ATEN=m
CONFIG_PARIDE_BPCK=m
CONFIG_PARIDE_BPCK6=m
CONFIG_PARIDE_COMM=m
CONFIG_PARIDE_DSTR=m
CONFIG_PARIDE_FIT2=m
CONFIG_PARIDE_FIT3=m
CONFIG_PARIDE_EPAT=m
CONFIG_PARIDE_EPATC8=y
CONFIG_PARIDE_EPIA=m
CONFIG_PARIDE_FRIQ=m
CONFIG_PARIDE_FRPW=m
CONFIG_PARIDE_KBIC=m
CONFIG_PARIDE_KTTI=m
CONFIG_PARIDE_ON20=m
CONFIG_PARIDE_ON26=m
CONFIG_BLK_CPQ_DA=m
CONFIG_BLK_CPQ_CISS_DA=m
CONFIG_CISS_SCSI_TAPE=y
CONFIG_BLK_DEV_DAC960=m
CONFIG_BLK_DEV_UMEM=m
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_CRYPTOLOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_SX8=m
CONFIG_BLK_DEV_UB=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
CONFIG_ATA_OVER_ETH=m

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECS=m
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDETAPE=m
CONFIG_BLK_DEV_IDEFLOPPY=m
CONFIG_BLK_DEV_IDESCSI=m
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_AEC62XX=y
CONFIG_BLK_DEV_ALI15X3=y
# CONFIG_WDC_ALI15X3 is not set
CONFIG_BLK_DEV_AMD74XX=y
CONFIG_BLK_DEV_ATIIXP=y
CONFIG_BLK_DEV_CMD64X=y
CONFIG_BLK_DEV_TRIFLEX=y
CONFIG_BLK_DEV_CY82C693=y
CONFIG_BLK_DEV_CS5520=y
CONFIG_BLK_DEV_CS5530=y
CONFIG_BLK_DEV_CS5535=m
CONFIG_BLK_DEV_HPT34X=y
# CONFIG_HPT34X_AUTODMA is not set
CONFIG_BLK_DEV_HPT366=y
CONFIG_BLK_DEV_SC1200=m
CONFIG_BLK_DEV_PIIX=y
CONFIG_BLK_DEV_IT821X=m
CONFIG_BLK_DEV_NS87415=m
CONFIG_BLK_DEV_PDC202XX_OLD=y
CONFIG_PDC202XX_BURST=y
CONFIG_BLK_DEV_PDC202XX_NEW=y
CONFIG_PDC202XX_FORCE=y
CONFIG_BLK_DEV_SVWKS=y
CONFIG_BLK_DEV_SIIMAGE=y
CONFIG_BLK_DEV_SIS5513=y
CONFIG_BLK_DEV_SLC90E66=y
CONFIG_BLK_DEV_TRM290=m
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_IDE_ARM is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_RAID_ATTRS=m
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=m
CONFIG_CHR_DEV_OSST=m
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=m
CONFIG_CHR_DEV_SCH=m

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y

#
# SCSI Transport Attributes
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m

#
# SCSI low-level drivers
#
CONFIG_ISCSI_TCP=m
CONFIG_BLK_DEV_3W_XXXX_RAID=m
CONFIG_SCSI_3W_9XXX=m
CONFIG_SCSI_ACARD=m
CONFIG_SCSI_AACRAID=m
CONFIG_SCSI_AIC7XXX=m
CONFIG_AIC7XXX_CMDS_PER_DEVICE=32
CONFIG_AIC7XXX_RESET_DELAY_MS=15000
CONFIG_AIC7XXX_DEBUG_ENABLE=y
CONFIG_AIC7XXX_DEBUG_MASK=0
CONFIG_AIC7XXX_REG_PRETTY_PRINT=y
CONFIG_SCSI_AIC7XXX_OLD=m
CONFIG_SCSI_AIC79XX=m
CONFIG_AIC79XX_CMDS_PER_DEVICE=32
CONFIG_AIC79XX_RESET_DELAY_MS=15000
CONFIG_AIC79XX_ENABLE_RD_STRM=y
# CONFIG_AIC79XX_DEBUG_ENABLE is not set
CONFIG_AIC79XX_DEBUG_MASK=0
CONFIG_AIC79XX_REG_PRETTY_PRINT=y
CONFIG_SCSI_DPT_I2O=m
CONFIG_MEGARAID_NEWGEN=y
CONFIG_MEGARAID_MM=m
CONFIG_MEGARAID_MAILBOX=m
CONFIG_MEGARAID_LEGACY=m
CONFIG_MEGARAID_SAS=m
CONFIG_SCSI_SATA=y
CONFIG_SCSI_SATA_AHCI=m
CONFIG_SCSI_SATA_SVW=m
CONFIG_SCSI_ATA_PIIX=y
CONFIG_SCSI_SATA_MV=m
CONFIG_SCSI_SATA_NV=m
CONFIG_SCSI_PDC_ADMA=m
CONFIG_SCSI_SATA_QSTOR=m
CONFIG_SCSI_SATA_PROMISE=m
CONFIG_SCSI_SATA_SX4=m
CONFIG_SCSI_SATA_SIL=m
CONFIG_SCSI_SATA_SIL24=m
CONFIG_SCSI_SATA_SIS=m
CONFIG_SCSI_SATA_ULI=m
CONFIG_SCSI_SATA_VIA=y
CONFIG_SCSI_SATA_VITESSE=m
CONFIG_SCSI_SATA_INTEL_COMBINED=y
CONFIG_SCSI_BUSLOGIC=m
# CONFIG_SCSI_OMIT_FLASHPOINT is not set
CONFIG_SCSI_DMX3191D=m
CONFIG_SCSI_EATA=m
CONFIG_SCSI_EATA_TAGGED_QUEUE=y
CONFIG_SCSI_EATA_LINKED_COMMANDS=y
CONFIG_SCSI_EATA_MAX_TAGS=16
CONFIG_SCSI_FUTURE_DOMAIN=m
CONFIG_SCSI_GDTH=m
CONFIG_SCSI_IPS=m
CONFIG_SCSI_INITIO=m
CONFIG_SCSI_INIA100=m
CONFIG_SCSI_PPA=m
CONFIG_SCSI_IMM=m
# CONFIG_SCSI_IZIP_EPP16 is not set
# CONFIG_SCSI_IZIP_SLOW_CTR is not set
CONFIG_SCSI_SYM53C8XX_2=m
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
# CONFIG_SCSI_SYM53C8XX_IOMAPPED is not set
CONFIG_SCSI_IPR=m
# CONFIG_SCSI_IPR_TRACE is not set
# CONFIG_SCSI_IPR_DUMP is not set
CONFIG_SCSI_QLOGIC_FC=m
# CONFIG_SCSI_QLOGIC_FC_FIRMWARE is not set
CONFIG_SCSI_QLOGIC_1280=m
CONFIG_SCSI_QLA_FC=m
# CONFIG_SCSI_QLA2XXX_EMBEDDED_FIRMWARE is not set
CONFIG_SCSI_LPFC=m
CONFIG_SCSI_DC395x=m
CONFIG_SCSI_DC390T=m
CONFIG_SCSI_NSP32=m
CONFIG_SCSI_DEBUG=m

#
# PCMCIA SCSI adapter support
#
CONFIG_PCMCIA_AHA152X=m
CONFIG_PCMCIA_FDOMAIN=m
CONFIG_PCMCIA_NINJA_SCSI=m
CONFIG_PCMCIA_QLOGIC=m
CONFIG_PCMCIA_SYM53C500=m

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID5=m
CONFIG_MD_RAID6=m
CONFIG_MD_MULTIPATH=m
# CONFIG_MD_FAULTY is not set
CONFIG_BLK_DEV_DM=m
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_MIRROR=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_EMC=m

#
# Fusion MPT device support
#
CONFIG_FUSION=y
CONFIG_FUSION_SPI=m
CONFIG_FUSION_FC=m
CONFIG_FUSION_SAS=m
CONFIG_FUSION_MAX_SGE=128
CONFIG_FUSION_CTL=m
CONFIG_FUSION_LAN=m

#
# IEEE 1394 (FireWire) support
#
CONFIG_IEEE1394=m

#
# Subsystem Options
#
# CONFIG_IEEE1394_VERBOSEDEBUG is not set
# CONFIG_IEEE1394_OUI_DB is not set
CONFIG_IEEE1394_EXTRA_CONFIG_ROMS=y
CONFIG_IEEE1394_CONFIG_ROM_IP1394=y
# CONFIG_IEEE1394_EXPORT_FULL_API is not set

#
# Device Drivers
#
CONFIG_IEEE1394_PCILYNX=m
CONFIG_IEEE1394_OHCI1394=m

#
# Protocol Drivers
#
CONFIG_IEEE1394_VIDEO1394=m
CONFIG_IEEE1394_SBP2=m
CONFIG_IEEE1394_SBP2_PHYS_DMA=y
CONFIG_IEEE1394_ETH1394=m
CONFIG_IEEE1394_DV1394=m
CONFIG_IEEE1394_RAWIO=m

#
# I2O device support
#
CONFIG_I2O=m
CONFIG_I2O_LCT_NOTIFY_ON_CHANGES=y
CONFIG_I2O_EXT_ADAPTEC=y
CONFIG_I2O_CONFIG=m
# CONFIG_I2O_CONFIG_OLD_IOCTL is not set
CONFIG_I2O_BUS=m
CONFIG_I2O_BLOCK=m
CONFIG_I2O_SCSI=m
CONFIG_I2O_PROC=m

#
# Network device support
#
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_BONDING=m
CONFIG_EQUALIZER=m
CONFIG_TUN=m
CONFIG_NET_SB1000=m

#
# ARCnet devices
#
CONFIG_ARCNET=m
CONFIG_ARCNET_1201=m
CONFIG_ARCNET_1051=m
CONFIG_ARCNET_RAW=m
CONFIG_ARCNET_CAP=m
CONFIG_ARCNET_COM90xx=m
CONFIG_ARCNET_COM90xxIO=m
CONFIG_ARCNET_RIM_I=m
CONFIG_ARCNET_COM20020=m
CONFIG_ARCNET_COM20020_PCI=m

#
# PHY device support
#
CONFIG_PHYLIB=m

#
# MII PHY device drivers
#
CONFIG_MARVELL_PHY=m
CONFIG_DAVICOM_PHY=m
CONFIG_QSEMI_PHY=m
CONFIG_LXT_PHY=m
CONFIG_CICADA_PHY=m

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=m
CONFIG_HAPPYMEAL=m
CONFIG_SUNGEM=m
CONFIG_CASSINI=m
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=m
CONFIG_TYPHOON=m

#
# Tulip family network device support
#
CONFIG_NET_TULIP=y
CONFIG_DE2104X=m
CONFIG_TULIP=m
CONFIG_TULIP_MWI=y
CONFIG_TULIP_MMIO=y
CONFIG_TULIP_NAPI=y
CONFIG_TULIP_NAPI_HW_MITIGATION=y
CONFIG_DE4X5=m
CONFIG_WINBOND_840=m
CONFIG_DM9102=m
CONFIG_ULI526X=m
CONFIG_PCMCIA_XIRCOM=m
CONFIG_PCMCIA_XIRTULIP=m
CONFIG_HP100=m
CONFIG_NET_PCI=y
CONFIG_PCNET32=m
CONFIG_AMD8111_ETH=m
CONFIG_AMD8111E_NAPI=y
CONFIG_ADAPTEC_STARFIRE=m
CONFIG_ADAPTEC_STARFIRE_NAPI=y
CONFIG_B44=m
CONFIG_FORCEDETH=m
CONFIG_DGRS=m
CONFIG_EEPRO100=m
CONFIG_E100=m
CONFIG_FEALNX=m
CONFIG_NATSEMI=m
CONFIG_NE2K_PCI=m
CONFIG_8139CP=m
CONFIG_8139TOO=m
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
CONFIG_8139TOO_8129=y
# CONFIG_8139_OLD_RX_RESET is not set
CONFIG_SIS900=m
CONFIG_EPIC100=m
CONFIG_SUNDANCE=m
# CONFIG_SUNDANCE_MMIO is not set
CONFIG_TLAN=m
CONFIG_VIA_RHINE=m
CONFIG_VIA_RHINE_MMIO=y
CONFIG_NET_POCKET=y
CONFIG_ATP=m
CONFIG_DE600=m
CONFIG_DE620=m

#
# Ethernet (1000 Mbit)
#
CONFIG_ACENIC=m
# CONFIG_ACENIC_OMIT_TIGON_I is not set
CONFIG_DL2K=m
CONFIG_E1000=m
CONFIG_E1000_NAPI=y
CONFIG_NS83820=m
CONFIG_HAMACHI=m
CONFIG_YELLOWFIN=m
CONFIG_R8169=m
CONFIG_R8169_NAPI=y
CONFIG_R8169_VLAN=y
CONFIG_SIS190=m
CONFIG_SKGE=m
CONFIG_SKY2=m
CONFIG_SK98LIN=m
CONFIG_VIA_VELOCITY=m
CONFIG_TIGON3=m
CONFIG_BNX2=m

#
# Ethernet (10000 Mbit)
#
CONFIG_CHELSIO_T1=m
CONFIG_IXGB=m
CONFIG_IXGB_NAPI=y
CONFIG_S2IO=m
CONFIG_S2IO_NAPI=y

#
# Token Ring devices
#
CONFIG_TR=y
CONFIG_IBMOL=m
CONFIG_IBMLS=m
CONFIG_3C359=m
CONFIG_TMS380TR=m
CONFIG_TMSPCI=m
CONFIG_ABYSS=m

#
# Wireless LAN (non-hamradio)
#
CONFIG_NET_RADIO=y

#
# Obsolete Wireless cards support (pre-802.11)
#
CONFIG_STRIP=m
CONFIG_PCMCIA_WAVELAN=m
CONFIG_PCMCIA_NETWAVE=m

#
# Wireless 802.11 Frequency Hopping cards support
#
CONFIG_PCMCIA_RAYCS=m

#
# Wireless 802.11b ISA/PCI cards support
#
CONFIG_IPW2100=m
# CONFIG_IPW2100_MONITOR is not set
# CONFIG_IPW2100_DEBUG is not set
CONFIG_IPW2200=m
# CONFIG_IPW2200_DEBUG is not set
CONFIG_AIRO=m
CONFIG_HERMES=m
CONFIG_PLX_HERMES=m
CONFIG_TMD_HERMES=m
CONFIG_NORTEL_HERMES=m
CONFIG_PCI_HERMES=m
CONFIG_ATMEL=m
CONFIG_PCI_ATMEL=m

#
# Wireless 802.11b Pcmcia/Cardbus cards support
#
CONFIG_PCMCIA_HERMES=m
CONFIG_PCMCIA_SPECTRUM=m
CONFIG_AIRO_CS=m
CONFIG_PCMCIA_ATMEL=m
CONFIG_PCMCIA_WL3501=m

#
# Prism GT/Duette 802.11(a/b/g) PCI/Cardbus support
#
CONFIG_PRISM54=m
CONFIG_HOSTAP=m
# CONFIG_HOSTAP_FIRMWARE is not set
CONFIG_HOSTAP_PLX=m
CONFIG_HOSTAP_PCI=m
CONFIG_HOSTAP_CS=m
CONFIG_NET_WIRELESS=y

#
# PCMCIA network device support
#
CONFIG_NET_PCMCIA=y
CONFIG_PCMCIA_3C589=m
CONFIG_PCMCIA_3C574=m
CONFIG_PCMCIA_FMVJ18X=m
CONFIG_PCMCIA_PCNET=m
CONFIG_PCMCIA_NMCLAN=m
CONFIG_PCMCIA_SMC91C92=m
CONFIG_PCMCIA_XIRC2PS=m
CONFIG_PCMCIA_AXNET=m
CONFIG_ARCNET_COM20020_CS=m
CONFIG_PCMCIA_IBMTR=m

#
# Wan interfaces
#
CONFIG_WAN=y
CONFIG_DSCC4=m
CONFIG_DSCC4_PCISYNC=y
CONFIG_DSCC4_PCI_RST=y
CONFIG_LANMEDIA=m
CONFIG_SYNCLINK_SYNCPPP=m
CONFIG_HDLC=m
CONFIG_HDLC_RAW=y
CONFIG_HDLC_RAW_ETH=y
CONFIG_HDLC_CISCO=y
CONFIG_HDLC_FR=y
CONFIG_HDLC_PPP=y
# CONFIG_HDLC_X25 is not set
CONFIG_PCI200SYN=m
CONFIG_WANXL=m
CONFIG_PC300=m
# CONFIG_PC300_MLPPP is not set
CONFIG_FARSYNC=m
CONFIG_DLCI=m
CONFIG_DLCI_COUNT=24
CONFIG_DLCI_MAX=8
CONFIG_WAN_ROUTER_DRIVERS=y
CONFIG_CYCLADES_SYNC=m
CONFIG_CYCLOMX_X25=y
CONFIG_LAPBETHER=m
CONFIG_X25_ASY=m
CONFIG_SBNI=m
CONFIG_SBNI_MULTILINE=y

#
# ATM drivers
#
CONFIG_ATM_DUMMY=m
CONFIG_ATM_TCP=m
CONFIG_ATM_LANAI=m
CONFIG_ATM_ENI=m
# CONFIG_ATM_ENI_DEBUG is not set
# CONFIG_ATM_ENI_TUNE_BURST is not set
CONFIG_ATM_FIRESTREAM=m
CONFIG_ATM_ZATM=m
# CONFIG_ATM_ZATM_DEBUG is not set
CONFIG_ATM_NICSTAR=m
CONFIG_ATM_NICSTAR_USE_SUNI=y
CONFIG_ATM_NICSTAR_USE_IDT77105=y
CONFIG_ATM_IDT77252=m
# CONFIG_ATM_IDT77252_DEBUG is not set
# CONFIG_ATM_IDT77252_RCV_ALL is not set
CONFIG_ATM_IDT77252_USE_SUNI=y
CONFIG_ATM_AMBASSADOR=m
# CONFIG_ATM_AMBASSADOR_DEBUG is not set
CONFIG_ATM_HORIZON=m
# CONFIG_ATM_HORIZON_DEBUG is not set
CONFIG_ATM_IA=m
# CONFIG_ATM_IA_DEBUG is not set
CONFIG_ATM_FORE200E_MAYBE=m
CONFIG_ATM_FORE200E_PCA=y
CONFIG_ATM_FORE200E_PCA_DEFAULT_FW=y
# CONFIG_ATM_FORE200E_USE_TASKLET is not set
CONFIG_ATM_FORE200E_TX_RETRY=16
CONFIG_ATM_FORE200E_DEBUG=0
CONFIG_ATM_FORE200E=m
CONFIG_ATM_HE=m
CONFIG_ATM_HE_USE_SUNI=y
CONFIG_FDDI=y
CONFIG_DEFXX=m
CONFIG_SKFP=m
CONFIG_HIPPI=y
CONFIG_ROADRUNNER=m
# CONFIG_ROADRUNNER_LARGE_RINGS is not set
CONFIG_PLIP=m
CONFIG_PPP=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPP_MPPE=m
CONFIG_PPPOE=m
CONFIG_PPPOATM=m
CONFIG_SLIP=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
CONFIG_SLIP_MODE_SLIP6=y
CONFIG_NET_FC=y
CONFIG_SHAPER=m
CONFIG_NETCONSOLE=m
CONFIG_NETPOLL=y
# CONFIG_NETPOLL_RX is not set
# CONFIG_NETPOLL_TRAP is not set
CONFIG_NET_POLL_CONTROLLER=y

#
# ISDN subsystem
#
CONFIG_ISDN=m

#
# Old ISDN4Linux
#
# CONFIG_ISDN_I4L is not set

#
# CAPI subsystem
#
CONFIG_ISDN_CAPI=m
CONFIG_ISDN_DRV_AVMB1_VERBOSE_REASON=y
CONFIG_ISDN_CAPI_MIDDLEWARE=y
CONFIG_ISDN_CAPI_CAPI20=m
CONFIG_ISDN_CAPI_CAPIFS_BOOL=y
CONFIG_ISDN_CAPI_CAPIFS=m

#
# CAPI hardware drivers
#

#
# Active AVM cards
#
CONFIG_CAPI_AVM=y
CONFIG_ISDN_DRV_AVMB1_B1PCI=m
CONFIG_ISDN_DRV_AVMB1_B1PCIV4=y
CONFIG_ISDN_DRV_AVMB1_B1PCMCIA=m
CONFIG_ISDN_DRV_AVMB1_AVM_CS=m
CONFIG_ISDN_DRV_AVMB1_T1PCI=m
CONFIG_ISDN_DRV_AVMB1_C4=m

#
# Active Eicon DIVA Server cards
#
# CONFIG_CAPI_EICON is not set

#
# Telephony Support
#
CONFIG_PHONE=m
CONFIG_PHONE_IXJ=m
CONFIG_PHONE_IXJ_PCMCIA=m

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_TSDEV=m
CONFIG_INPUT_TSDEV_SCREEN_X=240
CONFIG_INPUT_TSDEV_SCREEN_Y=320
CONFIG_INPUT_EVDEV=m
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_KEYBOARD_SUNKBD=m
CONFIG_KEYBOARD_LKKBD=m
CONFIG_KEYBOARD_XTKBD=m
CONFIG_KEYBOARD_NEWTON=m
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=m
CONFIG_MOUSE_SERIAL=m
CONFIG_MOUSE_VSXXXAA=m
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=m
CONFIG_JOYSTICK_A3D=m
CONFIG_JOYSTICK_ADI=m
CONFIG_JOYSTICK_COBRA=m
CONFIG_JOYSTICK_GF2K=m
CONFIG_JOYSTICK_GRIP=m
CONFIG_JOYSTICK_GRIP_MP=m
CONFIG_JOYSTICK_GUILLEMOT=m
CONFIG_JOYSTICK_INTERACT=m
CONFIG_JOYSTICK_SIDEWINDER=m
CONFIG_JOYSTICK_TMDC=m
CONFIG_JOYSTICK_IFORCE=m
CONFIG_JOYSTICK_IFORCE_USB=y
CONFIG_JOYSTICK_IFORCE_232=y
CONFIG_JOYSTICK_WARRIOR=m
CONFIG_JOYSTICK_MAGELLAN=m
CONFIG_JOYSTICK_SPACEORB=m
CONFIG_JOYSTICK_SPACEBALL=m
CONFIG_JOYSTICK_STINGER=m
CONFIG_JOYSTICK_TWIDJOY=m
CONFIG_JOYSTICK_DB9=m
CONFIG_JOYSTICK_GAMECON=m
CONFIG_JOYSTICK_TURBOGRAFX=m
CONFIG_JOYSTICK_JOYDUMP=m
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_GUNZE=m
CONFIG_TOUCHSCREEN_ELO=m
CONFIG_TOUCHSCREEN_MTOUCH=m
CONFIG_TOUCHSCREEN_MK712=m
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=m
CONFIG_INPUT_WISTRON_BTNS=m
CONFIG_INPUT_UINPUT=m

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=m
CONFIG_SERIO_CT82C710=m
CONFIG_SERIO_PARKBD=m
CONFIG_SERIO_PCIPS2=m
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_GAMEPORT=m
CONFIG_GAMEPORT_NS558=m
CONFIG_GAMEPORT_L4=m
CONFIG_GAMEPORT_EMU10K1=m
CONFIG_GAMEPORT_FM801=m

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_NONSTANDARD=y
CONFIG_COMPUTONE=m
CONFIG_ROCKETPORT=m
CONFIG_CYCLADES=m
# CONFIG_CYZ_INTR is not set
CONFIG_DIGIEPCA=m
CONFIG_MOXA_INTELLIO=m
CONFIG_MOXA_SMARTIO=m
CONFIG_ISI=m
CONFIG_SYNCLINK=m
CONFIG_SYNCLINKMP=m
CONFIG_SYNCLINK_GT=m
CONFIG_N_HDLC=m
CONFIG_RISCOM8=m
CONFIG_SPECIALIX=m
CONFIG_SPECIALIX_RTSCTS=y
CONFIG_SX=m
CONFIG_RIO=m
# CONFIG_RIO_OLDPCI is not set
CONFIG_STALDRV=y
CONFIG_STALLION=m
CONFIG_ISTALLION=m

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_CS=m
# CONFIG_SERIAL_8250_ACPI is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
CONFIG_SERIAL_8250_DETECT_IRQ=y
CONFIG_SERIAL_8250_RSA=y

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_PRINTER=m
CONFIG_LP_CONSOLE=y
CONFIG_PPDEV=m
CONFIG_TIPAR=m

#
# IPMI
#
CONFIG_IPMI_HANDLER=m
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m

#
# Watchdog Cards
#
CONFIG_WATCHDOG=y
# CONFIG_WATCHDOG_NOWAYOUT is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_ACQUIRE_WDT=m
CONFIG_ADVANTECH_WDT=m
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
CONFIG_SC520_WDT=m
CONFIG_EUROTECH_WDT=m
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
CONFIG_WAFER_WDT=m
CONFIG_I6300ESB_WDT=m
CONFIG_I8XX_TCO=m
CONFIG_SC1200_WDT=m
CONFIG_SCx200_WDT=m
CONFIG_60XX_WDT=m
CONFIG_SBC8360_WDT=m
CONFIG_CPU5_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
CONFIG_SBC_EPX_C3_WATCHDOG=m

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m
CONFIG_WDT_501_PCI=y

#
# USB-based Watchdog Cards
#
CONFIG_USBPCWATCHDOG=m
CONFIG_HW_RANDOM=m
CONFIG_NVRAM=m
CONFIG_RTC=y
CONFIG_DTLK=m
CONFIG_R3964=m
CONFIG_APPLICOM=m
CONFIG_SONYPI=m

#
# Ftape, the floppy tape device driver
#
CONFIG_FTAPE=m
CONFIG_ZFTAPE=m
CONFIG_ZFT_DFLT_BLK_SZ=10240

#
# The compressor will be built as a module only!
#
CONFIG_ZFT_COMPRESSOR=m
CONFIG_FT_NR_BUFFERS=3
CONFIG_FT_PROC_FS=y
CONFIG_FT_NORMAL_DEBUG=y
# CONFIG_FT_FULL_DEBUG is not set
# CONFIG_FT_NO_TRACE is not set
# CONFIG_FT_NO_TRACE_AT_ALL is not set

#
# Hardware configuration
#
CONFIG_FT_STD_FDC=y
# CONFIG_FT_MACH2 is not set
# CONFIG_FT_PROBE_FC10 is not set
# CONFIG_FT_ALT_FDC is not set
CONFIG_FT_FDC_THR=8
CONFIG_FT_FDC_MAX_RATE=2000
CONFIG_FT_ALPHA_CLOCK=0
CONFIG_AGP=y
CONFIG_AGP_ALI=m
CONFIG_AGP_ATI=m
CONFIG_AGP_AMD=m
CONFIG_AGP_AMD64=m
CONFIG_AGP_INTEL=m
CONFIG_AGP_NVIDIA=m
CONFIG_AGP_SIS=m
CONFIG_AGP_SWORKS=m
CONFIG_AGP_VIA=m
CONFIG_AGP_EFFICEON=m
CONFIG_DRM=y
CONFIG_DRM_TDFX=m
CONFIG_DRM_R128=m
CONFIG_DRM_RADEON=m
CONFIG_DRM_I810=m
CONFIG_DRM_I830=m
CONFIG_DRM_I915=m
CONFIG_DRM_MGA=m
CONFIG_DRM_SIS=m
CONFIG_DRM_VIA=m
CONFIG_DRM_SAVAGE=m

#
# PCMCIA character devices
#
CONFIG_SYNCLINK_CS=m
CONFIG_CARDMAN_4000=m
CONFIG_CARDMAN_4040=m
CONFIG_MWAVE=m
CONFIG_SCx200_GPIO=m
CONFIG_CS5535_GPIO=m
CONFIG_RAW_DRIVER=m
CONFIG_MAX_RAW_DEVS=256
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=m

#
# TPM devices
#
CONFIG_TCG_TPM=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
CONFIG_TELCLOCK=m

#
# I2C support
#
CONFIG_I2C=m
CONFIG_I2C_CHARDEV=m

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#
CONFIG_I2C_ALI1535=m
CONFIG_I2C_ALI1563=m
CONFIG_I2C_ALI15X3=m
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD756_S4882=m
CONFIG_I2C_AMD8111=m
CONFIG_I2C_I801=m
CONFIG_I2C_I810=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_ISA=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_PARPORT=m
CONFIG_I2C_PARPORT_LIGHT=m
CONFIG_I2C_PROSAVAGE=m
CONFIG_I2C_SAVAGE4=m
CONFIG_SCx200_I2C=m
CONFIG_SCx200_I2C_SCL=12
CONFIG_SCx200_I2C_SDA=13
CONFIG_SCx200_ACB=m
CONFIG_I2C_SIS5595=m
CONFIG_I2C_SIS630=m
CONFIG_I2C_SIS96X=m
CONFIG_I2C_STUB=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m
CONFIG_I2C_VOODOO3=m
CONFIG_I2C_PCA_ISA=m

#
# Miscellaneous I2C Chip support
#
CONFIG_SENSORS_DS1337=m
CONFIG_SENSORS_DS1374=m
CONFIG_SENSORS_EEPROM=m
CONFIG_SENSORS_PCF8574=m
CONFIG_SENSORS_PCA9539=m
CONFIG_SENSORS_PCF8591=m
CONFIG_SENSORS_RTC8564=m
CONFIG_SENSORS_MAX6875=m
CONFIG_RTC_X1205_I2C=m
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

#
# SPI support
#
# CONFIG_SPI is not set
# CONFIG_SPI_MASTER is not set

#
# Dallas's 1-wire bus
#
CONFIG_W1=m
CONFIG_W1_MATROX=m
CONFIG_W1_DS9490=m
CONFIG_W1_DS9490_BRIDGE=m
CONFIG_W1_THERM=m
CONFIG_W1_SMEM=m
CONFIG_W1_DS2433=m
# CONFIG_W1_DS2433_CRC is not set

#
# Hardware Monitoring support
#
CONFIG_HWMON=m
CONFIG_HWMON_VID=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1031=m
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ASB100=m
CONFIG_SENSORS_ATXP1=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_FSCHER=m
CONFIG_SENSORS_FSCPOS=m
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_LM63=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT8231=m
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
CONFIG_SENSORS_HDAPS=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Misc devices
#
CONFIG_IBM_ASM=m

#
# Multimedia Capabilities Port drivers
#

#
# Multimedia devices
#
CONFIG_VIDEO_DEV=m

#
# Video For Linux
#

#
# Video Adapters
#
# CONFIG_VIDEO_ADV_DEBUG is not set
CONFIG_VIDEO_BT848=m
# CONFIG_VIDEO_BT848_DVB is not set
CONFIG_VIDEO_SAA6588=m
CONFIG_VIDEO_BWQCAM=m
CONFIG_VIDEO_CQCAM=m
CONFIG_VIDEO_W9966=m
CONFIG_VIDEO_CPIA=m
CONFIG_VIDEO_CPIA_PP=m
CONFIG_VIDEO_CPIA_USB=m
CONFIG_VIDEO_SAA5246A=m
CONFIG_VIDEO_SAA5249=m
CONFIG_TUNER_3036=m
CONFIG_VIDEO_STRADIS=m
CONFIG_VIDEO_ZORAN=m
CONFIG_VIDEO_ZORAN_BUZ=m
CONFIG_VIDEO_ZORAN_DC10=m
CONFIG_VIDEO_ZORAN_DC30=m
CONFIG_VIDEO_ZORAN_LML33=m
CONFIG_VIDEO_ZORAN_LML33R10=m
CONFIG_VIDEO_MEYE=m
CONFIG_VIDEO_SAA7134=m
CONFIG_VIDEO_SAA7134_ALSA=m
CONFIG_VIDEO_SAA7134_DVB=m
CONFIG_VIDEO_SAA7134_DVB_ALL_FRONTENDS=y
CONFIG_VIDEO_MXB=m
CONFIG_VIDEO_DPC=m
CONFIG_VIDEO_HEXIUM_ORION=m
CONFIG_VIDEO_HEXIUM_GEMINI=m
CONFIG_VIDEO_CX88=m
CONFIG_VIDEO_CX88_DVB=m
CONFIG_VIDEO_CX88_ALSA=m
CONFIG_VIDEO_CX88_DVB_ALL_FRONTENDS=y
CONFIG_VIDEO_EM28XX=m
CONFIG_VIDEO_OVCAMCHIP=m
CONFIG_VIDEO_AUDIO_DECODER=m
CONFIG_VIDEO_DECODER=m

#
# Radio Adapters
#
CONFIG_RADIO_GEMTEK_PCI=m
CONFIG_RADIO_MAXIRADIO=m
CONFIG_RADIO_MAESTRO=m

#
# Digital Video Broadcasting Devices
#
CONFIG_DVB=y
CONFIG_DVB_CORE=m

#
# Supported SAA7146 based PCI Adapters
#
CONFIG_DVB_AV7110=m
CONFIG_DVB_AV7110_OSD=y
CONFIG_DVB_BUDGET=m
CONFIG_DVB_BUDGET_CI=m
CONFIG_DVB_BUDGET_AV=m
CONFIG_DVB_BUDGET_PATCH=m

#
# Supported USB Adapters
#
CONFIG_DVB_USB=m
# CONFIG_DVB_USB_DEBUG is not set
CONFIG_DVB_USB_A800=m
CONFIG_DVB_USB_DIBUSB_MB=m
# CONFIG_DVB_USB_DIBUSB_MB_FAULTY is not set
CONFIG_DVB_USB_DIBUSB_MC=m
CONFIG_DVB_USB_UMT_010=m
CONFIG_DVB_USB_CXUSB=m
CONFIG_DVB_USB_DIGITV=m
CONFIG_DVB_USB_VP7045=m
CONFIG_DVB_USB_VP702X=m
CONFIG_DVB_USB_NOVA_T_USB2=m
CONFIG_DVB_USB_DTT200U=m
CONFIG_DVB_TTUSB_BUDGET=m
CONFIG_DVB_TTUSB_DEC=m
CONFIG_DVB_CINERGYT2=m
# CONFIG_DVB_CINERGYT2_TUNING is not set

#
# Supported FlexCopII (B2C2) Adapters
#
CONFIG_DVB_B2C2_FLEXCOP=m
CONFIG_DVB_B2C2_FLEXCOP_PCI=m
CONFIG_DVB_B2C2_FLEXCOP_USB=m
# CONFIG_DVB_B2C2_FLEXCOP_DEBUG is not set

#
# Supported BT878 Adapters
#
CONFIG_DVB_BT8XX=m

#
# Supported Pluto2 Adapters
#
CONFIG_DVB_PLUTO2=m

#
# Supported DVB Frontends
#

#
# Customise DVB Frontends
#

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_STV0299=m
CONFIG_DVB_CX24110=m
CONFIG_DVB_CX24123=m
CONFIG_DVB_TDA8083=m
CONFIG_DVB_TDA80XX=m
CONFIG_DVB_MT312=m
CONFIG_DVB_VES1X93=m
CONFIG_DVB_S5H1420=m

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_SP8870=m
CONFIG_DVB_SP887X=m
CONFIG_DVB_CX22700=m
CONFIG_DVB_CX22702=m
CONFIG_DVB_L64781=m
CONFIG_DVB_TDA1004X=m
CONFIG_DVB_NXT6000=m
CONFIG_DVB_MT352=m
CONFIG_DVB_DIB3000MB=m
CONFIG_DVB_DIB3000MC=m

#
# DVB-C (cable) frontends
#
CONFIG_DVB_ATMEL_AT76C651=m
CONFIG_DVB_VES1820=m
CONFIG_DVB_TDA10021=m
CONFIG_DVB_STV0297=m

#
# ATSC (North American/Korean Terresterial DTV) frontends
#
CONFIG_DVB_NXT2002=m
CONFIG_DVB_NXT200X=m
CONFIG_DVB_OR51211=m
CONFIG_DVB_OR51132=m
CONFIG_DVB_BCM3510=m
CONFIG_DVB_LGDT330X=m
CONFIG_VIDEO_SAA7146=m
CONFIG_VIDEO_SAA7146_VV=m
CONFIG_VIDEO_VIDEOBUF=m
CONFIG_VIDEO_TUNER=m
CONFIG_VIDEO_BUF=m
CONFIG_VIDEO_BUF_DVB=m
CONFIG_VIDEO_BTCX=m
CONFIG_VIDEO_IR=m
CONFIG_VIDEO_TVEEPROM=m

#
# Graphics support
#
CONFIG_FB=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
# CONFIG_FB_MACMODES is not set
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y
CONFIG_FB_CIRRUS=m
CONFIG_FB_PM2=m
CONFIG_FB_PM2_FIFO_DISCONNECT=y
CONFIG_FB_CYBER2000=m
CONFIG_FB_ARC=m
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
CONFIG_FB_VGA16=m
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB_HGA=m
CONFIG_FB_HGA_ACCEL=y
CONFIG_FB_S1D13XXX=m
CONFIG_FB_NVIDIA=m
CONFIG_FB_NVIDIA_I2C=y
CONFIG_FB_RIVA=m
CONFIG_FB_RIVA_I2C=y
# CONFIG_FB_RIVA_DEBUG is not set
CONFIG_FB_I810=m
CONFIG_FB_I810_GTF=y
# CONFIG_FB_I810_I2C is not set
CONFIG_FB_INTEL=m
# CONFIG_FB_INTEL_DEBUG is not set
CONFIG_FB_MATROX=m
CONFIG_FB_MATROX_MILLENIUM=y
CONFIG_FB_MATROX_MYSTIQUE=y
CONFIG_FB_MATROX_G=y
CONFIG_FB_MATROX_I2C=m
CONFIG_FB_MATROX_MAVEN=m
CONFIG_FB_MATROX_MULTIHEAD=y
# CONFIG_FB_RADEON_OLD is not set
CONFIG_FB_RADEON=m
CONFIG_FB_RADEON_I2C=y
# CONFIG_FB_RADEON_DEBUG is not set
CONFIG_FB_ATY128=m
CONFIG_FB_ATY=m
CONFIG_FB_ATY_CT=y
CONFIG_FB_ATY_GENERIC_LCD=y
CONFIG_FB_ATY_GX=y
CONFIG_FB_SAVAGE=m
CONFIG_FB_SAVAGE_I2C=y
CONFIG_FB_SAVAGE_ACCEL=y
CONFIG_FB_SIS=m
CONFIG_FB_SIS_300=y
CONFIG_FB_SIS_315=y
CONFIG_FB_NEOMAGIC=m
CONFIG_FB_KYRO=m
CONFIG_FB_3DFX=m
CONFIG_FB_3DFX_ACCEL=y
CONFIG_FB_VOODOO1=m
CONFIG_FB_CYBLA=m
CONFIG_FB_TRIDENT=m
CONFIG_FB_TRIDENT_ACCEL=y
CONFIG_FB_GEODE=y
CONFIG_FB_GEODE_GX1=m
CONFIG_FB_VIRTUAL=m

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
CONFIG_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
# CONFIG_FONT_6x11 is not set
# CONFIG_FONT_7x14 is not set
# CONFIG_FONT_PEARL_8x8 is not set
# CONFIG_FONT_ACORN_8x8 is not set
# CONFIG_FONT_MINI_4x6 is not set
# CONFIG_FONT_SUN8x16 is not set
CONFIG_FONT_SUN12x22=y
# CONFIG_FONT_10x18 is not set

#
# Logo configuration
#
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y
CONFIG_BACKLIGHT_LCD_SUPPORT=y
CONFIG_BACKLIGHT_CLASS_DEVICE=m
CONFIG_BACKLIGHT_DEVICE=y
CONFIG_LCD_CLASS_DEVICE=m
CONFIG_LCD_DEVICE=y

#
# Sound
#
CONFIG_SOUND=m

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_HWDEP=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
CONFIG_SND_SEQ_RTCTIMER_DEFAULT=y
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_SUPPORT_OLD_API=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
CONFIG_SND_MPU401_UART=m
CONFIG_SND_OPL3_LIB=m
CONFIG_SND_VX_LIB=m
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_AC97_BUS=m
CONFIG_SND_DUMMY=m
CONFIG_SND_VIRMIDI=m
CONFIG_SND_MTPAV=m
CONFIG_SND_SERIAL_U16550=m
CONFIG_SND_MPU401=m

#
# PCI devices
#
CONFIG_SND_AD1889=m
CONFIG_SND_ALS4000=m
CONFIG_SND_ALI5451=m
CONFIG_SND_ATIIXP=m
CONFIG_SND_ATIIXP_MODEM=m
CONFIG_SND_AU8810=m
CONFIG_SND_AU8820=m
CONFIG_SND_AU8830=m
CONFIG_SND_AZT3328=m
CONFIG_SND_BT87X=m
CONFIG_SND_BT87X_OVERCLOCK=y
CONFIG_SND_CA0106=m
CONFIG_SND_CMIPCI=m
CONFIG_SND_CS4281=m
CONFIG_SND_CS46XX=m
CONFIG_SND_CS46XX_NEW_DSP=y
CONFIG_SND_CS5535AUDIO=m
CONFIG_SND_EMU10K1=m
CONFIG_SND_EMU10K1X=m
CONFIG_SND_ENS1370=m
CONFIG_SND_ENS1371=m
CONFIG_SND_ES1938=m
CONFIG_SND_ES1968=m
CONFIG_SND_FM801=m
CONFIG_SND_FM801_TEA575X=m
CONFIG_SND_HDA_INTEL=m
CONFIG_SND_HDSP=m
CONFIG_SND_HDSPM=m
CONFIG_SND_ICE1712=m
CONFIG_SND_ICE1724=m
CONFIG_SND_INTEL8X0=m
CONFIG_SND_INTEL8X0M=m
CONFIG_SND_KORG1212=m
CONFIG_SND_MAESTRO3=m
CONFIG_SND_MIXART=m
CONFIG_SND_NM256=m
CONFIG_SND_PCXHR=m
CONFIG_SND_RME32=m
CONFIG_SND_RME96=m
CONFIG_SND_RME9652=m
CONFIG_SND_SONICVIBES=m
CONFIG_SND_TRIDENT=m
CONFIG_SND_VIA82XX=m
CONFIG_SND_VIA82XX_MODEM=m
CONFIG_SND_VX222=m
CONFIG_SND_YMFPCI=m

#
# USB devices
#
CONFIG_SND_USB_AUDIO=m
CONFIG_SND_USB_USX2Y=m

#
# PCMCIA devices
#

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB=m
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_SUSPEND is not set
# CONFIG_USB_OTG is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_EHCI_SPLIT_ISO=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_ISP116X_HCD=m
CONFIG_USB_OHCI_HCD=m
# CONFIG_USB_OHCI_BIG_ENDIAN is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_UHCI_HCD=m
CONFIG_USB_SL811_HCD=m
CONFIG_USB_SL811_CS=m

#
# USB Device Class drivers
#
# CONFIG_OBSOLETE_OSS_USB_DRIVER is not set
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
#

#
# may also be needed; see USB_STORAGE Help for more information
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_DATAFAB=y
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_DPCM=y
CONFIG_USB_STORAGE_USBAT=y
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_STORAGE_SDDR55=y
CONFIG_USB_STORAGE_JUMPSHOT=y
CONFIG_USB_STORAGE_ALAUDA=y
# CONFIG_USB_LIBUSUAL is not set

#
# USB Input Devices
#
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
# CONFIG_USB_HIDINPUT_POWERBOOK is not set
CONFIG_HID_FF=y
CONFIG_HID_PID=y
CONFIG_LOGITECH_FF=y
CONFIG_THRUSTMASTER_FF=y
CONFIG_USB_HIDDEV=y

#
# USB HID Boot Protocol drivers
#
CONFIG_USB_KBD=m
CONFIG_USB_MOUSE=m
CONFIG_USB_AIPTEK=m
CONFIG_USB_WACOM=m
CONFIG_USB_ACECAD=m
CONFIG_USB_KBTAB=m
CONFIG_USB_POWERMATE=m
CONFIG_USB_MTOUCH=m
CONFIG_USB_ITMTOUCH=m
CONFIG_USB_EGALAX=m
CONFIG_USB_YEALINK=m
CONFIG_USB_XPAD=m
CONFIG_USB_ATI_REMOTE=m
CONFIG_USB_ATI_REMOTE2=m
CONFIG_USB_KEYSPAN_REMOTE=m
CONFIG_USB_APPLETOUCH=m

#
# USB Imaging devices
#
CONFIG_USB_MDC800=m
CONFIG_USB_MICROTEK=m

#
# USB Multimedia devices
#
CONFIG_USB_DABUSB=m
CONFIG_USB_VICAM=m
CONFIG_USB_DSBR=m
CONFIG_USB_IBMCAM=m
CONFIG_USB_KONICAWC=m
CONFIG_USB_OV511=m
CONFIG_USB_SE401=m
CONFIG_USB_SN9C102=m
CONFIG_USB_STV680=m
CONFIG_USB_W9968CF=m
CONFIG_USB_PWC=m

#
# USB Network Adapters
#
CONFIG_USB_CATC=m
CONFIG_USB_KAWETH=m
CONFIG_USB_PEGASUS=m
CONFIG_USB_RTL8150=m
CONFIG_USB_USBNET=m
CONFIG_USB_NET_AX8817X=m
CONFIG_USB_NET_CDCETHER=m
CONFIG_USB_NET_GL620A=m
CONFIG_USB_NET_NET1080=m
CONFIG_USB_NET_PLUSB=m
CONFIG_USB_NET_RNDIS_HOST=m
CONFIG_USB_NET_CDC_SUBSET=m
CONFIG_USB_ALI_M5632=y
# CONFIG_USB_AN2720 is not set
CONFIG_USB_BELKIN=y
CONFIG_USB_ARMLINUX=y
# CONFIG_USB_EPSON2888 is not set
CONFIG_USB_NET_ZAURUS=m
CONFIG_USB_ZD1201=m
CONFIG_USB_MON=y

#
# USB port drivers
#
CONFIG_USB_USS720=m

#
# USB Serial Converter support
#
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
CONFIG_USB_SERIAL_AIRPRIME=m
CONFIG_USB_SERIAL_ANYDATA=m
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_WHITEHEAT=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
CONFIG_USB_SERIAL_CP2101=m
CONFIG_USB_SERIAL_CYPRESS_M8=m
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_IPAQ=m
CONFIG_USB_SERIAL_IR=m
CONFIG_USB_SERIAL_EDGEPORT=m
CONFIG_USB_SERIAL_EDGEPORT_TI=m
CONFIG_USB_SERIAL_GARMIN=m
CONFIG_USB_SERIAL_IPW=m
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=m
CONFIG_USB_SERIAL_KEYSPAN_MPR=y
CONFIG_USB_SERIAL_KEYSPAN_USA28=y
CONFIG_USB_SERIAL_KEYSPAN_USA28X=y
CONFIG_USB_SERIAL_KEYSPAN_USA28XA=y
CONFIG_USB_SERIAL_KEYSPAN_USA28XB=y
CONFIG_USB_SERIAL_KEYSPAN_USA19=y
CONFIG_USB_SERIAL_KEYSPAN_USA18X=y
CONFIG_USB_SERIAL_KEYSPAN_USA19W=y
CONFIG_USB_SERIAL_KEYSPAN_USA19QW=y
CONFIG_USB_SERIAL_KEYSPAN_USA19QI=y
CONFIG_USB_SERIAL_KEYSPAN_USA49W=y
CONFIG_USB_SERIAL_KEYSPAN_USA49WLC=y
CONFIG_USB_SERIAL_KLSI=m
CONFIG_USB_SERIAL_KOBIL_SCT=m
CONFIG_USB_SERIAL_MCT_U232=m
CONFIG_USB_SERIAL_PL2303=m
CONFIG_USB_SERIAL_HP4X=m
CONFIG_USB_SERIAL_SAFE=m
CONFIG_USB_SERIAL_SAFE_PADDED=y
CONFIG_USB_SERIAL_TI=m
CONFIG_USB_SERIAL_CYBERJACK=m
CONFIG_USB_SERIAL_XIRCOM=m
CONFIG_USB_SERIAL_OPTION=m
CONFIG_USB_SERIAL_OMNINET=m
CONFIG_USB_EZUSB=y

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=m
CONFIG_USB_EMI26=m
CONFIG_USB_AUERSWALD=m
CONFIG_USB_RIO500=m
CONFIG_USB_LEGOTOWER=m
CONFIG_USB_LCD=m
CONFIG_USB_LED=m
CONFIG_USB_CYTHERM=m
CONFIG_USB_PHIDGETKIT=m
CONFIG_USB_PHIDGETSERVO=m
CONFIG_USB_IDMOUSE=m
CONFIG_USB_SISUSBVGA=m
# CONFIG_USB_SISUSBVGA_CON is not set
CONFIG_USB_LD=m
CONFIG_USB_TEST=m

#
# USB DSL modem support
#
CONFIG_USB_ATM=m
CONFIG_USB_SPEEDTOUCH=m
CONFIG_USB_CXACRU=m
CONFIG_USB_UEAGLEATM=m
CONFIG_USB_XUSBATM=m

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# MMC/SD Card support
#
CONFIG_MMC=m
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_BLOCK=m
CONFIG_MMC_WBSD=m

#
# InfiniBand support
#
CONFIG_INFINIBAND=m
CONFIG_INFINIBAND_USER_MAD=m
CONFIG_INFINIBAND_USER_ACCESS=m
CONFIG_INFINIBAND_MTHCA=m
# CONFIG_INFINIBAND_MTHCA_DEBUG is not set
CONFIG_INFINIBAND_IPOIB=m
# CONFIG_INFINIBAND_IPOIB_DEBUG is not set
CONFIG_INFINIBAND_SRP=m

#
# SN Devices
#

#
# File systems
#
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT2_FS_XIP is not set
CONFIG_EXT3_FS=m
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
CONFIG_JBD=m
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=m
# CONFIG_REISERFS_CHECK is not set
CONFIG_REISERFS_PROC_INFO=y
# CONFIG_REISERFS_FS_XATTR is not set
CONFIG_JFS_FS=m
CONFIG_JFS_POSIX_ACL=y
# CONFIG_JFS_SECURITY is not set
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_XFS_FS=m
CONFIG_XFS_EXPORT=y
# CONFIG_XFS_QUOTA is not set
CONFIG_XFS_SECURITY=y
CONFIG_XFS_POSIX_ACL=y
# CONFIG_XFS_RT is not set
CONFIG_OCFS2_FS=m
CONFIG_MINIX_FS=m
CONFIG_ROMFS_FS=m
CONFIG_INOTIFY=y
CONFIG_QUOTA=y
CONFIG_QFMT_V1=m
CONFIG_QFMT_V2=m
CONFIG_QUOTACTL=y
CONFIG_DNOTIFY=y
CONFIG_AUTOFS_FS=m
CONFIG_AUTOFS4_FS=m
CONFIG_FUSE_FS=m

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=m
CONFIG_UDF_FS=m
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_NTFS_FS=m
# CONFIG_NTFS_DEBUG is not set
CONFIG_NTFS_RW=y

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y
CONFIG_RELAYFS_FS=m
CONFIG_CONFIGFS_FS=m

#
# Miscellaneous filesystems
#
CONFIG_ADFS_FS=m
# CONFIG_ADFS_FS_RW is not set
CONFIG_AFFS_FS=m
CONFIG_HFS_FS=m
CONFIG_HFSPLUS_FS=m
CONFIG_BEFS_FS=m
# CONFIG_BEFS_DEBUG is not set
CONFIG_BFS_FS=m
CONFIG_EFS_FS=m
CONFIG_JFFS_FS=m
CONFIG_JFFS_FS_VERBOSE=0
# CONFIG_JFFS_PROC_FS is not set
CONFIG_JFFS2_FS=m
CONFIG_JFFS2_FS_DEBUG=0
CONFIG_JFFS2_FS_WRITEBUFFER=y
# CONFIG_JFFS2_SUMMARY is not set
# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
CONFIG_JFFS2_ZLIB=y
CONFIG_JFFS2_RTIME=y
# CONFIG_JFFS2_RUBIN is not set
CONFIG_CRAMFS=m
CONFIG_VXFS_FS=m
CONFIG_HPFS_FS=m
CONFIG_QNX4FS_FS=m
CONFIG_SYSV_FS=m
CONFIG_UFS_FS=m
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=y
CONFIG_NFS_DIRECTIO=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
# CONFIG_NFSD_V3_ACL is not set
CONFIG_NFSD_V4=y
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=m
CONFIG_SUNRPC_GSS=m
CONFIG_RPCSEC_GSS_KRB5=m
CONFIG_RPCSEC_GSS_SPKM3=m
CONFIG_SMB_FS=m
# CONFIG_SMB_NLS_DEFAULT is not set
CONFIG_CIFS=m
CONFIG_CIFS_STATS=y
# CONFIG_CIFS_STATS2 is not set
# CONFIG_CIFS_XATTR is not set
# CONFIG_CIFS_EXPERIMENTAL is not set
CONFIG_NCP_FS=m
CONFIG_NCPFS_PACKET_SIGNING=y
CONFIG_NCPFS_IOCTL_LOCKING=y
CONFIG_NCPFS_STRONG=y
CONFIG_NCPFS_NFS_NS=y
CONFIG_NCPFS_OS2_NS=y
CONFIG_NCPFS_SMALLDOS=y
CONFIG_NCPFS_NLS=y
CONFIG_NCPFS_EXTRAS=y
CONFIG_CODA_FS=m
# CONFIG_CODA_FS_OLD_API is not set
CONFIG_AFS_FS=m
CONFIG_RXRPC=m
CONFIG_9P_FS=m

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
CONFIG_OSF_PARTITION=y
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
# CONFIG_MINIX_SUBPARTITION is not set
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
# CONFIG_LDM_PARTITION is not set
CONFIG_SGI_PARTITION=y
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=y
# CONFIG_KARMA_PARTITION is not set
# CONFIG_EFI_PARTITION is not set

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_UTF8=m

#
# Instrumentation Support
#
# CONFIG_PROFILING is not set
# CONFIG_KPROBES is not set

#
# Kernel hacking
#
# CONFIG_PRINTK_TIME is not set
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_KERNEL=y
CONFIG_LOG_BUF_SHIFT=14
CONFIG_DETECT_SOFTLOCKUP=y
# CONFIG_SCHEDSTATS is not set
# CONFIG_DEBUG_SLAB is not set
CONFIG_DEBUG_PREEMPT=y
CONFIG_DEBUG_MUTEXES=y
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_HIGHMEM is not set
CONFIG_DEBUG_BUGVERBOSE=y
# CONFIG_DEBUG_INFO is not set
# CONFIG_DEBUG_FS is not set
# CONFIG_DEBUG_VM is not set
# CONFIG_FRAME_POINTER is not set
CONFIG_FORCED_INLINING=y
CONFIG_RCU_TORTURE_TEST=m
CONFIG_EARLY_PRINTK=y
CONFIG_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_DEBUG_RODATA is not set
# CONFIG_4KSTACKS is not set
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_TGR192=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_AES=m
CONFIG_CRYPTO_AES_586=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_CRC32C=m
CONFIG_CRYPTO_TEST=m

#
# Hardware crypto devices
#
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=y

#
# Library routines
#
CONFIG_CRC_CCITT=m
CONFIG_CRC16=m
CONFIG_CRC32=y
CONFIG_LIBCRC32C=m
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_DEC16=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_KTIME_SCALAR=y

