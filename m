Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266864AbUFYW46@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266864AbUFYW46 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 18:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266886AbUFYW46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 18:56:58 -0400
Received: from smtp07.auna.com ([62.81.186.17]:49549 "EHLO smtp07.retemail.es")
	by vger.kernel.org with ESMTP id S266864AbUFYW4z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 18:56:55 -0400
Date: Sat, 26 Jun 2004 00:56:54 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: linux-kernel@vger.kernel.org
Subject: Re: Scheduler: -mm vs -staircase
Message-ID: <20040625225654.GC4453@werewolf.able.es>
References: <20040625221042.GA4453@werewolf.able.es>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature"; boundary="gatW/ieO32f1wygP"
Content-Disposition: inline
In-Reply-To: <20040625221042.GA4453@werewolf.able.es> (from jamagallon@able.es on Sat, Jun 26, 2004 at 00:10:42 +0200)
X-Mailer: Balsa 2.0.17
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gatW/ieO32f1wygP
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On 06.26, J.A. Magallon wrote:
> Hi all...
>=20
> Just a comment about a weird thing I have noticed wrt scheduling in latest
> kernels.
>=20
> My last two tests are 2.6.7-mm2 and 2.6.7-mm2+staircase-7.4 (plus a couple
> other things, like aic updated driver). I use GLMatrix as screensaver,
> running with nVidia drivers (yup, tainted kernels, but both are tainted ;=
)).
> What I have noticed:
> - With standard -mm, as GLMatrix runs, the framerate drops even to someth=
ing
>   like a frame every couple seconds
> - With staircase, it keeps running smoothly at 25fps.
>=20
> Something is strange in -mm. It keeps stoling cycles to the screensaver.
> Is this expected ?
>=20

Sorry for the noise, it also happens with -staircase.
Lets remake the question.
I start /usr/lib/xscreensaver/glmatrix -fps, and the frame rate starts at
25 fps. In 30 seconds it has dropped to 6 fps. The app is still using=20
the same cpu time (about 90% of one cpu on a dual xeon box with ht).

Any ideas ?

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandrakelinux release 10.1 (Cooker) for i586
Linux 2.6.7-jam5 (gcc 3.4.1 (Mandrakelinux (Cooker) 3.4.1-0.3mdk)) #1

--gatW/ieO32f1wygP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA3K22RlIHNEGnKMMRAmixAJ9z1RLORgzGj9NL3UwH93cU2G599QCgh9g2
zjKttEPYDrJhjAp3V0DxFok=
=n2Rm
-----END PGP SIGNATURE-----

--gatW/ieO32f1wygP--
