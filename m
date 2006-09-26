Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751507AbWIZFkq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751507AbWIZFkq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 01:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbWIZFkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 01:40:18 -0400
Received: from ns2.suse.de ([195.135.220.15]:52181 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751412AbWIZFjz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 01:39:55 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Dmitry Torokhov <dtor@insightbb.com>, Dmitry Torokhov <dtor@mail.ru>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 35/47] Driver core: fix comments in drivers/base/power/resume.c
Date: Mon, 25 Sep 2006 22:37:55 -0700
Message-Id: <1159249196427-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.1
In-Reply-To: <11592491924093-git-send-email-greg@kroah.com>
References: <20060926053728.GA8970@kroah.com> <1159249087369-git-send-email-greg@kroah.com> <11592490903867-git-send-email-greg@kroah.com> <11592490933346-git-send-email-greg@kroah.com> <1159249096460-git-send-email-greg@kroah.com> <11592490993970-git-send-email-greg@kroah.com> <11592491023995-git-send-email-greg@kroah.com> <1159249104512-git-send-email-greg@kroah.com> <11592491082990-git-send-email-greg@kroah.com> <1159249111668-git-send-email-greg@kroah.com> <11592491152668-git-send-email-greg@kroah.com> <115924911859-git-send-email-greg@kroah.com> <11592491211162-git-send-email-greg@kroah.com> <1159249124371-git-send-email-greg@kroah.com> <11592491274168-git-send-email-greg@kroah.com> <11592491303012-git-send-email-greg@kroah.com> <11592491342421-git-send-email-greg@kroah.com> <11592491371254-git-send-email-greg@kroah.com> <1159249140339-git-send-email-greg@kroah.com> <11592491451786-git-send-email-greg@kroah.com> <11592491482560-git-send-email-greg@kroah.com> <11592491512
 235-git-send-email-greg@kroah.com> <11592491551919-git-send-email-greg@kroah.com> <11592491581007-git-send-email-greg@kroah.com> <11592491611339-git-send-email-greg@kroah.com> <11592491643725-git-send-email-greg@kroah.com> <11592491672052-git-send-email-greg@kroah.com> <11592491704137-git-send-email-greg@kroah.com> <11592491744040-git-send-email-greg@kroah.com> <1159249177618-git-send-email-greg@kroah.com> <11592491803904-git-send-email-greg@kroah.com> <11592491833450-git-send-email-greg@kroah.com> <11592491862904-git-send-email-greg@kroah.com> <11592491901464-git-send-email-greg@kroah.com> <11592491924093-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Torokhov <dtor@insightbb.com>

Driver core: fix comments in drivers/base/power/resume.c

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/power/resume.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/base/power/resume.c b/drivers/base/power/resume.c
index 7cb62d6..020be36 100644
--- a/drivers/base/power/resume.c
+++ b/drivers/base/power/resume.c
@@ -106,12 +106,12 @@ EXPORT_SYMBOL_GPL(device_resume);
 
 
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
@@ -129,7 +129,7 @@ void dpm_power_up(void)
 
 
 /**
- *	device_pm_power_up - Turn on all devices that need special attention.
+ *	device_power_up - Turn on all devices that need special attention.
  *
  *	Power on system devices then devices that required we shut them down
  *	with interrupts disabled.
-- 
1.4.2.1

