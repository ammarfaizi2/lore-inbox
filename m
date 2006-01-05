Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751086AbWAEA5l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbWAEA5l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 19:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750980AbWAEAu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 19:50:27 -0500
Received: from mail.kroah.org ([69.55.234.183]:64697 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750972AbWAEAty convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 19:49:54 -0500
Cc: bunk@stusta.de
Subject: [PATCH] drivers/base/power/runtime.c: #if 0 dpm_set_power_state()
In-Reply-To: <11364221712096@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 4 Jan 2006 16:49:31 -0800
Message-Id: <1136422171740@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] drivers/base/power/runtime.c: #if 0 dpm_set_power_state()

This patch #if 0's an unused global function.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 1f1bf132d81ed723bc5fefbcec7d0779ce683a4f
tree 59cfbf241906753770c6150ef76efd1816210b74
parent e80a5dea8e056d8f398be1900d61c581d379f02f
author Adrian Bunk <bunk@stusta.de> Mon, 12 Dec 2005 01:31:03 -0800
committer Greg Kroah-Hartman <gregkh@suse.de> Wed, 04 Jan 2006 16:18:10 -0800

 drivers/base/power/runtime.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index adbc314..4bafef8 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -64,6 +64,7 @@ int dpm_runtime_suspend(struct device * 
 }
 
 
+#if 0
 /**
  *	dpm_set_power_state - Update power_state field.
  *	@dev:	Device.
@@ -80,3 +81,4 @@ void dpm_set_power_state(struct device *
 	dev->power.power_state = state;
 	up(&dpm_sem);
 }
+#endif  /*  0  */

