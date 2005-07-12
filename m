Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261336AbVGLMpc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbVGLMpc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 08:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261391AbVGLMpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 08:45:32 -0400
Received: from alog0200.analogic.com ([208.224.220.215]:37596 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261336AbVGLMp3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 08:45:29 -0400
Date: Tue, 12 Jul 2005 08:43:56 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: "Mark Williams (MWP)" <mwp@internode.on.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Cannot fix unresolved module symbols
In-Reply-To: <20050712123113.GA8265@linux.comp>
Message-ID: <Pine.LNX.4.61.0507120840560.2712@chaos.analogic.com>
References: <20050712123113.GA8265@linux.comp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jul 2005, Mark Williams (MWP) wrote:

> Greetings all,
>
> First, im using 2.6.12 with version 3.1 of module-install-utils and GCC 4.0.1.
>
> I simply cannot get kernel modules to install.
>
> Building the kernel and modules works perfecty, no errors.
>
> But on running "make modules_install" i get:
>
> depmod: QM_MODULES: Function not implemented
>  INSTALL drivers/net/wireless/atmel.ko
> if [ -r System.map -a -x /sbin/depmod ]; then /sbin/depmod -ae -F System.map
> 2.6.12; fi
> depmod: *** Unresolved symbols in
> /lib/modules/2.6.12/kernel/drivers/net/wireless/atmel.ko
> depmod:         __netdev_watchdog_up
> depmod:         preempt_schedule
> depmod:         _mmx_memcpy
> depmod:         eth_type_trans
> depmod:         param_get_charp
> depmod:         __kfree_skb
> depmod:         alloc_skb
> ........ and many more
>
> Ive had this problem since i started using 2.6.x, and have always compiled
> drivers into the kernel to avoid it. But now i do need to get this fixed so i
> can get ndiswrapper working.
>
> Does anyone know what could be wrong?
>
> Thanks.

> depmod: QM_MODULES: Function not implemented
           ^^^^^^^^^^^^^^^
The hint: Upgrade your modules tools. (module-init-tools-3.2.tar.gz)

Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
