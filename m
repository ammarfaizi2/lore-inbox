Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135863AbRAMAOS>; Fri, 12 Jan 2001 19:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135850AbRAMAOI>; Fri, 12 Jan 2001 19:14:08 -0500
Received: from ziggy.one-eyed-alien.net ([216.120.107.189]:20486 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S135863AbRAMANz>; Fri, 12 Jan 2001 19:13:55 -0500
Date: Fri, 12 Jan 2001 16:13:47 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: "Robert J. Bell" <rob@bellfamily.org>
Cc: kernel-list <linux-kernel@vger.kernel.org>
Subject: Re: USB Mass Storage in 2.4.0
Message-ID: <20010112161347.A6792@one-eyed-alien.net>
Mail-Followup-To: "Robert J. Bell" <rob@bellfamily.org>,
	kernel-list <linux-kernel@vger.kernel.org>
In-Reply-To: <3A5F8956.9040305@bellfamily.org> <20010112151008.A5798@one-eyed-alien.net> <3A5F9108.4030706@bellfamily.org> <20010112152415.B5798@one-eyed-alien.net> <3A5F9491.20109@bellfamily.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <3A5F9491.20109@bellfamily.org>; from rob@bellfamily.org on Fri, Jan 12, 2001 at 03:34:41PM -0800
Organization: One Eyed Alien Networks
X-Copyright: (C) 2001 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Do you have an OHCI controller or an UHCI controller?  I noticed that
you're using the "alternate" UHCI driver... can you try this with the
standard UHCI driver?

Matt

On Fri, Jan 12, 2001 at 03:34:41PM -0800, Robert J. Bell wrote:
> Unfortunately I lost everything on my system (the one that worked) and I=
=20
> don't believe I ever looked in /proc/scsi/scsi because It was working=20
> and I didn't feel the need to go poking around.  I had this problem=20
> initially the first time I compiled 2.4.0 but I went back and added SCSI=
=20
> Generic "on" and that seemed to fix it.  I am just confused why it=20
> thinks this is a scanner. IS there any way to force it to detect it as a=
=20
> scsi disk?
>=20
> I must have recompiled this kernel 50 times trying to recreate the the=20
> scenario where this worked. I can send you my .config if you think that=
=20
> will help.
>=20
> Robert
>=20
>=20
>=20
>=20
>=20
> Matthew Dharm wrote:
>=20
> > Hrm... from these logs, everything looks okay, except for the fact that=
 the
> > device refuses to return any INQUIRY data.
> >=20
> > Can you reproduce the conditions under which it was working and send lo=
gs
> > from that?  Or at least remember what the /proc/scsi/scsi info looked l=
ike?
> >=20
> > Matt
> >=20
> > On Fri, Jan 12, 2001 at 03:19:36PM -0800, Robert J. Bell wrote:
> >=20
> >> Matthew here is the info you requested, thanks for your help.
> >>=20
> >>=20

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

It was a new hope.
					-- Dust Puppy
User Friendly, 12/25/1998

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6X527z64nssGU+ykRApL6AKDPMVc5Js5KRhWcT7RdWp+SxUpgHgCePKdh
0r9kzrqjyhV44ghr0/8e3Yo=
=oo++
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
