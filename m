Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270725AbTGUUm4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 16:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270726AbTGUUm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 16:42:56 -0400
Received: from mailf.telia.com ([194.22.194.25]:7679 "EHLO mailf.telia.com")
	by vger.kernel.org with ESMTP id S270725AbTGUUmz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 16:42:55 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
Subject: Re: driver error in mm2 compilation
From: Christian Axelsson <smiler@lanil.mine.nu>
To: Pedro Ribeiro <deadheart@netcabo.pt>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3F1CA198.2040603@netcabo.pt>
References: <3F1CA198.2040603@netcabo.pt>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-G2txtyu4FZChumXpHIz0"
Message-Id: <1058821069.11592.2.camel@sm-wks1.lan.irkk.nu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 21 Jul 2003 22:57:50 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-G2txtyu4FZChumXpHIz0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-07-22 at 04:29, Pedro Ribeiro wrote:
> I get this error when I try to compile mm2:
>=20
> drivers/video/riva/fbdev.c: In function `rivafb_cursor':
> drivers/video/riva/fbdev.c:1525: warning: passing arg 2 of=20
> `move_buf_aligned' from incompatible pointer type
> drivers/video/riva/fbdev.c:1525: warning: passing arg 4 of=20
> `move_buf_aligned' makes pointer from integer without a cast
> drivers/video/riva/fbdev.c:1525: too few arguments to function=20
> `move_buf_aligned'
> drivers/video/riva/fbdev.c:1527: warning: passing arg 2 of=20
> `move_buf_aligned' from incompatible pointer type
> drivers/video/riva/fbdev.c:1527: warning: passing arg 4 of=20
> `move_buf_aligned' makes pointer from integer without a cast
> drivers/video/riva/fbdev.c:1527: too few arguments to function=20
> `move_buf_aligned'
> make[3]: *** [drivers/video/riva/fbdev.o] Error 1
> make[2]: *** [drivers/video/riva] Error 2
> make[1]: *** [drivers/video] Error 2
> make: *** [drivers] Error 2

The rivafb driver is broken. It's beeing worked on by James Simmons.

--=20
Christian Axelsson
  smiler@lanil.mine.nu

GPG ID:
  6C3C55D9 @ ldap://keyserver.pgp.com

--=-G2txtyu4FZChumXpHIz0
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/HFPNyqbmAWw8VdkRArOmAJ9eSlKrdDFECiLDVk6OmcYYWu5mNwCgsNJz
gVc6S2gUjYSFCr4eNCFuwPY=
=pxeU
-----END PGP SIGNATURE-----

--=-G2txtyu4FZChumXpHIz0--

