Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268953AbRG0Tzj>; Fri, 27 Jul 2001 15:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268947AbRG0Tza>; Fri, 27 Jul 2001 15:55:30 -0400
Received: from con-64-133-52-190-ria.sprinthome.com ([64.133.52.190]:7177 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S268944AbRG0TzM>; Fri, 27 Jul 2001 15:55:12 -0400
Date: Fri, 27 Jul 2001 12:55:09 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-scsi@vger.kernel.org
Subject: Re: 2.4.7-pre9..
Message-ID: <20010727125509.D12304@one-eyed-alien.net>
Mail-Followup-To: David Woodhouse <dwmw2@infradead.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-scsi@vger.kernel.org
In-Reply-To: <20010727124736.B12304@one-eyed-alien.net> <Pine.LNX.4.33.0107280451150.4428-100000@lapdancer.baythorne.internal>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="uxuisgdDHaNETlh8"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0107280451150.4428-100000@lapdancer.baythorne.internal>; from dwmw2@infradead.org on Sat, Jul 28, 2001 at 04:53:30AM +0100
Organization: One Eyed Alien Networks
X-Copyright: (C) 2001 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


--uxuisgdDHaNETlh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Ah... okay.. now I see the issue.  Now let's see if I can fix and test this
over the weekend....

Matt

On Sat, Jul 28, 2001 at 04:53:30AM +0100, David Woodhouse wrote:
>=20
> (Cc list trimmed)
>=20
> On Fri, 27 Jul 2001, Matthew Dharm wrote:
>=20
> > IIRC, usb-storage only uses semaphores that are allocated via kfree, so=
 I
> > think we're okay.  Tho, I think the new semantics are probably better, =
and
> > will probably switch to them.  Later.
>=20
> If the exit (or indeed any) path does down(); kfree(); you suffer the sam=
e=20
> problem.
>=20
> --=20
> dwmw2

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

How would you like this tie wrapped around your hairy round head?
					-- Greg
User Friendly, 9/2/1998

--uxuisgdDHaNETlh8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7Ycccz64nssGU+ykRAroTAJ4wPiUUlUggOChAEUDsXjSZtCAAqwCgzW4F
El0O8DPYA8nwybPaSGQZ70E=
=zfVw
-----END PGP SIGNATURE-----

--uxuisgdDHaNETlh8--
