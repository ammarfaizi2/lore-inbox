Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317772AbSFSFLu>; Wed, 19 Jun 2002 01:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317773AbSFSFLt>; Wed, 19 Jun 2002 01:11:49 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:1264 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S317772AbSFSFLt>; Wed, 19 Jun 2002 01:11:49 -0400
Date: Wed, 19 Jun 2002 01:11:50 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [patch] export default_wake_function
Message-ID: <20020619011150.A15637@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

'Lo,

akpm pointed out that an EXPORT_SYMBOL is missing for default_wake_function. 

		-ben

diff -urN v2.5.23/kernel/ksyms.c export-2.5.23/kernel/ksyms.c
--- v2.5.23/kernel/ksyms.c	Tue Jun 18 23:22:23 2002
+++ export-2.5.23/kernel/ksyms.c	Wed Jun 19 01:08:06 2002
@@ -459,6 +459,7 @@
 
 /* process management */
 EXPORT_SYMBOL(complete_and_exit);
+EXPORT_SYMBOL(default_wake_function);
 EXPORT_SYMBOL(__wake_up);
 #if CONFIG_SMP
 EXPORT_SYMBOL_GPL(__wake_up_sync); /* internal use only */
