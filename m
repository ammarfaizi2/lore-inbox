Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263280AbSJCOSv>; Thu, 3 Oct 2002 10:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263305AbSJCOSv>; Thu, 3 Oct 2002 10:18:51 -0400
Received: from 200-171-183-235.dsl.telesp.net.br ([200.171.183.235]:48652 "EHLO
	techlinux.com.br") by vger.kernel.org with ESMTP id <S263280AbSJCOSv>;
	Thu, 3 Oct 2002 10:18:51 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Carlos E Gorges <carlos@techlinux.com.br>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.40 - fix apm (module) unresolved symbol 
Date: Thu, 3 Oct 2002 11:24:23 -0300
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200210031124.23570.carlos@techlinux.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- linux-2.5.40/arch/i386/kernel/i386_ksyms.c	Tue Oct  1 04:06:59 2002
+++ linux-2.5/arch/i386/kernel/i386_ksyms.c	Thu Oct  3 10:46:03 2002
@@ -38,6 +38,7 @@
 EXPORT_SYMBOL(machine_real_restart);
 extern void default_idle(void);
 EXPORT_SYMBOL(default_idle);
+EXPORT_SYMBOL(cpu_gdt_table);
 #endif
 
 #ifdef CONFIG_SMP


-- 
	 _________________________
	 Carlos E Gorges          
	 (carlos@techlinux.com.br)
	 Tech informática LTDA
	 Brazil                   
	 _________________________


