Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262003AbUDNWs2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 18:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262046AbUDNWlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 18:41:51 -0400
Received: from mail.kroah.org ([65.200.24.183]:56735 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262003AbUDNWZX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 18:25:23 -0400
Subject: Re: [PATCH] I2C update for 2.6.5
In-Reply-To: <10819814511367@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 14 Apr 2004 15:24:11 -0700
Message-Id: <10819814513813@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1643.36.15, 2004/04/02 11:05:14-08:00, mochel@digitalimplant.org

[PATCH] I2C: Fix check for DEBUG in i2c-ali1563


 drivers/i2c/busses/i2c-ali1563.c |    5 -----
 1 files changed, 5 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-ali1563.c b/drivers/i2c/busses/i2c-ali1563.c
--- a/drivers/i2c/busses/i2c-ali1563.c	Wed Apr 14 15:13:44 2004
+++ b/drivers/i2c/busses/i2c-ali1563.c	Wed Apr 14 15:13:44 2004
@@ -15,11 +15,6 @@
  *	This file is released under the GPLv2
  */
 
-#include <linux/config.h>
-#ifdef CONFIG_I2C_DEBUG_BUS
-#define DEBUG 0
-#endif
-
 #include <linux/module.h>
 #include <linux/i2c.h>
 #include <linux/pci.h>

