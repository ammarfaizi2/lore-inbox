Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263407AbUDZTuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263407AbUDZTuX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 15:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263415AbUDZTuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 15:50:23 -0400
Received: from mailoff.mtu.edu ([141.219.70.111]:13473 "EHLO mailoff.mtu.edu")
	by vger.kernel.org with ESMTP id S263407AbUDZTuT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 15:50:19 -0400
Date: Mon, 26 Apr 2004 15:50:16 -0400
From: Jon DeVree <jadevree@mtu.edu>
To: linux-kernel@vger.kernel.org
Subject: hsf modem drivers lying about their license
Message-ID: <20040426195015.GA23220@icu2.csl.mtu.edu>
Reply-To: jadevree@mtu.edu
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Someone needs to take a look at the MODULE_LICENSE string reported by
the HSF modem drivers made by LinuxAnt.

http://www.linuxant.com/drivers/hsf/full/downloads.php

They creatively inserted a \0 character in it.
MODULE_LICENSE("GPL\0for files in the \"GPL\" directory; for others,
only LICENSE file applies");

Runnning modinfo -F license on the compiled driver gives:
GPL because of their creative null character. The actual license for most of
the files is NOT GPL.
--=20
Jon
http://tesla.resnet.mtu.edu
The only meaning in life is the meaning you create for it.

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQFAjWf2rd+yBMYSKYIRAqTrAKCraveF0bPk4gRhP93hRbC6szcMkQCdFRxa
Jx2rEaE/7wfeH4MylGMrFTs=
=9shk
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--

