Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265715AbTFNU2z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 16:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265713AbTFNU2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 16:28:53 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:13034 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S265715AbTFNU2C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 16:28:02 -0400
Date: Sat, 14 Jun 2003 22:41:49 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] input: Add keys for HP HIL [7/13]
Message-ID: <20030614224149.F25997@ucw.cz>
References: <20030614223513.A25948@ucw.cz> <20030614223629.A25997@ucw.cz> <20030614223708.B25997@ucw.cz> <20030614223934.C25997@ucw.cz> <20030614224022.D25997@ucw.cz> <20030614224052.E25997@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030614224052.E25997@ucw.cz>; from vojtech@suse.cz on Sat, Jun 14, 2003 at 10:40:52PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1215.104.24, 2003-06-09 14:09:58+02:00, vojtech@suse.cz
  input: Add key definitions for HP-HIL keyboards.


 input.h |    5 +++++
 1 files changed, 5 insertions(+)

===================================================================

diff -Nru a/include/linux/input.h b/include/linux/input.h
--- a/include/linux/input.h	Sat Jun 14 22:23:15 2003
+++ b/include/linux/input.h	Sat Jun 14 22:23:15 2003
@@ -473,6 +473,11 @@
 #define KEY_TEEN		0x19e
 #define KEY_TWEN		0x19f
 
+#define KEY_DEL_EOL		0x1c0
+#define KEY_DEL_EOS		0x1c1
+#define KEY_INS_LINE		0x1c2
+#define KEY_DEL_LINE		0x1c3
+
 #define KEY_MAX			0x1ff
 
 /*
