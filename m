Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945992AbWGOEb6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945992AbWGOEb6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 00:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945996AbWGOEb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 00:31:58 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:29567 "EHLO
	asav06.manage.insightbb.com") by vger.kernel.org with ESMTP
	id S1945992AbWGOEb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 00:31:57 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AT0KALkKuESBUA
From: Dmitry Torokhov <dtor@insightbb.com>
To: Greg KH <gregkh@suse.de>
Subject: [PATCH] fix comments in drivers/base/power/resume.c
Date: Sat, 15 Jul 2006 00:31:54 -0400
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, pavel@suse.cz
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607150031.54724.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Driver core: fix comments in drivers/base/power/resume.c

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/base/power/resume.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

Index: work/drivers/base/power/resume.c
===================================================================
--- work.orig/drivers/base/power/resume.c
+++ work/drivers/base/power/resume.c
@@ -83,12 +83,12 @@ EXPORT_SYMBOL_GPL(device_resume);
 
 
 /**
- *	device_power_up_irq - Power on some devices.
+ *	dpm_power_up - Power on some devices.
  *
  *	Walk the dpm_off_irq list and power each device up. This
  *	is used for devices that required they be powered down with
- *	interrupts disabled. As devices are powered on, they are moved to
- *	the dpm_suspended list.
+ *	interrupts disabled. As devices are powered on, they are moved
+ *	to the dpm_active list.
  *
  *	Interrupts must be disabled when calling this.
  */
@@ -108,7 +108,7 @@ void dpm_power_up(void)
 
 
 /**
- *	device_pm_power_up - Turn on all devices that need special attention.
+ *	device_power_up - Turn on all devices that need special attention.
  *
  *	Power on system devices then devices that required we shut them down
  *	with interrupts disabled.
