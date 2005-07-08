Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbVGHDDI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbVGHDDI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 23:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261393AbVGHDDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 23:03:08 -0400
Received: from ozlabs.org ([203.10.76.45]:32999 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261347AbVGHDDH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 23:03:07 -0400
Date: Fri, 8 Jul 2005 12:44:31 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: avi@argo.co.il, linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: RFC: Hugepage COW
Message-ID: <20050708024431.GB30761@localhost.localdomain>
Mail-Followup-To: Stephen Rothwell <sfr@canb.auug.org.au>, avi@argo.co.il,
	linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
References: <20050707055554.GC11246@localhost.localdomain> <1120718967.2989.7.camel@blast.q> <20050707092425.GA10044@localhost.localdomain> <20050707225325.082ced8f.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
In-Reply-To: <20050707225325.082ced8f.sfr@canb.auug.org.au>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 07, 2005 at 10:53:25PM +1000, Stephen Rothwell wrote:
> On Thu, 7 Jul 2005 19:24:25 +1000 David Gibson <david@gibson.dropbear.id.=
au> wrote:
> >
> > That's not necessarily possible.  On some archs - ppc64 for one -
> > the mmu has to be set up for hugepages on a granularity greater than
> > the hugepage size.  So you can just arbitrarily substitute normal
>                              ^^^
> presumably you meant "cannot"

Oops.. yes, indeed.

> > pages for hugepages.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/people/dgibson

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCzeiOaILKxv3ab8YRAqfIAKCDfg6EgUe7VQAHiqKNLusLG61P3gCfcxTs
xsPrV2HkxJ550e4zzY/Mw/Y=
=jRLv
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
