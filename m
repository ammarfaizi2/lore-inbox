Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161925AbWJDRiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161925AbWJDRiM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 13:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161930AbWJDRiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 13:38:11 -0400
Received: from www.osadl.org ([213.239.205.134]:48101 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1161925AbWJDRiJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 13:38:09 -0400
Message-Id: <20061004172224.267255000@cruncher.tec.linutronix.de>
References: <20061004172217.092570000@cruncher.tec.linutronix.de>
Date: Wed, 04 Oct 2006 17:31:52 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       John Stultz <johnstul@us.ibm.com>,
       Valdis Kletnieks <valdis.kletnieks@vt.edu>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>,
       David Woodhouse <dwmw2@infradead.org>, Jim Gettys <jg@laptop.org>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: [patch 21/22] high-res timers, dynticks: enable i386 support
Content-Disposition: inline;
	filename=high-res-timers-dynticks-enable-i386-support.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

Enable high-res timers and dyntick on i386.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
 arch/i386/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-2.6.18-mm3/arch/i386/Kconfig
===================================================================
--- linux-2.6.18-mm3.orig/arch/i386/Kconfig	2006-10-04 18:13:57.000000000 +0200
+++ linux-2.6.18-mm3/arch/i386/Kconfig	2006-10-04 18:13:59.000000000 +0200
@@ -78,6 +78,8 @@ source "init/Kconfig"
 
 menu "Processor type and features"
 
+source "kernel/time/Kconfig"
+
 config SMP
 	bool "Symmetric multi-processing support"
 	---help---

--

