Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265998AbUAQFTN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 00:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265999AbUAQFTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 00:19:13 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:40200 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S265998AbUAQFTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 00:19:11 -0500
Date: Sat, 17 Jan 2004 16:19:00 +1100
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Set MODULE_LICENSE in tsdev
Message-ID: <20040117051900.GA2813@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi:

This patch sets MODULE_LICENSE for drivers/input/tsdev.c.

Cheers,
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

Index: kernel-2.5/drivers/input/tsdev.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/drivers/input/tsdev.c,v
retrieving revision 1.1.1.6
diff -u -r1.1.1.6 tsdev.c
--- kernel-2.5/drivers/input/tsdev.c	27 Sep 2003 00:01:56 -0000	1.1.1.6
+++ kernel-2.5/drivers/input/tsdev.c	17 Jan 2004 05:16:49 -0000
@@ -397,6 +397,7 @@
 
 MODULE_AUTHOR("James Simmons <jsimmons@transvirtual.com>");
 MODULE_DESCRIPTION("Input driver to touchscreen converter");
+MODULE_LICENSE("GPL");
 MODULE_PARM(xres, "i");
 MODULE_PARM_DESC(xres, "Horizontal screen resolution");
 MODULE_PARM(yres, "i");

--0F1p//8PRICkK4MW--
