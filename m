Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267939AbUJON7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267939AbUJON7m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 09:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267776AbUJON6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 09:58:05 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:664 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S267904AbUJONzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 09:55:47 -0400
From: "Matthias Urlichs" <smurf@smurf.noris.de>
Date: Fri, 15 Oct 2004 15:55:21 +0200
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Andrew Grover <andy.grover@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: 4level page tables for Linux II
Message-ID: <20041015135520.GA25999@kiste>
References: <1097638599.2673.9668.camel@cube> <20041013092221.471f7232.ak@suse.de> <pan.2004.10.14.16.57.23.884792@smurf.noris.de> <c0a09e5c041014185545517031@mail.gmail.com> <20041015132823.GA26048@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
In-Reply-To: <20041015132823.GA26048@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.5.6+20040722i
X-Smurf-Spam-Score: -2.8 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

J=F6rn Engel:
> Please don't.  Current names may be odd, but at least they are
> sufficiently different from one another.  4 names that only differ in
> a single number are an invitation for typos, thinkos and similar
> confusion.
>=20
Right now, so are the existing names: you have to remember which is which.

Levels numbered 1..4 are much simpler: you only have to remember that
the actual pages are level zero.

The solution of your typo problem is typechecking in the compiler;
presumably it'll warn me if I try to store a pgd3 pointer in a pgd2
entry.

--=20
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBb9bI8+hUANcKr/kRAjPnAJ4njfs2YJPasvJrsLOW2uGrCmltLwCeM1bB
d+ToU7VlRDDQXAKYleFXNDg=
=RALR
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
