Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265627AbSKAEyf>; Thu, 31 Oct 2002 23:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265625AbSKAEyf>; Thu, 31 Oct 2002 23:54:35 -0500
Received: from naru.ramix.jp ([218.45.113.209]:4362 "EHLO mail.ramix.jp")
	by vger.kernel.org with ESMTP id <S265624AbSKAEyK>;
	Thu, 31 Oct 2002 23:54:10 -0500
Date: Fri, 01 Nov 2002 14:00:32 +0900
From: YOSHIMURA Keitaro <ramsy@linux.or.jp>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] [2.5.45]: Kconfig needed qt also except xconfig is corrected.
Message-Id: <20021101135313.0540.RAMSY@linux.or.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.05.06
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kconfig bugfix. Please apply:)

My box text console only... Therefore, QT is not installed!

thanks

--- linux-2.5.45/scripts/kconfig/Makefile	Thu Oct 31 09:43:45 2002
+++ linux-2.5.45-kconfig_fix/scripts/kconfig/Makefile	Fri Nov  1 13:48:02 2002
@@ -34,7 +34,7 @@
 
 $(obj)/qconf.o: $(obj)/.tmp_qtcheck
 
--include $(obj)/.tmp_qtcheck
+#-include $(obj)/.tmp_qtcheck
 
 # QT needs some extra effort...
 $(obj)/.tmp_qtcheck:


<|> YOSHIMURA 'ramsy' Keitaro / Japan Linux Association
<|> mailto:ramsy@linux.or.jp
<|> http://jla.linux.or.jp/index.html

