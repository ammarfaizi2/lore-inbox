Return-Path: <linux-kernel-owner+w=401wt.eu-S1751356AbXAFPUx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbXAFPUx (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 10:20:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbXAFPUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 10:20:53 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:49584 "EHLO
	turing-police.cc.vt.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751356AbXAFPUx (ORCPT
	<RFC822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 10:20:53 -0500
Message-Id: <200701061520.l06FKntg003207@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.20-rc3-mm1 - reiser4-sb_sync_inodes.patch causes boot hang
In-Reply-To: Your message of "Thu, 04 Jan 2007 22:02:00 PST."
             <20070104220200.ae4e9a46.akpm@osdl.org>
From: Valdis.Kletnieks@vt.edu
References: <20070104220200.ae4e9a46.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1168096849_3075P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 06 Jan 2007 10:20:49 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1168096849_3075P
Content-Type: text/plain; charset=us-ascii

On Thu, 04 Jan 2007 22:02:00 PST, Andrew Morton said:
> 	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20-rc3/2.6.20-rc3-mm1/

reiser4-sb_sync_inodes.patch causes my system to lock hard (no alt-sysrq,
need to power cycle) *very* early in the boot - earlyprintk hasn't fired
up yet, I don't get penguins, *nada*. I'm guessing it's something to do with
the changed spinlocking from the -rc2-mm1 version.

Kernel boots OK with that one patch reverted.



--==_Exmh_1168096849_3075P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFn75RcC3lWbTT17ARAgoKAKCDOVz/VJcxuxpvT7EopOCvJebQ/wCg9yRK
oDh7zPi23NltX7N8QgqfRw4=
=d9ij
-----END PGP SIGNATURE-----

--==_Exmh_1168096849_3075P--
