Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268052AbUGWU6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268052AbUGWU6N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 16:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268055AbUGWU6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 16:58:13 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:45801 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S268052AbUGWU6L (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 16:58:11 -0400
Message-Id: <200407232058.i6NKwBW7031880@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.0.4+dev
To: Steve G <linux_4ever@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ext3 problems in dual booting machine with SE Linux 
In-Reply-To: Your message of "Fri, 23 Jul 2004 12:01:04 PDT."
             <20040723190104.48863.qmail@web50609.mail.yahoo.com> 
From: Valdis.Kletnieks@vt.edu
References: <20040723190104.48863.qmail@web50609.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1886543434P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 23 Jul 2004 16:58:11 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1886543434P
Content-Type: text/plain; charset=us-ascii

On Fri, 23 Jul 2004 12:01:04 PDT, Steve G said:

> This seems like an open door to mischief. Any removable media can now be used to
> oops a kernel.

However, this has *always* been the case - there's never been a guarantee that
mounting a possibly-maliciously modified filesystem won't trash things.  That's
why "force fsck on dirty bit set" was created way back in the Unix Stone Age.

And all you have to do to exploit it is get yourself a trashed filesystem, put it on
removable media, and clear the dirty bit...

--==_Exmh_1886543434P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBAXvjcC3lWbTT17ARAuFdAJ0ZLVCcYwZAXs61c2Z7Iv5wDl3rLwCgxbBI
W5gYPYRKXk7DZb3smBDRM3k=
=Yg+7
-----END PGP SIGNATURE-----

--==_Exmh_1886543434P--
