Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265062AbUAYRxN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 12:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265063AbUAYRxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 12:53:13 -0500
Received: from h80ad2489.async.vt.edu ([128.173.36.137]:35501 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265062AbUAYRxI (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 12:53:08 -0500
Message-Id: <200401251749.i0PHnlKE000956@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Fabio Coatti <cova@ferrara.linux.it>, Andi Kleen <ak@muc.de>,
       Andrew Morton <akpm@osdl.org>, Eric <eric@cisu.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: Kernels > 2.6.1-mm3 do not boot. - SOLVED 
In-Reply-To: Your message of "Sun, 25 Jan 2004 18:30:48 +0100."
             <20040125173048.GL513@fs.tum.de> 
From: Valdis.Kletnieks@vt.edu
References: <200401232253.08552.eric@cisu.net> <200401251639.56799.cova@ferrara.linux.it> <20040125162122.GJ513@fs.tum.de> <200401251811.27890.cova@ferrara.linux.it>
            <20040125173048.GL513@fs.tum.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1233871780P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 25 Jan 2004 12:49:47 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1233871780P
Content-Type: text/plain; charset=us-ascii

On Sun, 25 Jan 2004 18:30:48 +0100, Adrian Bunk said:

> Th patch below replaces use-funit-at-a-time.patch and uses 
> scripts/gcc-version.sh from add-config-for-mregparm-3-ng* to use 
> -funit-at-a-time only with gcc >= 3.4 .

The Fedora gcc-ssa compiler has this problem, but claims to be 3.5.  So
at a minimum, we'd need to document the Fedora breakage and stick a
big "Don't do that" on it.

--==_Exmh_-1233871780P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAFAG6cC3lWbTT17ARAjWvAKCVIYy1iWU/NfmyPFEow6rhAhN3ggCgwry+
kXrg90/7Q7BlLRh/R7+t5gg=
=w/ya
-----END PGP SIGNATURE-----

--==_Exmh_-1233871780P--
