Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263335AbTIAWZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 18:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263336AbTIAWZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 18:25:56 -0400
Received: from c-780372d5.012-136-6c756e2.cust.bredbandsbolaget.se ([213.114.3.120]:5588
	"EHLO pomac.netswarm.net") by vger.kernel.org with ESMTP
	id S263335AbTIAWZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 18:25:54 -0400
Subject: Re: [SHED] Questions.
From: Ian Kumlien <pomac@vapor.com>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1062389038.1313.39.camel@boobies.awol.org>
References: <1062324435.9959.56.camel@big.pomac.com>
	 <1062355996.1313.4.camel@boobies.awol.org>
	 <1062358285.5171.101.camel@big.pomac.com>
	 <1062359478.1313.9.camel@boobies.awol.org>
	 <1062369684.9959.166.camel@big.pomac.com>
	 <1062373274.1313.28.camel@boobies.awol.org>
	 <1062374409.5171.194.camel@big.pomac.com>
	 <1062389038.1313.39.camel@boobies.awol.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-GNsjaSK8J+u+uskxVovI"
Message-Id: <1062455078.9959.207.camel@big.pomac.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 02 Sep 2003 00:24:38 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-GNsjaSK8J+u+uskxVovI
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-09-01 at 06:03, Robert Love wrote:
> On Sun, 2003-08-31 at 20:00, Ian Kumlien wrote:
>=20
> > Then i'm beginning to agree with the time unit... Large timeslice but i=
n
> > units for high pri tasks... So that high pri can run (if needed) 2 or 3
> > times / timeslice.
>=20
> Exactly.
>=20
> > > This implies that a high priority, which has exhausted its timeslice,
> > > will not be allowed to run again until _all_ other runnable tasks
> > > exhaust their timeslice (this ignores the reinsertion into the active
> > > array of interactive tasks, but that is an optimization that just
> > > complicates this discussion).
> >=20
> > So it's penalised by being in the corner for one go? or just pri
> > penalised (sounds like it could get a corner from what you wrote... Or
> > is it time for bed).
>=20
> Not penalized... all tasks go through the same thing.

Yeah, that part was unclear though. =3D)

[Snip: Thanks for the explanation i'll reply in Con's mail if needed ]

> But Unix is designed for timesharing among many interactive tasks.  It
> works.  The problem faced today in 2.6 is juggling throughput versus
> latency in the scheduler, with the interactivity estimator.

Yeah...

--=20
Ian Kumlien <pomac@vapor.com>

--=-GNsjaSK8J+u+uskxVovI
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/U8cm7F3Euyc51N8RAndfAJwOIS4XgvWMv6TjFJjdvq9W3wDQ5wCfcyZx
zJvg6Wycmjfv5Iq+7LpQi8Q=
=aq4g
-----END PGP SIGNATURE-----

--=-GNsjaSK8J+u+uskxVovI--

