Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270248AbTGRRR2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 13:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270250AbTGRRR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 13:17:28 -0400
Received: from noose.gt.owl.de ([62.52.19.4]:26121 "EHLO noose.gt.owl.de")
	by vger.kernel.org with ESMTP id S270248AbTGRRRX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 13:17:23 -0400
Date: Fri, 18 Jul 2003 19:32:14 +0200
From: Florian Lohoff <flo@rfc822.org>
To: linux-kernel@vger.kernel.org
Subject: [2.4.21] bluez/usb-ohci bulk_msg timeout
Message-ID: <20030718173214.GD15430@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8w3uRX/HFJGApMzv"
Content-Disposition: inline
Organization: rfc822 - pure communication
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8w3uRX/HFJGApMzv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,
since 2.4.21 + mh2 bluez patch i am seeing these errors. 2.4.20 + mh7
bluez patch did not show these errors. Results are very instable
Bluetooth connections.

[...]
ohci1394: $Rev: 896 $ Ben Collins <bcollins@debian.org>
ohci1394_0: OHCI-1394 1.1 (PCI): IRQ=3D3D[9]  MMIO=3D3D[e8102000-e81027ff] =
 Max=3D
 Packet=3D3D[2048]
ieee1394: Host added: Node[00:1023]  GUID[0800460300de6e57]  [Linux OHCI-13=
=3D
94]
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
PCI: Enabling device 00:0f.0 (0010 -> 0012)
usb-ohci.c: USB OHCI at membase 0xd007b000, IRQ 9
usb-ohci.c: usb-00:0f.0, ALi Corporation. [ALi] USB 1.1 Controller
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb-ohci.c: USB OHCI at membase 0xc00e0000, IRQ 9
usb-ohci.c: usb-00:14.0, ALi Corporation. [ALi] USB 1.1 Controller (#2)
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: new USB device 00:0f.0-1, assigned address 2
usb.c: USB device 2 (vend/prod 0x54c/0x69) is not claimed by any active dri=
=3D
ver.

[...]
hub.c: new USB device 00:0f.0-2, assigned address 3
usb.c: USB device 3 (vend/prod 0x44e/0x3001) is not claimed by any active d=
=3D
river.
usb_control/bulk_msg: timeout
usbdevfs: USBDEVFS_CONTROL failed dev 3 rqt 128 rq 6 len 9 ret -110
usbdevfs: USBDEVFS_CONTROL failed dev 3 rqt 128 rq 6 len 9 ret -75
usb_control/bulk_msg: timeout
usbdevfs: USBDEVFS_CONTROL failed dev 3 rqt 128 rq 6 len 193 ret -110
usb_control/bulk_msg: timeout
usbdevfs: USBDEVFS_CONTROL failed dev 3 rqt 128 rq 6 len 49 ret -110
usbdevfs: USBDEVFS_CONTROL failed dev 3 rqt 128 rq 6 len 9 ret -75
usb_control/bulk_msg: timeout
usbdevfs: USBDEVFS_CONTROL failed dev 3 rqt 128 rq 6 len 49 ret -110
usb_control/bulk_msg: timeout
usbdevfs: USBDEVFS_CONTROL failed dev 3 rqt 128 rq 6 len 9 ret -110
usbdevfs: USBDEVFS_CONTROL failed dev 3 rqt 128 rq 6 len 9 ret -75
usb_control/bulk_msg: timeout
usbdevfs: USBDEVFS_CONTROL failed dev 3 rqt 128 rq 6 len 9 ret -110
eth1: New link status: AP Changed (0003)
usb.c: USB disconnect on device 00:0f.0-2 address 3

[ ... retry ... ]

hub.c: new USB device 00:0f.0-2, assigned address 4
usb.c: USB device 4 (vend/prod 0x44e/0x3001) is not claimed by any active d=
=3D
river.
usb_control/bulk_msg: timeout
usbdevfs: USBDEVFS_CONTROL failed dev 4 rqt 128 rq 6 len 193 ret -110
usbdevfs: USBDEVFS_CONTROL failed dev 4 rqt 128 rq 6 len 9 ret -75
usb_control/bulk_msg: timeout
usbdevfs: USBDEVFS_CONTROL failed dev 4 rqt 128 rq 6 len 193 ret -110
usbdevfs: USBDEVFS_CONTROL failed dev 4 rqt 128 rq 6 len 18 ret -75
usbdevfs: USBDEVFS_CONTROL failed dev 4 rqt 128 rq 6 len 18 ret -75
usb_control/bulk_msg: timeout
usbdevfs: USBDEVFS_CONTROL failed dev 4 rqt 128 rq 6 len 18 ret -110
BlueZ Core ver 2.3 Copyright (C) 2000,2001 Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
BlueZ HCI USB driver ver 2.4 Copyright (C) 2000,2001 Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
usb.c: registered new driver hci_usb
BlueZ RFCOMM ver 1.0
Copyright (C) 2002 Maxim Krasnyansky <maxk@qualcomm.com>
Copyright (C) 2002 Marcel Holtmann <marcel@holtmann.org>
BlueZ L2CAP ver 2.3 Copyright (C) 2000,2001 Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
usb.c: USB disconnect on device 00:0f.0-2 address 4

[ ... retry ... ]

hub.c: new USB device 00:0f.0-2, assigned address 5
usb_control/bulk_msg: timeout
usbdevfs: USBDEVFS_CONTROL failed dev 5 rqt 128 rq 6 len 9 ret -110
usbdevfs: USBDEVFS_CONTROL failed dev 5 rqt 128 rq 6 len 9 ret -75
usb_control/bulk_msg: timeout
usbdevfs: USBDEVFS_CONTROL failed dev 5 rqt 128 rq 6 len 193 ret -110
usbdevfs: USBDEVFS_CONTROL failed dev 5 rqt 128 rq 6 len 18 ret -75
usbdevfs: USBDEVFS_CONTROL failed dev 5 rqt 128 rq 6 len 18 ret -75
usb_control/bulk_msg: timeout
usbdevfs: USBDEVFS_CONTROL failed dev 5 rqt 128 rq 6 len 9 ret -110



Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-171-2280134
                        Heisenberg may have been here.

--8w3uRX/HFJGApMzv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/GC8eUaz2rXW+gJcRAqECAJ43NVHkDk/LNvoBy0bcETfcFzSTvgCg2vhf
rGM5fH8+VdG9C5xjmkOwmqI=
=Wd2f
-----END PGP SIGNATURE-----

--8w3uRX/HFJGApMzv--
