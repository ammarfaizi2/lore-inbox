Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267482AbUHXLVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267482AbUHXLVg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 07:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267486AbUHXLVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 07:21:36 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:4108 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S267482AbUHXLVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 07:21:21 -0400
Date: Tue, 24 Aug 2004 12:21:16 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alsa Devel list <alsa-devel@lists.sourceforge.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Fwd: [Alsa-devel] 2.6.6-rc2 build warnings
Message-ID: <20040824122116.A5031@flint.arm.linux.org.uk>
Mail-Followup-To: Alsa Devel list <alsa-devel@lists.sourceforge.net>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A reminder that this problem remains unresolved.

----- Forwarded message from Russell King <rmk+alsa@arm.linux.org.uk> -----
From: Russell King <rmk+alsa@arm.linux.org.uk>
To: Alsa Devel list <alsa-devel@lists.sourceforge.net>
Subject: [Alsa-devel] 2.6.6-rc2 build warnings
Date: Sun, 30 May 2004 11:00:08 +0100

Someone may wish to look into the cause of this... CONFIG_PCI is
unselected in this case.

  CC [M]  sound/core/oss/mixer_oss.o
In file included from sound/core/oss/mixer_oss.c:26:
include/sound/core.h:215: warning: `struct pci_dev' declared inside parameter list
include/sound/core.h:215: warning: its scope is only this definition or declaration, which is probably not what you want
include/sound/core.h:216: warning: `struct pci_dev' declared inside parameter list
  CC [M]  sound/core/oss/pcm_oss.o
In file included from sound/core/oss/pcm_oss.c:35:
include/sound/core.h:215: warning: `struct pci_dev' declared inside parameter list
include/sound/core.h:215: warning: its scope is only this definition or declaration, which is probably not what you want
include/sound/core.h:216: warning: `struct pci_dev' declared inside parameter list
...

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

----- End forwarded message -----

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
