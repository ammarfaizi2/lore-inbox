Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262598AbVBBRjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbVBBRjb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 12:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262477AbVBBRjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 12:39:31 -0500
Received: from vds-320151.amen-pro.com ([62.193.204.86]:22715 "EHLO
	vds-320151.amen-pro.com") by vger.kernel.org with ESMTP
	id S262420AbVBBRjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 12:39:09 -0500
Subject: Re: [PATCH] OpenBSD Networking-related randomization port
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: linux@horizon.com
Cc: mingo@elte.hu, Arjan van de Ven <arjan@infradead.org>, bunk@stusta.de,
       Chris Wright <chrisw@osdl.org>, davem@redhat.com,
       Hank Leininger <hlein@progressive-comp.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com, shemminger@osdl.org, Valdis.Kletnieks@vt.edu,
       spender@grsecurity.net
In-Reply-To: <20050202171702.24523.qmail@science.horizon.com>
References: <20050202171702.24523.qmail@science.horizon.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-JOyczWpX46u3ytv/yRYL"
Date: Wed, 02 Feb 2005 18:38:37 +0100
Message-Id: <1107365917.3754.155.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-JOyczWpX46u3ytv/yRYL
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

El mi=E9, 02-02-2005 a las 17:17 +0000, linux@horizon.com escribi=F3:
> There *are* things in OpenBSD, like randomized port assignment (as oppose=
d
> to the linear scan in tcp_v4_get_port()) that would be worth emulating.
> Maybe worry about that first?
>=20

Completely agreed with you, I was just trying to help with split up
patches, but, as your analysis shows, it's more a weak implementation
than a real security improvement.

All I can say, just ignore the patch.I will work on other (worthy)
issues that are in a bigger need.

Maybe I would work something out on randomized source ports, as soon as
I get time for it.

Note also that Brad fixed obsd_rand.c code this week, I've added him to
the CC list because there are things that may concern grSecurity he
should be able to comment further on it and discuss whatever concerns
*his* work (which is, BTW, a good thing (tm) to have in mind even if he
didn't send split up patches for each feature, which I really don't
know).

I've just ported it out of grsecurity.

Thanks for your meaningful comments,
Cheers.
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-JOyczWpX46u3ytv/yRYL
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD4DBQBCARAdDcEopW8rLewRAk/FAJwO9z7+G3+j67CGEDEDy/CJ5NnnKACY3VxJ
3SkgAMBcW3GKrhQGvVNXFg==
=yQ6v
-----END PGP SIGNATURE-----

--=-JOyczWpX46u3ytv/yRYL--

