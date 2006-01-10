Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932489AbWAJSXx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932489AbWAJSXx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 13:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932524AbWAJSXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 13:23:53 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:45039 "EHLO
	dhcp153.mvista.com") by vger.kernel.org with ESMTP id S932489AbWAJSXx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 13:23:53 -0500
Date: Tue, 10 Jan 2006 10:23:49 -0800
Message-Id: <200601101823.k0AINn2u032208@dhcp153.mvista.com>
From: Daniel Walker <dwalker@mvista.com>
To: mingo@elte.hu
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] Add kernel.h to plist.h
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	On ARM plist compilation fails due to missing container_of()
So I resolved it by adding kernel.h to plist.h .

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.15/include/linux/plist.h
===================================================================
--- linux-2.6.15.orig/include/linux/plist.h
+++ linux-2.6.15/include/linux/plist.h
@@ -75,6 +75,7 @@
 #ifndef _LINUX_PLIST_H_
 #define _LINUX_PLIST_H_
 
+#include <linux/kernel.h>
 #include <linux/list.h>
 
 struct plist_head {
