Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265140AbTASMER>; Sun, 19 Jan 2003 07:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265198AbTASMER>; Sun, 19 Jan 2003 07:04:17 -0500
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:28398 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP
	id <S265140AbTASMEQ>; Sun, 19 Jan 2003 07:04:16 -0500
Subject: Re: ANN: LKMB (Linux Kernel Module Builder) version 0.1.16
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Olaf Titz <olaf@bigred.inka.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E18a1aZ-0006mL-00@bigred.inka.de>
References: <25160.1042809144@passion.cambridge.redhat.com>
	 <Pine.LNX.4.33L2.0301171857230.25073-100000@vipe.technion.ac.il>
	 <E18a1aZ-0006mL-00@bigred.inka.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-6B32tKOZX7KEZsFu9Uhc"
Organization: Red Hat, Inc.
Message-Id: <1042930522.15782.12.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 18 Jan 2003 23:55:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6B32tKOZX7KEZsFu9Uhc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2003-01-18 at 23:37, Olaf Titz wrote:
> > > Use "/lib/modules/`uname -r`/build" as a default kernel directory, bu=
t
> > > allow it to be overridden somehow from the command line. Then do some=
thing
> > > like...
> >...
> > Do you mean I'll need a live Linux kernel to build the kernel module
> > package?
>=20
> Whoever invented this /lib/modules/... scheme should have known that
> it provokes this sort of misunderstandings, not to mention is broken
> in other ways too.

it was Linus who decreed this to be the standard;)

>=20
> You need the _source_ of the kernel the module will run on to compile
> modules. You don't need to _run_ this kernel while compiling. Putting
> build infrastructure into a deployment directory at the least causes
> confusion, not to mention that the deployment directory might not even
> exist on the development machine. (I routinely compile kernels and
> modules of different configurations for three boxes on one of them,
> the other two don't even have a complete development toolset.)

yes, and most of the time you want to compile against the currently
running kernel, at which point `uname -r` comes in handy; for other
kernels you just change the path a bit.
make install and make modules_install make the symlink right already....
it's a 99% solution, sure, but it's ok for all but a few cases.


--=-6B32tKOZX7KEZsFu9Uhc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+KdtaxULwo51rQBIRAijvAJ9Y4jMVmB2u58kz8BubSmsYr1rdUQCfWM4x
tvnwEkLXcHRlleatM1Keb2U=
=fX1Q
-----END PGP SIGNATURE-----

--=-6B32tKOZX7KEZsFu9Uhc--
