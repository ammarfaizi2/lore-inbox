Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262637AbTIVXtd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 19:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262592AbTIVXr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 19:47:57 -0400
Received: from mail.kroah.org ([65.200.24.183]:12193 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262678AbTIVXa6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 19:30:58 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10642734213872@kroah.com>
Subject: Re: [PATCH] i2c driver fixes for 2.6.0-test5
In-Reply-To: <10642734201540@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 22 Sep 2003 16:30:21 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1315.1.6, 2003/09/15 16:44:07-07:00, greg@kroah.com

[PATCH] I2C: turn off debugging on the new sis i2c bus drivers.

Forgot to do this before...


 drivers/i2c/busses/i2c-sis5595.c |    2 +-
 drivers/i2c/busses/i2c-sis630.c  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-sis5595.c b/drivers/i2c/busses/i2c-sis5595.c
--- a/drivers/i2c/busses/i2c-sis5595.c	Mon Sep 22 16:15:15 2003
+++ b/drivers/i2c/busses/i2c-sis5595.c	Mon Sep 22 16:15:15 2003
@@ -55,7 +55,7 @@
  * Add adapter resets
  */
 
-#define DEBUG
+/* #define DEBUG 1 */
 
 #include <linux/kernel.h>
 #include <linux/module.h>
diff -Nru a/drivers/i2c/busses/i2c-sis630.c b/drivers/i2c/busses/i2c-sis630.c
--- a/drivers/i2c/busses/i2c-sis630.c	Mon Sep 22 16:15:15 2003
+++ b/drivers/i2c/busses/i2c-sis630.c	Mon Sep 22 16:15:15 2003
@@ -48,7 +48,7 @@
    Note: we assume there can only be one device, with one SMBus interface.
 */
 
-#define DEBUG
+/* #define DEBUG 1 */
 
 #include <linux/kernel.h>
 #include <linux/module.h>

