Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264736AbTFWHsr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 03:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264759AbTFWHsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 03:48:46 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:35310 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S264736AbTFWHsh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 03:48:37 -0400
Subject: RE: [BK PATCH] acpismp=force fix
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: Andrew Morton <akpm@digeo.com>, torvalds@transmeta.com,
       acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <F760B14C9561B941B89469F59BA3A84725A302@orsmsx401.jf.intel.com>
References: <F760B14C9561B941B89469F59BA3A84725A302@orsmsx401.jf.intel.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-UAQQOzRDpOTAF7MiKZ5d"
Organization: Red Hat, Inc.
Message-Id: <1056355301.1699.6.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-2) 
Date: 23 Jun 2003 10:01:42 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-UAQQOzRDpOTAF7MiKZ5d
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-06-23 at 09:43, Grover, Andrew wrote:
> > From: Andrew Morton [mailto:akpm@digeo.com]=20
> > >    ACPI: make it so acpismp=3Dforce works (reported by Andrew Morton)
>=20
> > But prior to 2.5.72, CPU enumeration worked fine without=20
> > acpismp=3Dforce.=20
> > Now it is required.  How come?
>=20
> (I'm taking the liberty to update the subject, which I accidentally left
> blank)
>=20
> Because 2.4 has that behavior. One objection that people raised to
> applying the 2.4 ACPI patch was that it changed that behavior. So I made
> an effort to keep it there.

in 2.4 it is absolutely not mantadory; it's default actually if the cpu
advertises the "ht" flag.....

--=-UAQQOzRDpOTAF7MiKZ5d
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+9rPlxULwo51rQBIRAmSHAKCDUsXRO2DOFNGf38nO5sBgkcFkuQCZAcv2
HNtXVEwyuU1xFkOH5fihIHU=
=jskh
-----END PGP SIGNATURE-----

--=-UAQQOzRDpOTAF7MiKZ5d--
