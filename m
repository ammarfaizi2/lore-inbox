Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751588AbWHZPAu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751588AbWHZPAu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 11:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751589AbWHZPAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 11:00:50 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:54241 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751587AbWHZPAu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 11:00:50 -0400
Date: Sat, 26 Aug 2006 17:00:39 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
Subject: Fix typo in rtc kconfig
Message-ID: <20060826150039.GA1888@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix simple typo in RTC_HCTOSYS option.

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 8272feb..d8fa0a9 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -27,7 +27,7 @@ config RTC_HCTOSYS
 	help
 	  If you say yes here, the system time will be set using
 	  the value read from the specified RTC device. This is useful
-	  in order to avoid unnecessary fschk runs.
+	  in order to avoid unnecessary fsck runs.
 
 config RTC_HCTOSYS_DEVICE
 	string "The RTC to read the time from"

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
