Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261968AbTFSX4y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 19:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262013AbTFSX4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 19:56:54 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:64470 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261968AbTFSX4v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 19:56:51 -0400
Date: Fri, 20 Jun 2003 02:10:49 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: dahinds@users.sourceforge.net
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       trivial@rustcorp.com.au
Subject: [2.5 patch] remove an unused variable from xirc2ps_cs.c
Message-ID: <20030620001049.GI29247@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The platch below removes an unused variable from 
drivers/net/pcmcia/xirc2ps_cs.c .

Please apply
Adrian


--- linux-2.5.72-mm2/drivers/net/pcmcia/xirc2ps_cs.c.old	2003-06-20 02:07:40.000000000 +0200
+++ linux-2.5.72-mm2/drivers/net/pcmcia/xirc2ps_cs.c	2003-06-20 02:07:55.000000000 +0200
@@ -225,9 +225,7 @@
 #else
 #define DEBUG(n, args...)
 #endif
-static char *version =
-"xirc2ps_cs.c 1.31 1998/12/09 19:32:55 (dd9jn+kvh)";
-	    /* !--- CVS revision */
+
 #define KDBG_XIRC KERN_DEBUG   "xirc2ps_cs: "
 #define KERR_XIRC KERN_ERR     "xirc2ps_cs: "
 #define KWRN_XIRC KERN_WARNING "xirc2ps_cs: "
