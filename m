Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264187AbTDPB1w (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 21:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264189AbTDPB1w 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 21:27:52 -0400
Received: from adsl-67-121-155-183.dsl.pltn13.pacbell.net ([67.121.155.183]:8416
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id S264187AbTDPB1v (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 21:27:51 -0400
Date: Tue, 15 Apr 2003 18:39:42 -0700
To: kernel@kolivas.org
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [2.4.20-ck6] Rmap15f patch fails in vmscan.c
Message-ID: <20030416013942.GA31943@triplehelix.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Joshua Kwan <joshk@triplehelix.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The subject says it all. Extracted a clean 2.4.20 tree, patched it with
the full -ck6 patch, then applied the rmap15f patch, and it fails in
mm/vmscan.c. Give it a try for yourself... :)

(The reason why I haven't just fixed it myself is because the rejects
file is really big, and it seems to me like something you can easily
correct with your sources, by rediffing against the right version of the
file or something.)

Regards
Josh

--=20
New PGP public key: 0x27AFC3EE

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+nLReT2bz5yevw+4RAuNYAJ47PB4BBE+NH4JtWQFZthIvt3zlOQCgs01v
2TlrzFAo9LOjv/Y3PIUP3rE=
=TCTz
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
