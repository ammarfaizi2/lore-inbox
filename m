Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265725AbTCELJD>; Wed, 5 Mar 2003 06:09:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265809AbTCELJD>; Wed, 5 Mar 2003 06:09:03 -0500
Received: from h007.c000.snv.cp.net ([209.228.32.71]:32647 "HELO
	c000.snv.cp.net") by vger.kernel.org with SMTP id <S265725AbTCELJC>;
	Wed, 5 Mar 2003 06:09:02 -0500
X-Sent: 5 Mar 2003 11:19:31 GMT
Subject: [PATCH] hdreg.h documentation fix
From: "Alfred E. Heggestad" <linuxedmund@home.no>
To: linux ide <linux-ide@vger.kernel.org>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1046863170.17509.3.camel@tellus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 05 Mar 2003 12:19:30 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- linux-2.5.63_orig/include/linux/hdreg.h	2003-02-24 20:05:31.000000000 +0100
+++ linux-2.5.63/include/linux/hdreg.h	2003-03-05 00:26:59.000000000 +0100
@@ -466,8 +466,8 @@
 /*
  * Structure returned by HDIO_GET_IDENTITY, as per ANSI NCITS ATA6 rev.1b spec.
  *
- * If you change something here, please remember to update fix_driveid() in
- * ide/probe.c.
+ * If you change something here, please remember to update ide_fix_driveid() in
+ * ide/ide-iops.c.
  */
 struct hd_driveid {
 	unsigned short	config;		/* lots of obsolete bit flags */


