Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262319AbTEFD5x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 23:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262320AbTEFD5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 23:57:53 -0400
Received: from h80ad263c.async.vt.edu ([128.173.38.60]:52608 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262319AbTEFD4j (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 23:56:39 -0400
Message-Id: <200305060409.h46493MF002471@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: sumit_uconn@lycos.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: inode number 
In-Reply-To: Your message of "Mon, 05 May 2003 23:27:32 EDT."
             <BNBCKBPAKNHPBDAA@mailcity.com> 
From: Valdis.Kletnieks@vt.edu
References: <BNBCKBPAKNHPBDAA@mailcity.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1184821524P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 06 May 2003 00:09:02 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1184821524P
Content-Type: text/plain; charset=us-ascii

On Mon, 05 May 2003 23:27:32 EDT, Sumit Narayan <sumit_uconn@lycos.com>  said:
> How do I know which file has what Inode number? and its under which super blo
ck?

There's no single answer - multiple files can have the same inode number
(they're called hard links).  Finding which filesystem they are on
involves walking through the mount table..

--==_Exmh_-1184821524P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+tzVecC3lWbTT17ARAlXkAJ9PXOthjdIwU8tRqhqsnywvvKtTrgCdEfwy
+XoYwXs7MjPE6u/kh23a0Uc=
=wUHu
-----END PGP SIGNATURE-----

--==_Exmh_-1184821524P--
