Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262612AbVCVKZC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262612AbVCVKZC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 05:25:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262611AbVCVKYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 05:24:43 -0500
Received: from irulan.endorphin.org ([80.68.90.107]:33031 "EHLO
	irulan.endorphin.org") by vger.kernel.org with ESMTP
	id S262608AbVCVKYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 05:24:36 -0500
Subject: Re: [5/5] [CRYPTO] Optimise kmap calls in crypt()
From: Fruhwirth Clemens <clemens@endorphin.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: James Morris <jmorris@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       cryptoapi@lists.logix.cz
In-Reply-To: <20050322011308.GA15734@gondor.apana.org.au>
References: <20050321094047.GA23084@gondor.apana.org.au>
	 <20050321094807.GA23235@gondor.apana.org.au>
	 <20050321094939.GB23235@gondor.apana.org.au>
	 <20050321095057.GC23235@gondor.apana.org.au>
	 <20050321095208.GD23235@gondor.apana.org.au>
	 <20050321095322.GE23235@gondor.apana.org.au>
	 <1111404659.12532.9.camel@ghanima>
	 <20050322011308.GA15734@gondor.apana.org.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Go4VRgbqEvkWiJm1jZv+"
Date: Tue, 22 Mar 2005 11:24:31 +0100
Message-Id: <1111487071.12618.1.camel@ghanima>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Go4VRgbqEvkWiJm1jZv+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-03-22 at 12:13 +1100, Herbert Xu wrote:
> On Mon, Mar 21, 2005 at 12:30:59PM +0100, Fruhwirth Clemens wrote:
> >=20
> > Applying all patches results in a "does not work for me". The decryptio=
n
> > result is different from the original and my LUKS managed partition
> > refuses to mount.
>=20
> Thanks for testing this Fruhwirth.  The problem is that walk->data wasn't
> being incremented anymore after my last change. =20

I remember, that I almost forgot about that pointer too.

> This patch should fix it up.

Works for me now. Thanks.

--=20
Fruhwirth Clemens - http://clemens.endorphin.org=20
for robots: sp4mtrap@endorphin.org

--=-Go4VRgbqEvkWiJm1jZv+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCP/JfbjN8iSMYtrsRArcOAJ0ZoUcmYmU0JEwVySvGm/9OlH3viwCfTUdP
uJtSfK0zMCvQethIqGmvmp4=
=LdSE
-----END PGP SIGNATURE-----

--=-Go4VRgbqEvkWiJm1jZv+--
