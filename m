Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932292AbWFUSW3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbWFUSW3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 14:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932295AbWFUSW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 14:22:29 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:30912 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932292AbWFUSW3 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 14:22:29 -0400
Message-Id: <200606211822.k5LIMKHE010437@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] pi-futex-rt-mutex-core-merge.patch (was Re: 2.6.17-mm1
In-Reply-To: Your message of "Wed, 21 Jun 2006 03:48:57 PDT."
             <20060621034857.35cfe36f.akpm@osdl.org>
From: Valdis.Kletnieks@vt.edu
References: <20060621034857.35cfe36f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1150914139_3088P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 21 Jun 2006 14:22:20 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1150914139_3088P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, 21 Jun 2006 03:48:57 PDT, Andrew Morton said:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm1/

pi-futex-rt-mutex-core.patch has what looks like a merge error in it.

Patch to clean it up attached.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

--- linux-2.6.17-mm1/include/linux/sysctl.h.fix1	2006-06-21 13:24:32.000000000 -0400
+++ linux-2.6.17-mm1/include/linux/sysctl.h	2006-06-21 14:16:46.000000000 -0400
@@ -153,7 +153,7 @@ enum
 	KERN_NMI_WATCHDOG=74, /* int: enable/disable nmi watchdog */
 	KERN_PANIC_ON_NMI=75, /* int: whether we will panic on an unrecovered */
 	KERN_STOP_ON_CPU_LOST=76, /* int: SIGSTOP when a task losts its cpus */
-	KERN_MAX_LOCK_DEPTH=76,
+	KERN_MAX_LOCK_DEPTH=77,
 };
 
 



--==_Exmh_1150914139_3088P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEmY5bcC3lWbTT17ARAmSZAJ9uS1rMsoovr9Fd744VlClUm+beGQCfY/SU
EbxjNV8oM0+wSIHQ+Nkp250=
=VBSi
-----END PGP SIGNATURE-----

--==_Exmh_1150914139_3088P--
