Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbWIAHyZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWIAHyZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 03:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750859AbWIAHyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 03:54:25 -0400
Received: from server6.greatnet.de ([83.133.96.26]:56034 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP
	id S1750712AbWIAHyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 03:54:25 -0400
Message-ID: <44F7E74E.2060705@nachtwindheim.de>
Date: Fri, 01 Sep 2006 09:54:54 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: mingo@redhead.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [KERNELDOC] documentation for lock_key in struct hrtimer_base
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Henrik Kretzschmar <henne@nachtwindheim.de>

Fixes an errormessage on make xmldocs.
If somebody has a better description for lock_key, then please post it before
2.6.18.
Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>

---

--- linux-2.6.18-rc5/include/linux/hrtimer.h	2006-08-28 10:02:06.000000000 +0200
+++ linux-2.6.18-rc5/include/linux/hrtimer.h_new	2006-09-01 09:22:20.000000000 +0200
@@ -80,6 +80,7 @@
  * @get_softirq_time:	function to retrieve the current time from the softirq
  * @curr_timer:		the timer which is executing a callback right now
  * @softirq_time:	the time when running the hrtimer queue in the softirq
+ * @lock_key:		the lock_class_key for use with lockdep
  */
 struct hrtimer_base {
 	clockid_t		index;


