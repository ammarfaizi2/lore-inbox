Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262812AbTDATq0>; Tue, 1 Apr 2003 14:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262810AbTDATqZ>; Tue, 1 Apr 2003 14:46:25 -0500
Received: from B583e.pppool.de ([213.7.88.62]:49568 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id <S262812AbTDATqY>; Tue, 1 Apr 2003 14:46:24 -0500
Subject: Re: PATCH: allow percentile size of tmpfs (2.5.66 / 2.4.20-pre2)
From: Daniel Egger <degger@fhm.edu>
To: Hugh Dickins <hugh@veritas.com>
Cc: Christoph Rohland <cr@sap.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0304012020290.1253-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0304012020290.1253-100000@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-8HbHInCRAP8OPoYPYfJc"
Organization: 
Message-Id: <1049227067.11985.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 01 Apr 2003 21:57:48 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-8HbHInCRAP8OPoYPYfJc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Die, 2003-04-01 um 21.25 schrieb Hugh Dickins:

> Simply because quite a lot of the tmpfs code is concerned with moving
> pages between ram and swap: if you've limited ram and no swap, you may
> not want to waste your ram on that code!  One day I might try applying
> #ifdef CONFIG_SWAPs within mm/shmem.c; but I might well not, it could
> get ugly, and looks rudimentary elsewhere - do we intend to get serious
> about CONFIG_SWAP?

It would be more waste to have both ramfs and tmpfs in compiled form
since the whole system is intended to run on embedded systems with CF as
well as on faster machines with harddrive and swap.

--=20
Servus,
       Daniel

--=-8HbHInCRAP8OPoYPYfJc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+ie87chlzsq9KoIYRAneEAJ4q74+mL3ZgSkYzIGOJjW22gMsVAQCgw70T
vdqvs/8b7zPjVsU9lSjzEWU=
=rb0b
-----END PGP SIGNATURE-----

--=-8HbHInCRAP8OPoYPYfJc--

