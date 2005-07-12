Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261399AbVGLMfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbVGLMfg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 08:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261391AbVGLMdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 08:33:38 -0400
Received: from smtp1.adl2.internode.on.net ([203.16.214.181]:9484 "EHLO
	smtp1.adl2.internode.on.net") by vger.kernel.org with ESMTP
	id S261412AbVGLMbb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 08:31:31 -0400
Date: Tue, 12 Jul 2005 22:01:13 +0930
From: "Mark Williams (MWP)" <mwp@internode.on.net>
To: linux-kernel@vger.kernel.org
Subject: Cannot fix unresolved module symbols
Message-ID: <20050712123113.GA8265@linux.comp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings all,

First, im using 2.6.12 with version 3.1 of module-install-utils and GCC 4.0.1.

I simply cannot get kernel modules to install.

Building the kernel and modules works perfecty, no errors.

But on running "make modules_install" i get:

depmod: QM_MODULES: Function not implemented
  INSTALL drivers/net/wireless/atmel.ko
if [ -r System.map -a -x /sbin/depmod ]; then /sbin/depmod -ae -F System.map
2.6.12; fi
depmod: *** Unresolved symbols in
/lib/modules/2.6.12/kernel/drivers/net/wireless/atmel.ko
depmod:         __netdev_watchdog_up
depmod:         preempt_schedule
depmod:         _mmx_memcpy
depmod:         eth_type_trans
depmod:         param_get_charp
depmod:         __kfree_skb
depmod:         alloc_skb
........ and many more

Ive had this problem since i started using 2.6.x, and have always compiled
drivers into the kernel to avoid it. But now i do need to get this fixed so i
can get ndiswrapper working.

Does anyone know what could be wrong?

Thanks.
