Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272045AbTGYMgN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 08:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272047AbTGYMgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 08:36:13 -0400
Received: from noose.gt.owl.de ([62.52.19.4]:6673 "EHLO noose.gt.owl.de")
	by vger.kernel.org with ESMTP id S272045AbTGYMfr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 08:35:47 -0400
Date: Fri, 25 Jul 2003 14:40:10 +0200
From: Florian Lohoff <flo@rfc822.org>
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.21] bluez/usb-ohci bulk_msg timeout
Message-ID: <20030725124010.GA910@paradigm.rfc822.org>
References: <5.1.0.14.2.20030721100313.0759df08@unixmail.qualcomm.com> <20030718173214.GD15430@paradigm.rfc822.org> <5.1.0.14.2.20030721100313.0759df08@unixmail.qualcomm.com> <5.1.0.14.2.20030723140628.096fcbe0@unixmail.qualcomm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20030723140628.096fcbe0@unixmail.qualcomm.com>
Organization: rfc822 - pure communication
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2003 at 02:08:25PM -0700, Max Krasnyansky wrote:
> Probably. Could try the prev revision of the HCI USB driver though. ie Th=
e one without SCO
> support. Just copy hci_usb.[ch] over from older kernel and see if it work=
s with newer OHCI.

I tried the ones from 2.4.20 and the same error messages appear - So i
think its the OHCI stuff - It got a some major changes it seems from the
2.4.21 patch ...

Linux version 2.4.21-vaio3 (root@paradigm) (gcc version 2.95.4 20011002 (De=
bian prerelease)) #1 Fri Jul 25 13:12:06 CEST 2003

[...]

hub.c: new USB device 00:0f.0-2, assigned address 3
usb.c: USB device 3 (vend/prod 0x44e/0x3001) is not claimed by any active d=
river.
usb_control/bulk_msg: timeout
usbdevfs: USBDEVFS_CONTROL failed dev 3 rqt 128 rq 6 len 9 ret -110
BlueZ Core ver 2.3 Copyright (C) 2000,2001 Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
BlueZ HCI USB driver ver 2.1 Copyright (C) 2000,2001 Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
usb.c: registered new driver hci_usb
usb_control/bulk_msg: timeout
usbdevfs: USBDEVFS_CONTROL failed dev 3 rqt 128 rq 6 len 193 ret -110
usb_control/bulk_msg: timeout
usbdevfs: USBDEVFS_CONTROL failed dev 3 rqt 128 rq 6 len 193 ret -110
usb_control/bulk_msg: timeout
usbdevfs: USBDEVFS_CONTROL failed dev 3 rqt 128 rq 6 len 9 ret -110
BlueZ RFCOMM ver 1.0
Copyright (C) 2002 Maxim Krasnyansky <maxk@qualcomm.com>
Copyright (C) 2002 Marcel Holtmann <marcel@holtmann.org>
usbdevfs: USBDEVFS_CONTROL failed dev 3 rqt 128 rq 6 len 9 ret -75
BlueZ L2CAP ver 2.3 Copyright (C) 2000,2001 Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
CSLIP: code copyright 1989 Regents of the University of California
PPP generic driver version 2.4.2

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-171-2280134
                        Heisenberg may have been here.

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/ISUpUaz2rXW+gJcRAtbEAJ4gkXWyNz1Lkpu3ZRyP3LmVlPBmLACffDgJ
8acGbrnKshAmCx/g6BoCDC4=
=G+bp
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
