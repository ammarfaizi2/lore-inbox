Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268843AbRHBHnL>; Thu, 2 Aug 2001 03:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268846AbRHBHnB>; Thu, 2 Aug 2001 03:43:01 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:19215 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S268843AbRHBHmu>; Thu, 2 Aug 2001 03:42:50 -0400
Date: Thu, 2 Aug 2001 09:42:53 +0200
From: Jan Kara <jack@ucw.cz>
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Small fix
Message-ID: <20010802094253.A22656@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hello,

  the small fix which adds FIOQSIZE ioctl number to forgotten architectures
is attached. Please apply.

								Honza


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="quota-ioctls.diff"

--- linux/include/asm-parisc/ioctls.h	Wed Dec 20 19:34:44 2000
+++ linux/include/asm-parisc/ioctls.h	Wed Aug  1 01:15:19 2001
@@ -67,6 +67,7 @@
 #define TIOCGICOUNT	0x545D	/* read serial port inline interrupt counts */
 #define TIOCGHAYESESP   0x545E  /* Get Hayes ESP configuration */
 #define TIOCSHAYESESP   0x545F  /* Set Hayes ESP configuration */
+#define FIOQSIZE	0x5460	/* Get exact space used by quota */
 
 /* Used for packet mode */
 #define TIOCPKT_DATA		 0
--- linux/include/asm-cris/ioctls.h	Wed Mar 21 00:20:52 2001
+++ linux/include/asm-cris/ioctls.h	Wed Aug  1 01:13:17 2001
@@ -69,6 +69,7 @@
 #define TIOCGICOUNT	0x545D	/* read serial port inline interrupt counts */
 #define TIOCGHAYESESP   0x545E  /* Get Hayes ESP configuration */
 #define TIOCSHAYESESP   0x545F  /* Set Hayes ESP configuration */
+#define FIOQSIZE	0x5460
 
 /* Used for packet mode */
 #define TIOCPKT_DATA		 0

--BOKacYhQ+x31HxR3--
