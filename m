Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262327AbTKYL0L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 06:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262330AbTKYL0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 06:26:11 -0500
Received: from trantor.org.uk ([213.146.130.142]:31121 "EHLO trantor.org.uk")
	by vger.kernel.org with ESMTP id S262327AbTKYL0I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 06:26:08 -0500
Subject: Re: hard links create local DoS vulnerability and security problems
From: Gianni Tedesco <gianni@scaramanga.co.uk>
To: Jakob Lell <jlell@JakobLell.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200311241736.23824.jlell@JakobLell.de>
References: <200311241736.23824.jlell@JakobLell.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-IsaTHVjf4QiFmMG2YZtS"
Message-Id: <1069759557.24559.274.camel@lemsip>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 25 Nov 2003 12:26:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-IsaTHVjf4QiFmMG2YZtS
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-11-24 at 17:36, Jakob Lell wrote:
> To solve the problem, the kernel shouldn't allow users to create hard lin=
ks to=20
> files belonging to someone else.

chmod(fn, 0);
truncate(fn, 0);
unlink(fn);

then just the inode remains.

--=20
// Gianni Tedesco (gianni at scaramanga dot co dot uk)
lynx --source www.scaramanga.co.uk/scaramanga.asc | gpg --import
8646BE7D: 6D9F 2287 870E A2C9 8F60 3A3C 91B5 7669 8646 BE7D

--=-IsaTHVjf4QiFmMG2YZtS
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/wzxFkbV2aYZGvn0RAiZzAJ41PhJBMH2cE3DtPrW+aPEAfK7/EQCfcrke
e3n/SBW/2CtIAeV1zfciBNk=
=47Nl
-----END PGP SIGNATURE-----

--=-IsaTHVjf4QiFmMG2YZtS--

