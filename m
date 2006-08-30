Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751506AbWH3Ufo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751506AbWH3Ufo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 16:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751509AbWH3Ufn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 16:35:43 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:24324 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751506AbWH3Ufm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 16:35:42 -0400
Date: Wed, 30 Aug 2006 22:35:41 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Stephen Smalley <sds@tycho.nsa.gov>,
       jmorris@namei.org
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] improve SECURITY_SELINUX_POLICYDB_VERSION_MAX{,_VALUE} help texts
Message-ID: <20060830203541.GN18276@stusta.de>
References: <20060826160922.3324a707.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060826160922.3324a707.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We can't expect everyone to know what "FC3" is.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.18-rc4-mm3/security/selinux/Kconfig.old	2006-08-30 21:56:31.000000000 +0200
+++ linux-2.6.18-rc4-mm3/security/selinux/Kconfig	2006-08-30 21:58:21.000000000 +0200
@@ -135,8 +135,10 @@ config SECURITY_SELINUX_POLICYDB_VERSION
 	  It can be adjusted downward to support legacy userland (init) that
 	  does not correctly handle kernels that support newer policy versions.
 
-	  Examples:  For FC3 or FC4, enable this option and set the value via
-	  the next option.  For FC5 and later, do not enable this option.
+	  Examples:
+	  For the Fedora Core 3 or 4 Linux distributions, enable this option
+	  and set the value via the next option. For Fedore Core 5 and later,
+	  do not enable this option.
 
 	  If you are unsure how to answer this question, answer N.
 
@@ -149,7 +151,9 @@ config SECURITY_SELINUX_POLICYDB_VERSION
 	  This option sets the value for the maximum policy format version
 	  supported by SELinux.
 
-	  Examples:  For FC3, use 18.  For FC4, use 19.
+	  Examples:
+	  For Fedora Core 3, use 18.
+	  For Fedora Core 4, use 19.
 
 	  If you are unsure how to answer this question, look for the
 	  policy format version supported by your policy toolchain, by

