Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271452AbTGQMyN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 08:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271453AbTGQMyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 08:54:13 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:3824 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S271452AbTGQMyM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 08:54:12 -0400
Subject: Re: 2.6.0-t1-ac2: unable to compile glibc 2.3.2
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Martin Zwickel <martin.zwickel@technotrend.de>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030717114548.5f5d506d.martin.zwickel@technotrend.de>
References: <20030717114548.5f5d506d.martin.zwickel@technotrend.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Q3NQctb44vw47zYTlWkv"
Organization: Red Hat, Inc.
Message-Id: <1058436931.5778.2.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-2) 
Date: 17 Jul 2003 12:15:31 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Q3NQctb44vw47zYTlWkv
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-07-17 at 11:45, Martin Zwickel wrote:
> Hi there!
>=20
> I just tried to update my glibc to 2.3.2 and saw that glibc can't compile
> because of linux/sysctl.h.
>=20
> I added the line "#include <linux/compiler.h>" to sysctl.h.
> (since sysctl needs the __user)
>=20
> So someone forgot the line, or did I miss something?

you're probably better off using not-the-kernel headers for building
glibc. eg on a RHL distro it's glibc-kernheaders package, other distros
have different package names for these files.

--=-Q3NQctb44vw47zYTlWkv
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/FndDxULwo51rQBIRAoUWAJ0WzL7uOHIKxJJJ/1zGVwHiE98MXwCfQaVL
mWhwb1+gsa7AquoCN4fhdR8=
=hI/0
-----END PGP SIGNATURE-----

--=-Q3NQctb44vw47zYTlWkv--
