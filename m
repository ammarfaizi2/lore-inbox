Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266686AbSLJHOl>; Tue, 10 Dec 2002 02:14:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266690AbSLJHOl>; Tue, 10 Dec 2002 02:14:41 -0500
Received: from B537e.pppool.de ([213.7.83.126]:44433 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id <S266686AbSLJHOk>; Tue, 10 Dec 2002 02:14:40 -0500
Subject: Re: Why does C3 CPU downgrade in kernel 2.4.20?
From: Daniel Egger <degger@fhm.edu>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Joseph <jospehchan@yahoo.com.tw>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20021210055215.GA9124@suse.de>
References: <009f01c2a000$f38885d0$3716a8c0@taipei.via.com.tw>
	 <20021210055215.GA9124@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-GKAREn4Lr3VK9e5oeToV"
Organization: 
Message-Id: <1039504941.30881.10.camel@sonja>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 10 Dec 2002 08:22:21 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-GKAREn4Lr3VK9e5oeToV
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Die, 2002-12-10 um 06.52 schrieb Dave Jones:

> I believe someone (Jeff Garzik?) benchmarked gcc code generation,
> and the C3 executed code scheduled for a 486 faster than it did for
> -m586
> I'm not sure about the alignment flags. I've been meaning to look
> into that myself...

Interesting. I have no clue about which C3 you're talking about here but
a VIA Ezra has all 686 instructions including cmov and thus optimising=20
for PPro works best for me.

Prolly I would have to do more benchmarking to find out about aligment
advantages.

--=20
Servus,
       Daniel

--=-GKAREn4Lr3VK9e5oeToV
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA99ZYschlzsq9KoIYRAndtAJ9pct3xcLKtbycXLfj++luJVMQS7QCff43P
kVPnjxVF7SAr149N5/7Otms=
=BWQQ
-----END PGP SIGNATURE-----

--=-GKAREn4Lr3VK9e5oeToV--

