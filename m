Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751755AbWD0XCH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751755AbWD0XCH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 19:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751756AbWD0XCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 19:02:06 -0400
Received: from ozlabs.org ([203.10.76.45]:37256 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751755AbWD0XCF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 19:02:05 -0400
Subject: Re: [PATCH 04/16] ehca: userspace support
From: Michael Ellerman <michael@ellerman.id.au>
Reply-To: michael@ellerman.id.au
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Heiko J Schick <schihei@de.ibm.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org, linuxppc-dev@ozlabs.org,
       Christoph Raisch <RAISCH@de.ibm.com>,
       Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>
In-Reply-To: <20060427114355.GB32127@wohnheim.fh-wedel.de>
References: <4450A176.9000008@de.ibm.com>
	 <20060427114355.GB32127@wohnheim.fh-wedel.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-DttCo3RYPgfK2sXFjrj9"
Date: Fri, 28 Apr 2006 08:36:28 +1000
Message-Id: <1146177388.19236.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-DttCo3RYPgfK2sXFjrj9
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-04-27 at 13:43 +0200, J=C3=B6rn Engel wrote:
> More minors.
>=20
> On Thu, 27 April 2006 12:48:22 +0200, Heiko J Schick wrote:
> > +
> > +	EDEB_EN(7,
> > +		"vm_start=3D%lx vm_end=3D%lx vm_page_prot=3D%lx vm_fileoff=3D%lx "
> > +		"address=3D%lx",
> > +		vma->vm_start, vma->vm_end, vma->vm_page_prot, fileoffset,
> > +		address);
>=20
> Gesundheit!  Seriously, I suspect "EDEB_EN" is not the best possible
> name to pick.

Try pr_debug() in include/linux/kernel.h

cheers

--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-DttCo3RYPgfK2sXFjrj9
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEUUdsdSjSd0sB4dIRAj0oAJsGDP1vf81gjsm70yJv2YavVDNFSQCfWDUZ
r38dlv6fWBtVbx2K8c9RctU=
=cK1T
-----END PGP SIGNATURE-----

--=-DttCo3RYPgfK2sXFjrj9--

