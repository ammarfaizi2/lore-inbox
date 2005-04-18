Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262210AbVDRUPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262210AbVDRUPQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 16:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262202AbVDRUNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 16:13:43 -0400
Received: from vds-320151.amen-pro.com ([62.193.204.86]:17593 "EHLO
	vds-320151.amen-pro.com") by vger.kernel.org with ESMTP
	id S262185AbVDRULU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 16:11:20 -0400
Subject: Re: [PATCH 2/7] procfs privacy: tasks/processes lookup
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: Rik van Riel <riel@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0504181523440.11251@chimarrao.boston.redhat.com>
References: <1113849993.17341.69.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0504181523440.11251@chimarrao.boston.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ICaMOgSGYXP5ToqNQ2Rg"
Date: Mon, 18 Apr 2005 21:59:30 +0200
Message-Id: <1113854370.17341.115.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ICaMOgSGYXP5ToqNQ2Rg
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

El lun, 18-04-2005 a las 15:24 -0400, Rik van Riel escribi=F3:
> This looks like a very bad default to me!
>=20
> Your patch would force people to run system monitoring
> applications as root, because otherwise they cannot get
> some of the information they can get now.  Forcing that
> these applications run with root rights is a security
> risk, not a benefit...

Right, that's why I would say "fall back to the config. option"
behavior, trusting in a certain user group defined in configuration-time
or via sysctl, or just keeping it simple as it's right now, split up so
anyone can decide what to apply and what shouldn't be applied.

Cheers,
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-ICaMOgSGYXP5ToqNQ2Rg
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCZBGhDcEopW8rLewRAv5cAKCRu0uSU1pvmr7ERUHcvWo0JKdbGQCfU8JM
hBlX1V9ODCDCEQwaX3lK0n4=
=UD6Y
-----END PGP SIGNATURE-----

--=-ICaMOgSGYXP5ToqNQ2Rg--

