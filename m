Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266620AbTGHE7L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 00:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266797AbTGHE7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 00:59:11 -0400
Received: from dsl-62-3-122-163.zen.co.uk ([62.3.122.163]:17280 "EHLO
	tor.trudheim.com") by vger.kernel.org with ESMTP id S266620AbTGHE7G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 00:59:06 -0400
Subject: Re: kernel oops
From: Anders Karlsson <anders@trudheim.com>
To: Bernd Schubert <bernd-schubert@web.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200307072009.50677.bernd-schubert@web.de>
References: <1057582393.2034.13.camel@tor.trudheim.com>
	 <200307072009.50677.bernd-schubert@web.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Rgfnn0qkoJWRMiVSEcJm"
Organization: Trudheim Technology Limited
Message-Id: <1057641217.2154.8.camel@tor.trudheim.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 Rubber Turnip www.usr-local-bin.org 
Date: 08 Jul 2003 06:13:38 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Rgfnn0qkoJWRMiVSEcJm
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-07-07 at 19:09, Bernd Schubert wrote:
> Hi,
>=20
> did you already run a memtest86-test on your system ?

I said to Bernd last night I was going to run memtest over night. I
didn't think I'd find anything as the bits were brand new when I bought
them two months ago. However, memtest86 found some bad RAM around the
280MB mark and promptly locked hard just like the kernel does.

It was always the same bit stuck, a pattern ffffffff coming back as
feffffff and 00000000 coming back as 01000000. Bit unusual perhaps, a
stuck bit that inverts itself. The addresses where errors was detected
was quite symmetrical as well, ending in 3e0, 3e8, 3f0, 3f8, 400, 408,
410, 418.

I'm ordering a replacement DIMM today, and once it turns up, memtest is
seeing some action again.

Regards,

--=20
Anders Karlsson <anders@trudheim.com>
Trudheim Technology Limited

--=-Rgfnn0qkoJWRMiVSEcJm
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2-rc1-SuSE (GNU/Linux)

iD8DBQA/ClMBLYywqksgYBoRAjchAKCc/IXpXIf3ZNZKZnrDAi/zo3UgdQCfUBUt
H+lVps+n9iAspj2zhwpSgZw=
=DYIy
-----END PGP SIGNATURE-----

--=-Rgfnn0qkoJWRMiVSEcJm--

