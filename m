Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264967AbUD2U2Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264967AbUD2U2Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 16:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264966AbUD2U2C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 16:28:02 -0400
Received: from [213.133.118.2] ([213.133.118.2]:19857 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S264962AbUD2U1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 16:27:52 -0400
Message-ID: <4091661D.3030500@shadowconnect.com>
Date: Thu, 29 Apr 2004 22:31:25 +0200
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] I2O subsystem fixing and cleanup for 2.6 - i2o-config-clean.patch
Content-Type: multipart/mixed;
 boundary="------------070404040600080603010604"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070404040600080603010604
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------070404040600080603010604
Content-Type: text/plain;
 name="i2o-config-clean.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="i2o-config-clean.patch"

--- a/drivers/message/i2o/i2o_config.c	2004-02-18 04:59:26.000000000 +0100
+++ b/drivers/message/i2o/i2o_config.c	2004-03-03 17:14:38.035056342 +0100
@@ -5,21 +5,22 @@
  *	
  * Written by Alan Cox, Building Number Three Ltd
  *
- * Modified 04/20/1999 by Deepak Saxena
- *   - Added basic ioctl() support
- * Modified 06/07/1999 by Deepak Saxena
- *   - Added software download ioctl (still testing)
- * Modified 09/10/1999 by Auvo Häkkinen
- *   - Changes to i2o_cfg_reply(), ioctl_parms()
- *   - Added ioct_validate()
- * Modified 09/30/1999 by Taneli Vähäkangas
- *   - Fixed ioctl_swdl()
- * Modified 10/04/1999 by Taneli Vähäkangas
- *   - Changed ioctl_swdl(), implemented ioctl_swul() and ioctl_swdel()
- * Modified 11/18/1999 by Deepak Saxena
- *   - Added event managmenet support
- *
- * 2.4 rewrite ported to 2.5 - Alan Cox <alan@redhat.com>
+ * Fixes/additions:
+ *	Deepak Saxena (04/20/1999):
+ *		Added basic ioctl() support
+ *	Deepak Saxena (06/07/1999):
+ *		Added software download ioctl (still testing)
+ *	Auvo Häkkinen (09/10/1999):
+ *		Changes to i2o_cfg_reply(), ioctl_parms()
+ *		Added ioct_validate()
+ *	Taneli Vähäkangas (09/30/1999):
+ *		Fixed ioctl_swdl()
+ *	Taneli Vähäkangas (10/04/1999):
+ *		Changed ioctl_swdl(), implemented ioctl_swul() and ioctl_swdel()
+ *	Deepak Saxena (11/18/1999):
+ *		Added event managmenet support
+ *	Alan Cox <alan@redhat.com>:
+ *		2.4 rewrite ported to 2.5
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License

--------------070404040600080603010604--
