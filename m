Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318232AbSHZSXE>; Mon, 26 Aug 2002 14:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318234AbSHZSXE>; Mon, 26 Aug 2002 14:23:04 -0400
Received: from B508d.pppool.de ([213.7.80.141]:22424 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id <S318232AbSHZSXD>; Mon, 26 Aug 2002 14:23:03 -0400
Subject: Re: Linux 2.4.20-pre4-ac2
From: Daniel Egger <degger@fhm.edu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020826151526.3442@192.168.4.1>
References: <200208261035.g7QAZ4G19985@devserv.devel.redhat.com> 
	<20020826151526.3442@192.168.4.1>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-19JJHi4ks2Jm+x+TfchG"
X-Mailer: Ximian Evolution 1.0.7 
Date: 26 Aug 2002 18:23:57 +0200
Message-Id: <1030379037.17690.8.camel@sonja.de.interearth.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-19JJHi4ks2Jm+x+TfchG
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Mon, 2002-08-26 um 17.15 schrieb Benjamin Herrenschmidt:

> FYI, gmac is now obsolete and is replaced by the sungem
> driver.
=20
> I'll soon send a patch removing it entirely from the kernel
> source tree as there is no case where it works better than
> sungem on a given HW.

Indeed, I banged it hard on my PowerBook G4 and it works like=20
a charm and even in cases where gmac had occasional problems
like on wakeup or media-changes.

What are your plans to visualise the gmac removal in the config?
At the moment it's not exactly obvious that sungem will work
in place for gmac.

--=20
Servus,
       Daniel

--=-19JJHi4ks2Jm+x+TfchG
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9alYcchlzsq9KoIYRAmRqAJ0TOhrgzRfOYeYRHQzqpA/a+8n2ugCgqPM3
EsVh5IHk1bRXV3+AaZ5pFx8=
=FCDz
-----END PGP SIGNATURE-----

--=-19JJHi4ks2Jm+x+TfchG--

