Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266005AbUA2B7V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 20:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266142AbUA2B7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 20:59:21 -0500
Received: from fmr99.intel.com ([192.55.52.32]:25317 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S266005AbUA2B7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 20:59:18 -0500
Subject: [PATCH] enable fast symbol lookup via an inverted index in cscope
From: Louis Zhuang <louis_zhuang@linux.co.intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-wETkGoBEfEMvKwAZJCS3"
Organization: Intel Crop.
Message-Id: <1075341626.19394.12.camel@hawk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 29 Jan 2004 10:00:26 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-wETkGoBEfEMvKwAZJCS3
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Dear Andrew,=20
	'-q' switch will accelerate cscope finding symbol dramatically. Please
apply following pacth if you like it.=20
--=20
Yours truly,
Louis Zhuang
---------------------------------------------------------------------------=
-----
Software is a process, not a static entity. It is becoming, rather that bei=
ng.
It can easily be bad, but never be perfect. Its essence is eternal refactor=
ing.
  - Inspired by Judge William H. Hastie

My words are my own...

---------------------------------------------------------------------------=
-----
Fault Injection Test Harness Project
BK tree: http://fault-injection.bkbits.net/linux-2.5
Home Page: http://sf.net/projects/fault-injection

Open HPI Project
Home Page: http://sf.net/projects/openhpi


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher=
.
# This patch includes the following deltas:
#	           ChangeSet	1.1502  -> 1.1503=20
#	            Makefile	1.446   -> 1.447 =20
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/01/29	louis@hawk.sh.intel.com	1.1503
# [CSCOPE] enable  fast  symbol lookup via an inverted index.
# --------------------------------------------
#
diff -Nru a/Makefile b/Makefile
--- a/Makefile	Thu Jan 29 08:26:24 2004
+++ b/Makefile	Thu Jan 29 08:26:24 2004
@@ -829,7 +829,7 @@
       cmd_cscope-file =3D $(all-sources) > cscope.files
=20
 quiet_cmd_cscope =3D MAKE    cscope.out
-      cmd_cscope =3D cscope -k -b
+      cmd_cscope =3D cscope -k -b -q
=20
 cscope: FORCE
 	$(call cmd,cscope-file)


--=-wETkGoBEfEMvKwAZJCS3
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAGGk64bBM03cUD/QRAoWOAJsEd0Zlr/SP7w+r7Xnh2WWAilPAVACfeZTH
gffOBQw3IKCyqGSSTiPYhTs=
=RNC1
-----END PGP SIGNATURE-----

--=-wETkGoBEfEMvKwAZJCS3--

