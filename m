Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262254AbVC2MLM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262254AbVC2MLM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 07:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262249AbVC2MLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 07:11:10 -0500
Received: from dea.vocord.ru ([217.67.177.50]:30386 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S262233AbVC2MKd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 07:10:33 -0500
Subject: Re: [PATCH] API for true Random Number Generators to add entropy
	(2.6.11)
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
       Pavel Machek <pavel@ucw.cz>, cryptoapi@lists.logix.cz,
       Jeff Garzik <jgarzik@pobox.com>, David McCullough <davidm@snapgear.com>
In-Reply-To: <20050329113921.GA20174@gondor.apana.org.au>
References: <42439839.7060702@pobox.com> <1111728804.23532.137.camel@uganda>
	 <4243A86D.6000408@pobox.com> <1111731361.20797.5.camel@uganda>
	 <20050325061311.GA22959@gondor.apana.org.au>
	 <20050329102104.GB6496@elf.ucw.cz>
	 <20050329103049.GB19541@gondor.apana.org.au>
	 <1112093428.5243.88.camel@uganda>
	 <20050329104627.GD19468@gondor.apana.org.au>
	 <1112096525.5243.98.camel@uganda>
	 <20050329113921.GA20174@gondor.apana.org.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-sxs0o4fftTLyvmra89fl"
Organization: MIPT
Date: Tue, 29 Mar 2005 16:15:17 +0400
Message-Id: <1112098517.5243.102.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Tue, 29 Mar 2005 16:08:47 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-sxs0o4fftTLyvmra89fl
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-03-29 at 21:39 +1000, Herbert Xu wrote:
> On Tue, Mar 29, 2005 at 03:42:05PM +0400, Evgeniy Polyakov wrote:
> > On Tue, 2005-03-29 at 20:46 +1000, Herbert Xu wrote:
>=20
> > > Well if you can demonstrate that you're getting a higher rate of
> > > throughput from your RNG by doing this in kernel space vs. doing
> > > it in user space please let me know.
> >=20
> > While raw bits reading from hw_random on the fastest=20
> > VIA boards can exceed 55mbits per second=20
> > [above quite was taken from VIA C3 Nehemiah analysis],=20
> > it is not evaluated in rngd and is not written=20
> > back to the /dev/random.
>=20
> Well when you get 55mb/s from /dev/random please get back to me.

I cant, noone writes 55mbit into it, but HW RNG drivers could. :)

--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-sxs0o4fftTLyvmra89fl
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCSUbVIKTPhE+8wY0RAuTiAJwPNv8ZEGhlSCmSaL4FdWraatVGGQCeJCaC
tnx2bm+mspnZJZI1TWBYkIo=
=HYwe
-----END PGP SIGNATURE-----

--=-sxs0o4fftTLyvmra89fl--

