Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292910AbSBVPkt>; Fri, 22 Feb 2002 10:40:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292911AbSBVPkj>; Fri, 22 Feb 2002 10:40:39 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:34492 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S292910AbSBVPkc>; Fri, 22 Feb 2002 10:40:32 -0500
Message-Id: <200202221452.HAA16587@tstac.esa.lanl.gov>
Content-Type: text/plain; charset=US-ASCII
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: Theodore Tso <tytso@mit.edu>
Subject: [PATCH] 2.5.5-dj1 add one help text to drivers/char/drm/Config.help
Date: Fri, 22 Feb 2002 08:39:00 -0700
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org, Dave Jones <davej@suse.de>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a help text for CONFIG_DRM_SIS in drivers/char/drm/Config.help.
Patch is made against 2.5.5-dj1.

Steven

--- linux-2.5.5-dj1/drivers/char/drm/Config.help.orig   Fri Feb 22 08:29:07 2002
+++ linux-2.5.5-dj1/drivers/char/drm/Config.help        Fri Feb 22 08:30:32 2002
@@ -37,3 +37,7 @@
   card.  If M is selected, the module will be called mga.o.  AGP
   support is required for this driver to work.

+CONFIG_DRM_SIS
+  Choose this option if you have a SIS graphics card. AGP support is
+  required for this driver to work.
+
