Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264359AbTCXSve>; Mon, 24 Mar 2003 13:51:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264358AbTCXSve>; Mon, 24 Mar 2003 13:51:34 -0500
Received: from cpt-dial-196-30-179-112.mweb.co.za ([196.30.179.112]:9344 "EHLO
	nosferatu.lan") by vger.kernel.org with ESMTP id <S264359AbTCXSv0>;
	Mon, 24 Mar 2003 13:51:26 -0500
Subject: Re: Failed to register cdrom with ide.c
From: Martin Schlemmer <azarah@gentoo.org>
Reply-To: azarah@gentoo.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: KML <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@brodo.de>
In-Reply-To: <1048431682.6855.10.camel@nosferatu.lan>
References: <20030319211837.GA23651@brodo.de>
	 <1048146514.12350.43.camel@workshop.saharact.lan>
	 <20030320084148.GA2414@brodo.de>
	 <20030322131503.254c2aa7.azarah@gentoo.org>
	 <20030323090152.GA1113@brodo.de>  <1048431682.6855.10.camel@nosferatu.lan>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ylXCqcLO8IYyIB/pgkG5"
Organization: 
Message-Id: <1048532122.4150.1.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3- 
Date: 24 Mar 2003 20:55:22 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ylXCqcLO8IYyIB/pgkG5
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-03-23 at 17:01, Martin Schlemmer wrote:
> Hi
>=20
> I am sure somebody else had this issue, but I cannot find it now
> by browsing the online lists (subscribed at work only).
>=20
> Up to and with 2.5.65, the kernel boots fine, but with the new
> ide stuff merged, my Toshiba DVD do not register with ide.c, and I
> get a kernel panic.  This is with bk3, and -ac3.  If I unplug the
> drive, the kernel boots fine.
>=20
> Attached is relevant part of ide initialization from kernel logs.
> It is however from 2.5.64.  If you need from 2.5.65-ac3, let me
> know ... its just going to be difficult as I only have this box
> and a screen less gateway.
>=20

Dominik's patch fixed it for me as well, thanks!


Regards,

--=20

Martin Schlemmer




--=-ylXCqcLO8IYyIB/pgkG5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+f1SaqburzKaJYLYRAt/1AJ4yD64CPcO1UqaZ1FOWCdjfzYRpNwCfU5WT
zdQTErZtfhKw+3f3GqM84AQ=
=xZn8
-----END PGP SIGNATURE-----

--=-ylXCqcLO8IYyIB/pgkG5--

