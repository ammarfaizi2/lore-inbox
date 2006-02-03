Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750779AbWBCLrN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbWBCLrN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 06:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbWBCLrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 06:47:13 -0500
Received: from sipsolutions.net ([66.160.135.76]:3078 "EHLO sipsolutions.net")
	by vger.kernel.org with ESMTP id S1750779AbWBCLrM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 06:47:12 -0500
Subject: Re: [RFC 4/4] firewire: add mem1394
From: Johannes Berg <johannes@sipsolutions.net>
To: Andy Wingo <wingo@pobox.com>
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
In-Reply-To: <1138966521.4914.42.camel@localhost.localdomain>
References: <1138919238.3621.12.camel@localhost>
	 <1138920185.3621.24.camel@localhost>
	 <1138966521.4914.42.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-QcaiNG4JGppV0qi7Nz0D"
Date: Fri, 03 Feb 2006 12:47:05 +0100
Message-Id: <1138967225.3621.44.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-QcaiNG4JGppV0qi7Nz0D
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-02-03 at 12:35 +0100, Andy Wingo wrote:

> On Thu, 2006-02-02 at 23:43 +0100, Johannes Berg wrote:
> > +	spin_lock(&dev_list_lock);
>=20
> Stupid question: are you sure that something coming from an interrupt
> handler won't try to grab this lock? For example from a cable unplug?

Yes, I'm pretty sure (but I hope some of the firewire experts will chime
in) -- but if you unplug or anything the node only goes into 'limbo' and
afaict if it is ever cleaned up then that comes from a thread context.

johannes

--=-QcaiNG4JGppV0qi7Nz0D
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (SIP Solutions)

iQIVAwUAQ+NCuKVg1VMiehFYAQKNFw/9E6G3gd3yvftCamtli4uLr8BU8Q/Bn9tw
s8w6Lhcm26a+7bvY40x2j/xVvEh4v8QaRHd6NU2/SpRPcnQJQl3MWT5vgxaAJ//2
PONkoPKe2pD1p5BlNigrjfZ/+EYZdl/dhyEqdqiCeuROKUMoaGdIr/IuUuTqecRK
677bJJn6EieLwoM+AGvgLf2xZAnyDLGRaELzInJ+SO7ord2GYaYNjTR5t90R9Z5G
X0CrcxSgTDars169wF2+0xKVBzrgebu2rNqVv/XjUVPkndCmUwDySWW/KyMp6P6h
SLNW9PtReYS1EXw/3IsBCAYBlq+AyY1M+/zAAmx4OLjIDYe4dSU+qerop9/xz63c
+indjod7pAYlz2FKGj+V5fYx89JjyG+81PIOxnV50ItnZztsfwQGhSjMkslHNbsV
CBqxWkn6nkbl1d4o4BTNzVbpcXs1erI+VwbYSF57ohQa4MlEcSSQlZX1EYn3GUYW
l40Romoe9cUe1p71KMzX1gwpNxf6gmxH2W4rn0XRes3iINwWhXEISNcnhjkuogJh
xsrtqTY1MgXqPeoh3i4eRFTR7G5QX+6j+dq+Hn7aBZqQnFu8bx1E4DeVi0/YpXtt
ntyMcFuVbt4u5A21SO7gjP7zHZ7GgFO9GoocC6IDd2p6uLk+3tFBbmbNhQ3AwXsC
oBeTAi+U8To=
=URIi
-----END PGP SIGNATURE-----

--=-QcaiNG4JGppV0qi7Nz0D--

