Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267314AbUIXO5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267314AbUIXO5Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 10:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267388AbUIXO5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 10:57:16 -0400
Received: from mx1.redhat.com ([66.187.233.31]:41609 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267314AbUIXO5O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 10:57:14 -0400
Subject: Re: i386 entry.S problems
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Jan Beulich <JBeulich@novell.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <s1543914.047@emea1-mh.id2.novell.com>
References: <s1543914.047@emea1-mh.id2.novell.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-lufRyBeZQcRTE0QWvKvM"
Organization: Red Hat UK
Message-Id: <1096037828.2612.53.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 24 Sep 2004 16:57:08 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-lufRyBeZQcRTE0QWvKvM
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-09-24 at 16:12, Jan Beulich wrote:
> There appear to be two problems in i386's entry.S:
>=20
> (1) With CONFIG_REGPARM, lcall7 and lcall27 did not work (they pass the
> parameters to the actual handler procedure on the stack).

I wonder why we still have the lcall7/lcall27 entry points in the
kernel; nothing can legitemately use them and in the last few years they
have only caused a few security issues. Can I ask why you didn't just
remove this code from the kernel ?

--=-lufRyBeZQcRTE0QWvKvM
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBVDXExULwo51rQBIRAmmmAJ0W9xtw0xd4Dj/FPCOO7hGUdWPEzQCfcgti
0r/axIs47HR1WvXYhUuK4mk=
=+9sA
-----END PGP SIGNATURE-----

--=-lufRyBeZQcRTE0QWvKvM--

