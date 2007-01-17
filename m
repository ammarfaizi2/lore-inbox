Return-Path: <linux-kernel-owner+w=401wt.eu-S1751600AbXAQVJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751600AbXAQVJs (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 16:09:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751611AbXAQVJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 16:09:48 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:59102 "EHLO
	turing-police.cc.vt.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751568AbXAQVJr (ORCPT
	<RFC822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 16:09:47 -0500
Message-Id: <200701172109.l0HL9fdw019715@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Andrew Morton <akpm@osdl.org>, Chris Leech <christopher.leech@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.20-rc4-mm1 - cvs merge whoops in git-ioat.patch?
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1169068181_4892P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 17 Jan 2007 16:09:41 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1169068181_4892P
Content-Type: text/plain; charset=us-ascii

commit d8238afa7eedc047b57da7ec98e98fb051fc4e85
Author: Chris Leech <christopher.leech@intel.com>
Date:   Fri Nov 17 11:37:29 2006 -0800

    I/OAT: Add documentation for the tcp_dma_copybreak sysctl

    Signed-off-by: Chris Leech <christopher.leech@intel.com>

looks fishy, like a cvs update went bad:

diff -puN Documentation/networking/ip-sysctl.txt~git-ioat Documentation/networking/ip-sysctl.txt
--- a/Documentation/networking/ip-sysctl.txt~git-ioat
+++ a/Documentation/networking/ip-sysctl.txt
@@ -387,6 +387,22 @@ tcp_workaround_signed_windows - BOOLEAN
        not receive a window scaling option from them.
        Default: 0

+<<<<<<< HEAD/Documentation/networking/ip-sysctl.txt
+=======
+tcp_slow_start_after_idle - BOOLEAN
+       If set, provide RFC2861 behavior and time out the congestion



--==_Exmh_1169068181_4892P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFrpCVcC3lWbTT17ARAjHaAKC14ikUjOclkGvpxYtpcvjKWWrrPwCeP5oa
pQ5DeqcKdT5jt8wLiIiwjW0=
=UUr/
-----END PGP SIGNATURE-----

--==_Exmh_1169068181_4892P--
