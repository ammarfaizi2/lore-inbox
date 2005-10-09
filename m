Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932299AbVJIWdf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbVJIWdf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 18:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbVJIWdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 18:33:35 -0400
Received: from populous.netsplit.com ([62.49.129.34]:35488 "EHLO
	mailgate.netsplit.com") by vger.kernel.org with ESMTP
	id S932300AbVJIWde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 18:33:34 -0400
Subject: Re: Bug#322309: Debian woody dpkg no longer works with recent
	linux kernel.
From: Scott James Remnant <scott@netsplit.com>
To: Junichi Uekawa <dancer@netfort.gr.jp>, 322309@bugs.debian.org
Cc: 322309-submitter@bugs.debian.org, 329468@bugs.debian.org,
       329468-submitter@bugs.debian.org, debian-devel@bugs.debian.org,
       linux-kernel@vger.kernel.org, 332903-submitter@bugs.debian.org
In-Reply-To: <87zmpi3ell.dancerj%dancer@netfort.gr.jp>
References: <87zmpi3ell.dancerj%dancer@netfort.gr.jp>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-+jdALPzI3F1qHCeB32Es"
Date: Sun, 09 Oct 2005 23:33:16 +0100
Message-Id: <1128897196.19000.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+jdALPzI3F1qHCeB32Es
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2005-10-10 at 00:16 +0900, Junichi Uekawa wrote:

> dpkg in Debian woody (3.0) is broken by recent linux kernels;
> due to the following command changing behavior (mmap of=20
> zero-byte length):
>=20
>   addr=3Dmmap(NULL, 0, PROT_READ, MAP_SHARED, fd, 0);
>=20
> These bugs are caused by mmap changing behavior;=20
> it used to return NULL when given a length of 0.
> However, it now returns -1, and gives back an errno=3DEINVAL.
>=20
Indeed.  This was the sole change in the 1.13.8 release.

Scott
--=20
Have you ever, ever felt like this?
Had strange things happen?  Are you going round the twist?

--=-+jdALPzI3F1qHCeB32Es
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDSZqsIexP3IStZ2wRAsXHAKCE1NH4CaF0luf/iwizjlDI2gOK7gCdH+Ju
u/MnQFHWzwdylx+iLC74rQk=
=LaIk
-----END PGP SIGNATURE-----

--=-+jdALPzI3F1qHCeB32Es--

