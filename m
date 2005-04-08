Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262677AbVDHFFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262677AbVDHFFy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 01:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262688AbVDHFFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 01:05:54 -0400
Received: from dea.vocord.ru ([217.67.177.50]:42173 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S262677AbVDHFFm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 01:05:42 -0400
Subject: Re: [Fwd: Re: connector is missing in 2.6.12-rc2-mm1]
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: akpm@osdl.org, guillaume.thouvenin@bull.net, greg@kroah.com,
       linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050408045302.GA32600@gondor.apana.org.au>
References: <E1DJjiR-000850-00@gondolin.me.apana.org.au>
	 <1112931238.28858.180.camel@uganda>
	 <20050408033246.GA31344@gondor.apana.org.au>
	 <1112932354.28858.192.camel@uganda>
	 <20050408035052.GA31451@gondor.apana.org.au>
	 <1112932969.28858.194.camel@uganda>
	 <20050408040237.GA31761@gondor.apana.org.au>
	 <1112934088.28858.199.camel@uganda>
	 <20050408041724.GA32243@gondor.apana.org.au>
	 <1112936127.28858.206.camel@uganda>
	 <20050408045302.GA32600@gondor.apana.org.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-6XChfobyb96eO2JdhIJn"
Organization: MIPT
Date: Fri, 08 Apr 2005 09:11:56 +0400
Message-Id: <1112937116.28858.212.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Fri, 08 Apr 2005 09:05:03 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6XChfobyb96eO2JdhIJn
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-04-08 at 14:53 +1000, Herbert Xu wrote:
> On Fri, Apr 08, 2005 at 08:55:27AM +0400, Evgeniy Polyakov wrote:
> >
> > > > Unfortunately not, that sync is required exactly for return value s=
tore.
> > >=20
> > > On UP?
> >=20
> > Yes, some quotes:
>=20
> Yes but what will go wrong on uni-processor MIPS when you don't do the
> sync in atomic_sub_return?

Sync synchornizes cached mamory access,
without it new value may be stored only into cache,
but not into memory.

> Cheers,
--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-6XChfobyb96eO2JdhIJn
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCVhKcIKTPhE+8wY0RAiy7AJ9RyPUTPU7SxrsryQREcvxY0A/v3wCeKW9G
Reh5N88lzUQA+VKnSVRHb8Y=
=70YP
-----END PGP SIGNATURE-----

--=-6XChfobyb96eO2JdhIJn--

