Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbUGVUh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbUGVUh1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 16:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267237AbUGVUh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 16:37:27 -0400
Received: from wblv-254-37.telkomadsl.co.za ([165.165.254.37]:3300 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S261375AbUGVUhX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 16:37:23 -0400
Subject: Re: [PATCH] Delete cryptoloop
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: rol@as2917.net
Cc: "'James Morris'" <jmorris@redhat.com>, dpf-lkml@fountainbay.com,
       "'Andrew Morton'" <akpm@osdl.org>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <200407221158.i6MBwlb16284@tag.witbe.net>
References: <200407221158.i6MBwlb16284@tag.witbe.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-mpeIWYVe2ovFultiSx49"
Message-Id: <1090528807.10205.32.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 22 Jul 2004 22:40:07 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-mpeIWYVe2ovFultiSx49
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-07-22 at 13:58, Paul Rolland wrote:
> Hello,
>=20
> Well, we have an option to be able to select EXPERIMENTAL code when
> making a configuration, why not adding on option for DEPRECATED code ?
>=20
> Then, you'd just have to migrate cryptoloop into this DEPRECATED
> area.
>=20

Or just mark it as BROKEN ?

> Kconfig should be able to handle that very easily !
>=20
> Regards,
> Paul
>=20
> Paul Rolland, rol(at)as2917.net
> ex-AS2917 Network administrator and Peering Coordinator
>=20
> --
>=20
> Please no HTML, I'm not a browser - Pas d'HTML, je ne suis pas un navigat=
eur
>=20
> "Some people dream of success... while others wake up and work hard at it=
"=20
>=20
>  =20
>=20
> > -----Message d'origine-----
> > De : linux-kernel-owner@vger.kernel.org=20
> > [mailto:linux-kernel-owner@vger.kernel.org] De la part de James Morris
> > Envoy=C3=A9 : jeudi 22 juillet 2004 07:22
> > =C3=80 : dpf-lkml@fountainbay.com
> > Cc : Andrew Morton; linux-kernel@vger.kernel.org
> > Objet : Re: [PATCH] Delete cryptoloop
> >=20
> > On Wed, 21 Jul 2004 dpf-lkml@fountainbay.com wrote:
> >=20
> > > Ditching cryptoloop completely in 2.7 after dm-crypt=20
> > matures would be a
> > > better idea.
> >=20
> > Part of the reason for dropping cryptoloop is to help=20
> > dm-crypt mature more=20
> > quickly.
> >=20
> > I've had some off-list email on the security of dm-crypt, and it seems
> > that it does need some work.  We need to get the security=20
> > right more than=20
> > we need to worry about these other issues.
> >=20
> > Let's drop the technically inferior of the two (cryptoloop) and
> > concentrate on fixing the other (dm-crypt).
> >=20
> > There was a thread on redesigning the security a while back (subject:
> > "dm-crypt, new IV and standards"), but no code came out of=20
> > it.  Anyone=20
> > interested should probably have a look at that.
> >=20
> >=20
> > - James
> > --=20
> > James Morris
> > <jmorris@redhat.com>
> > -
> > To unsubscribe from this list: send the line "unsubscribe=20
> > linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >=20
> >=20
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--=20
Martin Schlemmer

--=-mpeIWYVe2ovFultiSx49
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBACYnqburzKaJYLYRAtkEAJ4qW6ZPsPnj6loehMJ7K5V+x7jyagCglYfs
ExeZ5jbuR6FsSpu7GIWMPQY=
=TJRV
-----END PGP SIGNATURE-----

--=-mpeIWYVe2ovFultiSx49--

