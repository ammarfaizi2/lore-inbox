Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964893AbWDML6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964893AbWDML6E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 07:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964894AbWDML6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 07:58:04 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:29198 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964893AbWDML6D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 07:58:03 -0400
Date: Thu, 13 Apr 2006 13:58:02 +0200
From: Adrian Bunk <bunk@stusta.de>
To: davej@codemonkey.org.uk
Cc: cpufreq@lists.linux.org.uk, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/cpufreq/cpufreq.c: static functions mustn't be exported
Message-ID: <20060413115802.GC8171@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the EXPORT_SYMBOL_GPL of the static function 
cpufreq_parse_governor().

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.17-rc1-mm2-full/drivers/cpufreq/cpufreq.c.old	2006-04-13 10:48:13.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/drivers/cpufreq/cpufreq.c	2006-04-13 10:48:19.000000000 +0200
@@ -319,7 +319,6 @@
 	}
 	return -EINVAL;
 }
-EXPORT_SYMBOL_GPL(cpufreq_parse_governor);
 
 
 /* drivers/base/cpu.c */

