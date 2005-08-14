Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932545AbVHNPL7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932545AbVHNPL7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 11:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932546AbVHNPL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 11:11:59 -0400
Received: from smtp-100-sunday.nerim.net ([62.4.16.100]:21003 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S932545AbVHNPL7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 11:11:59 -0400
Date: Sun, 14 Aug 2005 17:12:30 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4] (3/5) I2C updates for 2.4.32-pre3
Message-Id: <20050814171230.251ff04a.khali@linux-fr.org>
In-Reply-To: <20050814151320.76e906d5.khali@linux-fr.org>
References: <20050814151320.76e906d5.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix documentation to match code in include/linux/i2c-dev.h

Signed-off-by: Jan Veldeman <jan@mind.be>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Jean Delvare <khali@linux-fr.org>

 Documentation/i2c/dev-interface |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.4.31.orig/Documentation/i2c/dev-interface	2004-02-18 14:36:30.000000000 +0100
+++ linux-2.4.31/Documentation/i2c/dev-interface	2005-07-13 23:27:06.000000000 +0200
@@ -92,10 +92,10 @@
 ioctl(file,I2C_FUNCS,unsigned long *funcs)
   Gets the adapter functionality and puts it in *funcs.
 
-ioctl(file,I2C_RDWR,struct i2c_ioctl_rdwr_data *msgset)
+ioctl(file,I2C_RDWR,struct i2c_rdwr_ioctl_data *msgset)
 
   Do combined read/write transaction without stop in between.
-  The argument is a pointer to a struct i2c_ioctl_rdwr_data {
+  The argument is a pointer to a struct i2c_rdwr_ioctl_data {
 
       struct i2c_msg *msgs;  /* ptr to array of simple messages */
       int nmsgs;             /* number of messages to exchange */

-- 
Jean Delvare
