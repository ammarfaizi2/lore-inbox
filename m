Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262463AbULCAw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262463AbULCAw6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 19:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261917AbULCAw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 19:52:58 -0500
Received: from mta10.srv.hcvlny.cv.net ([167.206.5.85]:64254 "EHLO
	mta10.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S262317AbULCAwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 19:52:51 -0500
Date: Thu, 02 Dec 2004 19:52:50 -0500
From: Jeff Sipek <jeffpc@optonline.net>
Subject: [Patch 2.6] Use proper documentation path
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: trivial@rustcorp.com.au, akpm@osdl.org, axboe@suse.de,
       piggin@cyberone.com.au
Message-id: <20041203005250.GA9185@optonline.net>
MIME-version: 1.0
Content-type: multipart/signed; boundary="tThc/1wpZn/ma/RB";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Content-disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Use proper documentation path

Signed-off-by: Josef "Jeff" Sipek <jeffpc@optonline.net>


diff -Nru a/drivers/block/as-iosched.c b/drivers/block/as-iosched.c
--- a/drivers/block/as-iosched.c	2004-12-02 19:45:45 -05:00
+++ b/drivers/block/as-iosched.c	2004-12-02 19:45:45 -05:00
@@ -25,7 +25,7 @@
 #define REQ_ASYNC	0
=20
 /*
- * See Documentation/as-iosched.txt
+ * See Documentation/block/as-iosched.txt
  */
=20
 /*
diff -Nru a/drivers/block/deadline-iosched.c b/drivers/block/deadline-iosch=
ed.c
--- a/drivers/block/deadline-iosched.c	2004-12-02 19:45:45 -05:00
+++ b/drivers/block/deadline-iosched.c	2004-12-02 19:45:45 -05:00
@@ -19,7 +19,7 @@
 #include <linux/rbtree.h>
=20
 /*
- * See Documentation/deadline-iosched.txt
+ * See Documentation/block/deadline-iosched.txt
  */
 static int read_expire =3D HZ / 2;  /* max time before a read is submitted=
=2E */
 static int write_expire =3D 5 * HZ; /* ditto for writes, these limits are =
SOFT! */


--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBr7jiwFP0+seVj/4RAj4CAJwI/bwWdNwGmVQLqeZd123csovrNwCgjx6Z
CYyr7SfsCTNoUm86744NjBU=
=pUBM
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
