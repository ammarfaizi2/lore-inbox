Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263957AbTKZDiK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 22:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263961AbTKZDiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 22:38:10 -0500
Received: from h80ad25ef.async.vt.edu ([128.173.37.239]:34688 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263957AbTKZDiH (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 22:38:07 -0500
Message-Id: <200311260337.hAQ3bwmw016622@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: linux-kernel@vger.kernel.org, linux390@de.ibm.com
Subject: 2.6.0-test10 s390/Kconfig typo?
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_898817537P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 25 Nov 2003 22:37:57 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_898817537P
Content-Type: text/plain; charset=us-ascii

OK, it's been a few years since I did S390, but this looks like
it's confused for 31/32 bit mode (happened to trip over it while digging
up info for another posting)

--- linux-2.6.0-test10/arch/s390/Kconfig.dist	2003-11-25 22:35:09.247637990 -0500
+++ linux-2.6.0-test10/arch/s390/Kconfig	2003-11-25 22:35:20.298903222 -0500
@@ -142,7 +142,7 @@
 	default y
 
 config BINFMT_ELF32
-	tristate "Kernel support for 31 bit ELF binaries"
+	tristate "Kernel support for 32 bit ELF binaries"
 	depends on S390_SUPPORT
 	help
 	  This allows you to run 32-bit Linux/ELF binaries on your zSeries


--==_Exmh_898817537P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/xCAVcC3lWbTT17ARAi6CAKCLj8Gag4V1Yn8BGqwfaYD6/eMBlACgrVpl
Q8EwnZuzdLGj9BR+e0AHIvA=
=dnO/
-----END PGP SIGNATURE-----

--==_Exmh_898817537P--
