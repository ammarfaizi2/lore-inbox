Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275700AbRIZXjq>; Wed, 26 Sep 2001 19:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275699AbRIZXjh>; Wed, 26 Sep 2001 19:39:37 -0400
Received: from con-64-133-52-190-ria.sprinthome.com ([64.133.52.190]:51205
	"EHLO ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S275698AbRIZXjY>; Wed, 26 Sep 2001 19:39:24 -0400
Date: Wed, 26 Sep 2001 16:39:28 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Peter Sandstrom <peter@zaphod.nu>
Cc: Robert Cantu <robert@tux.cs.ou.edu>, linux-kernel@vger.kernel.org
Subject: Re: Question: Etherenet Link Detection
Message-ID: <20010926163928.A3678@one-eyed-alien.net>
Mail-Followup-To: Peter Sandstrom <peter@zaphod.nu>,
	Robert Cantu <robert@tux.cs.ou.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <20010926174116.A7544@tux.cs.ou.edu> <CIEJKOKMAIAHDBBLFGFFEEOPCGAA.peter@zaphod.nu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <CIEJKOKMAIAHDBBLFGFFEEOPCGAA.peter@zaphod.nu>; from peter@zaphod.nu on Fri, Sep 28, 2001 at 01:36:07AM +0200
Organization: One Eyed Alien Networks
X-Copyright: (C) 2001 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

You can get that information from the PHY too, so if you can get to the MII
control registers, you can query the phy for link status.

Again, tho, the problem is getting that data to userland.

Matt

On Fri, Sep 28, 2001 at 01:36:07AM +0200, Peter Sandstrom wrote:
> I know for sure that the Intel 82559 Fast Ethernet embedded controller=20
> has a register where it's possible to read out if the link led is active
> or not. It seems quite likely that this would be available on other
> controllers as well.
>=20
> Is there any functionality in the current kernel that enables a userland
> program to read this? I mostly turn my machines on and and let them do
> their thing until the hardware fails :)
>=20
> /Peter
>=20
> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Robert Cantu
> Sent: den 26 september 2001 23:41
> To: linux-kernel@vger.kernel.org
> Subject: Question: Etherenet Link Detection
>=20
>=20
> Is there a method of detecting the link status of an ethernet NIC? If not,
> is it feasible? And if it is, then would it be something in each driver, =
=20
> or on a level above the driver, thereby available to all drivers? I figure
> the list is the best place to ask this, although it might be a moot point.
>                                                                =20
> Example: Have a cable modem hooked into a computer's NIC. Cable service  =
=20
> goes out, link light on back of NIC goes out. A hypothetical program says=
=20
> that the link is gone via some hook in /proc somewhere.
>=20
> Is this a worthwhile endeavor, if possible?
>=20
> Thanks in advance,
> Robert
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20
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

Type "format c:"  That should fix everything.
					-- Greg
User Friendly, 12/18/1997

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7smcwz64nssGU+ykRAinkAJsFF+0NHQoFX2bS/Nri2DWhMdwL6QCfTRD+
mcAlO7TLA2iBQ1G3g1iwuCU=
=Zz/L
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
