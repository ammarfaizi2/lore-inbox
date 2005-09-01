Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030227AbVIAQYR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030227AbVIAQYR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 12:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030226AbVIAQYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 12:24:17 -0400
Received: from mail.gmx.de ([213.165.64.20]:63686 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030227AbVIAQYQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 12:24:16 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: "John Stoffel" <john@stoffel.org>
Subject: Re: 2.6.13-mm1
Date: Thu, 1 Sep 2005 18:28:05 +0200
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050901035542.1c621af6.akpm@osdl.org> <200509011738.45821.dominik.karall@gmx.net> <17175.10191.634957.119742@smtp.charter.net>
In-Reply-To: <17175.10191.634957.119742@smtp.charter.net>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1148390.kEFW5UgY5I";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200509011828.13579.dominik.karall@gmx.net>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1148390.kEFW5UgY5I
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 01 September 2005 18:09, John Stoffel wrote:
> >>>>> "Dominik" =3D=3D Dominik Karall <dominik.karall@gmx.net> writes:
>
> Dominik> When I switch on my external harddisk, which is connected
> Dominik> through usb, the kernel hangs. First time I did that at
> Dominik> bootup there were a lot of backtraces printed on the screen
> Dominik> but they did not find the way in the logfile :/ Now I
> Dominik> switched the drive on while running and everything freezes
> Dominik> after those messages:
>
> Dominik> usb 1-2.2: new high speed USB device using ehci_hcd and address 3
> Dominik> scsi2 : SCSI emulation for USB Mass Storage devices
> Dominik> usb-storage: device found at 3
> Dominik> usb-storage: waiting for device to settle before scanning
> Dominik>   Vendor: ST325082  Model: 3A                Rev: 3.02
> Dominik>   Type:   Direct-Access                      ANSI SCSI revision:
> 00 Dominik> SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
> Dominik> sda: assuming drive cache: write through
> Dominik> SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
> Dominik> sda: assuming drive cache: write through
>
> Have you updated the firmware on the USB enclosure?  I have one using
> the Prolific chipset for both USB/Firewire and it was crappy until I
> upgraded the firmware on there.  It made all the difference.
>
> Also, can you use this USB enclosure on Windows or another computer?
> And which kernel version are you running?  It's not clear if your on
> 2.6.13-mm1 or some other version.

2.6.13-mm1, as mentioned in subject.
The external hdd worked with 2.6.13-rc6-mm1 and 2.6.13-ck1, which were the=
=20
last versions I ran. Didn't test 2.6.13-rc6-mm2.

> More details would be good too, such as:
>
> 	lsusb

Bus 001 Device 004: ID 0840:009c Argosy Research, Inc.
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0        64
  idVendor           0x0840 Argosy Research, Inc.
  idProduct          0x009c
  bcdDevice            0.01
  iManufacturer           1 Generic
  iProduct                2 USB 2.0 Mass Storage Device
  iSerial                 3 009C0000000049BD
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           32
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xc0
      Self Powered
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass         8 Mass Storage
      bInterfaceSubClass      6 SCSI
      bInterfaceProtocol     80 Bulk (Zip)
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
Device Qualifier (for other device speed):
  bLength                10
  bDescriptorType         6
  bcdUSB               2.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0        64
  bNumConfigurations      1


dominik

--nextPart1148390.kEFW5UgY5I
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2-ecc0.1.6 (GNU/Linux)

iQCVAwUAQxcsHQvcoSHvsHMnAQIYpgP/WucHP7GJSf+4oCjpuvh/CnpBQegIQ3qK
aeNMTvi1pWRXcMHN5LsfyQYKmVKzeP+Lr9recEO2V9E5caXR3J8Mbb8AJCBD7GGB
gDPUqsVaippRz+JiZv8fkDaudzGHuLXq/uevOsqRtrf6xQUigFroVeQNyoM9k7VJ
1XuOIH72xfk=
=e4qB
-----END PGP SIGNATURE-----

--nextPart1148390.kEFW5UgY5I--
