Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262423AbTFBPL3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 11:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262427AbTFBPL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 11:11:29 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:27634 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S262423AbTFBPL2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 11:11:28 -0400
Subject: Re: Strange load issues with 2.5.69/70 in both -mm and -bk trees.
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Ingo Molnar <mingo@elte.hu>
Cc: Tom Sightler <ttsig@tuxyturvy.com>, Andrew Morton <akpm@digeo.com>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0306021712530.7224-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0306021712530.7224-100000@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-YlGSxd0+QQ/IldE3icmX"
Organization: Red Hat, Inc.
Message-Id: <1054567475.5187.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (1.3.92-1) (Preview Release)
Date: 02 Jun 2003 17:24:35 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-YlGSxd0+QQ/IldE3icmX
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-06-02 at 17:14, Ingo Molnar wrote:
> On 2 Jun 2003, Tom Sightler wrote:
>=20
> > Sorry, this is my fault, I'm actually renicing the process to '10' not
> > '-10' that's a typo.  I tested this again this morning to make sure. =20
> > I'm renicing this as a regular user, I don't think that a regular user
> > is allowed to renice to a negative value.
>=20
> hm. Which process is generating the sound? But yes, if a positive renicin=
g
> for the wine process solved the audio problem then this is bad.

given that audio mixing also happens in userspace it doesn't sound that
weird..... niceing wine gives the userspace sound mixer more cpu time :)

--=-YlGSxd0+QQ/IldE3icmX
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+22wzxULwo51rQBIRAvQLAJ9wsZCNQ7lpO7LWivJVUFyo+Rh+PACdFFbo
w8k+LwA19T80jhuEJKudrEc=
=khbL
-----END PGP SIGNATURE-----

--=-YlGSxd0+QQ/IldE3icmX--
