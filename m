Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932262AbVINKOi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbVINKOi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 06:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932670AbVINKOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 06:14:37 -0400
Received: from imap.gmx.net ([213.165.64.20]:18070 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932262AbVINKOg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 06:14:36 -0400
X-Authenticated: #1700068
From: Torsten Foertsch <torsten.foertsch@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: COW pages and paging question
Date: Wed, 14 Sep 2005 12:14:26 +0200
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart15031277.djktha3tA1";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200509141214.32946.torsten.foertsch@gmx.net>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart15031277.djktha3tA1
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

when a process forks it's pages become shared by COW. Now one or both=20
processes are written partially to the swap space. Later some pages are pag=
ed=20
in.

Are they still shared between the 2 processes? (Assuming they are not writt=
en=20
to and cover the same address range)

Thanks,
Torsten

--nextPart15031277.djktha3tA1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBDJ/gIwicyCTir8T4RAryZAJ9cUd30umHYttKA/DOv0krfoItifACgkvET
LhHgDoKQdDrreQgM8o1Nxes=
=K20n
-----END PGP SIGNATURE-----

--nextPart15031277.djktha3tA1--
