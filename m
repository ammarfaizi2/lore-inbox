Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269489AbRHaWSp>; Fri, 31 Aug 2001 18:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269517AbRHaWSf>; Fri, 31 Aug 2001 18:18:35 -0400
Received: from con-64-133-52-190-ria.sprinthome.com ([64.133.52.190]:6150 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S269489AbRHaWS2>; Fri, 31 Aug 2001 18:18:28 -0400
Date: Fri, 31 Aug 2001 15:18:39 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: [PATCH] usb fix
Message-ID: <20010831151839.C17480@one-eyed-alien.net>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
	torvalds@transmeta.com
In-Reply-To: <200108312203.WAA15637@vlet.cwi.nl> <E15cwcv-000477-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="jy6Sn24JjFx/iggw"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15cwcv-000477-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Aug 31, 2001 at 11:19:01PM +0100
Organization: One Eyed Alien Networks
X-Copyright: (C) 2001 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jy6Sn24JjFx/iggw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

That doesn't sound right, Alan...

The constant in question is an upper-limit to the range of device versions
what get accepted.  Narrowing the range can only break things -- making it
wider may not (necessarily) fix anything, but it does increase the scope of
the entry.

I'm guessing that someone meant to change it from something smaller than
either Andries' or the current value to where it is now, but the larger
value (i.e. Andries') is the proper one.

Matt

On Fri, Aug 31, 2001 at 11:19:01PM +0100, Alan Cox wrote:
> > but not with 2.4.9, I noticed that my name was added and some
> > constant changed. Changing it back revived my CF reader.
>=20
> Yes you added the entry, someone changed the constant as it didnt work
> for them, now you change it back.
>=20
> I suspect both constants should be in 8)

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

We can customize our colonels.
					-- Tux
User Friendly, 12/1/1998

--jy6Sn24JjFx/iggw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7kA0/z64nssGU+ykRApWRAJ9Y+kcIoSIV+tO82viIsLP5pqJAmwCg/vn7
KNTLNBaDzgPQiQ+Zy8GdTQs=
=QprS
-----END PGP SIGNATURE-----

--jy6Sn24JjFx/iggw--
