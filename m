Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262773AbVFVKmB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262773AbVFVKmB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 06:42:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262853AbVFVG4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 02:56:20 -0400
Received: from mail.kroah.org ([69.55.234.183]:9116 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262784AbVFVFV5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:21:57 -0400
Cc: tklauser@nuerscht.ch
Subject: [PATCH] I2C: Spelling fixes for drivers/i2c/i2c-dev.c
In-Reply-To: <11194174661220@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 21 Jun 2005 22:17:46 -0700
Message-Id: <1119417466126@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] I2C: Spelling fixes for drivers/i2c/i2c-dev.c

This patch fixes a misspelling in a comment section.

Signed-off-by: Tobias Klauser <tklauser@nuerscht.ch>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit d68a861d857c11a017a8f755fa250afaf8b1bcdb
tree 85975dd625d7a58da2a4e90c01729332a533c8a2
parent a551acc2cb1f13a9bd728b8cf86f9adafefdcfb2
author Tobias Klauser <tklauser@nuerscht.ch> Thu, 19 May 2005 21:41:47 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 21 Jun 2005 21:52:00 -0700

 drivers/i2c/i2c-dev.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -213,7 +213,7 @@ static int i2cdev_ioctl(struct inode *in
 				   sizeof(rdwr_arg)))
 			return -EFAULT;
 
-		/* Put an arbritrary limit on the number of messages that can
+		/* Put an arbitrary limit on the number of messages that can
 		 * be sent at once */
 		if (rdwr_arg.nmsgs > I2C_RDRW_IOCTL_MAX_MSGS)
 			return -EINVAL;

