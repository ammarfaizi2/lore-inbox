Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266159AbUAVDsa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 22:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266172AbUAVDsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 22:48:30 -0500
Received: from h80ad2664.async.vt.edu ([128.173.38.100]:5760 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S266159AbUAVDs3 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 22:48:29 -0500
Message-Id: <200401212236.i0LMaNuh020491@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: linux-kernel@vger.kernel.org
Subject: 2.6.1-mm5 versus gcc 3.5 snapshot
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-747366344P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 21 Jan 2004 17:36:23 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-747366344P
Content-Type: text/plain; charset=us-ascii

Is the Fedora GCC 3.5 snapshot on crack, or is this a yet-unfixed not-ready-for 3.5?

gcc-ssa (GCC) 3.5-tree-ssa 20040115 (Fedora Core Rawhide 3.5ssa-108)

produces tons of these:

include/asm/rwsem.h: In function `__down_read_trylock':
include/asm/rwsem.h:126: warning: read-write constraint does not allow a register

--==_Exmh_-747366344P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFADv7mcC3lWbTT17ARAn7DAKDIGlZEmdYImosNoTnYCcnOVI393QCfblKT
IyD4utnYabBHxJzGLKGVWaM=
=+C1D
-----END PGP SIGNATURE-----

--==_Exmh_-747366344P--
