Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751436AbWEUE2G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbWEUE2G (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 00:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbWEUE2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 00:28:05 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:24289 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751436AbWEUE2E (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 00:28:04 -0400
Message-Id: <200605210428.k4L4S0nv013532@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc4-mm2
In-Reply-To: Your message of "Sat, 20 May 2006 05:41:03 PDT."
             <20060520054103.46a6edb5.akpm@osdl.org>
From: Valdis.Kletnieks@vt.edu
References: <20060520054103.46a6edb5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1148185680_32020P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 21 May 2006 00:28:00 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1148185680_32020P
Content-Type: text/plain; charset=us-ascii

On Sat, 20 May 2006 05:41:03 PDT, Andrew Morton said:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc4/2.6.17-rc4-mm2/

secmark-add-new-packet-controls-to-selinux.patch looks fishy:

--- devel/security/selinux/Kconfig~secmark-add-new-packet-controls-to-selinux   2006
-05-18 03:04:58.000000000 -0700
+++ devel-akpm/security/selinux/Kconfig 2006-05-18 03:04:58.000000000 -0700
@@ -1,6 +1,6 @@
 config SECURITY_SELINUX
        bool "NSA SELinux Support"
-       depends on SECURITY_NETWORK && AUDIT && NET && INET
+       depends on SECURITY_NETWORK && AUDIT && NET && INET && NETWORK_SECMARK
        default n
        help
          This selects NSA Security-Enhanced Linux (SELinux).

Was it *really* intended that SELINUX not be selectable if NETWORK_SECMARK
isn't present?


--==_Exmh_1148185680_32020P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEb+xQcC3lWbTT17ARAmA7AJwOEJCXU0HmO+fYrlsXn7xH00F3mwCfVV56
cfMZB8+7eP4xuQycDH2I1kY=
=rVV+
-----END PGP SIGNATURE-----

--==_Exmh_1148185680_32020P--
