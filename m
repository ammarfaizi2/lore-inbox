Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268844AbUIQSCu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268844AbUIQSCu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 14:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268904AbUIQSCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 14:02:50 -0400
Received: from pop.gmx.de ([213.165.64.20]:166 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S268844AbUIQSC3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 14:02:29 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.9-rc2-mm1
Date: Fri, 17 Sep 2004 20:09:44 +0200
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <20040916024020.0c88586d.akpm@osdl.org>
In-Reply-To: <20040916024020.0c88586d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1317878.4RofZxgCDu";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200409172009.47617.dominik.karall@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1317878.4RofZxgCDu
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 16 September 2004 11:40, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc2/2=
=2E6
>.9-rc2-mm1/

I get a lot of usb error messages on boot, here the relevant dmesg output.
I also attached lsusb -v output, which maybe useful, if you need more=20
information, let me know!

mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
input: PC Speaker
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
IPv4 over IPv4 tunneling driver
GRE over IPv4 tunneling driver
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S3 S4 S5)
ACPI wakeup devices:=20
=46UTS PCI0 USB0 USB1 USB2 USB3 MAC0 AMR0 UAR1 PS2M PS2K=20
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
=46reeing unused kernel memory: 136k freed
Adding 514040k swap on /dev/hda9.  Priority:-1 extents:1
EXT3 FS on hda10, internal journal
warning: process `update' used the obsolete bdflush system call
=46ix your initscripts?
ohci1394: $Rev: 1226 $ Ben Collins <bcollins@debian.org>
ACPI: PCI interrupt 0000:00:02.3[B] -> GSI 17 (level, low) -> IRQ 17
ohci1394: fw-host0: Unexpected PCI resource length of 1000!
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=3D[17]  MMIO=3D[e2427000-e2427=
7ff] =20
Max Packet=3D[2048]
snd: Unknown parameter `device_gid'
ACPI: PCI interrupt 0000:00:02.7[C] -> GSI 18 (level, low) -> IRQ 18
intel8x0_measure_ac97_clock: measured 49665 usecs
intel8x0: clocking to 48000
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI interrupt 0000:00:03.0[A] -> GSI 20 (level, low) -> IRQ 20
ohci_hcd 0000:00:03.0: Silicon Integrated Systems [SiS] USB 1.0 Controller
ohci_hcd 0000:00:03.0: irq 20, pci mem 0xe2420000
ohci_hcd 0000:00:03.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:03.0: SiS init quirk
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:03.1[B] -> GSI 21 (level, low) -> IRQ 21
ohci_hcd 0000:00:03.1: Silicon Integrated Systems [SiS] USB 1.0 Controller=
=20
(#2)
ohci_hcd 0000:00:03.1: irq 21, pci mem 0xe2421000
ohci_hcd 0000:00:03.1: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:03.1: SiS init quirk
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:03.2[C] -> GSI 22 (level, low) -> IRQ 22
ohci_hcd 0000:00:03.2: Silicon Integrated Systems [SiS] USB 1.0 Controller=
=20
(#3)
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[000010dc001ee09a]
ohci_hcd 0000:00:03.2: irq 22, pci mem 0xe2422000
ohci_hcd 0000:00:03.2: new USB bus registered, assigned bus number 3
ohci_hcd 0000:00:03.2: SiS init quirk
usb 2-1: new full speed USB device using address 2
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:03.3[D] -> GSI 23 (level, low) -> IRQ 23
ehci_hcd 0000:00:03.3: Silicon Integrated Systems [SiS] USB 2.0 Controller
ehci_hcd 0000:00:03.3: irq 23, pci mem 0xe2423000
ehci_hcd 0000:00:03.3: new USB bus registered, assigned bus number 4
PCI: cache line size of 128 is not supported by device 0000:00:03.3
ehci_hcd 0000:00:03.3: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
usb 2-1: USB disconnect, address 2
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 6 ports detected
ohci_hcd 0000:00:03.1: wakeup
sis900.c: v1.08.07 11/02/2003
ACPI: PCI interrupt 0000:00:04.0[A] -> GSI 19 (level, low) -> IRQ 19
eth0: Unknown PHY transceiver found at address 0.
eth0: Realtek RTL8201 PHY transceiver found at address 1.
eth0: Unknown PHY transceiver found at address 2.
eth0: Unknown PHY transceiver found at address 3.
eth0: Unknown PHY transceiver found at address 4.
eth0: Unknown PHY transceiver found at address 5.
eth0: Unknown PHY transceiver found at address 6.
eth0: Unknown PHY transceiver found at address 7.
eth0: Unknown PHY transceiver found at address 8.
eth0: Unknown PHY transceiver found at address 9.
eth0: Unknown PHY transceiver found at address 10.
eth0: Unknown PHY transceiver found at address 11.
eth0: Unknown PHY transceiver found at address 12.
eth0: Unknown PHY transceiver found at address 13.
eth0: Unknown PHY transceiver found at address 14.
eth0: Unknown PHY transceiver found at address 15.
eth0: Unknown PHY transceiver found at address 16.
eth0: Unknown PHY transceiver found at address 17.
eth0: Unknown PHY transceiver found at address 18.
eth0: Unknown PHY transceiver found at address 19.
eth0: Unknown PHY transceiver found at address 20.
eth0: Unknown PHY transceiver found at address 21.
eth0: Unknown PHY transceiver found at address 22.
eth0: Unknown PHY transceiver found at address 23.
eth0: Unknown PHY transceiver found at address 24.
eth0: Unknown PHY transceiver found at address 25.
usb 2-1: new full speed USB device using address 3
eth0: Unknown PHY transceiver found at address 26.
eth0: Unknown PHY transceiver found at address 27.
eth0: Unknown PHY transceiver found at address 28.
eth0: Unknown PHY transceiver found at address 29.
eth0: Unknown PHY transceiver found at address 30.
eth0: Unknown PHY transceiver found at address 31.
eth0: Using transceiver found at address 1 as default
eth0: SiS 900 PCI Fast Ethernet at 0xdc00, IRQ 19, 00:10:fa:3f:29:16.
8139too Fast Ethernet driver 0.9.27
ACPI: PCI interrupt 0000:00:07.0[A] -> GSI 18 (level, low) -> IRQ 18
eth1: RealTek RTL8139 at 0xd134a000, 00:50:fc:2d:9a:5c, IRQ 18
eth1:  Identified 8139 chip type 'RTL-8139C'
usb usb3: string descriptor 0 read error: -113
usb usb3: string descriptor 0 read error: -113
usb usb3: string descriptor 0 read error: -113
usb 2-1: control timeout on ep0in
usb 2-1: string descriptor 0 read error: -110
usb 2-1: string descriptor 0 read error: -110
usb 2-1: string descriptor 0 read error: -110
usb usb1: string descriptor 0 read error: -113
usb usb1: string descriptor 0 read error: -113
usb usb1: string descriptor 0 read error: -113
eth0: Media Link On 100mbps full-duplex=20
eth0: Media Link On 100mbps full-duplex=20
usb usb3: string descriptor 0 read error: -113
usb usb3: string descriptor 0 read error: -113
usb usb3: string descriptor 0 read error: -113
usb 2-1: string descriptor 0 read error: -110
usb 2-1: string descriptor 0 read error: -110
usb 2-1: string descriptor 0 read error: -110
usb usb1: string descriptor 0 read error: -113
usb usb1: string descriptor 0 read error: -113
usb usb1: string descriptor 0 read error: -113
usb usb3: string descriptor 0 read error: -113
usb usb3: string descriptor 0 read error: -113
usb usb3: string descriptor 0 read error: -113
usb 2-1: string descriptor 0 read error: -110
usb 2-1: string descriptor 0 read error: -110
usb 2-1: string descriptor 0 read error: -110
usb usb1: string descriptor 0 read error: -113
usb usb1: string descriptor 0 read error: -113
usb usb1: string descriptor 0 read error: -113
usb usb3: string descriptor 0 read error: -113
usb usb3: string descriptor 0 read error: -113
usb usb3: string descriptor 0 read error: -113
usb 2-1: string descriptor 0 read error: -110
usb 2-1: string descriptor 0 read error: -110
usb 2-1: string descriptor 0 read error: -110
usb usb1: string descriptor 0 read error: -113
usb usb1: string descriptor 0 read error: -113
usb usb1: string descriptor 0 read error: -113
usb usb3: string descriptor 0 read error: -113
usb usb3: string descriptor 0 read error: -113
usb usb3: string descriptor 0 read error: -113
usb 2-1: string descriptor 0 read error: -110
usb 2-1: string descriptor 0 read error: -110
usb 2-1: string descriptor 0 read error: -110
usb usb1: string descriptor 0 read error: -113
usb usb1: string descriptor 0 read error: -113
usb usb1: string descriptor 0 read error: -113


lsusb -v:

Bus 004 Device 001: ID 0000:0000
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         1 Single TT
  bMaxPacketSize0         8
  idVendor           0x0000
  idProduct          0x0000
  bcdDevice            2.06
  iManufacturer           3 Linux 2.6.8.1-ck8 ehci_hcd
  iProduct                2 Silicon Integrated Systems [SiS] USB 2.0=20
Controller
  iSerial                 1 0000:00:03.3
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0002  bytes 2 twice
        bInterval              12

Bus 003 Device 001: ID 0000:0000
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         0
  bMaxPacketSize0         8
  idVendor           0x0000
  idProduct          0x0000
  bcdDevice            2.06
  iManufacturer           3 Linux 2.6.8.1-ck8 ohci_hcd
  iProduct                2 Silicon Integrated Systems [SiS] USB 1.0=20
Controller(#3)
  iSerial                 1 0000:00:03.2
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xc0
      Self Powered
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0002  bytes 2 twice
        bInterval             255

Bus 002 Device 003: ID 0db0:6982 Micro Star International Medion Flash XL=20
V2.7ACard Reader
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0         8
  idVendor           0x0db0 Micro Star International
  idProduct          0x6982 Medion Flash XL V2.7A Card Reader
  bcdDevice            2.6d
  iManufacturer           1
  iProduct                2
  iSerial                 3
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           39
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          4
    bmAttributes         0x80
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           3
      bInterfaceClass         8 Mass Storage
      bInterfaceSubClass      6 SCSI
      bInterfaceProtocol     80 Bulk (Zip)
      iInterface              5
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  bytes 64 once
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  bytes 64 once
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0008  bytes 8 once
        bInterval              10

Bus 002 Device 001: ID 0000:0000
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         0
  bMaxPacketSize0         8
  idVendor           0x0000
  idProduct          0x0000
  bcdDevice            2.06
  iManufacturer           3 Linux 2.6.8.1-ck8 ohci_hcd
  iProduct                2 Silicon Integrated Systems [SiS] USB 1.0=20
Controller(#2)
  iSerial                 1 0000:00:03.1
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xc0
      Self Powered
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0002  bytes 2 twice
        bInterval             255

Bus 001 Device 001: ID 0000:0000
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         0
  bMaxPacketSize0         8
  idVendor           0x0000
  idProduct          0x0000
  bcdDevice            2.06
  iManufacturer           3 Linux 2.6.8.1-ck8 ohci_hcd
  iProduct                2 Silicon Integrated Systems [SiS] USB 1.0=20
Controller
  iSerial                 1 0000:00:03.0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xc0
      Self Powered
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0002  bytes 2 twice
        bInterval             255

--nextPart1317878.4RofZxgCDu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iQCVAwUAQUsoawvcoSHvsHMnAQJgAAP/Xf06CUdO0mQxrddiOH+pMiLgmdPprQ7b
DvEMd7R+35+Ye5iNtptpLlDZOUh/pAS+mgo1jmbdGwymvFY62Eol7itGSfMijlQf
tYCNFVZsyZBkDR/m3UgYo2JhUEWU3A14LUnaAqnHTA87E99V8YBEtmNLxXOjOUr3
H/HC7G2MpEU=
=AsTV
-----END PGP SIGNATURE-----

--nextPart1317878.4RofZxgCDu--
