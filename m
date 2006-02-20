Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750895AbWBTVvq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750895AbWBTVvq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 16:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbWBTVvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 16:51:46 -0500
Received: from ctb-mesg9.saix.net ([196.25.240.89]:41350 "EHLO
	ctb-mesg9.saix.net") by vger.kernel.org with ESMTP id S1750889AbWBTVvp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 16:51:45 -0500
Subject: Re: kernel panic with unloadable module support... SMP
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: Ben Ford <ben@kalifornia.com>
Cc: George P Nychis <gnychis@cmu.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <43F8E87C.1000409@kalifornia.com>
References: <1174.128.237.252.29.1140376277.squirrel@128.237.252.29>
	 <20060219191552.GB4971@stusta.de>
	 <46653.128.237.252.29.1140384421.squirrel@128.237.252.29>
	 <43F8E87C.1000409@kalifornia.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-QTJNlVwAJLdsBe4Y7mbm"
Date: Mon, 20 Feb 2006 23:54:21 +0200
Message-Id: <1140472461.29789.9.camel@lycan.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.91 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-QTJNlVwAJLdsBe4Y7mbm
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2006-02-19 at 13:51 -0800, Ben Ford wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> George P Nychis wrote:
> > Okay, I downloaded the 2.6.16-r4 kernel and left it unmodified and I do
> not get the panic.
> >
> > Can you suggest anything for me so that I can find what is causing the
> panic with the gentoo vanilla sources?
>=20
> Gentoo doesn't understand the concept of "vanilla" packages.  Make a
> practice of downloading your kernel directly from kernel.org and
> building it yourself.
>=20

Uhm, last time I checked, sys-kernel/vanilla-sources was just that -
vanilla kernel.org sources handled by the package manager.

If you check what is in portage currently, there are no 2.6.15-rc or
even _any_ version that have a -rX, so he either used the
gentoo-sources, or he used 2.6.15.1 which had a bug that was fixed in
2.6.16-rc4 (assuming, as there are no 2.6.16-r4 on kernel.org).  No way
to know if he don't specify the correct version, or try the same version
directly from kernel.org (which would probably give the same results if
he really did use vanilla-sources).

> Out of 10+ boxes that I've run on Gentoo, only one has worked using
> the Gentoo kernel.
>=20

Maybe, but did you file a bug ?  No reason for random ranting if you had
issues with their patched kernel.  I can name many other distribution
kernels, and some kernel.org ones that had issues, but then it usually
was my own fault if it stayed an issue.


--=20
Martin Schlemmer


--=-QTJNlVwAJLdsBe4Y7mbm
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQBD+jqNqburzKaJYLYRAq/iAKCNaybNqUGxxN4WeDOLZVTEltWS1gCePK74
hrz9E2P3ty1zns2Jj27Vg38=
=/to5
-----END PGP SIGNATURE-----

--=-QTJNlVwAJLdsBe4Y7mbm--

