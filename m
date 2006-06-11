Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbWFKSN6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbWFKSN6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 14:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbWFKSN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 14:13:56 -0400
Received: from manic.desrt.ca ([66.36.239.117]:17089 "HELO manic.desrt.ca")
	by vger.kernel.org with SMTP id S1750732AbWFKSN4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 14:13:56 -0400
Subject: [patch] ICH7 SCI_EN quirk required for Macbook
From: Ryan Lortie <desrt@desrt.ca>
To: lkml@vger.kernel.org, linux-acpi@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Ben Collins <bcollins@ubuntu.com>,
       Frederic Riss <frederic.riss@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Yb3G0z+a1ZV00/YAUUh4"
Message-Id: <1150048812.11072.13.camel@moonpix.desrt.ca>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Date: Sun, 11 Jun 2006 14:00:19 -0400
X-Evolution-Format: text/plain
X-Evolution-Account: 1143426473.4964.20@moonpix
X-Evolution-Transport: smtp://@copacetic.desrt.ca/;use_ssl=never
X-Evolution-Fcc: imap://desrt@copacetic.desrt.ca/sent
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

X-E        {
         .callback =3D init_ints_after_s1,
         .ident =3D "Toshiba Satellite 4030cdt",
         .matches =3D {DMI_MATCH(DMI_PRODUCT_NAME, "S4030CDT/4.3"),},
         },
+       {
+        .callback =3D init_ich7_sci_en_quirk,
+        .ident =3D "Intel Apple",
+        .matches =3D {DMI_MATCH(DMI_SYS_VENDOR, "Apple Computer"),},
+        },
        {},
 };
=20





--=-Yb3G0z+a1ZV00/YAUUh4
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iQG5AwUARIxaLJ96IjKvqm/2AQJcMA0eIQnj5Lm6YfYiHecouNsckBvBcZaCsYLd
Arzkg/lMV7UpXwuMbcoXo5/GHDqvGorjRfqfibmg82/gL/syS2kcv3xyPqGXTSsk
iyuxyP0qW442mbC8Dp1r9eps953D5--=-Yb3G0z+a1ZV00/YAUUh4--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
--=-Yb3G0z+a1ZV00/YAUUh4--
