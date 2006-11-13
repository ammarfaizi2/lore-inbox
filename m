Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755351AbWKMVEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755351AbWKMVEM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 16:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755352AbWKMVEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 16:04:11 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:33289 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1755351AbWKMVDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 16:03:52 -0500
Date: Mon, 13 Nov 2006 22:03:57 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, John Stultz <johnstul@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Ingo Molnar <mingo@elte.hu>
Subject: [-mm patch] i386: unexport read_persistent_clock
Message-ID: <20061113210357.GG22565@stusta.de>
References: <20061108015452.a2bb40d2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061108015452.a2bb40d2.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the unused EXPORT_SYMBOL(read_persistent_clock).

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.19-rc5-mm1/arch/i386/kernel/time.c.old	2006-11-13 18:23:40.000000000 +0100
+++ linux-2.6.19-rc5-mm1/arch/i386/kernel/time.c	2006-11-13 18:23:46.000000000 +0100
@@ -210,7 +210,6 @@
 
 	return retval;
 }
-EXPORT_SYMBOL(read_persistent_clock);
 
 static void sync_cmos_clock(unsigned long dummy);
 

