Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbUEDVbm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbUEDVbm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 17:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261162AbUEDVbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 17:31:42 -0400
Received: from ALe-Mans-201-1-2-107.w193-253.abo.wanadoo.fr ([193.253.34.107]:26498
	"EHLO isis.localnet.fr") by vger.kernel.org with ESMTP
	id S261169AbUEDVbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 17:31:06 -0400
Subject: Re: Input system and keycodes > 256
From: Benoit Plessis <benoit@plessis.info>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20040428234841.GA4068@pclin040.win.tue.nl>
References: <1082938686.21842.50.camel@osiris.localnet.fr>
	 <20040428234841.GA4068@pclin040.win.tue.nl>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-dA2lC/WEd6QldNE+aBQk"
Organization: Do you expect me to be organized ?
Message-Id: <1083706264.16600.8.camel@osiris.localnet.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 04 May 2004 23:31:04 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-dA2lC/WEd6QldNE+aBQk
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-04-29 at 01:48, Andries Brouwer wrote:
> On Mon, Apr 26, 2004 at 02:18:07AM +0200, Benoit Plessis wrote:
>=20
> > When grabbing with 'showkey -s' nothing appear
> > When grabbing with 'showkey' i got keycodes like '0x00 0x82 0xd0 | 0x80
> > 0x82 0xd0' (i got same keycodes when pressing mouse buttons except thos=
e
> > are in 0x82 0x90 -> 0x82 0x97 range)
>=20
> What version of showkey are you using?
showkey: (console-tools) 0.2.3=20
(maybe modified by debian: console-tools_0.2.3dbs-52)

Actually while working with the Input Event system for my mouse under
Xfree (started by hacking moudev to support eigth button mouse and
remove the 'double' press on my Forward button (one press from the
Logitech Cruise mode, and another from the conversion in mousedev (and
not accurate), and after that creating an Input Event mouse driver for
XFree) i found another weird thing (not investigated for now): All
'extra' keys of the Keyboard (the standard one: play/pause/mail/... and
the new which doesn't work) generate events on the same device than the
mouse (but the normal keys goes to another event device).

--=20
Benoit Plessis		<benoit@plessis.info>	+33 6 77 42 78 32
<benoit.plessis@univ-lemans.fr>	   <benoit.plessis@tuxfamily.org>
<maverick@tuxfamily.org>	       <maverick@maverick.eu.org>
1024D/B4D74B76 B9A7 3697 661D 25FB A609  E69E 92CA FFAB B4D7 4B76



--=-dA2lC/WEd6QldNE+aBQk
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAmAuXksr/q7TXS3YRAhd3AKCMjWTWUQyrcU+qohosTymHTS3v1wCaArh6
fQyNSzjNIkkJA0l3nqGDF1Q=
=YkY8
-----END PGP SIGNATURE-----

--=-dA2lC/WEd6QldNE+aBQk--

