Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161882AbWKIXjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161882AbWKIXjb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 18:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161881AbWKIXjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 18:39:31 -0500
Received: from www.osadl.org ([213.239.205.134]:8093 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1161879AbWKIXjT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 18:39:19 -0500
Message-Id: <20061109233036.141838000@cruncher.tec.linutronix.de>
References: <20061109233030.915859000@cruncher.tec.linutronix.de>
Date: Thu, 09 Nov 2006 23:38:35 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Len Brown <lenb@kernel.org>, John Stultz <johnstul@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>, Andi Kleen <ak@suse.de>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: [patch 18/19] high-res timers, dynticks: enable i386 support
Content-Disposition: inline;
	filename=high-res-timers-dynticks-enable-i386-support.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

Enable high-res timers and dyntick on i386.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Index: linux-2.6.19-rc5-mm1/arch/i386/Kconfig
===================================================================
--- linux-2.6.19-rc5-mm1.orig/arch/i386/Kconfig	2006-11-09 20:15:54.000000000 +0100
+++ linux-2.6.19-rc5-mm1/arch/i386/Kconfig	2006-11-09 20:16:52.000000000 +0100
@@ -82,6 +82,8 @@ source "init/Kconfig"
 
 menu "Processor type and features"
 
+source "kernel/time/Kconfig"
+
 config SMP
 	bool "Symmetric multi-processing support"
 	---help---

--

