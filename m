Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261344AbVB0E2d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261344AbVB0E2d (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 23:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbVB0E2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 23:28:33 -0500
Received: from ozlabs.org ([203.10.76.45]:55942 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261344AbVB0E20 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 23:28:26 -0500
Date: Sun, 27 Feb 2005 14:39:44 +1100
From: David Gibson <hermes@gibson.dropbear.id.au>
To: Eric Gaumer <gaumerel@ecs.fullerton.edu>
Cc: linux-kernel@vger.kernel.org, proski@gnu.org
Subject: Re: [PATCH] orinoco rfmon
Message-ID: <20050227033944.GA15380@localhost.localdomain>
Mail-Followup-To: David Gibson <hermes@gibson.dropbear.id.au>,
	Eric Gaumer <gaumerel@ecs.fullerton.edu>,
	linux-kernel@vger.kernel.org, proski@gnu.org
References: <4220BB87.2010806@ecs.fullerton.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
In-Reply-To: <4220BB87.2010806@ecs.fullerton.edu>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 26, 2005 at 10:10:15AM -0800, Eric Gaumer wrote:
> Could anyone elaborate on the status of this patch? I've had 344 days of=
=20
> uptime on a PPC
> powerbook using it on 2.4.22 and about 3 months of solid use on 2.6.
>=20
> If the code looks problematic could someone point out possible deficienci=
es=20
> so we can work
> toward a satisfactory resolution? I didn't write the code but I'm willing=
=20
> do what I have to
> in order to get this (wireless scanning) into the official tree.

This looks like the ancient version of the monitor patch - which
includes importing a lot of needless junk from the linux-wlan-ng
tree.  A cleaned up version of monitor has been merged in the orinoco
CVS tree for ages now, but unfortunately that's long overdue for a
merge with mainline.  I'm trying to get that merge done - I just don't
have much time or energy for the orinoco driver these days.  One stack
of patches which gets part of the way went to Jeff Garzik last week.
We'll see how we go.

In the meantime go to http://savannah.nongnu.org/projects/orinoco for
access to the driver CVS.  You probably want to get the "for_linus"
branch of CVS if you're planning to work with 2.6.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist.  NOT _the_ _other_ _way_
				| _around_!
http://www.ozlabs.org/people/dgibson

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFCIUEAaILKxv3ab8YRAj0wAJ9TiFEIIWA9M9VZq+Yd5hNyB7TKVACglBs7
Y9rLMf/pvgMQLm3kpA0IOCY=
=S/w0
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
