Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261511AbVCYHbx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261511AbVCYHbx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 02:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbVCYHbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 02:31:53 -0500
Received: from dea.vocord.ru ([217.67.177.50]:60295 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S261510AbVCYHbo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 02:31:44 -0500
Subject: Re: [PATCH] API for true Random Number Generators to add entropy
	(2.6.11)
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
       David McCullough <davidm@snapgear.com>, cryptoapi@lists.logix.cz,
       linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>
In-Reply-To: <4243BB80.1010802@pobox.com>
References: <42432972.5020906@pobox.com> <1111725282.23532.130.camel@uganda>
	 <42439839.7060702@pobox.com> <1111728804.23532.137.camel@uganda>
	 <4243A86D.6000408@pobox.com> <1111731361.20797.5.camel@uganda>
	 <20050325061311.GA22959@gondor.apana.org.au>
	 <1111732459.20797.16.camel@uganda>
	 <20050325063333.GA27939@gondor.apana.org.au>
	 <1111733958.20797.30.camel@uganda>
	 <20050325065622.GA31127@gondor.apana.org.au>
	 <1111735195.20797.42.camel@uganda>  <4243BB80.1010802@pobox.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-/rHrJpqVtM8qmX5BevY9"
Organization: MIPT
Date: Fri, 25 Mar 2005 10:38:16 +0300
Message-Id: <1111736296.20797.47.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-1) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Fri, 25 Mar 2005 10:31:02 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-/rHrJpqVtM8qmX5BevY9
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-03-25 at 02:19 -0500, Jeff Garzik wrote:
> Evgeniy Polyakov wrote:
> > Noone will complain on Linux if NIC is broken and produces wrong
> > checksum
> > and HW checksum offloading is enabled using ethtools.
>=20
>=20
> Actually, that is a problem and people have definitely complained about=20
> it in the past.

And what they were recommended to do? :)
I believe not changing drivers and stack, but only disable it using
ethtool.

And people of course should be able to turn kernlspace <-> kernelspace
RNG dataflow off if they fill it is insecure.

> 	Jeff
>=20
--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-/rHrJpqVtM8qmX5BevY9
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCQ7/oIKTPhE+8wY0RAn36AJ4r9ENh25czhPWLuL77UeM0HDcBbwCfcyCz
cl1TqNQL386FAuRBWr2QCuo=
=7Fyg
-----END PGP SIGNATURE-----

--=-/rHrJpqVtM8qmX5BevY9--

