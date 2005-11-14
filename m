Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751202AbVKNRf5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbVKNRf5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 12:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbVKNRf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 12:35:57 -0500
Received: from ganesha.gnumonks.org ([213.95.27.120]:3256 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S1751202AbVKNRf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 12:35:57 -0500
Date: Mon, 14 Nov 2005 18:35:54 +0100
From: Harald Welte <laforge@gnumonks.org>
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org
Subject: [PATCH] Make sysctl.h (again) useable from userspace
Message-ID: <20051114173554.GK4773@sunbeam.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9ToWwKEyhugL+MAz"
Content-Disposition: inline
User-Agent: mutt-ng devel-20050619 (Debian)
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9ToWwKEyhugL+MAz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Make sysctl.h (again) useable from userspace

Signed-off-by: Harald Welte <laforge@netfilter.org>

---
commit b3d70298da3a00f29dd82cf16c1f13407ad2ac09
tree 740a126b72a8c1b1281ae159c0966960934aa207
parent 67e27e3ff7ef24e505d49d368fc3504569de86ef
author Harald Welte <laforge@netfilter.org> Mon, 14 Nov 2005 18:32:50 +0100
committer Harald Welte <laforge@netfilter.org> Mon, 14 Nov 2005 18:32:50 +0=
100

 include/linux/sysctl.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -20,7 +20,6 @@
=20
 #include <linux/kernel.h>
 #include <linux/types.h>
-#include <linux/list.h>
 #include <linux/compiler.h>
=20
 struct file;
@@ -859,6 +858,7 @@ enum
 };
=20
 #ifdef __KERNEL__
+#include <linux/list.h>
=20
 extern void sysctl_init(void);
=20
--=20
- Harald Welte <laforge@gnumonks.org>          	        http://gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--9ToWwKEyhugL+MAz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDeMr6XaXGVTD0i/8RAshzAJkBm0d6keOnOj4e/1zz0MxH/jCT1QCeJB3K
Tz+068dF7YFRsbYAL3UUaBU=
=eUL8
-----END PGP SIGNATURE-----

--9ToWwKEyhugL+MAz--
