Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261951AbVCZEXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbVCZEXq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 23:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261979AbVCZEXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 23:23:46 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:55894 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261951AbVCZEXc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 23:23:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding;
        b=Ii7FQZI3V+GmXLDDQdKG/3UApQ/61OJntJnxp6rceXKVQHZJlp6zNXb6OSwYQ6ZoWOd7cYOvss3zk3QW1sYZ8+BtXm55fpB7g9O9r96YOEaz6GlF9PRwSwpRFC6q3tmxAgfizbE5GRUvfQJzzcGDpd9BSm3AAkqr2JpsXcZm8D4=
Message-ID: <9dda3492050325202371f9a5cd@mail.gmail.com>
Date: Fri, 25 Mar 2005 23:23:32 -0500
From: Paul Blazejowski <diffie@gmail.com>
Reply-To: Paul Blazejowski <diffie@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc1-mm3
Cc: LKML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Something funky going on with ACPI on nForce2? NFS is no go either.

Linux version 2.6.12-rc1-mm3 (root@blaze) (gcc version 3.3.4) #2
PREEMPT Fri Mar 25 14:30:56 EST 2005

[snip ...]

ACPI: Subsystem revision 20050309
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] segment is 0
PCI: nForce2 C1 Halt Disconnect fixup
Boot video device is 0000:03:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Can't get handler for 0000:00:00.1
ACPI: Can't get handler for 0000:00:00.2
ACPI: Can't get handler for 0000:00:00.3
ACPI: Can't get handler for 0000:00:00.4
ACPI: Can't get handler for 0000:00:00.5
ACPI: Can't get handler for 0000:01:0a.0
ACPI: Can't get handler for 0000:01:0b.0
ACPI: Can't get handler for 0000:01:0c.0
ACPI: Can't get handler for 0000:03:00.1
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [APC1] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APC2] (IRQs *17), disabled.
ACPI: PCI Interrupt Link [APC3] (IRQs *18), disabled.
ACPI: PCI Interrupt Link [APC4] (IRQs *19), disabled.
ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCS] (IRQs *23), disabled.
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
ACPI: No ACPI bus support for 00:00
ACPI: No ACPI bus support for 00:01
ACPI: No ACPI bus support for 00:02
ACPI: No ACPI bus support for 00:03
ACPI: No ACPI bus support for 00:04
ACPI: No ACPI bus support for 00:05
ACPI: No ACPI bus support for 00:06
ACPI: No ACPI bus support for 00:07
ACPI: No ACPI bus support for 00:08
ACPI: No ACPI bus support for 00:09
ACPI: No ACPI bus support for 00:0a
ACPI: No ACPI bus support for 00:0b
ACPI: No ACPI bus support for 00:0c
ACPI: No ACPI bus support for 00:0d
pnp: PnP ACPI: found 14 devices
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
pnp: 00:00: ioport range 0x1000-0x107f could not be reserved
pnp: 00:00: ioport range 0x1080-0x10ff has been reserved
pnp: 00:00: ioport range 0x1400-0x147f has been reserved
pnp: 00:00: ioport range 0x1480-0x14ff could not be reserved
pnp: 00:00: ioport range 0x1800-0x187f has been reserved
pnp: 00:00: ioport range 0x1880-0x18ff has been reserved
pnp: 00:01: ioport range 0x1c00-0x1c3f has been reserved
pnp: 00:01: ioport range 0x2000-0x203f has been reserved
ACPI: Power Button (FF) [PWRF]
PNP: PS/2 controller doesn't have AUX irq; using default 0xc
PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 112
ACPI: No ACPI bus support for i8042
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ACPI: No ACPI bus support for serial8250
ACPI: No ACPI bus support for serio0
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ACPI: No ACPI bus support for serio1
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A

[snip ...]

ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ACPI: No ACPI bus support for 0.0
ACPI: No ACPI bus support for 0.1
Probing IDE interface ide1...
hdc: PLEXTOR DVDR PX-716A, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
ACPI: No ACPI bus support for 1.0
ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
ACPI: PCI Interrupt 0000:01:0a.0[A] -> Link [APC3] -> GSI 18 (level,
high) -> IRQ 18
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec 29160 Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

(scsi0:A:4): 20.000MB/s transfers (20.000MHz, offset 16)
(scsi0:A:6): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
  Vendor: PLEXTOR   Model: CD-R   PX-W1210S  Rev: 1.06
  Type:   CD-ROM                             ANSI SCSI revision: 02
ACPI: No ACPI bus support for 0:0:4:0
  Vendor: IBM       Model: DDYS-T36950N      Rev: S80D
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:6:0: Tagged Queuing enabled.  Depth 32
ACPI: No ACPI bus support for 0:0:6:0
ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
ACPI: PCI Interrupt 0000:01:0c.0[A] -> Link [APC2] -> GSI 17 (level,
high) -> IRQ 17
Found Controller: IT8212 UDMA/ATA133 RAID Controller
FindDevices: device 0 is IDE
Channel[0] BM-DMA at 0x9800-0x9807
Channel[1] BM-DMA at 0x9808-0x980F
scsi1 : ITE RAIDExpress133
  Vendor: ITE       Model: IT8212F           Rev: 1.45
  Type:   Direct-Access                      ANSI SCSI revision: 00
ACPI: No ACPI bus support for 1:0:0:0

[snip ...]

ieee1394: Initialized config rom entry `ip1394'
ohci1394: $Rev: 1250 $ Ben Collins <bcollins@debian.org>
ACPI: PCI Interrupt Link [APCM] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:0d.0[A] -> Link [APCM] -> GSI 22 (level,
high) -> IRQ 22
PCI: Setting latency timer of device 0000:00:0d.0 to 64
ACPI: No ACPI bus support for fw-host0
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:02.2[C] -> Link [APCL] -> GSI 22 (level,
high) -> IRQ 22
PCI: Setting latency timer of device 0000:00:02.2 to 64
ehci_hcd 0000:00:02.2: nVidia Corporation nForce2 USB Controller
ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:02.2: irq 22, io mem 0xee083000
PCI: cache line size of 64 is not supported by device 0000:00:02.2
ehci_hcd 0000:00:02.2: park 0
ehci_hcd 0000:00:02.2: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
ACPI: No ACPI bus support for usb1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
ACPI: No ACPI bus support for 1-0:1.0
ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [APCF] enabled at IRQ 21
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [APCF] -> GSI 21 (level,
high) -> IRQ 21
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: nVidia Corporation nForce2 USB Controller
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:02.0: irq 21, io mem 0xee087000
ACPI: No ACPI bus support for usb2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
ACPI: No ACPI bus support for 2-0:1.0
ACPI: PCI Interrupt Link [APCG] enabled at IRQ 20
ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [APCG] -> GSI 20 (level,
high) -> IRQ 20
PCI: Setting latency timer of device 0000:00:02.1 to 64
ohci_hcd 0000:00:02.1: nVidia Corporation nForce2 USB Controller (#2)
ACPI: No ACPI bus support for 8a1cc7ffff0020ed
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[8a1cc7ffff0020ed]
ACPI: No ACPI bus support for 8a1cc7ffff0020ed-0
e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 3
ohci_hcd 0000:00:02.1: irq 20, io mem 0xee082000
ACPI: No ACPI bus support for usb3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 3 ports detected
ACPI: No ACPI bus support for 3-0:1.0
eth1394: $Rev: 1247 $ Ben Collins <bcollins@debian.org>
eth1394: eth2: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
usb 1-3: new high speed USB device using ehci_hcd and address 3
ACPI: No ACPI bus support for 1-3
hub 1-3:1.0: USB hub found
hub 1-3:1.0: 4 ports detected
ACPI: No ACPI bus support for 1-3:1.0
i2c_adapter i2c-4: nForce2 SMBus adapter at 0x1c00
i2c_adapter i2c-5: nForce2 SMBus adapter at 0x2000
eth1: no link during initialization.
usb 2-1: new low speed USB device using ohci_hcd and address 2
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected NVIDIA nForce2 chipset
agpgart: AGP aperture is 128M @ 0xe0000000
ACPI: No ACPI bus support for 2-1
ACPI: No ACPI bus support for 2-1:1.0
usbcore: registered new driver hiddev

[snip ...]
RPC: failed to contact portmap (errno -512).

mount shows

mount -t nfs blazebox:/home/paul /mnt/hd
mount: blazebox:/home/paul: can't read superblock

And the rpcinfo -p on host blazebox [ running FreeBSD 5.3-STABLE ] shows

   program vers proto   port
    100000    4   tcp    111  portmapper
    100000    3   tcp    111  portmapper
    100000    2   tcp    111  portmapper
    100000    4   udp    111  portmapper
    100000    3   udp    111  portmapper
    100000    2   udp    111  portmapper
    100000    4     7    111  portmapper
    100000    3     7    111  portmapper
    100000    2     7    111  portmapper
    100005    1   udp    752  mountd
    100005    3   udp    752  mountd
    100005    1   tcp    666  mountd
    100005    3   tcp    666  mountd
    100003    2   udp   2049  nfs
    100003    3   udp   2049  nfs
    100003    2   tcp   2049  nfs
    100003    3   tcp   2049  nfs
    100021    0   udp    751  nlockmgr
    100021    1   udp    751  nlockmgr
    100021    3   udp    751  nlockmgr
    100021    4   udp    751  nlockmgr
    100021    0   tcp    965  nlockmgr
    100021    1   tcp    965  nlockmgr
    100021    3   tcp    965  nlockmgr
    100021    4   tcp    965  nlockmgr
    100024    1   udp    879  status
    100024    1   tcp    645  status

Trond has helped me before with debugging NFS

-- 
FreeBSD the Power to Serve!
