Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262874AbTHZPAt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 11:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262821AbTHZPAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 11:00:48 -0400
Received: from h80ad2714.async.vt.edu ([128.173.39.20]:60034 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262874AbTHZPAq (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 11:00:46 -0400
Message-Id: <200308261458.h7QEwIMe018551@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Adrian Bunk <bunk@fs.tum.de>,
       linux kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] add a config option for -Os 
In-Reply-To: Your message of "Tue, 26 Aug 2003 23:41:09 +0900."
             <m2ekz8eb22.wl%ysato@users.sourceforge.jp> 
From: Valdis.Kletnieks@vt.edu
References: <20030825224717.GZ7038@fs.tum.de>
            <m2ekz8eb22.wl%ysato@users.sourceforge.jp>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1464658510P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 26 Aug 2003 10:58:18 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1464658510P
Content-Type: text/plain; charset=us-ascii

On Tue, 26 Aug 2003 23:41:09 +0900, Yoshinori Sato said:

>         -O2     -Os   -O2&-Os
> .text  561200  554368  555088
> .data   59148   58612   58868
> .bss    45244   45260   45244
> total  665592  658240  659200

Note that specifying -O2 *and* -Os together is probably counter-productive.

'info gcc' says:

    If you use multiple `-O' options, with or without level numbers,
     the last such option is the one that is effective.

You might want to investigate why the 3rd column of numbers is different
from both of the first two.


--==_Exmh_1464658510P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/S3WJcC3lWbTT17ARAsstAKDdEIBHwQ+MvIju1BmMHyeN2l3qAACfY5yT
oT+nr+3shrOq/9I0W6bqMW8=
=UHyT
-----END PGP SIGNATURE-----

--==_Exmh_1464658510P--
