Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263980AbUFFSZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263980AbUFFSZi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 14:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263979AbUFFSZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 14:25:37 -0400
Received: from apate.telenet-ops.be ([195.130.132.57]:36788 "EHLO
	apate.telenet-ops.be") by vger.kernel.org with ESMTP
	id S263963AbUFFSZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 14:25:18 -0400
Date: Sun, 6 Jun 2004 20:24:48 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, hch@lst.de
Subject: [WATCHDOG] v2.6.6 linux/watchdog.h patch
Message-ID: <20040606202448.I30061@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, Andrew,

please do a

	bk pull http://linux-watchdog.bkbits.net/linux-2.6-watchdog

This will update the following files:

 include/linux/watchdog.h |    1 +
 1 files changed, 1 insertion(+)

through these ChangeSets:

<hch@lst.de> (04/06/06 1.1819)
   [WATCHDOG] linux/watchdog.h include types.h patch
   
   watchdog.h is using __u8 and __u32 from linux/types.h, so it needs to
   include it.


The ChangeSets can also be looked at on:
	http://linux-watchdog.bkbits.net:8080/linux-2.6-watchdog

For completeness, I added the patches below.

Greetings,
Wim.

================================================================================
diff -Nru a/include/linux/watchdog.h b/include/linux/watchdog.h
--- a/include/linux/watchdog.h	Sun Jun  6 20:22:55 2004
+++ b/include/linux/watchdog.h	Sun Jun  6 20:22:55 2004
@@ -10,6 +10,7 @@
 #define _LINUX_WATCHDOG_H
 
 #include <linux/ioctl.h>
+#include <linux/types.h>
 
 #define	WATCHDOG_IOCTL_BASE	'W'
 
