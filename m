Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265217AbUAERU2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 12:20:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265216AbUAERU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 12:20:28 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:43529 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S265215AbUAERTl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 12:19:41 -0500
Date: Mon, 5 Jan 2004 18:18:43 +0100
From: Willy Tarreau <willy@w.ods.org>
To: midian@ihme.org
Cc: Marcelo Tosatti <marcelo@hera.kernel.org>,
       Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.4.24 released
Message-ID: <20040105171843.GA2407@alpha.home.local>
References: <200401051355.i05DtvgC020415@hera.kernel.org> <1073321792.21338.2.camel@midux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1073321792.21338.2.camel@midux>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 05, 2004 at 06:56:32PM +0200, Markus H?stbacka wrote:
> make modules_install fails with the following errors:
> 
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.24/kernel/drivers/net/dummy.o
> depmod:         dev_alloc_name_R96db38a6
> depmod:         kmalloc_R93d4cfe6
> depmod:         ether_setup_R0309250f
> depmod:         unregister_netdev_Rbe3cfced
> depmod:         kfree_R037a0cba
> depmod:         __kfree_skb_R934b4bff
> depmod:         register_netdev_R7378c15b
> depmod: *** Unresolved symbols in

Compiled correctly here. Are you sure your patch applied correctly ?
Care to post .config ?

> /lib/modules/2.4.24/kernel/drivers/net/shaper.o
> depmod:         skb_clone_Rec5f0f23
> depmod:         arp_broken_ops_R5494f366
> depmod:         mod_timer_R1f13d309
> depmod:         irq_stat_Rd267df73
> depmod:         dev_alloc_name_R96db38a6
> depmod:         kmalloc_R93d4cfe6
> depmod:         dev_queue_xmit_R95582748
> depmod:         jiffies_R0da02d67
> depmod:         unregister_netdev_Rbe3cfced
> depmod:         __wake_up_Rb76c5f1e
> depmod:         del_timer_Rfc62f16d
> depmod:         __dev_get_by_name_R14ac47be
> depmod:         kfree_R037a0cba
> depmod:         sleep_on_Re0679a3f
> depmod:         printk_R1b7d4074
> depmod:         __kfree_skb_R934b4bff
> depmod:         register_netdev_R7378c15b
> make: *** [_modinst_post] Error 1

This one not tested.

Cheers,
Willy

