Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263245AbTE0LHY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 07:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263246AbTE0LHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 07:07:24 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:640 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263245AbTE0LHX (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 07:07:23 -0400
Message-Id: <200305271041.h4RAf1J2007019@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fixes trivial error in drivers/isdn/hardware/eicon/divamnt.c 
In-Reply-To: Your message of "Tue, 27 May 2003 20:21:02 +1000."
             <20030527102102.GA23378@gondor.apana.org.au> 
From: Valdis.Kletnieks@vt.edu
References: <20030527102102.GA23378@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_523496244P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 27 May 2003 06:41:00 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_523496244P
Content-Type: text/plain; charset=us-ascii

On Tue, 27 May 2003 20:21:02 +1000, Herbert Xu said:

> This patch adds a pair of missing quotes.

> -	devfs_mk_cdev(MKDEV(major, 0), S_IFCHR|S_IRUSR|S_IWUSR, DivasMAINT);
> +	devfs_mk_cdev(MKDEV(major, 0), S_IFCHR|S_IRUSR|S_IWUSR, "DivasMAINT");
>  	return (1);

This smells like a missing #define DivasMAINT "Some Value Here"?

--==_Exmh_523496244P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+00C8cC3lWbTT17ARAhlmAJwMwnzDyCmGK5RRYPNnBAou7pwVLwCfWC3t
SILEHjwQmscuDKDMhfKhBQg=
=enQp
-----END PGP SIGNATURE-----

--==_Exmh_523496244P--
