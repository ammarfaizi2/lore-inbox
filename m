Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266249AbUJLQ7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266249AbUJLQ7L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 12:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266236AbUJLQ7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 12:59:00 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:17132 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S266137AbUJLQ64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 12:58:56 -0400
Message-Id: <200410121658.i9CGwcaS021574@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 07/26/2004 with nmh-1.1-RC3
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH} 2.6.9-rc4-mm1 - clean up #if/#ifdef
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1066698410P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 12 Oct 2004 12:58:38 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1066698410P
Content-Type: text/plain; charset=us-ascii

Small cleanup to make code safe for compiling with -Wundef..

Signed-off-by: valdis.kletnieks@vt.edu

--- linux-2.6.9-rc4-mm1/include/linux/kexec.h.Wundef	2004-10-12 11:53:53.000000000 -0400
+++ linux-2.6.9-rc4-mm1/include/linux/kexec.h	2004-10-12 12:53:34.458064221 -0400
@@ -1,7 +1,7 @@
 #ifndef LINUX_KEXEC_H
 #define LINUX_KEXEC_H
 
-#if CONFIG_KEXEC
+#ifdef CONFIG_KEXEC
 #include <linux/types.h>
 #include <linux/list.h>
 #include <asm/kexec.h>



--==_Exmh_-1066698410P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBbA09cC3lWbTT17ARAuFrAJ9IuabWBWLZ0VA/jD3SgNPdQOfZdgCgnU2R
9C9T1yQDNFNeBLMDxsdZ4gk=
=V/sL
-----END PGP SIGNATURE-----

--==_Exmh_-1066698410P--
