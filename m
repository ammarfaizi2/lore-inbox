Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268301AbUH2Uk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268301AbUH2Uk3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 16:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268307AbUH2Uk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 16:40:28 -0400
Received: from ipx10602.ipxserver.de ([80.190.249.152]:34823 "EHLO taytron.net")
	by vger.kernel.org with ESMTP id S268301AbUH2UkU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 16:40:20 -0400
From: Florian Schirmer <jolt@tuxbox.org>
To: Pekka Pietikainen <pp@ee.oulu.fi>, jgarzik@pobox.com
Subject: [PATCH][0/4] b44: Cleanup and bcm47xx support
Date: Sun, 29 Aug 2004 22:17:57 +0200
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2614505.sLF7dPDoeK";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200408292218.00756.jolt@tuxbox.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2614505.sLF7dPDoeK
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

here is the second try to add bcm47xx support to the b44 driver. Changes si=
nce=20
the first version:

=2D Splitted the patch into logical hunks
=2D Ignore carrier lost errors (buggy hardware)
=2D Added CAM read support
=2D Read MAC from CAM instead of hardcoding a dummy MAC into the driver
=2D Use a special PHY address (0x30) to indicate that there is no PHY (this=
 is=20
compatible with the Broadcom et and 4401 driver)
=2D Added MDIO value calculation based on the backplane speed

Comments welcome!

Regards,
   Florian


--nextPart2614505.sLF7dPDoeK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBMjn4XRF2vHoIlBsRAqt5AJ0TC4k2iZ+Fp26TqKAiaWX3bE9kKgCfRoar
zG5U7bJnHBbTiBSnk0f1z2M=
=kqcU
-----END PGP SIGNATURE-----

--nextPart2614505.sLF7dPDoeK--
