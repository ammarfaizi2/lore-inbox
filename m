Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263211AbVCDXVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263211AbVCDXVZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 18:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263372AbVCDXT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 18:19:28 -0500
Received: from mail.kroah.org ([69.55.234.183]:26530 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263175AbVCDUyp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:54:45 -0500
Cc: khali@linux-fr.org
Subject: [PATCH] I2C: Kill unused includes in i2c-sensor-detect.c
In-Reply-To: <1109968594643@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 4 Mar 2005 12:36:35 -0800
Message-Id: <11099685951139@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2093, 2005/03/02 12:09:45-08:00, khali@linux-fr.org

[PATCH] I2C: Kill unused includes in i2c-sensor-detect.c

Looks to me like i2c-sensor-detect.c includes a handful of headers it
doesn't need at all. This patch removes them.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/i2c-sensor-detect.c |    7 -------
 1 files changed, 7 deletions(-)


diff -Nru a/drivers/i2c/i2c-sensor-detect.c b/drivers/i2c/i2c-sensor-detect.c
--- a/drivers/i2c/i2c-sensor-detect.c	2005-03-04 12:25:17 -08:00
+++ b/drivers/i2c/i2c-sensor-detect.c	2005-03-04 12:25:17 -08:00
@@ -19,17 +19,10 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/ctype.h>
-#include <linux/sysctl.h>
-#include <linux/init.h>
-#include <linux/ioport.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
-#include <asm/uaccess.h>
 
 static unsigned short empty[] = {I2C_CLIENT_END};
 static unsigned int empty_isa[] = {I2C_CLIENT_ISA_END};

