Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbTKPC7K (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 21:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbTKPC7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 21:59:10 -0500
Received: from h80ad2624.async.vt.edu ([128.173.38.36]:11146 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261909AbTKPC7H (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 21:59:07 -0500
Message-Id: <200311160259.hAG2x4La006117@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.0-test9 - document elevator= parameter
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_903298045P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 15 Nov 2003 21:59:03 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_903298045P
Content-Type: text/plain; charset=us-ascii

Nick wrote a nice as-iosched.txt file, but apparently nobody updated the
kernel-parameters.txt file...

Diff against 2.6.0-test9-mm3.

--- linux.dist/Documentation/kernel-parameters.txt.dist	2003-11-13 15:20:43.000000000 -0500
+++ linux/Documentation/kernel-parameters.txt	2003-11-15 21:54:54.004814257 -0500
@@ -24,6 +24,7 @@
 	HW	Appropriate hardware is enabled.
 	IA-32	IA-32 aka i386 architecture is enabled.
 	IA-64	IA-64 architecture is enabled.
+	IOSCHED	More than one I/O scheduler is enabled.
 	IP_PNP	IP DCHP, BOOTP, or RARP is enabled.
 	ISAPNP	ISA PnP code is enabled.
 	ISDN	Appropriate ISDN support is enabled.
@@ -303,6 +304,10 @@
 			See comment before function elanfreq_setup() in
 			arch/i386/kernel/cpu/cpufreq/elanfreq.c.
 
+	elevator=	[IOSCHED]
+			Format: {"as"|"cfq"|"deadline"|"noop"}
+			See Documentation/as-iosched.txt for details
+
 	es1370=		[HW,OSS]
 			Format: <lineout>[,<micbias>]
 			See also header of sound/oss/es1370.c.



--==_Exmh_903298045P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/tuf3cC3lWbTT17ARAi3rAJ40W+UL4Eq2q7F4oKkt7e0xKJfboACfUe3Y
AbU70OeiU+Lp/Vm3uopWlZA=
=ePMj
-----END PGP SIGNATURE-----

--==_Exmh_903298045P--
