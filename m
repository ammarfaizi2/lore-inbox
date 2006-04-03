Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964778AbWDCERz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbWDCERz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 00:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964783AbWDCERz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 00:17:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:3220 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964778AbWDCERz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 00:17:55 -0400
Date: Sun, 2 Apr 2006 23:17:54 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Remove extraneous \n in doubletalk init printk.
Message-ID: <20060403041754.GA9115@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doubletalk printk's an extraneous \n

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.15.noarch/drivers/char/dtlk.c~	2006-02-01 22:17:38.000000000 -0500
+++ linux-2.6.15.noarch/drivers/char/dtlk.c	2006-02-01 22:19:16.000000000 -0500
@@ -490,7 +490,7 @@ for (i = 0; i < 10; i++)			\
 		release_region(dtlk_portlist[i], DTLK_IO_EXTENT);
 	}
 
-	printk(KERN_INFO "\nDoubleTalk PC - not found\n");
+	printk(KERN_INFO "DoubleTalk PC - not found\n");
 	return -ENODEV;
 }
 


