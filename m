Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317437AbSGUVGo>; Sun, 21 Jul 2002 17:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317439AbSGUVGo>; Sun, 21 Jul 2002 17:06:44 -0400
Received: from moutng.kundenserver.de ([212.227.126.176]:59366 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id <S317437AbSGUVGn>; Sun, 21 Jul 2002 17:06:43 -0400
Date: Sun, 21 Jul 2002 23:09:47 +0200
From: Hans-Joachim Baader <hjb@pro-linux.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19-rc3 trivial patch
Message-ID: <20020721210947.GC27075@mandel.hjbaader.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BRE3mIcgqKzpedwo"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BRE3mIcgqKzpedwo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

This line seems to be wrong, or is there a reason for it?


--- drivers/net/Config.in.orig	Sun Jul 21 14:08:38 2002
+++ drivers/net/Config.in	Sun Jul 21 23:07:01 2002
@@ -242,7 +242,7 @@
 fi
 dep_tristate 'D-Link DL2000-based Gigabit Ethernet support' CONFIG_DL2K $C=
ONFIG_PCI
 dep_tristate 'MyriCOM Gigabit Ethernet support' CONFIG_MYRI_SBUS $CONFIG_S=
BUS
-dep_tristate 'National Semiconduct DP83820 support' CONFIG_NS83820 $CONFIG=
_PCI
+dep_tristate 'National Semiconductor DP83820 support' CONFIG_NS83820 $CONF=
IG_PCI
 dep_tristate 'Packet Engines Hamachi GNIC-II support' CONFIG_HAMACHI $CONF=
IG_PCI
 dep_tristate 'Packet Engines Yellowfin Gigabit-NIC support (EXPERIMENTAL)'=
 CONFIG_YELLOWFIN $CONFIG_PCI $CONFIG_EXPERIMENTAL
 dep_tristate 'SysKonnect SK-98xx support' CONFIG_SK98LIN $CONFIG_PCI


Regards,
hjb
--=20
Pro-Linux - Germany's largest volunteer Linux support site
http://www.pro-linux.de/          Public Key ID 0x3DDBDDEA

--BRE3mIcgqKzpedwo
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment:  

iD8DBQE9OyMZLbySPj3b3eoRAvrFAJ9N+ypEhj0EjtuO12HX90mqovhgZgCfct/b
vqDrqFVeF7lF3C6ynN9IxKQ=
=KgKO
-----END PGP SIGNATURE-----

--BRE3mIcgqKzpedwo--
