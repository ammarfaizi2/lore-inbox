Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269883AbUJHMsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269883AbUJHMsg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 08:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269920AbUJHMsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 08:48:36 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:8462 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S269883AbUJHMsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 08:48:35 -0400
Date: Fri, 8 Oct 2004 14:47:55 +0200
From: Adrian Bunk <bunk@stusta.de>
To: matthew@wil.cx, Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: grundler@parisc-linux.org, parisc-linux@parisc-linux.org,
       linux-kernel@vger.kernel.org
Subject: [patch] fix unterminated comment in asm-parisc/som.h
Message-ID: <20041008124754.GH5227@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The patch below fixes an unterminated comment in 
include/asm-parisc/som.h present in both 2.4 and 2.6 .

This bug was found using David A. Wheeler's 'SLOCCount'.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.9-rc3-mm3/include/asm-parisc/som.h.old	2004-10-08 14:38:44.000000000 +0200
+++ linux-2.6.9-rc3-mm3/include/asm-parisc/som.h	2004-10-08 14:39:10.000000000 +0200
@@ -5,4 +5,4 @@
 #include <linux/som.h>
 
 
-#endif /* _ASM_PARISC_SOM_H
+#endif /* _ASM_PARISC_SOM_H */
