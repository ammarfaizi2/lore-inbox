Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261419AbVCYGVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261419AbVCYGVy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 01:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbVCYGTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 01:19:07 -0500
Received: from dea.vocord.ru ([217.67.177.50]:30184 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S261420AbVCYGKU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 01:10:20 -0500
Subject: Re: [PATCH] API for true Random Number Generators to add entropy
	(2.6.11)
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Jeff Garzik <jgarzik@pobox.com>
Cc: David McCullough <davidm@snapgear.com>, cryptoapi@lists.logix.cz,
       linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       Herbert Xu <herbert@gondor.apana.org.au>
In-Reply-To: <4243A86D.6000408@pobox.com>
References: <20050315133644.GA25903@beast> <20050324042708.GA2806@beast>
	 <1111665551.23532.90.camel@uganda> <4242B712.50004@pobox.com>
	 <20050324132342.GD7115@beast> <1111671993.23532.115.camel@uganda>
	 <42432972.5020906@pobox.com> <1111725282.23532.130.camel@uganda>
	 <42439839.7060702@pobox.com> <1111728804.23532.137.camel@uganda>
	 <4243A86D.6000408@pobox.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-E8jNKOYoa8NbmaNFSNTn"
Organization: MIPT
Date: Fri, 25 Mar 2005 09:16:01 +0300
Message-Id: <1111731361.20797.5.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-1) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Fri, 25 Mar 2005 09:09:33 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-E8jNKOYoa8NbmaNFSNTn
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-03-25 at 00:58 -0500, Jeff Garzik wrote:
> Evgeniy Polyakov wrote:
> > So I still insist on creating ability to contribute entropy directly,
> > without userspace validation.
> > It will be turned off by default.
>=20
> If its disabled by default, then you and 2-3 other people will use this=20
> feature.  Not enough justification for a kernel API at that point.

It is only because there are only couple of HW crypto devices
in the tree, with one crypto framework inclusion there will be
at least redouble.
Let's return to this discussion after it.

Thank you.

> 	Jeff
>=20
--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-E8jNKOYoa8NbmaNFSNTn
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCQ6yhIKTPhE+8wY0RAu1dAKCKWWfQJ9LFIMzZ+LfoLsmBQQ3mgACfUf7p
VQEA2bM2Fj/jaU0yEgsK9vw=
=T4eU
-----END PGP SIGNATURE-----

--=-E8jNKOYoa8NbmaNFSNTn--

