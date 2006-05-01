Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932160AbWEARKh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbWEARKh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 13:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbWEARKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 13:10:37 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:40635 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932160AbWEARKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 13:10:36 -0400
Message-Id: <200605011710.k41HATiZ008473@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: pi-futex-patchset-v4.patch (was Re: 2.6.17-rc3-mm1 
In-Reply-To: Your message of "Mon, 01 May 2006 01:47:37 PDT."
             <20060501014737.54ee0dd5.akpm@osdl.org> 
From: Valdis.Kletnieks@vt.edu
References: <20060501014737.54ee0dd5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1146503429_2620P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 01 May 2006 13:10:29 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1146503429_2620P
Content-Type: text/plain; charset=us-ascii

On Mon, 01 May 2006 01:47:37 PDT, Andrew Morton said:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc3/2.6.17-rc3-mm1/

Seen in pi-futex-patchset-v4.patch:

diff -puN include/linux/sysctl.h~pi-futex-patchset-v4 include/linux/sysctl.h
--- devel/include/linux/sysctl.h~pi-futex-patchset-v4   2006-04-30 00:17:10.000000000 -0700
+++ devel-akpm/include/linux/sysctl.h   2006-04-30 00:17:39.000000000 -0700
@@ -148,11 +148,11 @@ enum
        KERN_SPIN_RETRY=70,     /* int: number of spinlock retries */
        KERN_ACPI_VIDEO_FLAGS=71, /* int: flags for setting up video after ACPI sleep */
        KERN_IA64_UNALIGNED=72, /* int: ia64 unaligned userland trap enable */
-       KERN_COMPAT_LOG=73,     /* int: print compat layer  messages */
+       KERN_COMPAT_LOG=73,     /* int: print compat layer messages */
+       KERN_MAX_LOCK_DEPTH=73,
 };
 
Mismerge? I suspect MAX_LOG wants to be =74?

--==_Exmh_1146503429_2620P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEVkEFcC3lWbTT17ARAjn2AKDCWSo4s/H5qAWgwaWz0VOYT1764QCfW+kL
DyzhHlavXJXTECDZoSl/vNU=
=S+l8
-----END PGP SIGNATURE-----

--==_Exmh_1146503429_2620P--
