Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270335AbTGWOFo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 10:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270346AbTGWOFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 10:05:44 -0400
Received: from noose.gt.owl.de ([62.52.19.4]:31496 "EHLO noose.gt.owl.de")
	by vger.kernel.org with ESMTP id S270335AbTGWOFd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 10:05:33 -0400
Date: Wed, 23 Jul 2003 16:20:35 +0200
From: Florian Lohoff <flo@rfc822.org>
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.21] bluez/usb-ohci bulk_msg timeout
Message-ID: <20030723142035.GA956@paradigm.rfc822.org>
References: <20030718173214.GD15430@paradigm.rfc822.org> <5.1.0.14.2.20030721100313.0759df08@unixmail.qualcomm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20030721100313.0759df08@unixmail.qualcomm.com>
Organization: rfc822 - pure communication
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2003 at 10:06:19AM -0700, Max Krasnyansky wrote:
> At 10:32 AM 7/18/2003, Florian Lohoff wrote:
>=20
> >Hi,
> >since 2.4.21 + mh2 bluez patch i am seeing these errors. 2.4.20 + mh7
> >bluez patch did not show these errors. Results are very instable
> >Bluetooth connections.
> Those errors don't seem to be related to the driver update. But you could
> try this. In drivers/bluetooth/hci_usb.h set HCI_MAX_BULK_TX define to 1 =
(instead of 4)
> and rebuild the module. Does it make any difference ?

Doesnt help at all - So the OHCI changes are to blame ?

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-171-2280134
                        Heisenberg may have been here.

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/HpmzUaz2rXW+gJcRAqXLAKDkIX9eQq/iNMmXru2I5K9tUJijdgCfebKN
4cg0+3SAYqCMvutre/AKJYk=
=+cs6
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
