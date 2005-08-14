Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932546AbVHNPOS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932546AbVHNPOS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 11:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932547AbVHNPOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 11:14:18 -0400
Received: from smtp-100-sunday.nerim.net ([62.4.16.100]:53003 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S932546AbVHNPOR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 11:14:17 -0400
Date: Sun, 14 Aug 2005 17:14:58 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4] (4/5) I2C updates for 2.4.32-pre3
Message-Id: <20050814171458.31e104dc.khali@linux-fr.org>
In-Reply-To: <20050814151320.76e906d5.khali@linux-fr.org>
References: <20050814151320.76e906d5.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix two typos in the i2c documentation.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 Documentation/i2c/functionality   |    2 +-
 Documentation/i2c/writing-clients |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.4.31.orig/Documentation/i2c/functionality	2000-12-29 23:35:47.000000000 +0100
+++ linux-2.4.31/Documentation/i2c/functionality	2005-07-28 19:06:36.000000000 +0200
@@ -115,7 +115,7 @@
 If you try to access an adapter from a userspace program, you will have
 to use the /dev interface. You will still have to check whether the
 functionality you need is supported, of course. This is done using
-the I2C_FUNCS ioctl. An example, adapted from the lm_sensors i2c_detect
+the I2C_FUNCS ioctl. An example, adapted from the lm_sensors i2cdetect
 program, is below:
 
   int file;
--- linux-2.4.31.orig/Documentation/i2c/writing-clients	2005-04-09 12:14:20.000000000 +0200
+++ linux-2.4.31/Documentation/i2c/writing-clients	2005-07-29 19:32:57.000000000 +0200
@@ -302,7 +302,7 @@
      These are automatically translated to insmod variables of the form
      force_foo.
 
-So we have a generic insmod variabled `force', and chip-specific variables
+So we have a generic insmod variable `force', and chip-specific variables
 `force_CHIPNAME'.
 
 Fortunately, as a module writer, you just have to define the `normal' 

-- 
Jean Delvare
