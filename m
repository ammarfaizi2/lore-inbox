Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263227AbUDZJU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263227AbUDZJU2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 05:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263598AbUDZJU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 05:20:28 -0400
Received: from ALe-Mans-201-1-4-214.w80-13.abo.wanadoo.fr ([80.13.245.214]:28289
	"EHLO isis.localnet.fr") by vger.kernel.org with ESMTP
	id S263227AbUDZJU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 05:20:26 -0400
Subject: Re: Input system and keycodes > 256
From: Benoit Plessis <benoit@plessis.info>
To: David =?ISO-8859-1?Q?G=F3mez?= <david@pleyades.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040426104850.GA791@fargo>
References: <1082938686.21842.50.camel@osiris.localnet.fr>
	 <20040426104850.GA791@fargo>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-hCCw+RQ4N2kTxRorBAAz"
Organization: Do you expect me to be organized ?
Message-Id: <1082971224.4815.6.camel@osiris.localnet.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 26 Apr 2004 11:20:24 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-hCCw+RQ4N2kTxRorBAAz
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-04-26 at 12:48, David G=C3=B3mez wrote:
> Hi Benoit ;),
>=20
> > There are two kind of addons keys, some works (scancode in the e0 XX
> > form): Email, Prev, Next, Play/Pause, Vol+/-, Mute, ...
> >  + some of thoses generate a simple keycode eg=20
> >      Vol+: 0x73 | 0xf3 (scancodes: 0xe0 0x30 | 0xe0 0xb0)
> >  + some doesn't eg:
> >      play: 0x00 0x81 0xa4 | 0x80 0x81 0xa4  (scancodes: 0xe0 0x22 | 0xe=
0
> > 0xa2)
>=20
> You could make them work using the 'setkeycodes' command to configure
> the kernel tables, so you can put some setkeycodes lines in your init
> scripts to make those extra keys always avaliable on your console.
>=20
> bye

Ok thanks for that,
in fact thoses key works under XFree so i doesn't exactly focus on them.
It's the other keys with 0x82 0xXX keycodes, no scancodes (maybe an
empty translation table ? for i've read that USB keyboard need one of
those) and that generate mouse click event under X that are really
bothering me.

--=20
Benoit Plessis		<benoit@plessis.info>	+33 6 77 42 78 32
<benoit.plessis@univ-lemans.fr>	   <benoit.plessis@tuxfamily.org>
<maverick@tuxfamily.org>	       <maverick@maverick.eu.org>
1024D/B4D74B76 B9A7 3697 661D 25FB A609  E69E 92CA FFAB B4D7 4B76



--=-hCCw+RQ4N2kTxRorBAAz
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAjNRXksr/q7TXS3YRAmpEAJ0bu/FFZs8PwT+2Ji58iVAz0V/dOwCfSG7V
rh0cpAzrMkLa1QJRaxgmAZs=
=KA6e
-----END PGP SIGNATURE-----

--=-hCCw+RQ4N2kTxRorBAAz--

