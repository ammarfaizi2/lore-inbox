Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290739AbSAYRYH>; Fri, 25 Jan 2002 12:24:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290740AbSAYRX4>; Fri, 25 Jan 2002 12:23:56 -0500
Received: from charger.oldcity.dca.net ([207.245.82.76]:27291 "EHLO
	charger.oldcity.dca.net") by vger.kernel.org with ESMTP
	id <S290739AbSAYRXr>; Fri, 25 Jan 2002 12:23:47 -0500
Date: Fri, 25 Jan 2002 12:06:42 -0500
From: christophe =?iso-8859-15?Q?barb=E9?= 
	<christophe.barbe.ml@online.fr>
To: simon@baydel.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: unresolved symbols __udivdi3 and __umoddi3
Message-ID: <20020125170642.GG671@online.fr>
Mail-Followup-To: simon@baydel.com, linux-kernel@vger.kernel.org
In-Reply-To: <3C50FBAE.26883.8EF8C@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z9ECzHErBrwFF8sy"
Content-Disposition: inline
In-Reply-To: <3C50FBAE.26883.8EF8C@localhost>
User-Agent: Mutt/1.3.26i
X-Operating-System: debian SID Gnu/Linux 2.4.17 on i586
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--z9ECzHErBrwFF8sy
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

GFS uses (provide) a module which provides these symbols.
I don't know if this is still the case with their non-free software but
you can certainly find the last free GFS release.

You can have a look at=20
   http://www.sistina.com
but I guess that if they provide a way to get the last free release this
will not be a easy to find link.

Or at
   http://www.opengfs.org

But IIRC these symbol were used only for the 2.2 kernel (that I assume
you are using?) and the support for 2.2 kernel was removed in the
opengfs fork.

Christophe

On Fri, Jan 25, 2002 at 06:31:10AM -0000, simon@baydel.com wrote:
> I am writing a module and would like to perform arithmetic on long=20
> long variables. When I try to do this the module does not load due
> to the unresolved symbols __udivdi3 and __umoddi3. I notice these
> are normally defined in libc. Is there any way I can do this in a=20
> kernel module.
>=20
> Many Thanks
>=20
> Simon.
> __________________________
>=20
> Simon Haynes - Baydel=20
> Phone : 44 (0) 1372 378811
> Email : simon@baydel.com
> __________________________
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Christophe Barb=E9 <christophe.barbe@ufies.org>
GnuPG FingerPrint: E0F6 FADF 2A5C F072 6AF8  F67A 8F45 2F1E D72C B41E

Dogs believe they are human. Cats believe they are God.

--z9ECzHErBrwFF8sy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Pour information voir http://www.gnupg.org

iD8DBQE8UZCij0UvHtcstB4RAqPPAJwLH4+ZOVy+QGCUexp6KbwsR7iadQCfT4aU
pmc9NOKC1BArCE7wJDqzjtM=
=3ifL
-----END PGP SIGNATURE-----

--z9ECzHErBrwFF8sy--
