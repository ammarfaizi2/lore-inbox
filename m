Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263185AbTE0KIG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 06:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263187AbTE0KIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 06:08:06 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:10001 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S263185AbTE0KIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 06:08:05 -0400
Date: Tue, 27 May 2003 20:21:02 +1000
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fixes trivial error in drivers/isdn/hardware/eicon/divamnt.c
Message-ID: <20030527102102.GA23378@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch adds a pair of missing quotes.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

Index: drivers/isdn/hardware/eicon/divamnt.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/drivers/isdn/hardware/eicon/divamnt.c,v
retrieving revision 1.1.1.4
diff -u -r1.1.1.4 divamnt.c
--- drivers/isdn/hardware/eicon/divamnt.c	27 May 2003 08:38:30 -0000	1.1.1.4
+++ drivers/isdn/hardware/eicon/divamnt.c	27 May 2003 10:17:11 -0000
@@ -421,7 +421,7 @@
 		return (0);
 	}
 
-	devfs_mk_cdev(MKDEV(major, 0), S_IFCHR|S_IRUSR|S_IWUSR, DivasMAINT);
+	devfs_mk_cdev(MKDEV(major, 0), S_IFCHR|S_IRUSR|S_IWUSR, "DivasMAINT");
 	return (1);
 }
 

--OXfL5xGRrasGEqWY--
