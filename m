Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265708AbSLJT5B>; Tue, 10 Dec 2002 14:57:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265711AbSLJT5B>; Tue, 10 Dec 2002 14:57:01 -0500
Received: from D01b4.pppool.de ([80.184.1.180]:10391 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id <S265708AbSLJT5A>; Tue, 10 Dec 2002 14:57:00 -0500
Subject: Re: Why does C3 CPU downgrade in kernel 2.4.20?
From: Daniel Egger <degger@fhm.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1039539080.14302.29.camel@irongate.swansea.linux.org.uk>
References: <009f01c2a000$f38885d0$3716a8c0@taipei.via.com.tw>
	 <20021210055215.GA9124@suse.de>  <1039504941.30881.10.camel@sonja>
	 <1039539080.14302.29.camel@irongate.swansea.linux.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-QEHMVEKr2bxxu35dPe8V"
Organization: 
Message-Id: <1039549178.7224.7.camel@sonja>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 10 Dec 2002 20:39:38 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-QEHMVEKr2bxxu35dPe8V
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Die, 2002-12-10 um 17.51 schrieb Alan Cox:

> Well if you optimise for ppro it won't actually always work.=20

Yeah, I had to learn earlier that it seems to support certain=20
kind of cmovs but certainly not all of them and some other
instructions seem also to be missing.

> Also thescheduling seems to be best with 486.
> Remember the C3 is a single issue risc processor.

Do you have pointers to some optimisation manual or whatever?
gcc currently defines the c3 as 486+mmx+3dnow however I doubt=20
that this model is entirely correct and as such leaves some=20
space for improvements.

> --=20
> Servus,
>        Daniel

--=-QEHMVEKr2bxxu35dPe8V
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA99kL6chlzsq9KoIYRAn7lAKDl5iHhDDN8qvttpgZCAmDFHCdPngCg1Par
YC/MiKbWxD8cd6b5gjpfOlw=
=3cQP
-----END PGP SIGNATURE-----

--=-QEHMVEKr2bxxu35dPe8V--

