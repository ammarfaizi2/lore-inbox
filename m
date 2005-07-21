Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261765AbVGUL4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261765AbVGUL4K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 07:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261767AbVGUL4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 07:56:10 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:19460 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261765AbVGUL4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 07:56:08 -0400
Date: Thu, 21 Jul 2005 13:56:04 +0200
From: Adrian Bunk <bunk@stusta.de>
To: sfrench@samba.org
Cc: samba-technical@lists.samba.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] let CIFS_EXPERIMENTAL depend on EXPERIMENTAL
Message-ID: <20050721115604.GB3160@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems logical.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-rc3-mm1-modular/fs/Kconfig.old	2005-07-21 13:52:49.000000000 +0200
+++ linux-2.6.13-rc3-mm1-modular/fs/Kconfig	2005-07-21 13:53:11.000000000 +0200
@@ -1804,7 +1804,7 @@
 
 config CIFS_EXPERIMENTAL
 	  bool "CIFS Experimental Features (EXPERIMENTAL)"
-	  depends on CIFS
+	  depends on CIFS && EXPERIMENTAL
 	  help
 	    Enables cifs features under testing. These features
 	    are highly experimental.  If unsure, say N.

