Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932541AbVHNPEZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932541AbVHNPEZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 11:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932543AbVHNPEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 11:04:25 -0400
Received: from smtp-100-sunday.noc.nerim.net ([62.4.17.100]:38663 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S932541AbVHNPEY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 11:04:24 -0400
Date: Sun, 14 Aug 2005 17:04:59 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4] (1/5) I2C updates for 2.4.32-pre3
Message-Id: <20050814170459.7758d061.khali@linux-fr.org>
In-Reply-To: <20050814151320.76e906d5.khali@linux-fr.org>
References: <20050814151320.76e906d5.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Backport of a spelling fix Tobias Klauser sent to me for Linux
2.6.12-rc4. Already fixed in i2c CVS.

Signed-off-by: Tobias Klauser <tklauser@nuerscht.ch>
Signed-off-by: Jean Delvare <khali@linux-fr.org>

 drivers/i2c/i2c-dev.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2.4.30.orig/drivers/i2c/i2c-dev.c	2005-06-03 19:21:12.000000000 +0200
+++ linux-2.4.30/drivers/i2c/i2c-dev.c	2005-06-03 19:22:52.000000000 +0200
@@ -229,7 +229,7 @@
 				   sizeof(rdwr_arg)))
 			return -EFAULT;
 
-		/* Put an arbritrary limit on the number of messages that can
+		/* Put an arbitrary limit on the number of messages that can
 		 * be sent at once */
 		if (rdwr_arg.nmsgs > 42)
 			return -EINVAL;

-- 
Jean Delvare
