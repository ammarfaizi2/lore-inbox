Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318731AbSG0Ko2>; Sat, 27 Jul 2002 06:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318732AbSG0Ko2>; Sat, 27 Jul 2002 06:44:28 -0400
Received: from B5810.pppool.de ([213.7.88.16]:8969 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id <S318731AbSG0Ko2>; Sat, 27 Jul 2002 06:44:28 -0400
Subject: Re: Problems assigning IRQs on Sony R505ECK laptop
From: Daniel Egger <degger@fhm.edu>
To: Aaron Gaudio <prothonotar@tarnation.dyndns.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020726114157.A11147@tarnation.dyndns.org>
References: <20020726114157.A11147@tarnation.dyndns.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-03AkXTWIBxUTInjPBA7g"
X-Mailer: Ximian Evolution 1.0.7 
Date: 27 Jul 2002 12:48:23 +0200
Message-Id: <1027766903.22179.31.camel@sonja.de.interearth.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-03AkXTWIBxUTInjPBA7g
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Fre, 2002-07-26 um 17.41 schrieb Aaron Gaudio:

> Hi all. I'm having trouble with linux finding IRQs for several
> devices on my Sony R505ECK laptop (just got it yesterday :)

I've seen similar troubles on a different Vaio (unfortunately I don't
have the model number handy). Basically what happens is that the
Local-APIC seemingly isn't initialised correctly, all bridges in the
system are treated transparently and all devices get the same IRQ (9)
assigned. The system works just fine but I guess not as efficient as
it could go because of the interrupt storm on IRQ 9. I can get get all
data from this machine if someone wants to debug this problem.

--=20
Servus,
       Daniel

--=-03AkXTWIBxUTInjPBA7g
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9Qnp3chlzsq9KoIYRAlFTAKDFedMDKgCsY4pPl+dGjoevX2dheACePZTV
omxw6Vh8se6EwQ3OdgpAnzc=
=NFoL
-----END PGP SIGNATURE-----

--=-03AkXTWIBxUTInjPBA7g--

