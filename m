Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932261AbWDRPGz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbWDRPGz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 11:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbWDRPGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 11:06:31 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:50693 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932261AbWDRPGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 11:06:14 -0400
Date: Tue, 18 Apr 2006 17:06:13 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: davej@codemonkey.org.uk, cpufreq@lists.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/cpufreq/cpufreq.c: static functions mustn't be exported
Message-ID: <20060418150613.GG11582@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the EXPORT_SYMBOL_GPL of the static function 
cpufreq_parse_governor().

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 13 Apr 2006

--- linux-2.6.17-rc1-mm2-full/drivers/cpufreq/cpufreq.c.old	2006-04-13 10:48:13.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/drivers/cpufreq/cpufreq.c	2006-04-13 10:48:19.000000000 +0200
@@ -319,7 +319,6 @@
 	}
 	return -EINVAL;
 }
-EXPORT_SYMBOL_GPL(cpufreq_parse_governor);
 
 
 /* drivers/base/cpu.c */

