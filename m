Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751396AbVIUXig@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbVIUXig (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 19:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbVIUXig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 19:38:36 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:65267 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S1751396AbVIUXif
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 19:38:35 -0400
Subject: [PATCH] RT: Add headers to timeofday.c
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: MontaVista
Date: Wed, 21 Sep 2005 16:38:29 -0700
Message-Id: <1127345909.19506.49.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add cache.h for smp alignment, and seqlock.h for ntp_lock seqlock
define.

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.13/kernel/ntp.c
===================================================================
--- linux-2.6.13.orig/kernel/ntp.c
+++ linux-2.6.13/kernel/ntp.c
@@ -47,6 +47,8 @@
 #include <linux/ntp.h>
 #include <linux/jiffies.h>
 #include <linux/errno.h>
+#include <linux/cache.h>
+#include <linux/seqlock.h>
 
 #define NTP_DEBUG 0
 


