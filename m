Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261620AbTH2Sa1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 14:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261623AbTH2Sa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 14:30:27 -0400
Received: from mx.laposte.net ([213.30.181.11]:28336 "EHLO mx.laposte.net")
	by vger.kernel.org with ESMTP id S261620AbTH2Sa0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 14:30:26 -0400
Subject: CONFIG_LOG_BUF_SHIFT hardwired in 2.6.0-test4-bk2 ?
From: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-c+wlUg3xxlMiHAKTNMpO"
Organization: Adresse personnelle
Message-Id: <1062181819.3618.4.camel@rousalka.dyndns.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Fri, 29 Aug 2003 20:30:19 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-c+wlUg3xxlMiHAKTNMpO
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

	I'm testing acpi changes and unfortunately all the debug messages
overflow the log buffer. So I decided to increase CONFIG_LOG_BUF_SHIFT=20
in .config (there was a menu entry for this at some time in menuconfig
but I can't find it anymore).

	Anyway no matter what I do the value seems to be reseted to 14 at build
time. Is there a way to cleanly change it without poking directly into
the kernel source code ?

Regards,

[ Please CC me answers as I only skim the list via marc ]

--=20
Nicolas Mailhot

--=-c+wlUg3xxlMiHAKTNMpO
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/T5u6I2bVKDsp8g0RAgzhAKDc2f6oqE5WtuBQX46nv5y9OoFo7QCeIYe5
1CRktnXpLkmngdpqnzJC2vY=
=BPFP
-----END PGP SIGNATURE-----

--=-c+wlUg3xxlMiHAKTNMpO--

