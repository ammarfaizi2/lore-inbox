Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289754AbSAJWsk>; Thu, 10 Jan 2002 17:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289747AbSAJWsa>; Thu, 10 Jan 2002 17:48:30 -0500
Received: from ziggy.one-eyed-alien.net ([64.169.228.100]:25861 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S289753AbSAJWsM>; Thu, 10 Jan 2002 17:48:12 -0500
Date: Thu, 10 Jan 2002 14:48:03 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Timothy Covell <timothy.covell@ashavan.org>
Cc: Nelson Mok <nmok@cse.Buffalo.EDU>, linux-kernel@vger.kernel.org
Subject: Re: SCSI ID wars [was:  USB Sandisk SDDR-31 problems in 2.4.9 - 2.4.17]
Message-ID: <20020110144803.F21482@one-eyed-alien.net>
Mail-Followup-To: Timothy Covell <timothy.covell@ashavan.org>,
	Nelson Mok <nmok@cse.Buffalo.EDU>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.SOL.4.30.0201100411100.25549-100000@yeager.cse.Buffalo.EDU> <20020110133534.C21482@one-eyed-alien.net> <200201102237.g0AMbASr031936@svr3.applink.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="f61P+fpdnY2FZS1u"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200201102237.g0AMbASr031936@svr3.applink.net>; from timothy.covell@ashavan.org on Thu, Jan 10, 2002 at 04:33:22PM -0600
Organization: One Eyed Alien Networks
X-Copyright: (C) 2002 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--f61P+fpdnY2FZS1u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Actually, device IDs are handed out by the SCSI mid-layer.  The low-level
drivers don't even have an easy way to figure it out.

Matt

On Thu, Jan 10, 2002 at 04:33:22PM -0600, Timothy Covell wrote:
> On Thursday 10 January 2002 15:35, Matthew Dharm wrote:
> > The "stall at shutdown" is a known problem.  I'm testing a patch now...=
 as
> > soon as I see my last patchset incorporated into the kernels, I'll send=
 it
> > out for inclusion.
> >
> > As for the USB device "hiding" your SCSI device... how odd.   I've never
> > heard of that before.
> >
> > Matt
>=20
> Does it hide your SCSI device or just shift the SCSI IDs such that
> /dev/scd0 becomes /dev/scd1?  =20
>=20
>=20
> And that brings up a question concerning whether there is a defined
> way of assigning SCSI IDs.    I'm assume that it's "every driver for
> itself".
>=20
>=20
> ---
> timothy.covell@ashavan.org.

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

G:  Money isn't everything, A.J.
AJ: Who convinced you of that?
G:  The Chief, at my last salary review.
					-- Mike and Greg
User Friendly, 11/3/1998

--f61P+fpdnY2FZS1u
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8Phojz64nssGU+ykRAq7PAKDOfuzdFgJbgZOmKoN/AkbVLaWhrACg5eHY
AmUHwY8J5Zrf9GpCMvH4wQY=
=FClV
-----END PGP SIGNATURE-----

--f61P+fpdnY2FZS1u--
