Return-Path: <linux-kernel-owner+ralf=40uni-koblenz.de@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S315851AbSEWCrX>; Wed, 22 May 2002 22:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S315853AbSEWCrW>; Wed, 22 May 2002 22:47:22 -0400
Received: from fwout.nihs.go.jp ([202.241.36.162]:35489 "EHLO smtp") by vger.kernel.org with ESMTP id <S315851AbSEWCrV>; Wed, 22 May 2002 22:47:21 -0400
Message-ID: <004c01c20204$2d128b70$f3c4b5cb@k768>
From: "Takuya Satoh" <taka0038@yahoo.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: [PATCHSET] 2.4.19-pre8-jp13
Date: Thu, 23 May 2002 11:47:26 +0900
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No way, patch number 72 removed but:

mm/mm.o: In function `flush_inode_pages':
mm/mm.o(.text+0x3c2e): undefined reference to `pagecache_lock_cacheline'
mm/mm.o(.text+0x3cd5): undefined reference to `pagecache_lock_cacheline'
mm/mm.o: In function `filemap_fdatawait':
mm/mm.o(.text+0x4719): undefined reference to `pagecache_lock_cacheline'
mm/mm.o(.text+0x4748): undefined reference to `pagecache_lock_cacheline'
mm/mm.o: In function `do_generic_file_read':
mm/mm.o(.text+0x55ca): undefined reference to `pagecache_lock_cacheline'
mm/mm.o(.text+0x79bc): more undefined references to
`pagecache_lock_cacheline' follow
make[1]: *** [kallsyms] Error 1
make: *** [vmlinux] Error 2
errors during make bzImage, exiting

Taka


