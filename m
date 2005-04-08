Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262688AbVDHFN3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262688AbVDHFN3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 01:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262689AbVDHFN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 01:13:29 -0400
Received: from dea.vocord.ru ([217.67.177.50]:59069 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S262688AbVDHFNR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 01:13:17 -0400
Subject: Re: [Fwd: Re: connector is missing in 2.6.12-rc2-mm1]
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: akpm@osdl.org, guillaume.thouvenin@bull.net, greg@kroah.com,
       linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050408050814.GA32722@gondor.apana.org.au>
References: <20050408033246.GA31344@gondor.apana.org.au>
	 <1112932354.28858.192.camel@uganda>
	 <20050408035052.GA31451@gondor.apana.org.au>
	 <1112932969.28858.194.camel@uganda>
	 <20050408040237.GA31761@gondor.apana.org.au>
	 <1112934088.28858.199.camel@uganda>
	 <20050408041724.GA32243@gondor.apana.org.au>
	 <1112936127.28858.206.camel@uganda>
	 <20050408045302.GA32600@gondor.apana.org.au>
	 <1112937116.28858.212.camel@uganda>
	 <20050408050814.GA32722@gondor.apana.org.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-+sPp/MPXTDHM8hBdj+ET"
Organization: MIPT
Date: Fri, 08 Apr 2005 09:19:39 +0400
Message-Id: <1112937579.28858.218.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Fri, 08 Apr 2005 09:12:47 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+sPp/MPXTDHM8hBdj+ET
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-04-08 at 15:08 +1000, Herbert Xu wrote:
> On Fri, Apr 08, 2005 at 09:11:56AM +0400, Evgeniy Polyakov wrote:
> >
> > > Yes but what will go wrong on uni-processor MIPS when you don't do th=
e
> > > sync in atomic_sub_return?
> >=20
> > Sync synchornizes cached mamory access,
> > without it new value may be stored only into cache,
> > but not into memory.
>=20
> I know, the same thing holds for most architectures, including i386.
> However, this is not an issue for uni-processor kernels anywhere else,
> so what's so special about MIPS?

Does i386 or ppc has cached and uncached memory?
No, i386, ppc and others do not require sync on uncached memory access,
and only instruction not data cache sync on SMP.

> Cheers,
--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-+sPp/MPXTDHM8hBdj+ET
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCVhRrIKTPhE+8wY0RAgPzAJ9UPOTyvHWd4UZXIoI270iH6xCwJgCfWb1S
gR5l1nGVDQfpSdMfaAVh6ek=
=NkRT
-----END PGP SIGNATURE-----

--=-+sPp/MPXTDHM8hBdj+ET--

