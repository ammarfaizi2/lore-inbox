Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264522AbUAYQbI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 11:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264535AbUAYQbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 11:31:08 -0500
Received: from h80ad2489.async.vt.edu ([128.173.36.137]:1965 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S264522AbUAYQbF (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 11:31:05 -0500
Message-Id: <200401251628.i0PGS9Lh030629@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Fabio Coatti <cova@ferrara.linux.it>
Cc: Adrian Bunk <bunk@fs.tum.de>, Eric <eric@cisu.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Kernels > 2.6.1-mm3 do not boot. 
In-Reply-To: Your message of "Sun, 25 Jan 2004 16:39:56 +0100."
             <200401251639.56799.cova@ferrara.linux.it> 
From: Valdis.Kletnieks@vt.edu
References: <200401232253.08552.eric@cisu.net> <200401251452.58318.cova@ferrara.linux.it> <20040125143438.GI513@fs.tum.de>
            <200401251639.56799.cova@ferrara.linux.it>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1266474448P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 25 Jan 2004 11:28:08 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1266474448P
Content-Type: text/plain; charset=us-ascii

On Sun, 25 Jan 2004 16:39:56 +0100, Fabio Coatti said:

>   gcc -Wp,-MD,fs/.dcache.o.d -nostdinc -iwithprefix include -D__KERNEL__ 
> -Iinclude  -D__KERNEL__ -Iinclude  -Wall -Wstrict-prototypes -Wno-trigraphs 
> -fno-strict-aliasing -fno-common -pipe -msoft-float 
> -mpreferred-stack-boundary=2 -march=pentium4 -Iinclude/asm-i386/mach-default 
> -O2 -fomit-frame-pointer -funit-at-a-time     -DKBUILD_BASENAME=dcache 
> -DKBUILD_MODNAME=dcache -c -o fs/.tmp_dcache.o fs/dcache.c

Does it work if you disable -funit-at-a-time?  I had a problem with that
totally wedging a kernel right after the decompressing/loading messages.

--==_Exmh_-1266474448P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAE+6YcC3lWbTT17ARAuyaAKCRIen9duo57HU/czZifdBQo95z7wCbBFLP
8hCrU447+4BlcTG3BmgErJ0=
=HEB/
-----END PGP SIGNATURE-----

--==_Exmh_-1266474448P--
