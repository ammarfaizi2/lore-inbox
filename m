Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261631AbTCQMTT>; Mon, 17 Mar 2003 07:19:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261643AbTCQMTT>; Mon, 17 Mar 2003 07:19:19 -0500
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:40433 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP
	id <S261631AbTCQMTS>; Mon, 17 Mar 2003 07:19:18 -0500
Subject: Re: Read Hat 7.3 and 8.0 compilation problems
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: chandrasekhar.nagaraj@patni.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <001d01c2ec83$6bfbcc10$e9bba5cc@patni.com>
References: <001d01c2ec83$6bfbcc10$e9bba5cc@patni.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-0xeWH/0x0KbUsAPW+37/"
Organization: Red Hat, Inc.
Message-Id: <1047904177.1596.1.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 17 Mar 2003 13:29:37 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-0xeWH/0x0KbUsAPW+37/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-03-17 at 13:47, chandrasekhar.nagaraj wrote:
> Hello,
>=20
> We have a driver which was originally bulit on Red Hat 7.2 version.Now we
> are compiling the same driver on Red Hat 7.3 and 8.0
> While compiling we are facing the following problems.
> Compilation output :-
> The following files are missing
> /usr/include/asm/msr.h
> /usr/include/asm/fixmap.h
> /usr/include/asm/uaccess.h
> /usr/include/asm/hardirq.h

why are you using glibc headers to compile KERNEL modules ?

>=20
> But if we compile the driver using the include souces
> /usr/src/linux-2.4/include we do not get any compilation errors.

the "standardized between all distros and Linus" place to get headers is
/lib/modules/`uname -r`/build/include
I would suggest you use that.

--=-0xeWH/0x0KbUsAPW+37/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+db+wxULwo51rQBIRAjBlAJ4o1idP5f0wkBoo76vqQaCMwREO3wCeKoGW
q/gDx5bROrkx8aL3YFaOO0I=
=Vr6H
-----END PGP SIGNATURE-----

--=-0xeWH/0x0KbUsAPW+37/--
