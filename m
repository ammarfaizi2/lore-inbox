Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261934AbULGU75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261934AbULGU75 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 15:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261936AbULGU75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 15:59:57 -0500
Received: from mail.gmx.de ([213.165.64.20]:47758 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261934AbULGU7s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 15:59:48 -0500
X-Authenticated: #3340650
Subject: Re: [<02282da7>] (usb_hcd_irq+0x0/0x4b) Disabling IRQ #5 - USB
	Devices
From: Florian Krammel <florian_kr@gmx.de>
To: Kernel-list <linux-kernel@vger.kernel.org>
In-Reply-To: <1102451337.7531.24.camel@orange-bud>
References: <200412062027.33561.david-b@pacbell.net>
	 <1102451337.7531.24.camel@orange-bud>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-G+XeO92+l6dYBstbWUTQ"
Date: Tue, 07 Dec 2004 21:50:42 +0100
Message-Id: <1102452642.7531.27.camel@orange-bud>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-G+XeO92+l6dYBstbWUTQ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> > As a rule, Linux will be happier without it.
> > Why do you want to enable it?
>=20

maybe I don't need it but I want a OS wich is 100% compatible to my
hardware and it's configuration.


> > Have you tried adding "usb-handoff" to your
> > kernel command line?  That was added specifically
> > to help work around BIOS bugs like those you've
> > run into ...
>=20

"irqpoll" as boot parameter solved my problem. I can try your solution,
too.


> > As a rule, if BIOS bugs affect XP I'd not be surprised
> > if to find them affecting Linux too.

therefore I updated my BIOS allready ;)


> > That was interesting ... not directly related to USB,
> > looks like maybe the "legacy" support didn't work
> > very well either; maybe that's what the BIOS update
> > was solving.

this was not solved by the BIOS update. This takes only affect if the
mouse is not connected to the PS/2 port. 1st my mouse was connected with
the USB port and I connected it via an adapter to the PS/2 port, because
X wthout mouse is futile, and this problem was solved.

mfg
flo
--=20
Florian Krammel <florian_kr@gmx.de>

--=-G+XeO92+l6dYBstbWUTQ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBtheim9XQAcbR/eIRAngeAJ9MQ1CQvot8EPBitzox8tSdl1WlGACeMXA3
RvSkBCGcj5U3iq8ZWUGMJys=
=mNB0
-----END PGP SIGNATURE-----

--=-G+XeO92+l6dYBstbWUTQ--

