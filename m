Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262197AbTERU6D (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 16:58:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262202AbTERU6D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 16:58:03 -0400
Received: from cpt-dial-196-30-180-182.mweb.co.za ([196.30.180.182]:14465 "EHLO
	nosferatu.lan") by vger.kernel.org with ESMTP id S262197AbTERU6C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 16:58:02 -0400
Subject: Re: Recent changes to sysctl.h breaks glibc
From: Martin Schlemmer <azarah@gentoo.org>
Reply-To: azarah@gentoo.org
To: William Lee Irwin III <wli@holomorphy.com>
Cc: KML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030518204956.GB8978@holomorphy.com>
References: <1053289316.10127.41.camel@nosferatu.lan>
	 <20030518204956.GB8978@holomorphy.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-HkF7Gm9CY0AEcufnYI3a"
Organization: 
Message-Id: <1053292339.10127.45.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4- 
Date: 18 May 2003 23:12:19 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-HkF7Gm9CY0AEcufnYI3a
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-05-18 at 22:49, William Lee Irwin III wrote:
> On Sun, May 18, 2003 at 10:21:56PM +0200, Martin Schlemmer wrote:
> > Some recent changes to include/linux/sysctl.h breaks glibc.
> > Problem is that __sysctl_args have been modified to use '__user',
> > but that is only defined if __KERNEL__ is defined, because that
> > is the only time compiler.h is included.
>=20
> Don't include the kernel headers in userspace.
>=20

Yes, the standard answer.  So what kernel headers should glibc
be compiled against then ?


--=20

Martin Schlemmer




--=-HkF7Gm9CY0AEcufnYI3a
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+x/cyqburzKaJYLYRAkt+AJ0d/Xb6WPU+t86kqDioDDluIRtaIgCdEb0D
RceK+Ni3gWkzSkabqJzl99U=
=LLDN
-----END PGP SIGNATURE-----

--=-HkF7Gm9CY0AEcufnYI3a--

