Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265644AbUFOOKn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265644AbUFOOKn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 10:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265649AbUFOOKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 10:10:43 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:25563 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S265644AbUFOOKk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 10:10:40 -0400
Date: Tue, 15 Jun 2004 16:10:39 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Helge Hafting vs. make menuconfig help
Message-ID: <20040615141039.GF20632@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040615140206.A6153@beton.cybernet.src>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tckbdLYzcwSsUQa3"
Content-Disposition: inline
In-Reply-To: <20040615140206.A6153@beton.cybernet.src>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tckbdLYzcwSsUQa3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-06-15 14:02:06 +0000, Karel Kulhav=FD <clock@twibright.com>
wrote in message <20040615140206.A6153@beton.cybernet.src>:
> Hello
>=20
> Helge Hafting says that CONFIG_INPUT is about HID in general.
> make menuconfig help in 2.4.25 says that CONFIG_INPUT is about USB HID on=
ly.

HID is used in conjunction of USB input devices (USB mice, USB
keyboards, ...).

CONFIG_INPUT only gives you an API where you can process input events
with. For instance, look at the atkbd.c, sunkbd.c or lkkbd.c drivers.
They all send key strokes into the Input API (activated by
CONFIG_INPUT), but none of them actually uses USB (but the PS/2 keyboard
port or normal serial ports with non-standard plugs).

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--tckbdLYzcwSsUQa3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAzwNfHb1edYOZ4bsRAjiVAJ9TI2XwfVoCeQsB9oJYn2VG+x1ojwCfX9LR
nasemD8QbAqpUGHvHsBA5EI=
=GSmZ
-----END PGP SIGNATURE-----

--tckbdLYzcwSsUQa3--
