Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310457AbSCBVUC>; Sat, 2 Mar 2002 16:20:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310458AbSCBVTw>; Sat, 2 Mar 2002 16:19:52 -0500
Received: from charger.oldcity.dca.net ([207.245.82.76]:6332 "EHLO
	charger.oldcity.dca.net") by vger.kernel.org with ESMTP
	id <S310457AbSCBVTj>; Sat, 2 Mar 2002 16:19:39 -0500
Date: Sat, 2 Mar 2002 16:19:34 -0500
From: christophe =?iso-8859-15?Q?barb=E9?= 
	<christophe.barbe.ml@online.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 3c509 Power Management (take 2)
Message-ID: <20020302211934.GD4958@ufies.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0203010826180.26745-100000@netfinity.realnet.co.sz> <Pine.LNX.4.44.0203011222010.31530-100000@netfinity.realnet.co.sz> <20020301093317.I22608@lynx.adilger.int> <20020302204839.GA4958@ufies.org> <3C814118.FAAF0502@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qp4W5+cUSnZs0RIF"
Content-Disposition: inline
In-Reply-To: <3C814118.FAAF0502@mandrakesoft.com>
User-Agent: Mutt/1.3.27i
X-Operating-System: debian SID Gnu/Linux 2.4.18 on i586
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qp4W5+cUSnZs0RIF
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 02, 2002 at 04:16:08PM -0500, Jeff Garzik wrote:
> christophe barb=E9 wrote:
> >=20
> > On Fri, Mar 01, 2002 at 09:33:17AM -0700, Andreas Dilger wrote:
> > > PS - any chance you can fix this for xirc2ps_cs?  I can test if you w=
ant,
> > >      as my current card always fails to word after APM suspend (needs=
 a
> > >      "cardctl eject; cardctl insert" to work again.
> >=20
> > It looks like there is a general problem concerning PM for pcmcia cards.
> > I have a similar problem with a 3c59x card (which is managed by hotplug)
> > and I am convinced that the problem is not in the driver code.
>=20
> 3c59x is 32-bit cardbus not 16-bit pcmcia... the code is very different
> for the two in the kernel core.

Yes I know that that's why I have added '(which is managed by hotplug)'.
But I'm convinced that the bug is not in the driver code.
I would not be surprised to have a bug in the OHCI code bug.

Christophe

>=20
> That sounds more like a suspend and resume problem in 3c59x driver to
> me...
>=20
> --=20
> Jeff Garzik      |
> Building 1024    |
> MandrakeSoft     | Choose life.

--=20
Christophe Barb=E9 <christophe.barbe@ufies.org>
GnuPG FingerPrint: E0F6 FADF 2A5C F072 6AF8  F67A 8F45 2F1E D72C B41E

Ce que l'on con=E7oit bien s'=E9nonce clairement,
Et les mots pour le dire arrivent ais=E9ment.
   Nicolas Boileau, L'Art po=E9tique

--qp4W5+cUSnZs0RIF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Pour information voir http://www.gnupg.org

iD8DBQE8gUHmj0UvHtcstB4RApUvAJ9ddkYGhi6P+3u4EOzRrQHqCD4ZigCbBEqH
p8aZBHLuD/XxrRMbVJ/PjZU=
=EqX/
-----END PGP SIGNATURE-----

--qp4W5+cUSnZs0RIF--
