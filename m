Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbVBVXOy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbVBVXOy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 18:14:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261341AbVBVXOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 18:14:53 -0500
Received: from vds-320151.amen-pro.com ([62.193.204.86]:22441 "EHLO
	vds-320151.amen-pro.com") by vger.kernel.org with ESMTP
	id S261335AbVBVXOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 18:14:10 -0500
Subject: Re: JFFS2 Extended attributes support & SELinux in handhelds
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: Josh Boyer <jdub@us.ibm.com>
Cc: familiar-dev@handhelds.org, selinux@tycho.nsa.gov,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       familiar@handhelds.org, handhelds@handhelds.org,
       kernel-discuss@handhelds.org, oe@handhelds.org, agruen@suse.de,
       Russell Coker <rcoker@redhat.com>
In-Reply-To: <1109096502.7813.5.camel@windu.rchland.ibm.com>
References: <1109089039.4100.114.camel@localhost.localdomain>
	 <1109096502.7813.5.camel@windu.rchland.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-GIpU+2InhgwMn2MGFZRL"
Date: Wed, 23 Feb 2005 00:13:37 +0100
Message-Id: <1109114017.4100.139.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-GIpU+2InhgwMn2MGFZRL
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

El mar, 22-02-2005 a las 12:21 -0600, Josh Boyer escribi=F3:
> You should send this to the JFFS2 development list.  The xattr support
> is probably a JFFS3 candidate.
>=20
> The mtd tree is the most current.  Any development would probably get
> the most benefit from being done there.  Especially since JFFS3 doesn't
> exist anywhere else :).

As we have talked in #mtd, I've moved everything to JFFS3 code and
re-worked the pretty basic stuff that was already done, as a really
dirty night-hack.

I hadn't time to fix the remaining errors (no, it's not a working
patch), nor the remaining "stolen" ReiserFS code that needs to be
modified in order to make JFFS3 happy with it (priv. directory handling
in xattr initialization, etc).
I'm going to have limited time for it, I have exams these two weeks and
also finish some other work in progress.

I've uploaded a patch that applies to 2.6.11-rc4 tree, with latest mtd
tree included.

http://pearls.tuxedo-es.org/patches/mtd-jffs3-xattr-20050222-2.6.11-rc4.pat=
ch
(998Kb)

I would appreciate any collaboration and help with it.

Cheers, thanks in advance and enjoy (not working) it.
:)
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-GIpU+2InhgwMn2MGFZRL
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCG7yhDcEopW8rLewRAsCcAJ0VszZeor6cyo4agnO8yTvmfkOJWACeM3yo
WOcOVilekHd0pQYJaGjmBJA=
=uEtg
-----END PGP SIGNATURE-----

--=-GIpU+2InhgwMn2MGFZRL--

