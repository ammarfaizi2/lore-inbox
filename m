Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264201AbTICXD4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 19:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264345AbTICXD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 19:03:56 -0400
Received: from c-780372d5.012-136-6c756e2.cust.bredbandsbolaget.se ([213.114.3.120]:1758
	"EHLO pomac.netswarm.net") by vger.kernel.org with ESMTP
	id S264338AbTICXDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 19:03:53 -0400
Subject: Re: [SHED] Questions.
From: Ian Kumlien <pomac@vapor.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Con Kolivas <kernel@kolivas.org>, Daniel Phillips <phillips@arcor.de>,
       linux-kernel@vger.kernel.org, Robert Love <rml@tech9.net>
In-Reply-To: <3F552C70.2030109@cyberone.com.au>
References: <1062324435.9959.56.camel@big.pomac.com>
	 <200309011707.20135.phillips@arcor.de>
	 <1062457396.9959.243.camel@big.pomac.com>
	 <200309021023.24763.kernel@kolivas.org>
	 <1062498307.5171.267.camel@big.pomac.com>
	 <3F547A4B.7060309@cyberone.com.au>
	 <1062523374.5171.321.camel@big.pomac.com>
	 <3F552C70.2030109@cyberone.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-8OQ+O4lCx5EFAH2I0iBO"
Message-Id: <1062630148.9959.680.camel@big.pomac.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 04 Sep 2003 01:02:29 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-8OQ+O4lCx5EFAH2I0iBO
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-09-03 at 01:49, Nick Piggin wrote:
> Ian Kumlien wrote:
> >When you reach a certain load you *have to* allow starvation. Ie, you
> >can't work around it... All i say is that if we have a more relaxed
> >method we might benefit from it.

> Depending on your definition. If 1000 processes get 10ms CPU every
> 10000ms I would not call that being starved. Maybe thats misleading.

[Sorry, i'm tired, i hope this comes out right ]

What i'm thinking of is more of a, "Hey, hog, we didn't manage to get
you in on this 'system wide schedule' (doing all the tasks before
restarting) due to heavy load, so we'll give you this boost so that you
can compete better next time".

> >And not the amount of cpu consumed by the app / go?

> Well yeah in a way. Consuming CPU lowers priority, sleeping raises.

Thought so. And afair it does use "timeslice useage" at one time or has
that changed?


> >Mail me if you're interested as well.

> OK CC me

As soon as Con has me straight on a few things... =3D)

--=20
Ian Kumlien <pomac@vapor.com>

--=-8OQ+O4lCx5EFAH2I0iBO
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/VnME7F3Euyc51N8RAsHxAJ0YYgftRtzL2DXnPi8Uug0e/77ABwCcC60R
03J3kspRDhpWyVicRjit8Q4=
=x+aP
-----END PGP SIGNATURE-----

--=-8OQ+O4lCx5EFAH2I0iBO--

