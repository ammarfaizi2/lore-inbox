Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261708AbVDEMWB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261708AbVDEMWB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 08:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261710AbVDEMWB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 08:22:01 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:31503 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261708AbVDEMV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 08:21:58 -0400
Date: Tue, 5 Apr 2005 14:21:57 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Ryan Anderson <ryan@michonline.com>,
       Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] Makefile: fix spaces instead of tab
Message-ID: <20050405122157.GC6885@stusta.de>
References: <20050405000524.592fc125.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050405000524.592fc125.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2005 at 12:05:24AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.12-rc1-mm4:
>...
>  bk-kbuild.patch
>...


GNU Emacs correctly complains because of spaces instead of a tab.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc2-mm1-full/Makefile.old	2005-04-05 14:00:06.000000000 +0200
+++ linux-2.6.12-rc2-mm1-full/Makefile	2005-04-05 14:00:16.000000000 +0200
@@ -577,7 +577,7 @@
 
 ifdef CONFIG_LOCALVERSION_AUTO
 	localversion-auto := \
-        	$(shell $(PERL) $(srctree)/scripts/setlocalversion $(srctree))
+		$(shell $(PERL) $(srctree)/scripts/setlocalversion $(srctree))
 	LOCALVERSION := $(LOCALVERSION)$(localversion-auto)
 endif
 

