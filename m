Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282683AbRLFTHX>; Thu, 6 Dec 2001 14:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282695AbRLFTHE>; Thu, 6 Dec 2001 14:07:04 -0500
Received: from smtp02.web.de ([217.72.192.151]:33811 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S282668AbRLFTFA>;
	Thu, 6 Dec 2001 14:05:00 -0500
Date: Thu, 6 Dec 2001 20:09:22 +0100
From: =?ISO-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.17-pre2: unclean cleanup in i2ellis.c
Message-Id: <20011206200922.58f05b82.l.s.r@web.de>
X-Mailer: Sylpheed version 0.6.1 (GTK+ 1.2.10; i586-mandrake-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Could you please send me a patch to undo that change ? 

Sure.

--- linux-2.4.17-pre2/drivers/char/ip2/i2ellis.c	Thu Dec  6 19:38:02 2001
+++ linux-2.4.17-pre1/drivers/char/ip2/i2ellis.c	Wed Oct 24 21:05:18 2001
@@ -102,7 +102,6 @@
 // This routine performs any required cleanup of the iiEllis subsystem.
 //
 //******************************************************************************
-#if 0 /* Unused */
 static void
 iiEllisCleanup(void)
 {
@@ -110,7 +109,6 @@
 		kfree ( pDelayTimer );
 	}
 }
-#endif
 
 //******************************************************************************
 // Function:   iiSetAddress(pB, address, delay)
