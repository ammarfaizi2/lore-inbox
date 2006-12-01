Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759097AbWLAOTf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759097AbWLAOTf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 09:19:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759099AbWLAOTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 09:19:34 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:23308 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S1758996AbWLAOTd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 09:19:33 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: Willy Tarreau <wtarreau@hera.kernel.org>
Subject: [2.4 PATCH] add missing parenthesis in pci-v320usc
Date: Fri, 1 Dec 2006 15:19:07 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612011519.08019.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	This patch adds missing parenthesis in v320usc_inb() macro.

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 arch/sh/kernel/pci-v320usc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.4.34-pre6-a/arch/sh/kernel/pci-v320usc.c	2003-08-25 13:44:40.000000000 +0200
+++ linux-2.4.34-pre6-b/arch/sh/kernel/pci-v320usc.c	2006-12-01 12:31:58.000000000 +0100
@@ -48,7 +48,7 @@
 
 #define reg32(x)	(V320USC_BASE + (V320USC_##x))
 
-#define v320usc_inb(addr)			readb(reg08(addr)
+#define v320usc_inb(addr)			readb(reg08(addr))
 #define v320usc_outb(value, addr)	writeb(value, reg08(addr))
 #define v320usc_inw(addr)			readw(reg16(addr))
 #define v320usc_outw(value, addr)	writew(value, reg16(addr))

-- 
Regards,

	Mariusz Kozlowski
