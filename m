Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266890AbUFYXja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266890AbUFYXja (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 19:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266892AbUFYXja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 19:39:30 -0400
Received: from smtp06.auna.com ([62.81.186.16]:6280 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S266890AbUFYXj1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 19:39:27 -0400
Date: Sat, 26 Jun 2004 01:39:25 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: linux-kernel@vger.kernel.org
Subject: Re: Scheduler: -mm vs -staircase
Message-ID: <20040625233925.GA7857@werewolf.able.es>
References: <20040625221042.GA4453@werewolf.able.es> <20040625225654.GC4453@werewolf.able.es> <20040626012620.0622a3af.diegocg@teleline.es>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <20040626012620.0622a3af.diegocg@teleline.es> (from diegocg@teleline.es on Sat, Jun 26, 2004 at 01:26:20 +0200)
X-Mailer: Balsa 2.0.17
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On 06.26, Diego Calleja Garc=EDa wrote:
> El Sat, 26 Jun 2004 00:56:54 +0200 "J.A. Magallon" <jamagallon@able.es> e=
scribi=F3:
>=20
>=20
> > I start /usr/lib/xscreensaver/glmatrix -fps, and the frame rate starts =
at
> > 25 fps. In 30 seconds it has dropped to 6 fps. The app is still using=
=20
> > the same cpu time (about 90% of one cpu on a dual xeon box with ht).
>=20
> For that particular screensaver, notice that glmatrix starts drawing noth=
ing.
> 30 seconds after the start there're lots of polygons so after 20 seconds
> it needs more processing power. It happens exactly the same
> but the difference is not so big, from 30fps to 24fps, perhaps
> you didn't enabled DRI acceleration?

This is very strange.
As I was logged in, gears gave aout 60 fps, and glmatrix degraded over time.
I have logged out and in, and gears is back to its 750 fps (GeForce FX 5200)
and glmatrix runs fine at a constant 30 fps rate (2.6.7-mm2+staircase).

raro, raro...

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandrakelinux release 10.1 (Cooker) for i586
Linux 2.6.7-jam5 (gcc 3.4.1 (Mandrakelinux (Cooker) 3.4.1-0.3mdk)) #1

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA3LetRlIHNEGnKMMRAqt0AJ9J/+fkUEmFM+sUG/+3xhh4WJ73ogCcCskX
unj8ld2Ktw+2y5BBje99a9w=
=2c1H
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
