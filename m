Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261272AbUKXHkG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261272AbUKXHkG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 02:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262444AbUKXHiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 02:38:15 -0500
Received: from lug-owl.de ([195.71.106.12]:35230 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S262531AbUKXHg2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 02:36:28 -0500
Date: Wed, 24 Nov 2004 08:36:28 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: tulip question: tulip.o vs de4x5.o
Message-ID: <20041124073628.GJ2067@lug-owl.de>
Mail-Followup-To: Justin Piszcz <jpiszcz@lucidpixels.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0411231216470.3740@p500>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/0U0QBNx7JIUZLHm"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0411231216470.3740@p500>
X-Operating-System: Linux mail 2.6.10-rc2-bk5lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/0U0QBNx7JIUZLHm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-11-23 12:28:54 -0500, Justin Piszcz <jpiszcz@lucidpixels.com>
wrote in message <Pine.LNX.4.61.0411231216470.3740@p500>:
> Each driver works, I have not benchmarked performance with one over the=
=20
> other with ttcp yet; however, does anyone have any experience with using=
=20
> one over the other? I see the tulip has several options and the de4x5=20
> seems to be a rather generic driver.

The de4x5 driver supports some older revisions of the tulip chipset
which aren't supported by the tulip driver. I guess it could be made to
support those, too, but nobody did that up to now.

You can actually see the difference on older Alphas: de4x5 works while
tulip doesn't transmit or receive a single packet (getting netdev
watchdogs later on...).

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Irak! =
  O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--/0U0QBNx7JIUZLHm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBpDn7Hb1edYOZ4bsRAn6VAJoDKCmaIlkTz/3wwXO1bc0dN7pczgCeM9H0
//NZCvQR41qkEQzyL9u4E+k=
=AjA5
-----END PGP SIGNATURE-----

--/0U0QBNx7JIUZLHm--
