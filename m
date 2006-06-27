Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933441AbWF0Emo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933441AbWF0Emo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933427AbWF0Emn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:42:43 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:54747 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1030702AbWF0Emh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:42:37 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 03/13] [Suspend2] Add netlink socket numbers.
Date: Tue, 27 Jun 2006 14:42:36 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627044234.15066.63603.stgit@nigel.suspend2.net>
In-Reply-To: <20060627044226.15066.7403.stgit@nigel.suspend2.net>
References: <20060627044226.15066.7403.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reserve netlink socket numbers for use by Suspend2 userspace helpers.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 include/linux/netlink.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/linux/netlink.h b/include/linux/netlink.h
index 87b8a57..50f282a 100644
--- a/include/linux/netlink.h
+++ b/include/linux/netlink.h
@@ -21,6 +21,8 @@
 #define NETLINK_DNRTMSG		14	/* DECnet routing messages */
 #define NETLINK_KOBJECT_UEVENT	15	/* Kernel messages to userspace */
 #define NETLINK_GENERIC		16
+#define NETLINK_SUSPEND2_USERUI	17	/* For suspend2's userui */
+#define NETLINK_SUSPEND2_USM	18	/* For suspend2's userui */
 
 #define MAX_LINKS 32		
 

--
Nigel Cunningham		nigel at suspend2 dot net
