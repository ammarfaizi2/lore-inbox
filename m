Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261533AbSJDJBi>; Fri, 4 Oct 2002 05:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261537AbSJDJBi>; Fri, 4 Oct 2002 05:01:38 -0400
Received: from node-d-1ef6.a2000.nl ([62.195.30.246]:25326 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S261533AbSJDJBh>; Fri, 4 Oct 2002 05:01:37 -0400
Subject: Re: export of sys_call_table
From: Arjan van de Ven <arjanv@fenrus.demon.nl>
To: bidulock@openss7.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021003170608.A30759@openss7.org>
References: <20021003153943.E22418@openss7.org>
	<1033682560.28850.32.camel@irongate.swansea.linux.org.uk> 
	<20021003170608.A30759@openss7.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-YDq8eJR1SxitZgh0GcGx"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 04 Oct 2002 11:10:12 +0200
Message-Id: <1033722612.1853.1.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-YDq8eJR1SxitZgh0GcGx
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2002-10-04 at 01:06, Brian F. G. Bidulock wrote:
> Alan,
>=20
> Would it be possible to put a secondary call table behind
> the call gate wrappered in sys_ni_syscall that a module
> could register against.=20
Why ?
Adding "unknown" syscalls is I doubt EVER a good idea.
LiS has *known* and *official* syscalls, they can easily live with a
stub like nfsd uses.... few lines of code and it's safe.

Greetings,
   Arjan van de Ven

--=-YDq8eJR1SxitZgh0GcGx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9nVrzxULwo51rQBIRAmrBAKCiIDggombTs+lPBYH0Z5Ix1fT+0QCgiJZU
xewwHt3EWj3bVS4xdt/LZ2k=
=DSOZ
-----END PGP SIGNATURE-----

--=-YDq8eJR1SxitZgh0GcGx--

