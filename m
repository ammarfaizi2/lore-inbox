Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262828AbVGKWM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262828AbVGKWM5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 18:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262756AbVGKWMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 18:12:55 -0400
Received: from mail.kroah.org ([69.55.234.183]:58076 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262828AbVGKWDt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 18:03:49 -0400
Cc: jan@mind.be
Subject: [PATCH] I2C: Documentation fix
In-Reply-To: <11211193781619@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 11 Jul 2005 15:02:58 -0700
Message-Id: <11211193783332@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] I2C: Documentation fix

Fix documentation to match code in include/linux/i2c-dev.h

Signed-off-by: Jan Veldeman <jan@mind.be>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit a68e2f4895070f3a449bfe5ae1174b73cc900642
tree 76f3e9e4da1f261687b51aad6c8be3534788e63f
parent 61f5809d3ebce9d5433b8696048e91405b681023
author Jan Veldeman <jan@mind.be> Fri, 01 Jul 2005 16:20:24 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 11 Jul 2005 14:10:37 -0700

 Documentation/i2c/dev-interface |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/i2c/dev-interface b/Documentation/i2c/dev-interface
--- a/Documentation/i2c/dev-interface
+++ b/Documentation/i2c/dev-interface
@@ -97,10 +97,10 @@ ioctl(file,I2C_PEC,long select)
 ioctl(file,I2C_FUNCS,unsigned long *funcs)
   Gets the adapter functionality and puts it in *funcs.
 
-ioctl(file,I2C_RDWR,struct i2c_ioctl_rdwr_data *msgset)
+ioctl(file,I2C_RDWR,struct i2c_rdwr_ioctl_data *msgset)
 
   Do combined read/write transaction without stop in between.
-  The argument is a pointer to a struct i2c_ioctl_rdwr_data {
+  The argument is a pointer to a struct i2c_rdwr_ioctl_data {
 
       struct i2c_msg *msgs;  /* ptr to array of simple messages */
       int nmsgs;             /* number of messages to exchange */

