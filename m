Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262071AbUDXKtv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbUDXKtv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Apr 2004 06:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262132AbUDXKtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Apr 2004 06:49:51 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:61447 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S262071AbUDXKtt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Apr 2004 06:49:49 -0400
Date: Sat, 24 Apr 2004 20:49:36 +1000
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Set module license in mcheck/non-fatal.c
Message-ID: <20040424104936.GA11721@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi:

This patch sets the module license for mcheck/non-fatal.c.  The module
doesn't work at all without this as one of the symbols it needs is
only exported as GPL.

Cheers,
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

Index: arch/i386/kernel/cpu/mcheck/non-fatal.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/arch/i386/kernel/cpu/mcheck/non-fatal.c,v
retrieving revision 1.1.1.6
diff -u -r1.1.1.6 non-fatal.c
--- a/arch/i386/kernel/cpu/mcheck/non-fatal.c	11 Mar 2004 02:55:22 -0000	1.1.1.6
+++ b/arch/i386/kernel/cpu/mcheck/non-fatal.c	24 Apr 2004 10:45:18 -0000
@@ -88,3 +88,5 @@
 	return 0;
 }
 module_init(init_nonfatal_mce_checker);
+
+MODULE_LICENSE("GPL");

--IJpNTDwzlM2Ie8A6--
