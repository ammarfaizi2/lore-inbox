Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264403AbTEaSfa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 14:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264399AbTEaSfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 14:35:30 -0400
Received: from smtp-out6.blueyonder.co.uk ([195.188.213.9]:39192 "EHLO
	smtp-out6.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S264403AbTEaSf3 (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Sat, 31 May 2003 14:35:29 -0400
Subject: Re: const from include/asm-i386/byteorder.h
From: Gianni Tedesco <gianni@scaramanga.co.uk>
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>
In-Reply-To: <16088.47088.814881.791196@laputa.namesys.com>
References: <16088.47088.814881.791196@laputa.namesys.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-dmyi5DTL4MaMiJvswMtY"
Organization: 
Message-Id: <1054406992.4837.0.camel@sherbert>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 31 May 2003 19:49:53 +0100
X-OriginalArrivalTime: 31 May 2003 18:48:50.0832 (UTC) FILETIME=[46DA8900:01C327A5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-dmyi5DTL4MaMiJvswMtY
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2003-05-31 at 15:10, Nikita Danilov wrote:
> Hello,=20
>=20
> include/asm-i386/byteorder.h contains strange __const__'s in function
> definitions that have no effect:
>=20
> static __inline__ __const__ __u32 ___arch__swab32(__u32 x)
> static __inline__ __const__ __u16 ___arch__swab16(__u16 x)

shouldn't it be __attribute__((const)) to designate a pure function?

--=20
// Gianni Tedesco (gianni at scaramanga dot co dot uk)
lynx --source www.scaramanga.co.uk/gianni-at-ecsc.asc | gpg --import
8646BE7D: 6D9F 2287 870E A2C9 8F60 3A3C 91B5 7669 8646 BE7D


--=-dmyi5DTL4MaMiJvswMtY
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+2PlQkbV2aYZGvn0RAggDAJ4iVzJaIjJTZ74nLnniw66ijl3rdQCdFwv6
AEDZxtDOMbA/xc1O+J0CJbY=
=hJEL
-----END PGP SIGNATURE-----

--=-dmyi5DTL4MaMiJvswMtY--

