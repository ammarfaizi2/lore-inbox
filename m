Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751354AbVIUXiw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbVIUXiw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 19:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbVIUXih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 19:38:37 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:65523 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S1751354AbVIUXif
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 19:38:35 -0400
Subject: [PATCH] RT: Add timeofday.h to ktimers.c
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: MontaVista
Date: Wed, 21 Sep 2005 16:38:31 -0700
Message-Id: <1127345911.19506.51.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.13/kernel/ktimers.c
===================================================================
--- linux-2.6.13.orig/kernel/ktimers.c
+++ linux-2.6.13/kernel/ktimers.c
@@ -38,6 +38,7 @@
 #include <linux/module.h>
 #include <linux/notifier.h>
 #include <linux/percpu.h>
+#include <linux/timeofday.h>
 #include <linux/ktimer.h>
 
 #include <asm/uaccess.h>


