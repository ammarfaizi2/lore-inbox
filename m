Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261326AbSI0Ior>; Fri, 27 Sep 2002 04:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261380AbSI0Ior>; Fri, 27 Sep 2002 04:44:47 -0400
Received: from CPE-144-132-195-245.nsw.bigpond.net.au ([144.132.195.245]:23426
	"EHLO anakin.wychk.org") by vger.kernel.org with ESMTP
	id <S261326AbSI0Ioq>; Fri, 27 Sep 2002 04:44:46 -0400
Date: Fri, 27 Sep 2002 18:13:59 +1000
From: Geoffrey Lee <glee@gnupilgrims.org>
To: marcelo@conectiva.com.br, torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] MODULE_LICENSE for i82092 pcmcia.
Message-ID: <20020927081359.GA19526@anakin.wychk.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=big5
Content-Disposition: inline

Yo,


It appears that during the MODULE_LICENSE merge for pcmcia i82092 was
missed.

Here is a trivial patch to correct this.


	-- G.

--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=big5
Content-Disposition: attachment; filename="i82092.c.patch"

--- linux-2.4.20/drivers/pcmcia/i82092.c	Wed Sep  4 16:49:36 2002
+++ linux-2.4.20/drivers/pcmcia/i82092.c.new	Fri Sep 27 13:21:45 2002
@@ -25,6 +25,8 @@
 #include "i82092aa.h"
 #include "i82365.h"
 
+MODULE_LICENSE("GPL");
+
 /* PCI core routines */
 static struct pci_device_id i82092aa_pci_ids[] = {
 	{

--M9NhX3UHpAaciwkO--
