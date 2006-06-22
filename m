Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030357AbWFVSep@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030357AbWFVSep (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 14:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030355AbWFVSeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 14:34:37 -0400
Received: from cantor2.suse.de ([195.135.220.15]:53182 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030343AbWFVSak (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 14:30:40 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 5/14] [PATCH] w1: netlink: Mark netlink group 1 as unused.
Reply-To: Greg KH <greg@kroah.com>
Date: Thu, 22 Jun 2006 11:27:09 -0700
Message-Id: <11510008553417-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11510008522327-git-send-email-greg@kroah.com>
References: <20060622182645.GB5668@kroah.com> <11510008381000-git-send-email-greg@kroah.com> <11510008413045-git-send-email-greg@kroah.com> <11510008461301-git-send-email-greg@kroah.com> <11510008522327-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>

netlink_w1 was moved to connector.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 include/linux/netlink.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/netlink.h b/include/linux/netlink.h
index 87b8a57..855b446 100644
--- a/include/linux/netlink.h
+++ b/include/linux/netlink.h
@@ -5,7 +5,7 @@ #include <linux/socket.h> /* for sa_fami
 #include <linux/types.h>
 
 #define NETLINK_ROUTE		0	/* Routing/device hook				*/
-#define NETLINK_W1		1	/* 1-wire subsystem				*/
+#define NETLINK_UNUSED		1	/* Unused number				*/
 #define NETLINK_USERSOCK	2	/* Reserved for user mode socket protocols 	*/
 #define NETLINK_FIREWALL	3	/* Firewalling hook				*/
 #define NETLINK_INET_DIAG	4	/* INET socket monitoring			*/
-- 
1.4.0

