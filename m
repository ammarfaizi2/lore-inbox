Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265198AbTAFMbz>; Mon, 6 Jan 2003 07:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265890AbTAFMbz>; Mon, 6 Jan 2003 07:31:55 -0500
Received: from host217-36-81-41.in-addr.btopenworld.com ([217.36.81.41]:37558
	"EHLO mail.dark.lan") by vger.kernel.org with ESMTP
	id <S265198AbTAFMby>; Mon, 6 Jan 2003 07:31:54 -0500
Subject: Re: PCI code:  why need  outb (0x01, 0xCFB); ?
From: Gianni Tedesco <gianni@ecsc.co.uk>
To: fretre lewis <fretre3618@hotmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <F87sTOHYNhMwqvbLaKL0001615a@hotmail.com>
References: <F87sTOHYNhMwqvbLaKL0001615a@hotmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-SzWtlDDBusOlzXt/a+ps"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Jan 2003 12:41:01 +0000
Message-Id: <1041856867.12900.1.camel@lemsip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-SzWtlDDBusOlzXt/a+ps
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-01-06 at 09:26, fretre lewis wrote:
> 1. which device is at port address 0xCFB?

the PCI controller.

> 2. what is meaning of the writing operation "outb (0x01, 0xCFB);" for THI=
S
> device?, it'seem that PCI spec v2.0 not say anything about it?

I think it selects PCI configuration mode 1. (I could be wrong).

--=20
// Gianni Tedesco (gianni at scaramanga dot co dot uk)
lynx --source www.scaramanga.co.uk/gianni-at-ecsc.asc | gpg --import
8646BE7D: 6D9F 2287 870E A2C9 8F60 3A3C 91B5 7669 8646 BE7D

--=-SzWtlDDBusOlzXt/a+ps
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA+GXldkbV2aYZGvn0RAsZNAJ4zs7Wnu9fIMIoIzNILoJskl9Db3QCfU0fg
MCLEtU3dS+clvOx6Psns1k8=
=QDAV
-----END PGP SIGNATURE-----

--=-SzWtlDDBusOlzXt/a+ps--

