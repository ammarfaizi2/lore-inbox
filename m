Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129035AbRBIAeH>; Thu, 8 Feb 2001 19:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129156AbRBIAd5>; Thu, 8 Feb 2001 19:33:57 -0500
Received: from [209.53.18.145] ([209.53.18.145]:7360 "EHLO continuum.cm.nu")
	by vger.kernel.org with ESMTP id <S129155AbRBIAdr>;
	Thu, 8 Feb 2001 19:33:47 -0500
Date: Thu, 8 Feb 2001 16:33:07 -0800
From: Shane Wegner <shane@cm.nu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: One liner: compile failure with 2.2.19pre9 aic7xxx
Message-ID: <20010208163307.A18918@cm.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Organization: Continuum Systems, Vancouver, Canada
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Seems aic7xxx.h got lost.

--- drivers/scsi/hosts.c.orig   Thu Feb  8 16:32:00 2001
+++ drivers/scsi/hosts.c        Thu Feb  8 16:29:48 2001
@@ -136,7 +136,7 @@
 #endif

 #ifdef CONFIG_SCSI_AIC7XXX
-#include "aic7xxx.h"
+#include "aic7xxx/aic7xxx.h"
 #endif

 #ifdef CONFIG_SCSI_IPS

-- 
Shane Wegner: shane@cm.nu
              http://www.cm.nu/~shane/
PGP:          1024D/FFE3035D
              A0ED DAC4 77EC D674 5487
              5B5C 4F89 9A4E FFE3 035D
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
