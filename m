Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750909AbWAaOzh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750909AbWAaOzh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 09:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750912AbWAaOzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 09:55:37 -0500
Received: from lug-owl.de ([195.71.106.12]:41437 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1750909AbWAaOzh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 09:55:37 -0500
Date: Tue, 31 Jan 2006 15:55:35 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/11] LED: Add LED Class
Message-ID: <20060131145535.GW18336@lug-owl.de>
Mail-Followup-To: Richard Purdie <rpurdie@rpsys.net>,
	LKML <linux-kernel@vger.kernel.org>
References: <1138714882.6869.123.camel@localhost.localdomain> <1138714888.6869.125.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vowh9qpYCOVF+x5F"
Content-Disposition: inline
In-Reply-To: <1138714888.6869.125.camel@localhost.localdomain>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vowh9qpYCOVF+x5F
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-01-31 13:41:28 +0000, Richard Purdie <rpurdie@rpsys.net> wrote:
> Index: linux-2.6.15/include/linux/leds.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6.15/include/linux/leds.h	2006-01-29 16:03:21.000000000 +0000
> +enum led_brightness {
> +	LED_OFF =3D 0,
> +	LED_HALF =3D 127,
> +	LED_FULL =3D 255,
> +};
> +
> +struct led_device {
> +	/* A function to set the brightness of the led */
> +	void (*brightness_set)(struct led_device *led_dev, enum led_brightness =
brightness);

I somehow dislike using an enum being abused for a dimmed LED value...

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 f=C3=BCr einen Freien Staat voll Freier B=C3=BCrger"  | im Internet! |   i=
m Irak!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--vowh9qpYCOVF+x5F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFD33pnHb1edYOZ4bsRAhBEAKCLf95FVYbwJnuDphuI9MjA8c/BVQCfTcRD
M9Gf9IHm9J54MO3LH1d+KTo=
=xBjK
-----END PGP SIGNATURE-----

--vowh9qpYCOVF+x5F--
