Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263530AbTDMOnM (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 10:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263532AbTDMOnM (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 10:43:12 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:43250 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S263530AbTDMOnL (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Apr 2003 10:43:11 -0400
Subject: Re: 2.5.67-mm2
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
In-Reply-To: <20030413151232.D672@nightmaster.csn.tu-chemnitz.de>
References: <20030412180852.77b6c5e8.akpm@digeo.com>
	 <20030413151232.D672@nightmaster.csn.tu-chemnitz.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-RIlFG6ONcUo8zNug1Y3Z"
Organization: Red Hat, Inc.
Message-Id: <1050245689.1422.11.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 (1.2.4-2) 
Date: 13 Apr 2003 16:54:49 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-RIlFG6ONcUo8zNug1Y3Z
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-04-13 at 15:12, Ingo Oeser wrote:
> Hi Andrew,
> hi lists readers,
>=20
> On Sat, Apr 12, 2003 at 06:08:52PM -0700, Andrew Morton wrote:
> > +gfp_repeat.patch
> >=20
> >  Implement __GFP_REPEAT: so we can consolidate lots of alloc-with-retry=
 code.
>=20
> What about reworking the semantics of kmalloc()?
>=20
> Many users of kmalloc get the flags and size reversed (major
> source of hard to find bugs), so wouldn't it be simpler to have:

that in itself is easy to find btw; just give every GFP_* an extra
__GFP_REQUIRED bit and then check inside kmalloc for that bit (MSB?) to
be set.....

--=-RIlFG6ONcUo8zNug1Y3Z
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+mXo5xULwo51rQBIRAo9GAKCgDFFIXqa8x6RDNkwxm3awj9WpjgCffJbG
/DfJRIqObd1wzlktC0xxz8k=
=DBbY
-----END PGP SIGNATURE-----

--=-RIlFG6ONcUo8zNug1Y3Z--
