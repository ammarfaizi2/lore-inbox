Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131041AbQLMGVu>; Wed, 13 Dec 2000 01:21:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131049AbQLMGVb>; Wed, 13 Dec 2000 01:21:31 -0500
Received: from ziggy.one-eyed-alien.net ([216.51.112.145]:19982 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S131041AbQLMGV2>; Wed, 13 Dec 2000 01:21:28 -0500
Date: Tue, 12 Dec 2000 21:50:58 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Frédéric L . W . Meunier 
	<0@pervalidus.net>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: USB mass storage backport status?
Message-ID: <20001212215058.A3681@one-eyed-alien.net>
Mail-Followup-To: Frédéric L . W . Meunier <0@pervalidus.net>,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <20001213014154.H1245@pervalidus> <20001212200840.K23762@one-eyed-alien.net> <20001213030311.I1245@pervalidus>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20001213030311.I1245@pervalidus>; from 0@pervalidus.net on Wed, Dec 13, 2000 at 03:03:11AM -0200
Organization: One Eyed Alien Networks
X-Copyright: (C) 2000 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

AAAHHHHHHHHHH!

Okay, this must have changed somewhat recently.  When last I spoke to Alan
Cox (the maintainer of the 2.2.x code), I told him (and he agreed) that
this code should be marked EXPERIMENTAL.  If it's not marked thus in
2.2.18pre21, then it's an error and should be corrected ASAP.

Matt Dharm

On Wed, Dec 13, 2000 at 03:03:11AM -0200, Fr=E9d=E9ric L . W . Meunier wrot=
e:
> On Tue, Dec 12, 2000 at 08:08:40PM -0800, Matthew Dharm wrote:
> > Depending on the type of device you have and how you use it, it can eit=
her:
> > (1) Work properly
> > (2) Corrupt your data
> > (3) Crash the driver
> > (4) Crash your system
>=20
> The reboot was about Iomega's Zip Drive under 2.2.18pre21:
>=20
> http://slashdot.org/comments.pl?sid=3D00/12/11/2355217&threshold=3D0&comm=
entsort=3D1&mode=3Dthread&cid=3D110
> =20
> > It's allready labeled EXPERIMENTAL.  Perhaps it should be labeled
> > DANGEROUS, also, but how many labels can you put on things to warn peop=
le
> > off?
>=20
> Hmm, where? I don't see an (EXPERIMENTAL) in
> Documentation/Configure.help:
>=20
> USB Mass Storage support
> CONFIG_USB_STORAGE
> Say Y here if you want to connect USB mass storage devices to your
> computer's USB port.
>=20
> This code is also available as a module ( =3D code which can be
> inserted in and removed from the running kernel whenever you want).
> The module will be called usb-storage.o. If you want to compile it
> as a module, say M here and read Documentation/modules.txt.
>=20
> USB Mass Storage verbose debug
> CONFIG_USB_STORAGE_DEBUG
> Say Y here in order to have the USB Mass Storage code generate
> verbose debugging messages.
>=20
> Maybe it's only enabled when you set CONFIG_EXPERIMENTAL? I don't know, b=
ecause I enabled
> it to just set CONFIG_FB.
>=20
> > On Wed, Dec 13, 2000 at 01:41:54AM -0200, Fr=E9d=E9ric L . W . Meunier =
wrote:
> > > What's the real status of the mass storage backport to 2.2.18?
> > > Some people report it can corrupt your data, another that it
> > > rebooted his computer while doing a large trasnfer, and so on.
> > >=20
> > > If it's not good, shouldn't it be removed or labeled
> > > DANGEROUS? BTW, where can I see a list of what's backported
> > > and working without major problems?
>=20
> --=20
> 0@pervalidus.{net,{dyndns.}org} TelFax: 55-21-717-2399 (Niter=F3i-RJ BR)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

God, root, what is difference?
					-- Pitr
User Friendly, 11/11/1999

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6Nw5Cz64nssGU+ykRAnxeAJ0X0oPbnXjDAAIxOtTISM4Yyf4TFQCcCas/
aqaZ9EMGUr2jL3nPYkR/Q1Y=
=wpU9
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
