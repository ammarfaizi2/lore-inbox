Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbUA3Ki5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 05:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbUA3Ki5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 05:38:57 -0500
Received: from dvmwest.gt.owl.de ([62.52.24.140]:48063 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S261965AbUA3Kiy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 05:38:54 -0500
Date: Fri, 30 Jan 2004 11:38:47 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Lindent fixed to match reality
Message-ID: <20040130103846.GR20536@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040129193727.GJ21888@waste.org> <slrnc1irnj.2is.erik@bender.home.hensema.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xSu31lw3TgkWXnjh"
Content-Disposition: inline
In-Reply-To: <slrnc1irnj.2is.erik@bender.home.hensema.net>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xSu31lw3TgkWXnjh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-01-29 20:37:07 +0000, Erik Hensema <erik@hensema.net>
wrote in message <slrnc1irnj.2is.erik@bender.home.hensema.net>:
> Matt Mackall (mpm@selenic.com) wrote:

> You just nicely broke 'find . -name *.c | xargs grep ^foo'.

That's what I like, too:)

> Why make functions harder to find? It's just one line... Being
> able to navigate the source tree with standard unix utils is a
> Good Thing.
>=20
> Even better, IMHO:
>=20
> void *
> foo(void)

=2E..which may even help you preparing header files' declarations if you
did a long shot of coding without adding the declarations in time!

> Yes, that takes a full three lines. But within the function body
> you can just reverse search for ^{ and you're at the function
> declaration. Not nearly as useful as grepping for a function
> name, but still a nice thing to have, IMHO.

It's quite useful!

> > b) (no -bs) "sizeof(foo)" rather than "sizeof (foo)"
> Agreed.

I prefer sizeof with a space, but that's pure religion...

> > c) (-ncs) "(void *)foo" rather than "(void *) foo"
> Agreed.

=2E..as well as with casts.

That's all sooo much religion. Let's keep coding and not argue about
indention. Just keep *consistend* within a single file...

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--xSu31lw3TgkWXnjh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAGjQ2Hb1edYOZ4bsRAqcdAJ9sU7U8P2WtnDCSOkJwui7guZGVOgCdGJ2F
sDiAdutkNr6wtVPBe1nlr2Y=
=RjON
-----END PGP SIGNATURE-----

--xSu31lw3TgkWXnjh--
