Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261273AbSJDJLc>; Fri, 4 Oct 2002 05:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261473AbSJDJLc>; Fri, 4 Oct 2002 05:11:32 -0400
Received: from node-d-1ef6.a2000.nl ([62.195.30.246]:25326 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S261273AbSJDJLb>; Fri, 4 Oct 2002 05:11:31 -0400
Subject: Re: export of sys_call_table
From: Arjan van de Ven <arjanv@redhat.com>
To: Andy Pfiffer <andyp@osdl.org>
Cc: Michal Jaegermann <michal@harddata.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <1033691520.28254.6.camel@andyp>
References: <20021003153943.E22418@openss7.org>
	<1033682560.28850.32.camel@irongate.swansea.linux.org.uk> 
	<20021003171013.B22986@mail.harddata.com>  <1033691520.28254.6.camel@andyp>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-Adzi23UOj0sqWcShPS0w"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 04 Oct 2002 11:20:07 +0200
Message-Id: <1033723207.1733.4.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Adzi23UOj0sqWcShPS0w
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2002-10-04 at 02:32, Andy Pfiffer wrote:
(Beowulf support) also relies on this ability.
> > Or at least "kmonte" trick to load and switch to a new kernel.
>=20
> The last kmonte that I worked with would preserve, then overwrite,
> sys_call_table[__NT_reboot] with a pointer to it's version of reboot()
> when the kmonte module was loaded.
>=20
> If asked to unload, the original version of reboot() was restored prior
> to being unloaded.

this actually gets very messy if you have ANOTHER module that tries to
do the same at the same time....

I wonder why kmonte can't just use a reboot notifier.... existing
infrastructure already ;(


--=-Adzi23UOj0sqWcShPS0w
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9nV1HxULwo51rQBIRAtvMAJ41IhP5ZGZip6BDzPzTFrFwGsqWDQCfdXw6
/0tuE6GBOpFCsjfSmGGdIHM=
=Ywr8
-----END PGP SIGNATURE-----

--=-Adzi23UOj0sqWcShPS0w--

