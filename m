Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262871AbUCPBV4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 20:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262894AbUCPBTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 20:19:50 -0500
Received: from mail.kroah.org ([65.200.24.183]:53679 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262938AbUCPADN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:03:13 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.4
In-Reply-To: <1079391390517@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 15 Mar 2004 14:56:30 -0800
Message-Id: <10793913902818@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1557.61.3, 2004/02/17 14:41:14-08:00, khali@linux-fr.org

[PATCH] I2C: Credit James Bolt in w83l785ts

I forgot to give the credit he deserves to James Bolt for testing the
latest w83l785ts driver changes. Here is a patch that fixes that.


 drivers/i2c/chips/w83l785ts.c |    3 +++
 1 files changed, 3 insertions(+)


diff -Nru a/drivers/i2c/chips/w83l785ts.c b/drivers/i2c/chips/w83l785ts.c
--- a/drivers/i2c/chips/w83l785ts.c	Mon Mar 15 14:37:45 2004
+++ b/drivers/i2c/chips/w83l785ts.c	Mon Mar 15 14:37:46 2004
@@ -12,6 +12,9 @@
  * Ported to Linux 2.6 by Wolfgang Ziegler <nuppla@gmx.at> and Jean Delvare
  * <khali@linux-fr.org>.
  *
+ * Thanks to James Bolt <james@evilpenguin.com> for benchmarking the read
+ * error handling mechanism.
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or

