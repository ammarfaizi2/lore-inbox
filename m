Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288959AbSBMVfX>; Wed, 13 Feb 2002 16:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288969AbSBMVfO>; Wed, 13 Feb 2002 16:35:14 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:3245 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S288959AbSBMVfH>; Wed, 13 Feb 2002 16:35:07 -0500
Message-Id: <200202132047.NAA03164@tstac.esa.lanl.gov>
Content-Type: text/plain; charset=US-ASCII
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: [PATCH] 2.5.4, add 1 help text to drivers/video/Config.help
Date: Wed, 13 Feb 2002 14:33:55 -0700
X-Mailer: KMail [version 1.3.1]
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The drivers/video/Config.in file contains 3 options which do not have any 
help text in drivers/video/Config.help (or anywhere else).

The following patch provides a help text for CONFIG_FB_TX3912.  The other
two options which could use help texts are CONFIG_FB_PCI and CONFIG_FB_SUN3.

Steven

--- linux-2.5.4/drivers/video/Config.help.orig  Wed Feb 13 13:55:31 2002
+++ linux-2.5.4/drivers/video/Config.help       Wed Feb 13 13:55:42 2002
@@ -569,6 +569,12 @@
   The IMS Twin Turbo is a PCI-based frame buffer card bundled with
   many Macintosh and compatible computers.

+CONFIG_FB_TX3912
+  The TX3912 is a Toshiba RISC processor based on the MIPS 3900 core;
+  see <http://www.toshiba.com/taec/components/Generic/risc/tx3912.htm>.
+
+  Say Y here to enable kernel support for the on-board framebuffer.
+
 CONFIG_FB_VIRTUAL
   This is a `virtual' frame buffer device. It operates on a chunk of
   unswappable kernel memory instead of on the memory of a graphics
