Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261984AbVFWCsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbVFWCsg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 22:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262025AbVFWCse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 22:48:34 -0400
Received: from 67.Red-80-25-56.pooles.rima-tde.net ([80.25.56.67]:20801 "EHLO
	estila.tuxedo-es.org") by vger.kernel.org with ESMTP
	id S261984AbVFWCs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 22:48:28 -0400
Subject: Re: [patch 1/1] selinux: minor cleanup in the
	hooks.c:file_map_prot_check() code
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: James Morris <jmorris@redhat.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, sds@tycho.nsa.gov
In-Reply-To: <Xine.LNX.4.44.0506222203060.10598-100000@thoron.boston.redhat.com>
References: <Xine.LNX.4.44.0506222203060.10598-100000@thoron.boston.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-aDCuL355iwiLrYQBre5I"
Date: Thu, 23 Jun 2005 04:48:24 +0200
Message-Id: <1119494904.9254.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-aDCuL355iwiLrYQBre5I
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

El mi=E9, 22-06-2005 a las 22:03 -0400, James Morris escribi=F3:
> On Wed, 22 Jun 2005, James Morris wrote:
>=20
> > > @@ -2485,7 +2487,7 @@ static int selinux_file_mprotect(struct=20
> > >  		 * check ability to execute the possibly modified content.
> > >  		 * This typically should only occur for text relocations.
> > >  		 */
> > > -		int rc =3D file_has_perm(current, vma->vm_file, FILE__EXECMOD);
> > > +		rc =3D file_has_perm(current, vma->vm_file, FILE__EXECMOD);
> > >  		if (rc)
> > >  			return rc;
> > >  	}
> > > _
> >=20
> Actually, this one's ok.

OK, thanks. I'll wait for Stephen to review it and then decide what to
do.

Cheers,
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-aDCuL355iwiLrYQBre5I
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCuiL4DcEopW8rLewRAtNPAKDNOzygU8W+DLtTCxkvX+3vQewXCgCeNk3K
g1KcQvVPtHcrZP4QrdYzAfk=
=rAyD
-----END PGP SIGNATURE-----

--=-aDCuL355iwiLrYQBre5I--
