Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270740AbTGVNqq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 09:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270832AbTGVNqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 09:46:45 -0400
Received: from web20704.mail.yahoo.com ([216.136.226.177]:53276 "HELO
	web20704.mail.yahoo.com") by vger.kernel.org with SMTP
	id S270740AbTGVNoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 09:44:09 -0400
Message-ID: <20030722135912.72029.qmail@web20704.mail.yahoo.com>
Date: Tue, 22 Jul 2003 15:59:12 +0200 (CEST)
From: =?iso-8859-1?q?Tode=20Dim?= <tode_dim@yahoo.dk>
Subject: [PATCH] trivial 2.6-test1 - removes unused function.
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-79142091-1058882352=:71315"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-79142091-1058882352=:71315
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

 hi,

 The function reset_vivideobiosfter_s3() seems
to be not used in arch/i386/kernel/dmdmican.c.

 This patch removes it.

Yahoo! Mail (http://dk.mail.yahoo.com) - Gratis: 6 MB lagerplads, spamfilter og virusscan
--0-79142091-1058882352=:71315
Content-Type: text/plain; name="2.6-test1_dmi_scan.diff"
Content-Description: 2.6-test1_dmi_scan.diff
Content-Disposition: inline; filename="2.6-test1_dmi_scan.diff"

diff -Nru linux-2.6.0-test1/arch/i386/kernel/dmi_scan.c linux-2.6.0-test1~/arch/i386/kernel/dmi_scan.c
--- linux-2.6.0-test1/arch/i386/kernel/dmi_scan.c	2003-06-17 10:04:30.000000000 -0300
+++ linux-2.6.0-test1~/arch/i386/kernel/dmi_scan.c	2003-07-22 09:24:38.000000000 -0300
@@ -444,13 +444,6 @@
 	acpi_video_flags |= 2;
 	return 0;
 }
-
-static __init int reset_videobios_after_s3(struct dmi_blacklist *d)
-{
-	extern long acpi_video_flags;
-	acpi_video_flags |= 1;
-	return 0;
-}
 #endif
 
 /*

--0-79142091-1058882352=:71315--
