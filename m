Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262201AbTA2Bs3>; Tue, 28 Jan 2003 20:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262208AbTA2Bs2>; Tue, 28 Jan 2003 20:48:28 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:30461 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S262201AbTA2Bs2>; Tue, 28 Jan 2003 20:48:28 -0500
Date: Tue, 28 Jan 2003 20:57:47 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: linux390@de.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Tyop in hwc_rw.c (2.4.21-pre3)
Message-ID: <20030128205747.A6557@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nobody compiles without CONFIG_SMP anymore?

--- linux-2.4.20-ent.1s390.4/drivers/s390/char/hwc_rw.c	2002-11-28 15:53:14.000000000 -0800
+++ linux-2.4.20-ent.1s390.4a/drivers/s390/char/hwc_rw.c	2003-01-27 19:18:30.000000000 -0800
@@ -1662,7 +1662,7 @@
 	psw_t quiesce_psw;
 
 	quiesce_psw.mask = _DW_PSW_MASK;
-	queisce_psw.addr = 0xfff;
+	quiesce_psw.addr = 0xfff;
 	__load_psw (quiesce_psw);
 }
 
