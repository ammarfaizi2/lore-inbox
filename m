Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261787AbUD1V54@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbUD1V54 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 17:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbUD1V5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 17:57:22 -0400
Received: from moutng.kundenserver.de ([212.227.126.189]:27100 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261706AbUD1TiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 15:38:05 -0400
Message-ID: <40900818.7080607@roemling.net>
Date: Wed, 28 Apr 2004 21:38:00 +0200
From: Jochen Roemling <jochen@roemling.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en-us, en, de-de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [patch] 2.6.6-rc3 fix typo in Documentation/kernel-parameters.txt
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:35bace2e8eeec41a1b9500b782c09cc4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I came accross a typo in the 2.4.24 kernel tree that is still present in 
2.6.6-rc3 as this patch shows:

--- kernel-parameters.txt~      2004-04-28 21:32:15.000000000 +0200
+++ kernel-parameters.txt       2004-04-28 21:32:32.000000000 +0200
@@ -36,7 +36,7 @@
         IA-32   IA-32 aka i386 architecture is enabled.
         IA-64   IA-64 architecture is enabled.
         IOSCHED More than one I/O scheduler is enabled.
-       IP_PNP  IP DCHP, BOOTP, or RARP is enabled.
+       IP_PNP  IP DHCP, BOOTP, or RARP is enabled.
         ISAPNP  ISA PnP code is enabled.
         ISDN    Appropriate ISDN support is enabled.
         JOY     Appropriate joystick support is enabled.


Sorry for beeing smart-ass but some of the NT-guys in our company use to 
spell it "DCHP" and it strikes me every time...

//Jochen Roemling

