Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279997AbRKNBoz>; Tue, 13 Nov 2001 20:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279990AbRKNBoq>; Tue, 13 Nov 2001 20:44:46 -0500
Received: from con-64-133-52-190-ria.sprinthome.com ([64.133.52.190]:7686 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S279980AbRKNBoe>; Tue, 13 Nov 2001 20:44:34 -0500
Date: Tue, 13 Nov 2001 17:44:24 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Rob Turk <r.turk@chello.nl>, linux-kernel@vger.kernel.org
Subject: Re: PATCH: scsi_scan.c: emulate windows behavior
Message-ID: <20011113174424.A30423@one-eyed-alien.net>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Rob Turk <r.turk@chello.nl>, linux-kernel@vger.kernel.org
In-Reply-To: <20011113120855.A25014@one-eyed-alien.net> <E163mwl-0002jR-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E163mwl-0002jR-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Nov 13, 2001 at 11:26:27PM +0000
Organization: One Eyed Alien Networks
X-Copyright: (C) 2001 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm hard pressed to come up with a reason that changing the SCSI probing
would affect SANE...

If you've found a merge of 255 back into the kernel, then that means that,
for a while, my 36 patch _was_ in place.  Was that (overfix) the only
reason it was reverted to 255 after a while?

Matt

On Tue, Nov 13, 2001 at 11:26:27PM +0000, Alan Cox wrote:
> > This patch doesn't prevent another application from getting more INQUIRY
> > bytes.  What it does change is how much data the SCSI scanning loop loo=
ks
> > for.  That data is requested, and then thrown away.  It's not kept arou=
nd
> > for anything.
> >=20
> > If it were kept, I'd agree with you.  But it's not.  Some useful data is
> > copied out of the INQUIRY result, and then the buffer is overwritten by=
 the
> > next probing request.
>=20
> Ok I need to double check that. My merge of the 255 has a note saying for
> fixing sane, but that doesnt mean someone didnt overfix the matter
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

We can customize our colonels.
					-- Tux
User Friendly, 12/1/1998

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE78cx4z64nssGU+ykRAq+dAJwMRPcxxVEtMpGW4QDnW+PUZSGf8ACgw2nG
z8ZDdmec2N163/d4KOXDko4=
=adLl
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
