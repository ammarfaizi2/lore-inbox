Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282149AbRLDCBe>; Mon, 3 Dec 2001 21:01:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281855AbRLDB77>; Mon, 3 Dec 2001 20:59:59 -0500
Received: from ns3.miraclelinux.com ([61.120.40.82]:25082 "EHLO
	dns01.miraclelinux.com") by vger.kernel.org with ESMTP
	id <S280703AbRLDB7D>; Mon, 3 Dec 2001 20:59:03 -0500
To: kaos@sgi.com
Cc: kdb@oss.sgi.com, linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org
Cc: hyoshiok@miraclelinux.com
Subject: Re: [Linux-ia64] Announce: kdb v1.9 is available for kernel 2.4.16
In-Reply-To: <3838.1007359891@kao2.melbourne.sgi.com>
In-Reply-To: <3838.1007359891@kao2.melbourne.sgi.com>
X-Mailer: Mew version 1.94.2 on XEmacs 21.1 (Cuyahoga Valley)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20011204105051A.hyoshiok@miraclelinux.com>
Date: Tue, 04 Dec 2001 10:50:51 +0900
From: Hiro Yoshioka <hyoshiok@miraclelinux.com>
X-Dispatcher: imput version 20000228(IM140)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith,

I have a naive question.

Is there any chance to be merged into Linus's linux?

If not, why? If yes, when?

Thanks in advance,
  Hiro

From: Keith Owens <kaos@sgi.com>
Subject: [Linux-ia64] Announce: kdb v1.9 is available for kernel 2.4.16
Date: Mon, 03 Dec 2001 17:11:31 +1100
Message-ID: <3838.1007359891@kao2.melbourne.sgi.com>

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Content-Type: text/plain; charset=us-ascii
> 
> ftp://oss.sgi.com/projects/kdb/download/ix86/kdb-v1.9-2.4.16.bz2
> ftp://oss.sgi.com/projects/kdb/download/ia64/kdb-v1.9-2.4.16-ia64-011128.bz2
> 
> Ethan Solomita (ethan@cs.columbia.edu) has done a port of kdb to
> sparc64 against 2.4.13.  I will upgrade that to 2.4.16, integrate it
> with the other kdb changes since 2.4.13 and release it in a few days.
> 
> This will probably be the last release of kdb using this patch format.
> I plan to split kdb into a core patch and smaller arch dependent
> patches, instead of one big patch for each arch.
> 
> Changelog extract.
> 
> 2001-12-03 Keith Owens  <kaos@sgi.com>
> 
> 	* Upgrade to 2.4.16.
> 	* Add include/asm-um/kdb.h stub to allow XFS to be tested under UML.
> 	* Check if an interrupt frame on i386 came from user space.
> 	* Out of scope bug fix in kdb_id.c.  Ethan Solomita.
> 	* Changes to common code to support sparc64.  Ethan Solomita.
> 	* Change GFP_KERNEL to GFP_ATOMIC in disasm.  Ethan Solomita.
> 
> 2001-11-16 Keith Owens  <kaos@sgi.com>
> 
> 	* Upgrade to 2.4.15-pre5.
> 	* Wrap () around #define expressions with unary operators.
> 
> 2001-11-13 Keith Owens  <kaos@sgi.com>
> 
> 	* Upgrade to 2.4.15-pre4.
> 	* kbdm_pg.c patch from Hugh Dickins.
> 
> 2001-11-07 Keith Owens  <kaos@sgi.com>
> 
> 	* Upgrade to 2.4.14-ia64-011105.
> 	* Change name of l1 serial I/O routine, add ia64 init command.  SGI.
> 	* Sync kdbm_pg with XFS.
> 
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.0.4 (GNU/Linux)
> Comment: Exmh version 2.1.1 10/15/1999
> 
> iD8DBQE8CxeSi4UHNye0ZOoRAg5XAJ0X38pwRAQn626kA52x3blkPqJEZQCfYFZf
> uEs8b9QtISbATIBWtO44H/M=
> =01s4
> -----END PGP SIGNATURE-----
> 
> 
> _______________________________________________
> Linux-IA64 mailing list
> Linux-IA64@linuxia64.org
> http://lists.linuxia64.org/lists/listinfo/linux-ia64
