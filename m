Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261493AbSIZVBX>; Thu, 26 Sep 2002 17:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261501AbSIZVBX>; Thu, 26 Sep 2002 17:01:23 -0400
Received: from node-d-1ef6.a2000.nl ([62.195.30.246]:46318 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S261493AbSIZVBW>; Thu, 26 Sep 2002 17:01:22 -0400
Subject: Re: Distributing drivers independent of the kernel source tree
From: Arjan van de Ven <arjanv@redhat.com>
To: "Heater, Daniel (IndSys, " "GEFanuc, VMIC)" 
	<Daniel.Heater@gefanuc.com>
Cc: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
In-Reply-To: <A9713061F01AD411B0F700D0B746CA6802FC14D6@vacho6misge.cho.ge.com>
References: <A9713061F01AD411B0F700D0B746CA6802FC14D6@vacho6misge.cho.ge.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-2rxPYzoHcK+QiCXGpIe1"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 26 Sep 2002 23:08:39 +0200
Message-Id: <1033074519.2698.5.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-2rxPYzoHcK+QiCXGpIe1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2002-09-26 at 22:55, Heater, Daniel (IndSys, GEFanuc, VMIC)=20
> 2. Assuming the kernel source is in /usr/src/linux is not always valid.
>=20
> 3. I currently use /usr/src/linux-`uname -r` to locate the kernel source
> which is just as broken as method #2.

you have to use

/lib/modules/`uname -r`/build
(yes it's a symlink usually, but that doesn't matter)


that's what Linus decreed and that's what all distributions honor, and
that's that make install does for manual builds.

Greetings,
   Arjan van de Ven

--=-2rxPYzoHcK+QiCXGpIe1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9k3dXxULwo51rQBIRApzFAJ9bxqF/6PtozYP3vWaep5f+rGjehgCfZTpK
VzBvMFIJzBpVb9Ix00Wttko=
=M5db
-----END PGP SIGNATURE-----

--=-2rxPYzoHcK+QiCXGpIe1--

