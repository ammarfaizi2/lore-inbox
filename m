Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261819AbSITJbl>; Fri, 20 Sep 2002 05:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261925AbSITJbl>; Fri, 20 Sep 2002 05:31:41 -0400
Received: from mta.sara.nl ([145.100.16.144]:31906 "EHLO mta.sara.nl")
	by vger.kernel.org with ESMTP id <S261819AbSITJbk>;
	Fri, 20 Sep 2002 05:31:40 -0400
Date: Fri, 20 Sep 2002 11:36:40 +0200
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: multipart/mixed; boundary=Apple-Mail-1-520309516
Subject: [patch] 2.5.36 reiserfs super.c
From: Remco Post <r.post@sara.nl>
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Message-Id: <778038AA-CC7C-11D6-AF50-000393911DE2@sara.nl>
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-1-520309516
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed

Hi,

small patch to include mm.h in fs/reiserfs/super.c


--Apple-Mail-1-520309516
Content-Disposition: attachment;
	filename=reiserfs2.patch
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="reiserfs2.patch"

--- linux-2.5/fs/reiserfs/super.c.org	Fri Sep 20 11:28:40 2002
+++ linux-2.5/fs/reiserfs/super.c	Thu Sep 19 20:59:46 2002
@@ -13,6 +13,7 @@
 
 #include <linux/config.h>
 #include <linux/module.h>
+#include <linux/mm.h>
 #include <linux/vmalloc.h>
 #include <linux/time.h>
 #include <asm/uaccess.h>

--Apple-Mail-1-520309516
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed


--
Met vriendelijke groeten,

Remco Post

SARA - Stichting Academisch Rekencentrum Amsterdam    http://www.sara.nl
High Performance Computing  Tel. +31 20 592 8008    Fax. +31 20 668 3167
PGP keys at http://home.sara.nl/~remco/keys.asc

"I really didn't foresee the Internet. But then, neither did the computer
industry. Not that that tells us very much of course - the computer 
industry
didn't even foresee that the century was going to end." -- Douglas Adams



--Apple-Mail-1-520309516--

