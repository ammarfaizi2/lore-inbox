Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263169AbREaTWj>; Thu, 31 May 2001 15:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263177AbREaTW3>; Thu, 31 May 2001 15:22:29 -0400
Received: from amadeus.resilience.com ([209.245.157.29]:37689 "HELO jmcmullan")
	by vger.kernel.org with SMTP id <S263169AbREaTWP>;
	Thu, 31 May 2001 15:22:15 -0400
Date: Thu, 31 May 2001 12:21:02 -0700
From: Jason McMullan <jmcmullan@linuxcare.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] simple_strtoull export
Message-ID: <20010531122102.A10486@jmcmullan.resilience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Missing kernel export for 'simple_strtoull'

diff -u --recursive --new-file 2.4.5/kernel/ksyms.c 2.4.5.fixed/kernel/ksyms.c
--- 2.4.5/kernel/ksyms.c    Wed May 30 10:13:14 2001
+++ 2.4.5.fixed/kernel/ksyms.c    Thu May 31 12:15:49 2001
@@ -461,6 +461,7 @@
 EXPORT_SYMBOL(bdevname);
 EXPORT_SYMBOL(cdevname);
 EXPORT_SYMBOL(simple_strtoul);
+EXPORT_SYMBOL(simple_strtoull);
 EXPORT_SYMBOL(system_utsname); /* UTS data */
 EXPORT_SYMBOL(uts_sem);                /* UTS semaphore */
 #ifndef __mips__


-- 
Jason McMullan, Senior Linux Consultant
Linuxcare, Inc. 412.432.6457 tel, 412.656.3519 cell
jmcmullan@linuxcare.com, http://www.linuxcare.com/
Linuxcare. Putting open source to work.
