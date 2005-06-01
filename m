Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261185AbVFAUVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbVFAUVs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 16:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbVFAUVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 16:21:33 -0400
Received: from smtp110.mail.sc5.yahoo.com ([66.163.170.8]:64908 "HELO
	smtp110.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261185AbVFAUJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 16:09:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:Content-Type:Content-Transfer-Encoding;
  b=06eCc475YDtojdHLIgp0V9SRZAjcndczdaup/khtZ9bxwxZfwaXTDBnIzTbYR6uU+S4hOQQIWwc+UnBBuxwwN6rm/FylvLBSQyUF+CZfVGm3rmuLVfoIUwnbxxR4zrG+UgoRj3IKgYSZoPZf/Y1codVvGdIXR1O2xu1rRHG8UjY=  ;
Message-ID: <429E1610.302@yahoo.com>
Date: Wed, 01 Jun 2005 13:09:52 -0700
From: Alex Aizman <itn780@yahoo.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-scsi@vger.kernel.org
CC: linux-kernel@vger.kernel.org,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Christoph Hellwig <hch@lst.de>
Subject: [ANNOUNCE 4/7] Open-iSCSI/Linux-iSCSI-5 High-Performance Initiator:
 iscsi-netlink.patch
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	iscsi-netlink.patch - include/linux/netlink.h changes (added NETLINK_ISCSI).

	Signed-off-by: Alex Aizman <itn780@yahoo.com>
	Signed-off-by: Dmitry Yusupov <dmitry_yus@yahoo.com>
	Signed-off-by: Mike Christie <michaelc@cs.wisc.edu>

Index: include/linux/netlink.h
===================================================================
--- 7570fde464d579ce455c865f07a613e967e9396c/include/linux/netlink.h  (mode:100644 sha1:f731abdc1a29a9cd1d5290d6a8121414377e88df)
+++ uncommitted/include/linux/netlink.h  (mode:100644)
@@ -14,6 +14,7 @@
 #define NETLINK_SELINUX		7	/* SELinux event notifications */
 #define NETLINK_ARPD		8
 #define NETLINK_AUDIT		9	/* auditing */
+#define NETLINK_ISCSI		10	/* iSCSI Open Interface */
 #define NETLINK_ROUTE6		11	/* af_inet6 route comm channel */
 #define NETLINK_IP6_FW		13
 #define NETLINK_DNRTMSG		14	/* DECnet routing messages */



