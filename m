Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266883AbUFYWLX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266883AbUFYWLX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 18:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266337AbUFYWLX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 18:11:23 -0400
Received: from smtp07.auna.com ([62.81.186.17]:41090 "EHLO smtp07.retemail.es")
	by vger.kernel.org with ESMTP id S266881AbUFYWKo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 18:10:44 -0400
Date: Sat, 26 Jun 2004 00:10:42 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Scheduler: -mm vs -staircase
Message-ID: <20040625221042.GA4453@werewolf.able.es>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
X-Mailer: Balsa 2.0.17
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all...

Just a comment about a weird thing I have noticed wrt scheduling in latest
kernels.

My last two tests are 2.6.7-mm2 and 2.6.7-mm2+staircase-7.4 (plus a couple
other things, like aic updated driver). I use GLMatrix as screensaver,
running with nVidia drivers (yup, tainted kernels, but both are tainted ;)).
What I have noticed:
- With standard -mm, as GLMatrix runs, the framerate drops even to something
  like a frame every couple seconds
- With staircase, it keeps running smoothly at 25fps.

Something is strange in -mm. It keeps stoling cycles to the screensaver.
Is this expected ?

TIA

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandrakelinux release 10.1 (Cooker) for i586
Linux 2.6.7-jam5 (gcc 3.4.1 (Mandrakelinux (Cooker) 3.4.1-0.3mdk)) #1

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA3KLiRlIHNEGnKMMRAtiBAJ9XcbNecIsw5hEaOjaWu0/DYkOWuQCgodJ1
gy48qMkIjrXGSLr16VRFLAM=
=OJNh
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
