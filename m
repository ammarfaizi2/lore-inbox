Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264984AbUHMKnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264984AbUHMKnp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 06:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269078AbUHMKnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 06:43:45 -0400
Received: from dea.vocord.ru ([194.220.215.4]:23449 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S264984AbUHMKnL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 06:43:11 -0400
Subject: Re: [2.6 patch] let W1 select NET
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Adrian Bunk <bunk@fs.tum.de>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0408131231480.20635@scrub.home>
References: <20040813101717.GS13377@fs.tum.de>
	 <Pine.LNX.4.58.0408131231480.20635@scrub.home>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-gK148KjwKGltOjUVBUTG"
Organization: MIPT
Message-Id: <1092394019.12729.441.camel@uganda>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 13 Aug 2004 14:46:59 +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gK148KjwKGltOjUVBUTG
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-08-13 at 14:32, Roman Zippel wrote:
> Hi,
>=20
> On Fri, 13 Aug 2004, Adrian Bunk wrote:
>=20
> >  config W1
> >  	tristate "Dallas's 1-wire support"
> > +	select NET
>=20
> What's wrong with a simple dependency?

W1 requires NET, and thus depends on it.
If you _do_ want W1 then you _do_ need network and then NET must be
selected.

>=20
> bye, Roman
--=20
	Evgeniy Polyakov ( s0mbre )

Crash is better than data corruption. -- Art Grabowski

--=-gK148KjwKGltOjUVBUTG
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBHJwjIKTPhE+8wY0RApZ5AJoCnTP6uR6CJ8+eO3nhdjOmcOKzgwCglhmK
Winn0gmMAKdV6CrojbmZQZc=
=ekec
-----END PGP SIGNATURE-----

--=-gK148KjwKGltOjUVBUTG--

