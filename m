Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263590AbTJVLoD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 07:44:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263591AbTJVLoD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 07:44:03 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:11536 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S263590AbTJVLoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 07:44:00 -0400
Date: Wed, 22 Oct 2003 21:43:51 +1000
To: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Include linux/init.h for __init
Message-ID: <20031022114351.GA31790@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi:

These two files need linux/init.h to compile on alpha.

Cheers,
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

Index: kernel-source-2.5/drivers/char/moxa.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/drivers/char/moxa.c,v
retrieving revision 1.6
diff -u -r1.6 moxa.c
--- kernel-source-2.5/drivers/char/moxa.c	11 Oct 2003 06:29:21 -0000	1.6
+++ kernel-source-2.5/drivers/char/moxa.c	22 Oct 2003 11:34:49 -0000
@@ -49,6 +49,7 @@
 #include <linux/tty_driver.h>
 #include <linux/delay.h>
 #include <linux/pci.h>
+#include <linux/init.h>
 
 #include <asm/system.h>
 #include <asm/io.h>
Index: kernel-source-2.5/drivers/char/mxser.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/drivers/char/mxser.c,v
retrieving revision 1.1.1.8
diff -u -r1.1.1.8 mxser.c
--- kernel-source-2.5/drivers/char/mxser.c	8 Oct 2003 19:24:17 -0000	1.1.1.8
+++ kernel-source-2.5/drivers/char/mxser.c	22 Oct 2003 11:35:42 -0000
@@ -56,6 +56,7 @@
 #include <linux/mm.h>
 #include <linux/smp_lock.h>
 #include <linux/pci.h>
+#include <linux/init.h>
 
 #include <asm/system.h>
 #include <asm/io.h>

--ZGiS0Q5IWpPtfppv--
