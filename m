Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262313AbSJDQOw>; Fri, 4 Oct 2002 12:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262314AbSJDQOv>; Fri, 4 Oct 2002 12:14:51 -0400
Received: from CPE-144-132-195-245.nsw.bigpond.net.au ([144.132.195.245]:53380
	"EHLO anakin.wychk.org") by vger.kernel.org with ESMTP
	id <S262313AbSJDQOt>; Fri, 4 Oct 2002 12:14:49 -0400
Date: Sat, 5 Oct 2002 00:15:06 +0800
From: Geoffrey Lee <glee@gnupilgrims.org>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] MODULE_LICENSE fix for i82092.
Message-ID: <20021004161506.GA17084@anakin.wychk.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=big5
Content-Disposition: inline

Hi Marcelo,


This is a trivial patch to put MODULE_LICENSE("GPL") in one of the 
PCMCIA drivers which was apparently missed during the MODULE_LICENSE
merge.


	-- G.

--mP3DRpeJDSE+ciuQ
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

--mP3DRpeJDSE+ciuQ--
