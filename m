Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264614AbUENXcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264614AbUENXcS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 19:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264621AbUENXb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 19:31:59 -0400
Received: from mail.kroah.org ([65.200.24.183]:33765 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264614AbUENXaJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 19:30:09 -0400
Subject: Re: [PATCH] I2C update for 2.6.6
In-Reply-To: <10845773583910@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 14 May 2004 16:29:18 -0700
Message-Id: <10845773584101@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1587.15.18, 2004/05/14 15:00:02-07:00, dsaxena@plexity.net

[PATCH] I2C: Missed ixp42x -> ixp4xx conversion

Forgot to include this with my original patch a few weeks ago...


 include/linux/i2c-id.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/include/linux/i2c-id.h b/include/linux/i2c-id.h
--- a/include/linux/i2c-id.h	Fri May 14 16:18:19 2004
+++ b/include/linux/i2c-id.h	Fri May 14 16:18:19 2004
@@ -222,7 +222,7 @@
 #define I2C_HW_B_OMAHA  0x14    /* Omaha I2C interface (ARM)		*/
 #define I2C_HW_B_GUIDE  0x15    /* Guide bit-basher			*/
 #define I2C_HW_B_IXP2000 0x16	/* GPIO on IXP2000 systems              */
-#define I2C_HW_B_IXP425 0x17	/* GPIO on IXP425 systems		*/
+#define I2C_HW_B_IXP4XX 0x17	/* GPIO on IXP4XX systems		*/
 #define I2C_HW_B_S3VIA	0x18	/* S3Via ProSavage adapter		*/
 #define I2C_HW_B_ZR36067 0x19	/* Zoran-36057/36067 based boards	*/
 

