Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261613AbUKGNg1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbUKGNg1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 08:36:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261615AbUKGNg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 08:36:27 -0500
Received: from ipx10602.ipxserver.de ([80.190.249.152]:53765 "EHLO taytron.net")
	by vger.kernel.org with ESMTP id S261613AbUKGNgX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 08:36:23 -0500
From: Florian Schirmer <jolt@tuxbox.org>
To: Sam Ravnborg <sam@mars.opasia.dk>
Subject: kbuild: make O=/build/dir broken
Date: Sun, 7 Nov 2004 14:36:08 +0100
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5300133.YmTlvpgUdK";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200411071436.14046.jolt@tuxbox.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart5300133.YmTlvpgUdK
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

i tried to build a kernel outside the src dir using <src dir>/make O=3D<bui=
ld=20
dir>. This failed because of

1. scripts/kbuild/zconf.tab.c not available in the <src dir>
2. usr/initramfs_list not available in the <build dir>

After copying the files by hand it worked. Something wrong on my side? I'm=
=20
using 2.6.10-rc1.

Thanks,
  Florian

--nextPart5300133.YmTlvpgUdK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBjiTNXRF2vHoIlBsRAspsAJ4imUK50l1Iq94Zuyx88esFXN1huwCfZhA3
co3A11TdBI5N0SU/8GuWgh0=
=DvzR
-----END PGP SIGNATURE-----

--nextPart5300133.YmTlvpgUdK--
