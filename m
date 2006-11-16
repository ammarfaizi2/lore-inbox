Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162086AbWKPADL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162086AbWKPADL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 19:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162087AbWKPADK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 19:03:10 -0500
Received: from ozlabs.org ([203.10.76.45]:4484 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1162086AbWKPADJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 19:03:09 -0500
Subject: Re: [PATCH]: HVCS char driver janitoring: fix compile warnings
From: Michael Ellerman <michael@ellerman.id.au>
Reply-To: michael@ellerman.id.au
To: Linas Vepstas <linas@austin.ibm.com>
Cc: Greg KH <greg@kroah.com>, akpm@osdl.org, Alan Cox <alan@redhat.com>,
       "Ryan S. Arnold" <rsa@us.ibm.com>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061115212619.GJ8395@austin.ibm.com>
References: <20061115212619.GJ8395@austin.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-xyBtvIMMSCzfvtVhCm93"
Date: Thu, 16 Nov 2006 11:03:07 +1100
Message-Id: <1163635387.8805.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xyBtvIMMSCzfvtVhCm93
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-11-15 at 15:26 -0600, Linas Vepstas wrote:
>=20
> This is a non-urgent patch.=20
>=20
> I can't figure out who the upstream maintainer for char drivers=20
> is supposed to be. Can this patch be applied?=20
>=20
> --linas
>=20
> This patch removes an pair of irritating compiler warnings:
>=20
> drivers/char/hvcs.c:1605: warning: ignoring return value of
> sysfs_create_group declared with attribute warn_unused_result
> drivers/char/hvcs.c:1639: warning: ignoring return value of
> driver_create_file declared with attribute warn_unused_result
>=20
> Doing this required moving a big block of code from the bottom=20
> of the file to the top, so as to avoid the need for (irritating)=20
> forward declarations.

Can you do the move and the fix as two patches? It's very hard to review
in its current form.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-xyBtvIMMSCzfvtVhCm93
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFW6q7dSjSd0sB4dIRAui0AJwMx+pk+gQYnIQ/P6BXjRXF9qf2SACfV/fy
v0VX8TwyNRG/Yyp7TYovRds=
=pWlU
-----END PGP SIGNATURE-----

--=-xyBtvIMMSCzfvtVhCm93--

