Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262631AbVBCI4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262631AbVBCI4R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 03:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262478AbVBCI4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 03:56:11 -0500
Received: from irulan.endorphin.org ([80.68.90.107]:24324 "EHLO
	irulan.endorphin.org") by vger.kernel.org with ESMTP
	id S262631AbVBCIza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 03:55:30 -0500
Subject: Re: [PATCH 01/04] Adding cipher mode context information
	to	crypto_tfm
From: Fruhwirth Clemens <clemens@endorphin.org>
To: Michal Ludvig <michal@logix.cz>
Cc: "David S. Miller" <davem@davemloft.net>, James Morris <jmorris@redhat.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       dm-crypt@saout.de, cryptoapi@lists.logix.cz
In-Reply-To: <42017316.4070805@logix.cz>
References: <Xine.LNX.4.44.0502021728140.5000-100000@thoron.boston.redhat.com>
	 <1107386909.19339.9.camel@ghanima>
	 <20050202153449.1e92c29a.davem@davemloft.net>
	 <1107390095.19339.26.camel@ghanima>  <42017316.4070805@logix.cz>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-sLM7IuvIM3gCeCEwRapv"
Date: Thu, 03 Feb 2005 09:55:23 +0100
Message-Id: <1107420923.15236.8.camel@ghanima>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-sLM7IuvIM3gCeCEwRapv
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-02-03 at 13:40 +1300, Michal Ludvig wrote:
> Fruhwirth Clemens wrote:
>=20
>  > Especially, if James ask me to redo Michal's conflicting patches
>  > (done btw), which are totally off-topic for me.
>=20
> Great, thanks! Has the interface for multiblock modules changed or=20
> should my old modules work with it with no more effort?

Yes, changes are required. I fixed up padlock-aes.c along the way. So
don't worry if it's just padlock.=20

The changes to the CryptoAPI core minimal, in fact, 10 lines, retaining
all the functionally of you original patch. I'll finalize/clean/post the
patch when the scatterwalk stuff is merged. Please have a look at the
scatterwalk code, because, as I don't have a padlock, you'll have the
joy of running my code for the very first time :)

--=20
Fruhwirth Clemens <clemens@endorphin.org>  http://clemens.endorphin.org

--=-sLM7IuvIM3gCeCEwRapv
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCAeb7W7sr9DEJLk4RAqzkAJ0cdmJS+4HmHKHigAkEhpGE7xHyqgCeLebc
SbtXv/LYweSWOs3kz/AprfQ=
=RmiL
-----END PGP SIGNATURE-----

--=-sLM7IuvIM3gCeCEwRapv--
