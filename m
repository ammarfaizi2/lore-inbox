Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263452AbTL2MxR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 07:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263463AbTL2MxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 07:53:16 -0500
Received: from mx1.redhat.com ([66.187.233.31]:16286 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263452AbTL2MxF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 07:53:05 -0500
Date: Mon, 29 Dec 2003 13:52:56 +0100
From: Arjan van de Ven <arjanv@redhat.com>
To: Frank van Maarseveen <frankvm@xs4all.nl>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.23 can run with HZ==0!
Message-ID: <20031229125256.GA28065@devserv.devel.redhat.com>
References: <20031228230522.GA1876@janus> <1072691126.5223.5.camel@laptop.fenrus.com> <20031229125240.GA4055@janus>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
In-Reply-To: <20031229125240.GA4055@janus>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 29, 2003 at 01:52:40PM +0100, Frank van Maarseveen wrote:
> On Mon, Dec 29, 2003 at 10:45:27AM +0100, Arjan van de Ven wrote:
> >=20
> > not all motherboards can deal with HZ=3D1000.... seems yours is one of
> > thise.
>=20
> But it seems to work. I would expect it to fail quite soon right at or af=
ter
> boot, not after a day once every few weeks (assuming it was the cause).
>=20
> > your patch is *highly* inadequate to get HZ=3D1000 working well in 2.4.=
...
> > it needs to be about 10x bigger with fixing more userspace api's...
>=20
> Can you give me an example?
>=20
> HZ for x386 is 100 by definition and there aren't that many system calls
> and /proc files which expose jiffies to userspace.

there are quite a few you missed; scsi ioctls is one, firewall rules are
another.... there's a long list (2.6 has most if not all of them fixed)

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/8COnxULwo51rQBIRAoReAJ9WtrK4Rmt+Ej9CzRF0Zn37AW75XwCgh1vU
M5dtULSJ2o3CNQgU2QepvP4=
=KeKe
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
