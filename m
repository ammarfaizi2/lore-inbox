Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422868AbWAMTu2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422868AbWAMTu2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 14:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422871AbWAMTu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 14:50:28 -0500
Received: from mail.kroah.org ([69.55.234.183]:36756 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422868AbWAMTu1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 14:50:27 -0500
Cc: khali@linux-fr.org
Subject: [PATCH] platform-device-del typo fix
In-Reply-To: <1137181812140@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 13 Jan 2006 11:50:12 -0800
Message-Id: <11371818121359@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] platform-device-del typo fix

Please fold this typo fix into platform-device-del.patch, as was
discussed earlier on LKML:
  http://lkml.org/lkml/2005/12/10/76

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 2d7b5a70e01ff8b1b054d8313362e454e3057c5a
tree db0c60aac7ed0d07de1c1b53957bf11fac4ffc17
parent 8bbace7e686f1536905c703038a7eddfb1520264
author Jean Delvare <khali@linux-fr.org> Tue, 27 Dec 2005 19:45:58 +0100
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 13 Jan 2006 11:26:11 -0800

 drivers/base/platform.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 0f81731..461554a 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -327,7 +327,7 @@ EXPORT_SYMBOL_GPL(platform_device_regist
  *	@pdev:	platform device we're unregistering
  *
  *	Unregistration is done in 2 steps. Fisrt we release all resources
- *	and remove it from the sybsystem, then we drop reference count by
+ *	and remove it from the subsystem, then we drop reference count by
  *	calling platform_device_put().
  */
 void platform_device_unregister(struct platform_device * pdev)

