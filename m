Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263894AbTFVIFq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 04:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263898AbTFVIFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 04:05:46 -0400
Received: from ziggy.one-eyed-alien.net ([64.169.228.100]:37380 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S263894AbTFVIFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 04:05:45 -0400
Date: Sun, 22 Jun 2003 01:19:48 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Harald Dunkel <harri@synopsys.COM>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.21: USB Mass Storage data integrity not assured?
Message-ID: <20030622011948.E10803@one-eyed-alien.net>
Mail-Followup-To: Harald Dunkel <harri@synopsys.COM>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3EF556D0.5060900@Synopsys.COM>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="kA1LkgxZ0NN7Mz3A"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3EF556D0.5060900@Synopsys.COM>; from harri@synopsys.COM on Sun, Jun 22, 2003 at 09:12:16AM +0200
Organization: One Eyed Alien Networks
X-Copyright: (C) 2003 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--kA1LkgxZ0NN7Mz3A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

That warning means that if you yank the device at a bad time, you could get
screwed.

Matt

On Sun, Jun 22, 2003 at 09:12:16AM +0200, Harald Dunkel wrote:
> Hi folks,
>=20
> This morning I tried to attach an 2.5" HD via USB2.0 to my Linux box.
> I got a message
>=20
> 	WARNING: USB Mass Storage data integrity not assured
>=20
> in kern.log, followed by billions of IO errors during mkfs.
>=20
>=20
> Well, I need a mass storage whose integrity _is_ assured. Is there
> any hope that ehci and usb-storage get improved for a 2.4.x kernel?
> Any patches I could try?
>=20
>=20
> Regards
>=20
> Harri
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

Stef, you just got beaten by a ball of DIRT.
					-- Greg
User Friendly, 12/7/1997

--kA1LkgxZ0NN7Mz3A
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE+9WakIjReC7bSPZARAnT0AKC2Q60mo7vUgO3EQi1Z3ge/fuK3gwCdEe4I
aCuTTBQ6xYzXQYUH+sIHJVk=
=PwXg
-----END PGP SIGNATURE-----

--kA1LkgxZ0NN7Mz3A--
