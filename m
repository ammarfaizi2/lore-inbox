Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261547AbREUOQl>; Mon, 21 May 2001 10:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261550AbREUOQb>; Mon, 21 May 2001 10:16:31 -0400
Received: from lenka.ph.ipex.cz ([212.71.128.11]:772 "EHLO lenka.ph.ipex.cz")
	by vger.kernel.org with ESMTP id <S261547AbREUOQQ>;
	Mon, 21 May 2001 10:16:16 -0400
Date: Mon, 21 May 2001 16:17:25 +0200
From: Robert Vojta <vojta@ipex.cz>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 3c905C-TX [Fast Etherlink] problem ...
Message-ID: <20010521161724.G8397@ipex.cz>
In-Reply-To: <20010521090946.D769@ipex.cz> <3B08C15E.264AE074@uow.edu.au>, <3B08C15E.264AE074@uow.edu.au> <20010521140443.C8397@ipex.cz> <3B090645.9D54574F@uow.edu.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="udcq9yAoWb9A4FsZ"
Content-Disposition: inline
In-Reply-To: <3B090645.9D54574F@uow.edu.au>
User-Agent: Mutt/1.3.18i
X-Telephone: +420 603 167 911
X-Company: IPEX, s.r.o.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--udcq9yAoWb9A4FsZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> mm..  It _should_ autonegotiate.  Perhaps the device at
> the other end is old or not very good.

Hi,
  it should but do not autonegotiating. All computers are connected to swit=
ch
CentreCOM FH716SW and there are several types of cards on this computers
like 3COM Tornado, 8139 chip, NE2000, etc.

> http://www.scyld.com/network/vortex.html is the official
> place.  It doesn't tell you much.
>=20
> vortex.txt has a pointer to 3com's documentation. Heavy
> going.
>=20
> When the NIC is running in full-duplex mode it *assumes*
> that once (by default) 128 bytes of a frame have gone
> onto the wire, the remainder of the frame will be sent
> without any collisions.  This assumption allows it to reuse
> part on the on-board memory - it transfers more data from
> the host into the place where the currently-transmitting
> frame used to reside.
>=20
> If another host then comes along and generates a collision
> this late into the frame, the NIC detects it but cannot
> back off and retransmit the frame as it would normally do.
> Because the frame's memory has been "reclaimed".  All it
> can do is raise an interrupt and complain.

  Thanks for this informations ...

Best,
  .R.V.

--=20
   _
  |-|  __      Robert Vojta <vojta-at-ipex.cz>          -=3D Oo.oO =3D-
  |=3D| [Ll]     IPEX, s.r.o.
  "^" =3D=3D=3D=3D`o

--udcq9yAoWb9A4FsZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjsJI3QACgkQInNB3KDLeVMxCgCcD6yc3Ta4lGTpkmPhmGUd9jua
aDoAoJiD6uYu7/VM5V3AQTfc4DmnCRtL
=UGiK
-----END PGP SIGNATURE-----

--udcq9yAoWb9A4FsZ--
