Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932208AbWCUH5X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbWCUH5X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 02:57:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbWCUH5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 02:57:22 -0500
Received: from lug-owl.de ([195.71.106.12]:38090 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1751343AbWCUH5W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 02:57:22 -0500
Date: Tue, 21 Mar 2006 08:57:18 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VFAT: Can't create file named 'aux.h'?
Message-ID: <20060321075718.GK20746@lug-owl.de>
Mail-Followup-To: "H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org
References: <1142890822.5007.18.camel@localhost.localdomain> <20060320134533.febb0155.rdunlap@xenotime.net> <dvn835$lvo$1@terminus.zytor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Zz5hxuHUV8Fb7Aol"
Content-Disposition: inline
In-Reply-To: <dvn835$lvo$1@terminus.zytor.com>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Zz5hxuHUV8Fb7Aol
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-03-20 13:50:29 -0800, H. Peter Anvin <hpa@zytor.com> wrote:
> > /* MS-DOS "device special files" */
> > static const unsigned char *reserved_names[] =3D {
> > 	"CON     ", "PRN     ", "NUL     ", "AUX     ",
> > 	"LPT1    ", "LPT2    ", "LPT3    ", "LPT4    ",
> > 	"COM1    ", "COM2    ", "COM3    ", "COM4    ",
> > 	NULL
> > };
> >=20
>=20
> There should be more than that.  At the very least there is "CLOCK$"
> (arguably anything with $), "MSCD001" (and probably more than 001), as
> well as "COM5".."COM8".

Please divide all the reservednames into two groups: those build-in
into io.sys/msdos.sys/command.com and those that are added on the fly.
For example, "mscd001" is runtime-registered trhough any atapi CD-ROM
driver and this name is/was usually a user-configurable option. (Bad
guys name it 'README'.)

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 f=C3=BCr einen Freien Staat voll Freier B=C3=BCrger"  | im Internet! |   i=
m Irak!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--Zz5hxuHUV8Fb7Aol
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEH7HeHb1edYOZ4bsRAsHhAJ9HuAXDQBYIM0Gobc9JwJ7QYsEFWgCdFPlY
u1M85UOOkO2J9gGqO6niL90=
=+CyP
-----END PGP SIGNATURE-----

--Zz5hxuHUV8Fb7Aol--
