Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030542AbWJJVwJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030542AbWJJVwJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 17:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030531AbWJJVt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:49:59 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:42683 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030532AbWJJVti
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:49:38 -0400
To: torvalds@osdl.org
Subject: [PATCH] missed const in prototype
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1GXPTl-0007SP-H9@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 22:49:37 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/um/drivers/pcap_user.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/um/drivers/pcap_user.h b/arch/um/drivers/pcap_user.h
index 58f9f6a..96b80b5 100644
--- a/arch/um/drivers/pcap_user.h
+++ b/arch/um/drivers/pcap_user.h
@@ -15,7 +15,7 @@ struct pcap_data {
 	void *dev;
 };
 
-extern struct net_user_info pcap_user_info;
+extern const struct net_user_info pcap_user_info;
 
 extern int pcap_user_read(int fd, void *buf, int len, struct pcap_data *pri);
 
-- 
1.4.2.GIT


