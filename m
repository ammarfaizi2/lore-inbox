Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262665AbVDHEPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262665AbVDHEPj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 00:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262686AbVDHEPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 00:15:39 -0400
Received: from dea.vocord.ru ([217.67.177.50]:34233 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S262665AbVDHEPQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 00:15:16 -0400
Subject: Re: [Fwd: Re: connector is missing in 2.6.12-rc2-mm1]
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: akpm@osdl.org, guillaume.thouvenin@bull.net, greg@kroah.com,
       linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050408040237.GA31761@gondor.apana.org.au>
References: <E1DJjiR-000850-00@gondolin.me.apana.org.au>
	 <1112931238.28858.180.camel@uganda>
	 <20050408033246.GA31344@gondor.apana.org.au>
	 <1112932354.28858.192.camel@uganda>
	 <20050408035052.GA31451@gondor.apana.org.au>
	 <1112932969.28858.194.camel@uganda>
	 <20050408040237.GA31761@gondor.apana.org.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-/iSv4E2hPYcCNGR3w6iA"
Organization: MIPT
Date: Fri, 08 Apr 2005 08:21:28 +0400
Message-Id: <1112934088.28858.199.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Fri, 08 Apr 2005 08:14:36 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-/iSv4E2hPYcCNGR3w6iA
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-04-08 at 14:02 +1000, Herbert Xu wrote:
> On Fri, Apr 08, 2005 at 08:02:49AM +0400, Evgeniy Polyakov wrote:
> >
> > > > mips has additional sync.
> > >=20
> > > But atomic_dec + 2 barries is going to do the sync as well, no?
> >=20
> > On UP do not.
>=20
> Shouldn't we should be fixing the MIPS implementation of
> atomic_sub_return to not do the sync on UP then?

Unfortunately not, that sync is required exactly for return value store.

--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-/iSv4E2hPYcCNGR3w6iA
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCVgbIIKTPhE+8wY0RAsG6AJwK84gB4eHlSEMdJ81myn5ovuPNtwCfT52z
pO09M8+vUXXxmXg1+oMexzU=
=Hu2l
-----END PGP SIGNATURE-----

--=-/iSv4E2hPYcCNGR3w6iA--

