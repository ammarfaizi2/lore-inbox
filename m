Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbTJMPgz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 11:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261791AbTJMPgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 11:36:55 -0400
Received: from mail.tamiweb.com ([194.12.244.146]:27522 "EHLO mail.tamiweb.com")
	by vger.kernel.org with ESMTP id S261784AbTJMPgx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 11:36:53 -0400
Subject: Duron 1GB memory problem
From: Kostadin Karaivanov <larry@tamiweb.com>
Reply-To: larry@tamiweb.com
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-vZKX2O8a78Nfta50zNBw"
Organization: tamiweb
Message-Id: <1066059458.16230.22.camel@laptop.minfin.bg>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 13 Oct 2003 18:37:38 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-vZKX2O8a78Nfta50zNBw
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

	1. After upgrading my memory up to 1BG (2x512MB SDRAM) previosly 512MB
(2x256MB SDRAM) I try to boot 2.6.0-test5 compiled without highmem
support with boot-time option mem=3D512M and I got an Oops right before
the checks for memory (15th-16th row of dmesg).
It can't boot without mem=3D512M option even.
 =09
	2. 2.4.20 (without highmem support) boots fine with same option, but
can't boot without it (?same? Oops).
=09
	3. 2.6.0-test7 _WITH_ highmem enabled boots but I get 2 kernel Oops for
24 hours.
=09
	4. 2.6.0-test5 _with_ highmem reboots itself before getting to login
prompt,  I was told  about this by my hosting support.
=09
	5. 2.4.22 with high mem works fine... for now

=09
	1, 2, 3 had happaned in my presence.
	I can't provide traces. It is productional server.

wwell Larry

--=-vZKX2O8a78Nfta50zNBw
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/isbBinq4IVRzHg8RAjXTAJwO9PuMm/aJZsBStuah2ZscxBArKgCg4M0d
nf4wVjYC441tUWdn/DL1E5I=
=tcA5
-----END PGP SIGNATURE-----

--=-vZKX2O8a78Nfta50zNBw--

