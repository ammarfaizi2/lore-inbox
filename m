Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267869AbTBVJWL>; Sat, 22 Feb 2003 04:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267870AbTBVJWL>; Sat, 22 Feb 2003 04:22:11 -0500
Received: from postoffice2.mail.cornell.edu ([132.236.56.10]:29149 "EHLO
	postoffice2.mail.cornell.edu") by vger.kernel.org with ESMTP
	id <S267869AbTBVJWK> convert rfc822-to-8bit; Sat, 22 Feb 2003 04:22:10 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
Organization: ( )
To: Hans Reiser <reiser@namesys.com>
Subject: Compile error, reiserfs, 2.4.21-pre4-ac5
Date: Sat, 22 Feb 2003 04:33:27 -0500
User-Agent: KMail/1.5
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200302220433.44284.ivg2@cornell.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

gcc -D__KERNEL__ -I/usr/src/linux-2.4.21-pre4-ac5/include -Wall 
- -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
- -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=athlon    
- -nostdinc -iwithprefix include -DKBUILD_BASENAME=namei  -c -o namei.o namei.c
namei.c: In function `reiserfs_mkdir':
namei.c:651: label `out_failed' used but not defined
namei.c: In function `reiserfs_rmdir':
namei.c:709: `windex' undeclared (first use in this function)
namei.c:709: (Each undeclared identifier is reported only once
namei.c:709: for each function it appears in.)
namei.c: In function `reiserfs_symlink':
namei.c:863: `mode' undeclared (first use in this function)
namei.c:855: warning: unused variable `windex'
make[3]: *** [namei.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.4.21-pre4-ac5/fs/reiserfs'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.21-pre4-ac5/fs/reiserfs'
make[1]: *** [_subdir_reiserfs] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.21-pre4-ac5/fs'
make: *** [_dir_fs] Error 2

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+V0P3XQ/AjixQzHcRAsGiAJ0V2TtcCcYGKvfF8yr4OeRbTlUowwCgjcBY
eIt4xPePh79tVIt7f60lxY8=
=/pwf
-----END PGP SIGNATURE-----

