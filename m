Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263010AbTCWKdO>; Sun, 23 Mar 2003 05:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263013AbTCWKdO>; Sun, 23 Mar 2003 05:33:14 -0500
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:10991 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP
	id <S263010AbTCWKdN>; Sun, 23 Mar 2003 05:33:13 -0500
Subject: Re: 2.4+ptrace exploit fix breaks root's ability to strace
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: "Lists (lst)" <linux@lapd.cj.edu.ro>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Russell King <rmk@arm.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.51L0.0303231225070.15290@lapd.cj.edu.ro>
References: <20030322103121.A16994@flint.arm.linux.org.uk>
	 <1048345130.8912.9.camel@irongate.swansea.linux.org.uk>
	 <Pine.LNX.4.51L0.0303231225070.15290@lapd.cj.edu.ro>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-y1etykm1sZ9zi0JGKEOB"
Organization: Red Hat, Inc.
Message-Id: <1048416233.1499.1.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 23 Mar 2003 11:43:53 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-y1etykm1sZ9zi0JGKEOB
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-03-23 at 11:31, Lists (lst) wrote:
> On Sat, 22 Mar 2003, Alan Cox wrote:
>=20
> > On Sat, 2003-03-22 at 10:31, Russell King wrote:
> > > Are the authors of the ptrace patch aware that, in addition to closin=
g the
> > > hole, the "fix" also prevents a ptrace-capable task (eg, strace start=
ed by
> > > root) from ptracing user threads?
> >=20
> > Its an unintended side effect, nobody has sent a patch to fix it yet.
>=20
> Hi,
>=20
> mlafon send a patch to the list:

uid =3D=3D 0 is the wrong test

--=-y1etykm1sZ9zi0JGKEOB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+fY/pxULwo51rQBIRAnnxAJ0fr2qQkU+Ar7BP1yLNH7DVpjdFPgCgo5Og
VDFeZVWN5b7dWNoosDTD66Q=
=zMtP
-----END PGP SIGNATURE-----

--=-y1etykm1sZ9zi0JGKEOB--
