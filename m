Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285692AbSBKAor>; Sun, 10 Feb 2002 19:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285666AbSBKAoi>; Sun, 10 Feb 2002 19:44:38 -0500
Received: from mailout.informatik.tu-muenchen.de ([131.159.0.5]:59318 "EHLO
	mailout.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id <S285692AbSBKAoZ>; Sun, 10 Feb 2002 19:44:25 -0500
Subject: pci_pool reap?
From: Daniel Stodden <stodden@in.tum.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-uD6v9UepdAfDo1GC0gD+"
X-Mailer: Evolution/1.0.2 
Date: 11 Feb 2002 01:44:13 +0100
Message-Id: <1013388253.15449.12.camel@bitch>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-uD6v9UepdAfDo1GC0gD+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

hi.

is it true that pci pools are never shrunk? or am i just missing the
point where it happens?

try_to_free_pages() seems to care just about kmem_caches.

looks odd to me...


thanx,
dns

--=20
___________________________________________________________________________
 mailto:stodden@in.tum.de


--=-uD6v9UepdAfDo1GC0gD+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8ZxPdSPSplX5M5nQRAgkjAJ9X+qDkiywiggSmrGj19r2r85g39wCgtcXx
wkfr03d1fxQYKGPpjx4Iols=
=C2DB
-----END PGP SIGNATURE-----

--=-uD6v9UepdAfDo1GC0gD+--
