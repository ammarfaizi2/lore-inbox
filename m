Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272710AbTG1HgF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 03:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272712AbTG1HgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 03:36:04 -0400
Received: from mx02.qsc.de ([213.148.130.14]:61902 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S272710AbTG1Hf4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 03:35:56 -0400
Date: Mon, 28 Jul 2003 09:51:06 +0200
From: Wiktor Wodecki <wodecki@gmx.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] O10int for interactivity
Message-ID: <20030728075106.GA660@gmx.de>
References: <200307280112.16043.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
In-Reply-To: <200307280112.16043.kernel@kolivas.org>
X-message-flag: Linux - choice of the GNU generation
X-Operating-System: Linux 2.6.0-test2-O10 i686
X-PGP-KeyID: 182C9783
X-Info: X-PGP-KeyID, send an email with the subject 'public key request' to wodecki@gmx.de
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2003 at 01:12:16AM +1000, Con Kolivas wrote:
> Here is a fairly rapid evolution of the O*int patches for interactivity t=
hanks
> to Ingo's involvement.
>=20
> Changes:
> I've put in some defines to clarify where the numbers for MAX_SLEEP_AVG c=
ome=20
> from now, rather than the number being magic. In the process it increases=
 MSA=20
> every so slightly so that an average task that runs a full timeslice (102=
ms)=20
> will drop exactly one priority in that time.
>=20
> I've incorporated Ingo's fix for scheduling latency in a form that works =
for=20
> my patch, along with the other minor tweaks.
>=20
> The parent and child sleep avg on forking is set to just on the priority =
bonus=20
> value with each fork thus keeping their bonus the same but making them ve=
ry=20
> easy to tip to a lower priority.
>=20
> A tiny addition to ensure any task that runs gets charged one tick of=20
> sleep_avg.
>=20
> This patch is against 2.6.0-test1-mm2 patched up to O9int. An updated
> O9int with layout corrections was posted on my website. A full O10int pat=
ch
> against 2.6.0-test1 is available on my website.

okay, applied O10 on top of 2.6.0-test2. The same problem I wrote you
yesterday about O9, when starting OpenOffice and bzip2'ing in the
background OO becomes nearly unusable - I can type a sentence and watch
the characters appear. I don't know if this was always the case since I
haven't used OO before that much (need it for the university now)

--=20
Regards,

Wiktor Wodecki

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/JNXq6SNaNRgsl4MRAhjnAJ0b49OoMcdT1AgxcfJefmkVtp9x1wCfRbTq
oFZpepMMfWRcX05xhmw9fvE=
=Bq25
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
