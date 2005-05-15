Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261210AbVEOTaN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbVEOTaN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 15:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbVEOTaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 15:30:12 -0400
Received: from sabe.cs.wisc.edu ([128.105.6.20]:48844 "EHLO sabe.cs.wisc.edu")
	by vger.kernel.org with ESMTP id S261210AbVEOTaG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 15:30:06 -0400
Subject: [PATCH 1/3] add open iscsi netlink interface to iscsi transport
	class
From: Mike Christie <michaelc@cs.wisc.edu>
To: open-iscsi@googlegroups.com, netdev@oss.sgi.com,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       inux-iscsi-devel@lists.sourceforge.netl
Content-Type: text/plain
Message-Id: <1116185397.17312.10.camel@mina>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 15 May 2005 12:29:57 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

include/linux/netlink.h changes (added new protocol NETLINK_ISCSI)

Thanks,

Linux-iscsi Team

Signed-off-by: Alex Aizman <itn780@yahoo.com>
Signed-off-by: Dmitry Yusupov <dmitry_yus@yahoo.com>
Signed-off-by: Mike Christie <michaelc@cs.wisc.edu>


--- linux-2.6.12-rc3.orig/include/linux/netlink.h	2005-04-20 17:03:16.000000000 -0700
+++ linux-2.6.12-rc3/include/linux/netlink.h	2005-05-04 18:06:44.000000000 -0700
@@ -14,6 +14,7 @@
 #define NETLINK_SELINUX		7	/* SELinux event notifications */
 #define NETLINK_ARPD		8
 #define NETLINK_AUDIT		9	/* auditing */
+#define NETLINK_ISCSI		10	/* iSCSI Open Interface */
 #define NETLINK_ROUTE6		11	/* af_inet6 route comm channel */
 #define NETLINK_IP6_FW		13
 #define NETLINK_DNRTMSG		14	/* DECnet routing messages */


