Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311211AbSDXNAA>; Wed, 24 Apr 2002 09:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311424AbSDXM77>; Wed, 24 Apr 2002 08:59:59 -0400
Received: from pop.gmx.de ([213.165.64.20]:58788 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S311211AbSDXM76>;
	Wed, 24 Apr 2002 08:59:58 -0400
Date: Wed, 24 Apr 2002 14:58:16 +0200
From: Sebastian Droege <sebastian.droege@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: [PATCH 2.5.10] "CAPI2.0 support" showing up two times
Message-Id: <20020424145816.468ab94d.sebastian.droege@gmx.de>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.Xv3chX+wbr.IC/"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.Xv3chX+wbr.IC/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,
this simple patch removes one "tristate ...", because CAPI2.0 support was shown 2 times ;)
I think more explanation isn't necessary, or try CAPI2.0 support with menuconfig or xconfig without this patch

Bye

diff -Nur linux-2.5.10/drivers/isdn/capi/Config.in linux-2.5.10-2/drivers/isdn/capi/Config.in
--- linux-2.5.10/drivers/isdn/capi/Config.in    Wed Apr 24 09:15:13 2002
+++ linux-2.5.10-2/drivers/isdn/capi/Config.in  Wed Apr 24 14:50:55 2002
@@ -2,7 +2,6 @@
 # Config.in for the CAPI subsystem
 #
 
-tristate           'CAPI2.0 support' CONFIG_ISDN_CAPI
 if [ "$CONFIG_ISDN_CAPI" != "n" ]; then
    bool            '  Verbose reason code reporting (kernel size +=7K)' CONFIG_ISDN_DRV_AVMB1_VERBOSE_REASON
    dep_bool        '  CAPI2.0 Middleware support (EXPERIMENTAL)' CONFIG_ISDN_CAPI_MIDDLEWARE $CONFIG_EXPERIMENTAL

--=.Xv3chX+wbr.IC/
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE8xqvse9FFpVVDScsRAsx1AJ9C4knoe68Ug1A1RnVA5zmMis/9UgCgnVaA
uuj1cPr8kCg+GhFdc5SodFQ=
=FzyJ
-----END PGP SIGNATURE-----

--=.Xv3chX+wbr.IC/--

