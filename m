Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262549AbVAPRT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262549AbVAPRT2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 12:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262554AbVAPRT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 12:19:27 -0500
Received: from smtpq2.home.nl ([213.51.128.197]:45237 "EHLO smtpq2.home.nl")
	by vger.kernel.org with ESMTP id S262549AbVAPRTM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 12:19:12 -0500
Message-ID: <41EAA1F1.2020305@keyaccess.nl>
Date: Sun, 16 Jan 2005 18:18:41 +0100
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a5) Gecko/20041121
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-15?Q?Kai_M=E4kisara?= <Kai.Makisara@kolumbus.fi>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [TRIVIAL] MODULE_ALIAS_CHARDEV_MAJOR(SCSI_TAPE_MAJOR)
Content-Type: multipart/mixed;
 boundary="------------080905020009080804010001"
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080905020009080804010001
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi Kai.

Attachment allows st to be autoloaded.

Rene.

--------------080905020009080804010001
Content-Type: text/plain;
 name="linux-2.6.11-rc1_scsi_tape_major.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.11-rc1_scsi_tape_major.diff"

--- linux-2.6.11-rc1.orig/drivers/scsi/st.c	2004-12-26 23:33:37.000000000 +0100
+++ linux-2.6.11-rc1/drivers/scsi/st.c	2005-01-16 17:32:45.000000000 +0100
@@ -85,6 +85,7 @@
 MODULE_AUTHOR("Kai Makisara");
 MODULE_DESCRIPTION("SCSI Tape Driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS_CHARDEV_MAJOR(SCSI_TAPE_MAJOR);
 
 /* Set 'perm' (4th argument) to 0 to disable module_param's definition
  * of sysfs parameters (which module_param doesn't yet support).

--------------080905020009080804010001--
