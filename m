Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293680AbSEIMt0>; Thu, 9 May 2002 08:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293632AbSEIMtZ>; Thu, 9 May 2002 08:49:25 -0400
Received: from www.nfas.org.sz ([196.28.7.66]:7866 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S293680AbSEIMtZ>; Thu, 9 May 2002 08:49:25 -0400
Date: Thu, 9 May 2002 14:25:15 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: trivial@rustcorp.com.au
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] serial unload message
Message-ID: <Pine.LNX.4.44.0205091424450.6271-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- linux-2.4.19-pre7-ac3/drivers/char/serial.c.orig	Thu May  9 10:47:13 2002
+++ linux-2.4.19-pre7-ac3/drivers/char/serial.c	Thu May  9 10:47:19 2002
@@ -5699,7 +5699,7 @@
 	if (state->info && state->info->tty)
 		tty_hangup(state->info->tty);
 	state->type = PORT_UNKNOWN;
-	printk(KERN_INFO "tty%02d unloaded\n", state->line);
+	printk(KERN_INFO "ttyS%02d unloaded\n", state->line);
 	/* These will be hidden, because they are devices that will no longer
 	 * be available to the system. (ie, PCMCIA modems, once ejected)
 	 */

-- 
http://function.linuxpower.ca
		

