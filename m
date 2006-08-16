Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750818AbWHPA3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbWHPA3Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 20:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbWHPA3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 20:29:24 -0400
Received: from ozlabs.org ([203.10.76.45]:8891 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750728AbWHPA3W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 20:29:22 -0400
Subject: Re: [PATCH 4/4]: powerpc/cell spidernet ethtool -i version number
	info.
From: Michael Ellerman <michael@ellerman.id.au>
Reply-To: michael@ellerman.id.au
To: Olof Johansson <olof@lixom.net>
Cc: James K Lewis <jklewis@us.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
       Jens Osterkamp <Jens.Osterkamp@de.ibm.com>,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       netdev@vger.kernel.org
In-Reply-To: <20060815190524.GW6603@pb15.lixom.net>
References: <20060811180013.GB6550@pb15.lixom.net>
	 <OF934FE4E3.EEC44FDD-ON872571C7.00668651-862571C7.00677A44@us.ibm.com>
	 <20060815190524.GW6603@pb15.lixom.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-0hSfKaqUAvN8P1/CJO7c"
Date: Wed, 16 Aug 2006 10:29:05 +1000
Message-Id: <1155688145.26911.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-0hSfKaqUAvN8P1/CJO7c
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-08-15 at 14:05 -0500, Olof Johansson wrote:
> On Fri, Aug 11, 2006 at 01:50:19PM -0500, James K Lewis wrote:
> >  Hi Olof,
> >=20
> >   There are several reasons why an Ethernet driver should have an up to=
=20
> > date version number:
> >=20
> > 1. Customers like to see they are really getting a new version.
> >=20
> > 2. It makes it easier for support personnel (me in this case) to see wh=
ich=20
> > driver they have. Sure, sometimes I can talk them thru doing a "sum" on=
=20
> > the .ko and all that, but why not just use the version number? That's w=
hat=20
> > it is for. And no, you can't just assume they have the version that cam=
e=20
> > with the kernel they are running. It doesn't work that way.
> >=20
> > 3. It makes bug reporting easier.=20
> >=20
> > 4. I have already run into too many problems and wasted too much time=20
> > working with drivers when the number was NOT getting updated.=20
>=20
> Thanks for the info, Jim.
>=20
> Sounds like it's most useful if a customer (or distro) takes the driver
> out of the tree and run it with a different kernel, i.e. when kernel
> and driver versions no longer go together. Makes sense.

It only makes sense in addition to the kernel version number (which in
some cases can be meaningless), plus any distro and/or local patches,
plus the kernel config.

Without all that information you don't really know what you're talking
about, because any one of the many interfaces between the driver and the
core kernel may have changed.

So in practice I find it's much simpler to just get the exact source
that they're running, rather than trying to guess based on version
numbers. But that's just me :)

cheers

--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-0hSfKaqUAvN8P1/CJO7c
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBE4mbRdSjSd0sB4dIRAvhKAKCA3hLLMSzx/yEn391sbCqBjBz94QCfdQmx
48APrHG1VW4AMJbYwsld/6w=
=8Kij
-----END PGP SIGNATURE-----

--=-0hSfKaqUAvN8P1/CJO7c--

