Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262805AbTJFIaH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 04:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262824AbTJFIaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 04:30:07 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:14063 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S262805AbTJFIaB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 04:30:01 -0400
Subject: Re: 71MB compressed for COMPILED(!!!) 2.6.0-test6
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20031006082340.GA1135@matchmail.com>
References: <20031006082340.GA1135@matchmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-RlJFXyarok+oPKtvYyuq"
Organization: Red Hat, Inc.
Message-Id: <1065428996.5033.5.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-7) 
Date: Mon, 06 Oct 2003 10:29:56 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-RlJFXyarok+oPKtvYyuq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-10-06 at 10:23, Mike Fedyk wrote:
> Hi LK,
>=20
> A while back (after 2.6.0-test2-mm1 which came to 6.4MB compressed, and
> 2.6.0-test3-mm2 which came out to 34MB compressed), I noticed that the fi=
le
> sizes for compiled object code got a lot bigger.  I reported it at the ti=
me,
> but nobody was interested.
>=20
> Today after using 2.6.0-test4-mm3 for a few weeks, I decided to upgrade t=
o
> test6 and it's up to 71MB compressed!


CONFIG_DEBUG_INFO=3Dy

makes the kernel be compiled with -g which gives it debuginfo, which
basically ends up being the entire sourcecode included in the
modules/kernel


--=-RlJFXyarok+oPKtvYyuq
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/gSgDxULwo51rQBIRAkyBAJ42s5+yJTxXtTzi1an+jJunMWCBQQCfTUBy
qQvexyjC7xu4jquMfKidSMg=
=KsxL
-----END PGP SIGNATURE-----

--=-RlJFXyarok+oPKtvYyuq--
