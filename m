Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282817AbRLLWm0>; Wed, 12 Dec 2001 17:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282839AbRLLWmQ>; Wed, 12 Dec 2001 17:42:16 -0500
Received: from ts46-01-qdr38.ykma.wa.charter.com ([66.189.200.38]:46737 "EHLO
	ember.morcant.org") by vger.kernel.org with ESMTP
	id <S282817AbRLLWmG>; Wed, 12 Dec 2001 17:42:06 -0500
Subject: Re: emu10k1 - interrupt storm?
From: Morgan Collins <sirmorcant@morcant.org>
To: zlatko.calusic@iskon.hr
Cc: "Marcelo ''Mosca'' de Paula Bezerra" <mosca@roadnet.com.br>,
        Rui Sousa <rui.p.m.sousa@clix.pt>,
        emu10k1-devel@opensource.creative.com, linux-kernel@vger.kernel.org
In-Reply-To: <878zc8az65.fsf@atlas.iskon.hr>
In-Reply-To: <Pine.LNX.4.33.0112121112450.2868-100000@sophia-sousar2.nice.mindspeed.com>
	<3C175A7C.6C532320@roadnet.com.br>  <878zc8az65.fsf@atlas.iskon.hr>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-l+5OSn2SThNSqpNY1d4W"
X-Mailer: Evolution/1.0 (Preview Release)
Date: 12 Dec 2001 14:41:45 -0800
Message-Id: <1008196905.980.6.camel@ember>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-l+5OSn2SThNSqpNY1d4W
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2001-12-12 at 13:47, Zlatko Calusic wrote:
> "Marcelo ''Mosca'' de Paula Bezerra" <mosca@roadnet.com.br> writes:
>=20
> > Try running esd with the -as 10 options..
> > As the help says, it will disconnect the audio device after 10 seconds
> > of inactivity. It will at least help you with the interrupt load while
> > not using sound.
> >=20
>=20
> Yes, nice idea, but easier said than done. :)
>=20
> Unfortunately esd is started by the gnome desktop environment and I
> can disable or enable it, but can't set any parameters (as far as I
> can see). Probably I'll disable it for good, as emu10k1 driver already
> does a great job mixing multiple sound streams.
>=20
> Regards,

in $prefix/etc/esd.conf
add:

spawn_options=3D-as 10

--=20
Morgan Collins http://sirmorcant.morcant.org
Crypto Doesn't Kill - People Do.

--=-l+5OSn2SThNSqpNY1d4W
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEABECAAYFAjwX3SkACgkQUmuTJ4AlzFEGHACeLbEmbYFPMHQ+krf0s5I/6HLH
rCsAn31pF0msczHziLJmG7ngUVlbroTK
=VnAV
-----END PGP SIGNATURE-----

--=-l+5OSn2SThNSqpNY1d4W--
