Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263181AbSKEFcz>; Tue, 5 Nov 2002 00:32:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264736AbSKEFcy>; Tue, 5 Nov 2002 00:32:54 -0500
Received: from delta.Colorado.EDU ([128.138.139.9]:56297 "EHLO
	ibg.colorado.edu") by vger.kernel.org with ESMTP id <S263181AbSKEFcy>;
	Tue, 5 Nov 2002 00:32:54 -0500
Message-Id: <200211050539.gA55dKOP014814@ibg.colorado.edu>
From: Jeff Lessem <3zsltfx02@sneakemail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.46 (and a few older revisions) typo in qlogicfas.c
Organization: Institute for Behavioral Genetics
              University of Colorado
              Boulder, CO  80309-0447
X-Phone: +1 303 492 2843
X-FAX: +1 303 492 0852
X-URL: http://ibgwww.Colorado.EDU/~lessem/
X-Copyright: All original content is copyright 2002 Jeff Lessem.
X-Copyright: Quoted and non-original content may be copyright the
X-Copyright: original author or others.
Date: Mon, 04 Nov 2002 22:39:20 -0700
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the last few 2.5.4x kernels there has been a typo in qlogicfas.c
preventing it from building as a pcmcia driver.  The fix is trivial,
but I haven't seen it mentioned yet, so I suspect nobody has noticed.

diff -Nru linux-2.5.46/drivers/scsi/qlogicfas.c linux/drivers/scsi/qlogicfas.c
--- linux-2.5.46/drivers/scsi/qlogicfas.c	2002-11-04 22:22:39.000000000 -0700
+++ linux/drivers/scsi/qlogicfas.c	2002-11-04 22:25:47.000000000 -0700
@@ -613,7 +613,7 @@
 #ifdef PCMCIA
 
 /*
- *	Allow PCMCIA code to preset the port */
+ *	Allow PCMCIA code to preset the port
  *	port should be 0 and irq to -1 respectively for autoprobing 
  */
 
