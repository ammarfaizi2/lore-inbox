Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbTIZKlq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 06:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262053AbTIZKlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 06:41:46 -0400
Received: from smtp6.clb.oleane.net ([213.56.31.26]:5349 "EHLO
	smtp6.clb.oleane.net") by vger.kernel.org with ESMTP
	id S261195AbTIZKlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 06:41:44 -0400
Subject: Re: Keyboard oddness.
From: Nicolas Mailhot <Nicolas.Mailhot@laposte.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030926102403.GA8864@ucw.cz>
References: <1064569422.21735.11.camel@ulysse.olympe.o2t>
	 <20030926102403.GA8864@ucw.cz>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-u4xkYd7+eNJE+/C/oMw9"
Organization: Adresse personelle
Message-Id: <1064572898.21735.17.camel@ulysse.olympe.o2t>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-7) 
Date: Fri, 26 Sep 2003 12:41:38 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-u4xkYd7+eNJE+/C/oMw9
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

Le ven 26/09/2003 =E0 12:24, Vojtech Pavlik a =E9crit :
> On Fri, Sep 26, 2003 at 11:43:43AM +0200, Nicolas Mailhot wrote:
> > Vojtech Pavlik  wrote:

[...]

> > Couldn't it at least detect there's a problem ? Most people I know do n=
ot press a key
> > 2000+ times in a row during normal activity.
>=20
> You do. Scrolling up/down in a document is one example. And there is no
> point to limit the repeat to say 80 or 200 characters. You would still
> hate having 80 repeated characters and then it stopping.

Well then only allow monster autorepeats for arrows then.
(they are never stuck in my board anyway;)

> The problem really is there is no way to detect it. My latest patches
> should fix this for AT keyboards by not using software autorepeat for
> them.
>=20
> Of course this won't fix any problems with USB, if there are still any.
> My USB keyboard works just perfectly, no problems with the autorepeat.

Well mine doesn't:(. I seem to have gathered from past threads that HID
makes the full keyboard status available at all time (unlike AT which
only provides push/release events). Couldn't the repeat code just
double-check the key is really stuck every ten repeats for example ?

Cheers

--=20
Nicolas Mailhot

--=-u4xkYd7+eNJE+/C/oMw9
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/dBffI2bVKDsp8g0RAhiFAKDc0LnUiqPP82YxMll+s3C/W+3jDgCg4i3c
fcZW49gAII/sBpBz//X+X8w=
=n4xw
-----END PGP SIGNATURE-----

--=-u4xkYd7+eNJE+/C/oMw9--

