Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760201AbWLDBgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760201AbWLDBgJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 20:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760202AbWLDBgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 20:36:09 -0500
Received: from havoc.gtf.org ([69.61.125.42]:43394 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1760201AbWLDBgI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 20:36:08 -0500
Date: Sun, 3 Dec 2006 20:36:06 -0500
From: Jeff Garzik <jeff@garzik.org>
To: len.brown@intel.com, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] ACPI: kill unused variable
Message-ID: <20061204013606.GA6655@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Jeff Garzik <jeff@garzik.org>

diff --git a/drivers/acpi/events/evmisc.c b/drivers/acpi/events/evmisc.c
index ee2a10b..bf63edc 100644
--- a/drivers/acpi/events/evmisc.c
+++ b/drivers/acpi/events/evmisc.c
@@ -331,7 +331,6 @@ static void ACPI_SYSTEM_XFACE acpi_ev_gl
 static u32 acpi_ev_global_lock_handler(void *context)
 {
 	u8 acquired = FALSE;
-	acpi_status status;
 
 	/*
 	 * Attempt to get the lock

