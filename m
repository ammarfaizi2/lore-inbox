Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272595AbRHaD6Q>; Thu, 30 Aug 2001 23:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272596AbRHaD6G>; Thu, 30 Aug 2001 23:58:06 -0400
Received: from mclean.mail.mindspring.net ([207.69.200.57]:57390 "EHLO
	mclean.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S272595AbRHaD5z>; Thu, 30 Aug 2001 23:57:55 -0400
Subject: Re: Linux 2.4.9-ac5
From: Robert Love <rml@tech9.net>
To: Alan Cox <laughing@shared-source.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010831013311.A8535@lightning.swansea.linux.org.uk>
In-Reply-To: <20010831013311.A8535@lightning.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99+cvs.2001.08.21.23.41 (Preview Release)
Date: 30 Aug 2001 23:58:11 -0400
Message-Id: <999230300.5953.20.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-08-30 at 20:33, Alan Cox wrote:
> 2.4.9-ac5
> o	Add MODULE_LICENSE tagging			(me)
> o	Add tags in drivers upto and including drivers/char/*

looks like a typo in drivers/block/z2ram.c 's addition of
MODULE_LICENSE.  Patch enclosed fixes:


--- linux-2.4.9-ac5/drivers/block/z2ram.c	Thu Aug 30 22:52:34 2001
+++ linux/drivers/block/z2ram.c	Thu Aug 30 23:52:56 2001
@@ -375,10 +375,10 @@
     return 0;
 }
 
-#if defined(MODULE
+#if defined(MODULE)
 
 MODULE_LICENSE("GPL");
-)
+
 int
 init_module( void )
 {


-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

