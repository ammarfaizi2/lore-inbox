Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbTEMNBF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 09:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbTEMNBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 09:01:05 -0400
Received: from imhotep.hursley.ibm.com ([194.196.110.14]:63743 "EHLO
	tor.trudheim.com") by vger.kernel.org with ESMTP id S261192AbTEMNBD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 09:01:03 -0400
Subject: Re: kernel BUG at inode.c:562!
From: Anders Karlsson <anders@trudheim.com>
To: Oleg Drokin <green@namesys.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030513124135.GA28238@namesys.com>
References: <1052823517.5022.3.camel@tor.trudheim.com>
	 <20030513124135.GA28238@namesys.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-BkIZOaY9qOGm3ntZLcJN"
Organization: Trudheim Technology Limited
Message-Id: <1052831624.4887.28.camel@tor.trudheim.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4Rubber Turnip 
Date: 13 May 2003 14:13:44 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-BkIZOaY9qOGm3ntZLcJN
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-05-13 at 13:41, Oleg Drokin wrote:
> Hello!

Hello there. :)

> On Tue, May 13, 2003 at 11:58:38AM +0100, Anders Karlsson wrote:
>=20
> > Running kernel 2.4.21-rc2 and using reiserfs (built as module) on an IB=
M
> > X31 laptop. I have hit a kernel bug (as per subject line).
> > kernel BUG at inode.c:562!
> > EIP:    0010:[<c01554da>]    Tainted: PF
> > >>EIP; c01554da <clear_inode+1a/f0>   <=3D=3D=3D=3D=3D
>=20
> Hm, can you please try to reproduce without vmware modules ever being loa=
ded?
> What was the file that you tried to delete?

Yes, I can try and reproduce. It will take me a few hours. The files I
tried to delete was is /usr/src/packages/BUILD the directoried for
libbonobo, libbonobiui and libIDL after having rebuilt the rpm's for
i686 arch. The rm's just hung and I noticed the BUG in the dmesg output.

> Thank you.

Many thanks for getting back to me so quickly, if there is any more
information you need, let me know.

/Anders


--=-BkIZOaY9qOGm3ntZLcJN
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2-rc1-SuSE (GNU/Linux)

iD8DBQA+wO+ILYywqksgYBoRAklsAKCnp8Im3jrNrHfkYD/UZNAZFfzAigCdE9tY
QJ4KlNlSXf72NadZaSSoOW8=
=4FG0
-----END PGP SIGNATURE-----

--=-BkIZOaY9qOGm3ntZLcJN--

