Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264922AbUAFSPA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 13:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264931AbUAFSO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 13:14:59 -0500
Received: from debian4.unizh.ch ([130.60.73.144]:53931 "EHLO
	albatross.madduck.net") by vger.kernel.org with ESMTP
	id S264922AbUAFSO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 13:14:57 -0500
Date: Tue, 6 Jan 2004 19:14:48 +0100
From: martin f krafft <madduck@madduck.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [solved] 2.6 IPsec (Kame) appears to be working, but it isn't
Message-ID: <20040106181448.GA7684@piper.madduck.net>
Mail-Followup-To: martin f krafft <madduck@madduck.net>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20040106171236.GA3068@piper.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <20040106171236.GA3068@piper.madduck.net>
X-OS: Debian GNU/Linux testing/unstable kernel 2.6.0-piper i686
X-Mailer: Mutt 1.5.4i (2003-03-19)
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach martin f krafft <madduck@madduck.net> [2004.01.06.1812 +0100]:
> I now ping one end from the other, tcpdump reports successful packet
> exchanges on both sides:
>=20
>   10.201.165.118 > 10.201.23.21:
>     AH(spi=3D0x00000200,seq=3D0x2d): ESP(spi=3D0x00000201,seq=3D0x2d) (DF)
>   10.201.23.21 > 10.201.165.118:
>     AH(spi=3D0x00000300,seq=3D0x6): ESP(spi=3D0x00000301,seq=3D0x6)
>=20
> However, the ping application at 10.201.165.118 sees none of the
> replies:

This was (of course) my bad. One of the AH keys was incorrect.

I guess I should first learn cut'n'paste before learning IPsec
and/or bothering y'all.

Sorry.

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
invalid/expired pgp subkeys? use subkeys.pgp.net as keyserver!
=20
"good advice is something a man gives
 when he is too old to set a bad example.
                                                  -- la rouchefoucauld

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/+vsYIgvIgzMMSnURApZVAJ0W4ksaemqHsIXpxPLAVM4KM23CRgCfd0b6
IpPaUlV9Eq3Ujz8M0WxyF8c=
=XrjQ
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
