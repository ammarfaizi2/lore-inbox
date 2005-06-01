Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261174AbVFAKMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbVFAKMc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 06:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbVFAKMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 06:12:31 -0400
Received: from lug-owl.de ([195.71.106.12]:44456 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S261174AbVFAKMX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 06:12:23 -0400
Date: Wed, 1 Jun 2005 12:12:22 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Cc: Nico Schottelius <nico-kernel@schottelius.org>
Subject: Re: Parallel Port: Settings PINs on?
Message-ID: <20050601101222.GO2417@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Nico Schottelius <nico-kernel@schottelius.org>
References: <20050601100150.GB27717@schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5UgT1ku+qTHnlONB"
Content-Disposition: inline
In-Reply-To: <20050601100150.GB27717@schottelius.org>
X-Operating-System: Linux mail 2.6.11.10lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5UgT1ku+qTHnlONB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-06-01 12:01:50 +0200, Nico Schottelius <nico-kernel@schotteliu=
s.org> wrote:
> Is it possible to select (in userspace) which pins
> should be enabled or do I have to write a kernel driver
> for that?

There's already a driver available for exactly this purpose: ppdev.

At http://lug-owl.de/~jbglaw/software/steckdose/steckdose.c is a program
I wrote for controlling a shift register (serial in, parallel out) with
relays attached (to switch on/off computers or to reset them). This
should help you for a start. (Basically, open/claim the port and set the
bits of the DATA port via an ioctl())

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 fuer einen Freien Staat voll Freier B=C3=BCrger" | im Internet! |   im Ira=
k!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--5UgT1ku+qTHnlONB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCnYoGHb1edYOZ4bsRAqJ7AJ9SkcWMcV1M06LOvCW6qBCfNsC8qwCfZqW9
Kd3DSeEExl2csAYTexvNK6M=
=BsQQ
-----END PGP SIGNATURE-----

--5UgT1ku+qTHnlONB--
