Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261555AbVAXSGW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261555AbVAXSGW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 13:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261556AbVAXSGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 13:06:21 -0500
Received: from null.rsn.bth.se ([194.47.142.3]:52648 "EHLO null.rsn.bth.se")
	by vger.kernel.org with ESMTP id S261555AbVAXSGA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 13:06:00 -0500
Subject: Re: Linux 2.6.11-rc2
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: David Brownell <david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200501232251.42394.david-b@pacbell.net>
References: <200501232251.42394.david-b@pacbell.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-UKztF5Ro7qdrO2kal3wh"
Date: Mon, 24 Jan 2005 19:05:54 +0100
Message-Id: <1106589954.1085.5.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-UKztF5Ro7qdrO2kal3wh
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2005-01-23 at 22:51 -0800, David Brownell wrote:
> I'm seeing a problem with TCP as accessed through KMail (SuSE 9.2, x86_64=
).
> But oddly enough, only for sending mail, not reading it; and not through
> other (reading) applications... it's a regression with respect to rc1 and
> earlier kernels.  Basically, it can only send REALLY TINY emails...
>=20
> What ethereal shows me is roughly:
>=20
>  - SMTP connect, initial handshake, ok (ACKed later)
>  - Send two 1500 byte Ethernet packets
>  - Each gets an ICMP destination unreachable, frag needed, next hop MTU 1=
492
>  - ... all retransmits are 1500 bytes not 1492, triggering ICMPs ...
>=20
> Naturally the connection goes nowhere. =20

Is there a firewall on this machine? And if so, do you allow inbound
icmp?

--=20
/Martin

--=-UKztF5Ro7qdrO2kal3wh
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBB9TkCWm2vlfa207ERApSrAJ43GEjNyp5lcXN1gHd/jrN7GT15fgCgl79z
zM1+VlsJe2Nvot4vA3ZXUqQ=
=Z2wN
-----END PGP SIGNATURE-----

--=-UKztF5Ro7qdrO2kal3wh--
