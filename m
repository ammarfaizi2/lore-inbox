Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318310AbSHPLV7>; Fri, 16 Aug 2002 07:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318312AbSHPLV7>; Fri, 16 Aug 2002 07:21:59 -0400
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:35087 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id <S318310AbSHPLV5>; Fri, 16 Aug 2002 07:21:57 -0400
Date: Fri, 16 Aug 2002 12:25:47 +0100
To: Jurgen Kramer <gtm.kramer@inter.nl.net>
Cc: Muli Ben-Yehuda <mulix@actcom.co.il>, linux-kernel@vger.kernel.org
Subject: Re: sound choking with trident driver (SiS 7018)
Message-ID: <20020816122547.A5843@computer-surgery.co.uk>
References: <1029409909.1121.17.camel@paragon.slim> <20020815121602.GI6772@alhambra.actcom.co.il> <1029495244.1294.2.camel@paragon.slim>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1029495244.1294.2.camel@paragon.slim>; from gtm.kramer@inter.nl.net on Fri, Aug 16, 2002 at 12:54:03PM +0200
From: Roger Gammans <roger@computer-surgery.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2002 at 12:54:03PM +0200, Jurgen Kramer wrote:
> I have just tried the driver from 2.4.20pre2. No change in behavior. The
> sound still chokes every few seconds. Any ideas what might cause this
> problem? It doesn't have to be the sound driver.
>=20
> I will give 2.5 another go.=20

Hmm.

I've seen this behavour on windwows as well. (I don't have any=20
linux desktops with the chipset atm. Servers yes - but we don't
normally install sound drivers on severs ;-)).

The machines I see this on are Athlon 1600XP with SIS5513 chipset
and an AMI bios.

Over in 'dozeland the problem was fixed by turning IDE DMA off, I
had characterised the problem as being due to I/o bandwidth
starvation, possibly due to a poorly set up DMAC. But given it
was doze I couldn't really investigate.

Phaps 2.5 IDE changes are more relavant.

Does information this help? ;-).


--=20
Roger.
Master of Peng Shui.  (Ancient oriental art of Penguin Arranging)
GPG Key FPR: CFF1 F383 F854 4E6A 918D  5CFF A90D E73B 88DE 0B3E

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9XOE6qQ3nO4jeCz4RAvyGAKCZxhpXn19vXBdFxVz5TuNLVtjGBwCdG/KJ
naHSlkxZMqvmqXo78KMzAUk=
=m4ot
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
