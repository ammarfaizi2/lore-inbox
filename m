Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263270AbVCDXIC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263270AbVCDXIC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 18:08:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263271AbVCDWFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 17:05:37 -0500
Received: from mail.kroah.org ([69.55.234.183]:3490 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263160AbVCDUyb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:54:31 -0500
Cc: akpm@osdl.org
Subject: [PATCH] I2C: saa7146 build fix
In-Reply-To: <11099685973185@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 4 Mar 2005 12:36:37 -0800
Message-Id: <11099685971963@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2112, 2005/03/02 15:03:32-08:00, akpm@osdl.org

[PATCH] I2C: saa7146 build fix

include/media/saa7146.h:160: parse error before `*'
include/media/saa7146.h:160: warning: function declaration isn't a prototype


Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 include/media/saa7146.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/include/media/saa7146.h b/include/media/saa7146.h
--- a/include/media/saa7146.h	2005-03-04 12:23:06 -08:00
+++ b/include/media/saa7146.h	2005-03-04 12:23:06 -08:00
@@ -157,7 +157,7 @@
 
 /* from saa7146_i2c.c */
 int saa7146_i2c_adapter_prepare(struct saa7146_dev *dev, struct i2c_adapter *i2c_adapter, u32 bitrate);
-int saa7146_i2c_transfer(struct saa7146_dev *saa, const struct *i2c_msg msgs, int num,  int retries);
+int saa7146_i2c_transfer(struct saa7146_dev *saa, const struct i2c_msg *msgs, int num,  int retries);
 
 /* from saa7146_core.c */
 extern struct list_head saa7146_devices;

