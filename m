Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262177AbTJGOX6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 10:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262152AbTJGOX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 10:23:58 -0400
Received: from 24-216-47-19.charter.com ([24.216.47.19]:44459 "EHLO
	wally.rdlg.net") by vger.kernel.org with ESMTP id S262177AbTJGOX4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 10:23:56 -0400
Date: Tue, 7 Oct 2003 10:23:49 -0400
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: M?ns Rullg?rd <mru@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: devfs vs. udev
Message-ID: <20031007142349.GX1223@rdlg.net>
Mail-Followup-To: M?ns Rullg?rd <mru@users.sourceforge.net>,
	linux-kernel@vger.kernel.org
References: <yw1xad8dfcjg.fsf@users.sourceforge.net> <pan.2003.10.07.13.41.23.48967@dungeon.inka.de> <yw1xekxpdtuq.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eGyD7iWN192kf2IJ"
Content-Disposition: inline
In-Reply-To: <yw1xekxpdtuq.fsf@users.sourceforge.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--eGyD7iWN192kf2IJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thus spake M?ns Rullg?rd (mru@users.sourceforge.net):

> Andreas Jellinghaus <aj@dungeon.inka.de> writes:
>=20
> >> I noticed this in the help text for devfs in 2.6.0-test6:
> >>=20
> >> 	  Note that devfs has been obsoleted by udev,
> >
> > devfs works fine, lists all devices, and obsoletes makedev.
>=20
> That's my experience.

Same here but read on.

> > udev needs patching for several issues, current sysfs only exports
> > many but by far not all devices, and because of that makedev
> > is still needed to create an initial /dev.
> >
> > in short: devfs works fine. udev has quite a way to go.
> > so marking devfs obsolete was done too soon by far. but
>=20
> Exactly my point.
>=20
> I'd also like an explanation of the rationale behind the switch.
> devfs works and is stable.  Why replace it with an incomplete fragile
> userspace solution?  I recall reading something about the original
> author not updating devfs recently, but I can't see why that requires
> rewriting it from scratch.

As a pro-devfs person I felt the same and hate to say it but "read the
archives".  Someone gave a good writeup on the problems with devfs and
how udev will (eventually) solve them.

I just hope udev can give a look/feel similar to devfs as I have quite a
few machines already in production configured for devfs and really like
the manageablility.

:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

Life is not a destination, it's a journey.
  Microsoft produces 15 car pileups on the highway.
    Don't stop traffic to stand and gawk at the tragedy.

--eGyD7iWN192kf2IJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/gsx18+1vMONE2jsRAnJFAKDJuxfPcC9/DTqOacj5pDtKbGfUowCgiz42
+qIirVmE1CJDydZmwq1ockU=
=HRY1
-----END PGP SIGNATURE-----

--eGyD7iWN192kf2IJ--
