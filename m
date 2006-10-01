Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932489AbWJAXLw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932489AbWJAXLw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 19:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932482AbWJAXHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 19:07:25 -0400
Received: from www.osadl.org ([213.239.205.134]:26803 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S932490AbWJAXHA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 19:07:00 -0400
Message-Id: <20061001225725.323709000@cruncher.tec.linutronix.de>
References: <20061001225720.115967000@cruncher.tec.linutronix.de>
Date: Sun, 01 Oct 2006 23:01:07 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Jim Gettys <jg@laptop.org>, John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: [patch 20/21] high-res timers, dynticks: enable i386 support
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
--- linux-2.6.18-mm2.orig/arch/i386/Kconfig	2006-10-02 00:55:53.000000000 +0200
+++ linux-2.6.18-mm2/arch/i386/Kconfig	2006-10-02 00:55:55.000000000 +0200
@@ -65,6 +65,8 @@ source "init/Kconfig"
 
 menu "Processor type and features"
 
+source "kernel/time/Kconfig"
+
 config SMP
 	bool "Symmetric multi-processing support"
 	---help---

--

