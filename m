Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965069AbVINW1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965069AbVINW1h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 18:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965064AbVINW1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 18:27:14 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:60677 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S965069AbVINW1H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 18:27:07 -0400
Message-Id: <200509142155.j8ELtugo012137@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 3/10] UML - Remove a useless include
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 14 Sep 2005 17:55:56 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux/inet.h isn't needed, and on my system, is empty.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.13-mm1/arch/um/drivers/mcast_user.c
===================================================================
--- linux-2.6.13-mm1.orig/arch/um/drivers/mcast_user.c	2005-06-17 15:48:29.000000000 -0400
+++ linux-2.6.13-mm1/arch/um/drivers/mcast_user.c	2005-09-02 19:41:45.000000000 -0400
@@ -13,7 +13,6 @@
 
 #include <errno.h>
 #include <unistd.h>
-#include <linux/inet.h>
 #include <sys/socket.h>
 #include <sys/un.h>
 #include <sys/time.h>

