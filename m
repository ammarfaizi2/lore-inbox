Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422852AbWI3AGi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422852AbWI3AGi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 20:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422856AbWI3AGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 20:06:37 -0400
Received: from www.osadl.org ([213.239.205.134]:31892 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1422852AbWI3AEP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 20:04:15 -0400
Message-Id: <20060929234440.980110000@cruncher.tec.linutronix.de>
References: <20060929234435.330586000@cruncher.tec.linutronix.de>
Date: Fri, 29 Sep 2006 23:58:38 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Jim Gettys <jg@laptop.org>, John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: [patch 19/23] high-res timers, dynticks: enable i386 support
Content-Disposition: inline; filename=hrtimer-hres-i386.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

enable high-res timers and dyntick on i386.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
--
 arch/i386/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-2.6.18-mm2/arch/i386/Kconfig
===================================================================
--- linux-2.6.18-mm2.orig/arch/i386/Kconfig	2006-09-30 01:41:10.000000000 +0200
+++ linux-2.6.18-mm2/arch/i386/Kconfig	2006-09-30 01:41:19.000000000 +0200
@@ -61,6 +61,8 @@ source "init/Kconfig"
 
 menu "Processor type and features"
 
+source "kernel/time/Kconfig"
+
 config SMP
 	bool "Symmetric multi-processing support"
 	---help---

--

