Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263794AbUDQKoM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 06:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263782AbUDQKoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 06:44:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:49301 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263794AbUDQKoK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 06:44:10 -0400
Subject: Re: Fix UDF-FS potentially dereferencing null
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Linus Torvalds <torvalds@osdl.org>
Cc: Dave Jones <davej@redhat.com>, Jeff Garzik <jgarzik@pobox.com>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       bfennema@falcon.csc.calpoly.edu
In-Reply-To: <1082195458.4691.1.camel@laptop.fenrus.com>
References: <20040416214104.GT20937@redhat.com>
	 <20040416220014.GI24997@parcelfarce.linux.theplanet.co.uk>
	 <40806880.1030007@pobox.com> <20040416231823.GZ20937@redhat.com>
	 <Pine.LNX.4.58.0404161720450.3947@ppc970.osdl.org>
	 <1082195458.4691.1.camel@laptop.fenrus.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-wneqgyvKuUj3OfmE03Iq"
Organization: Red Hat UK
Message-Id: <1082198575.4691.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sat, 17 Apr 2004 12:42:55 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-wneqgyvKuUj3OfmE03Iq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> Hi,
>=20
> is it maybe a good idea to map this to gcc's "nonnull" attribute in some
> way? That way both sparse and the compiler get this explicit
> knowledge.... (afaics gcc will then also just optimize out the null ptr
> checks)

eh scratch that idea; the nonnull attribute appears to be quite useless
(and unused by gcc)

--=-wneqgyvKuUj3OfmE03Iq
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAgQovxULwo51rQBIRAgGfAJ9lMTDq+sbylehAPMSjDbRtjtl3XQCdHYaJ
b8KMm7LnZ4Mr9BaAP+lWgw0=
=7xcg
-----END PGP SIGNATURE-----

--=-wneqgyvKuUj3OfmE03Iq--

