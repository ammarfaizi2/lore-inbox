Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267871AbUGWSU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267871AbUGWSU1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 14:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267872AbUGWSU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 14:20:27 -0400
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:26773 "EHLO
	websrv.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S267871AbUGWSUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 14:20:25 -0400
Subject: Re: [PATCH] Delete cryptoloop
From: Christophe Saout <christophe@saout.de>
To: Kevin Corry <kevcorry@us.ibm.com>
Cc: linux-kernel@vger.kernel.org,
       Walter Hofmann <lkml-040723143345-5954@secretlab.mine.nu>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <200407230901.33814.kevcorry@us.ibm.com>
References: <2kvT4-5AY-1@gated-at.bofh.it> <2kECW-3a0-7@gated-at.bofh.it>
	 <E1BnzGM-0005zX-00@gimli.local>  <200407230901.33814.kevcorry@us.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-hUz+enPtvGAuuodtMS/u"
Date: Fri, 23 Jul 2004 20:20:18 +0200
Message-Id: <1090606819.17093.1.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-hUz+enPtvGAuuodtMS/u
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Fr, den 23.07.2004 um 9:01 Uhr -0500 schrieb Kevin Corry:

> > I use cryptoloop and I would be really annoyed if it disappeared in
> > the stable kernel series. Besides, I read in another mail in this threa=
d
> > that dm-crypt will not work with file-based storage (I'm using
> > cryptoloop on a file), and that it is new and potentially buggy.
>=20
> Just to clarify this one point...
> Device-Mapper (and thus dm-crypt) can only create mappings on block-devic=
es.=20
> However, in your situation, you could just take a two-step approach of=20
> creating a loop device on the encrypted file (using losetup), and then us=
ing=20
> dm-crypt on top of this loop device.

Yes, just look at the Wiki page on http://www.saout.de/misc/dm-crypt/ ,
people have contributed a lot of scripts.


--=-hUz+enPtvGAuuodtMS/u
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBAVbiZCYBcts5dM0RAoY7AJ4jL+PM2B6MkDh2BDNf0BgRh5K4owCfXJ0n
ka33HqG1o4zYcwvf0/vEF9Q=
=Z0Kp
-----END PGP SIGNATURE-----

--=-hUz+enPtvGAuuodtMS/u--

