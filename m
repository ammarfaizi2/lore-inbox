Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265039AbTAWJE7>; Thu, 23 Jan 2003 04:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265058AbTAWJE7>; Thu, 23 Jan 2003 04:04:59 -0500
Received: from host213-121-111-56.in-addr.btopenworld.com ([213.121.111.56]:25832
	"EHLO mail.dark.lan") by vger.kernel.org with ESMTP
	id <S265039AbTAWJE6>; Thu, 23 Jan 2003 04:04:58 -0500
Subject: Re: Zero copy in 2.4 kernels
From: Gianni Tedesco <gianni@ecsc.co.uk>
To: Stanley Yee <SYee@snapappliance.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <057889C7F1E5D61193620002A537E8690B4378@NCBDC>
References: <057889C7F1E5D61193620002A537E8690B4378@NCBDC>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-DVMf+MpajTfUb0kJvRMe"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 23 Jan 2003 09:14:16 +0000
Message-Id: <1043313257.26889.1.camel@lemsip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-DVMf+MpajTfUb0kJvRMe
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-01-22 at 01:48, Stanley Yee wrote:
> Is the zero copy function enabled by default in the 2.4.X kernels?  If so
> which kernel version and what do I need to do to enable it?  Thanks for y=
our
> time.

sendfile(2) does zero-copy writes from files to sockets, works on any
version of 2.4 AFAIK.

HTH

--=20
// Gianni Tedesco (gianni at scaramanga dot co dot uk)
lynx --source www.scaramanga.co.uk/gianni-at-ecsc.asc | gpg --import
8646BE7D: 6D9F 2287 870E A2C9 8F60 3A3C 91B5 7669 8646 BE7D

--=-DVMf+MpajTfUb0kJvRMe
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA+L7JokbV2aYZGvn0RAktJAJ0TrLHGaeoE9+vXoVLvVwXzceBAmwCfX5+1
0GLwsDdw2Ma8/v1KayygXrw=
=suF4
-----END PGP SIGNATURE-----

--=-DVMf+MpajTfUb0kJvRMe--

