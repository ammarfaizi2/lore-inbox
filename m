Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267331AbTBKJVo>; Tue, 11 Feb 2003 04:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267332AbTBKJVo>; Tue, 11 Feb 2003 04:21:44 -0500
Received: from host213-121-98-76.in-addr.btopenworld.com ([213.121.98.76]:55971
	"EHLO mail.dark.lan") by vger.kernel.org with ESMTP
	id <S267331AbTBKJVn>; Tue, 11 Feb 2003 04:21:43 -0500
Subject: Re: allocate more than 2 GB on IA32
From: Gianni Tedesco <gianni@ecsc.co.uk>
To: Hartmut Manz <manz@intes.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200302111015.54223.manz@intes.de>
References: <200302111015.54223.manz@intes.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-t7VrWiII/5vdgH5atrCj"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 11 Feb 2003 09:31:45 +0000
Message-Id: <1044955906.1117.54.camel@lemsip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-t7VrWiII/5vdgH5atrCj
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-02-11 at 09:15, Hartmut Manz wrote:
> but I am only able to allocate 2 GB with a single malloc call.
> I tought it should be possible to allocate up to 2.9 GB of memory to a
> process, with this kernel settings.

have you tried your own anonymous mmap() with start set to getpagesize()
?

--=20
// Gianni Tedesco (gianni at scaramanga dot co dot uk)
lynx --source www.scaramanga.co.uk/gianni-at-ecsc.asc | gpg --import
8646BE7D: 6D9F 2287 870E A2C9 8F60 3A3C 91B5 7669 8646 BE7D

--=-t7VrWiII/5vdgH5atrCj
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA+SMMBkbV2aYZGvn0RAgWwAJ4qfCulcRniocHhyKXABRPHdi2QbgCfaAc4
qf+K3TP77mveuR7MqpDk03w=
=5shb
-----END PGP SIGNATURE-----

--=-t7VrWiII/5vdgH5atrCj--

