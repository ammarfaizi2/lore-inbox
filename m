Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264647AbSKVL7j>; Fri, 22 Nov 2002 06:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264653AbSKVL7j>; Fri, 22 Nov 2002 06:59:39 -0500
Received: from host217-36-81-41.in-addr.btopenworld.com ([217.36.81.41]:5279
	"EHLO mail.dark.lan") by vger.kernel.org with ESMTP
	id <S264647AbSKVL7i>; Fri, 22 Nov 2002 06:59:38 -0500
Subject: Re: TCP memory pressure question
From: Gianni Tedesco <gianni@ecsc.co.uk>
To: David Schwartz <davids@webmaster.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021121213447.AAA4864@shell.webmaster.com@whenever>
References: <20021121213447.AAA4864@shell.webmaster.com@whenever>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-4Fwzris/bQMn3dMG0F04"
Organization: 
Message-Id: <1037966789.6079.33.camel@lemsip>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.1.99 (Preview Release)
Date: 22 Nov 2002 12:06:29 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4Fwzris/bQMn3dMG0F04
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2002-11-21 at 21:34, David Schwartz wrote:
> 	When a Linux machine has reached the tcp_mem limit, what will happen to=20
> 'write's on non-blocking sockets? Will they block until more TCP memory i=
s=20
> available? Will they return an error code? ENOMEM?

from write(2) man page.

EAGAIN Non-blocking I/O has been selected using O_NONBLOCK and the write
would block.

--=20
// Gianni Tedesco (gianni at ecsc dot co dot uk)
lynx --source www.scaramanga.co.uk/gianni-at-ecsc.asc | gpg --import
8646BE7D: 6D9F 2287 870E A2C9 8F60 3A3C 91B5 7669 8646 BE7D

--=-4Fwzris/bQMn3dMG0F04
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA93h3FkbV2aYZGvn0RAlaWAJkB6S+eszhHTanxE81HbbVA8H6eigCeMKkt
hJRRcJwJVNBnhM7mwQ5wN00=
=408z
-----END PGP SIGNATURE-----

--=-4Fwzris/bQMn3dMG0F04--

