Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276115AbRI1PO2>; Fri, 28 Sep 2001 11:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276113AbRI1POJ>; Fri, 28 Sep 2001 11:14:09 -0400
Received: from [195.223.140.107] ([195.223.140.107]:13556 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S276111AbRI1PN6>;
	Fri, 28 Sep 2001 11:13:58 -0400
Date: Fri, 28 Sep 2001 17:14:35 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Hubert Mantel <mantel@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bug report: linux-2.4.10.SuSE-0.tar.bz2
Message-ID: <20010928171435.B24922@athlon.random>
In-Reply-To: <20010926004612.A6621@spylog.ru> <20010926115449.L17951@suse.de> <20010926225958.A27526@spylog.ru> <20010927113145.H22554@suse.de> <20010928105919.B2517@spylog.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010928105919.B2517@spylog.ru>; from andy@spylog.ru on Fri, Sep 28, 2001 at 10:59:19AM +0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2001 at 10:59:19AM +0400, Andrey Nekrasov wrote:
> Trace; e013914e <_alloc_pages+16/18>
> Trace; e01395da <__get_free_pages+a/18>
> Trace; e0134cb1 <kmem_cache_grow+149/4a0>
> Trace; e0135bbc <kmalloc+31c/348>
> Trace; e024c26a <alloc_skb+102/1c8>
> Trace; e02703f3 <tcp_send_ack+23/cc>
> Trace; e0270dd4 <tcp_delack_timer+19c/228>
> Trace; e0270c38 <tcp_delack_timer+0/228>
> Trace; e012220d <timer_bh+301/3c4>
> Trace; e01219fe <tqueue_bh+16/1c>
> Trace; e011d604 <bh_action+50/108>
> Trace; e011d4d9 <tasklet_hi_action+6d/a0>
> Trace; e011d25f <do_softirq+6f/cc>
> Trace; e0108f45 <do_IRQ+1b1/1c0>
> Trace; e029fd68 <stext_lock+ec0/7a85>
> Trace; e01147c7 <do_page_fault+2eb/904>
> Trace; e01144dc <do_page_fault+0/904>
> Trace; e0248e23 <sock_read+8b/98>
> Trace; e015612d <do_fcntl+1f1/404>
> Trace; e0116e98 <sys_sched_setscheduler+14/18>
> Trace; e01075d4 <error_code+34/3c>
> 
> Trace; e013914e <_alloc_pages+16/18>
> Trace; e01395da <__get_free_pages+a/18>
> Trace; e0134cb1 <kmem_cache_grow+149/4a0>
> Trace; e0135888 <kmem_cache_alloc+2e4/2fc>
> Trace; e0121e1c <update_process_times+20/9c>
> Trace; e012302c <send_signal+2c/100>
> Trace; e012311d <deliver_signal+1d/fc>
> Trace; e01232cf <send_sig_info+d3/128>
> Trace; e0124331 <sys_rt_sigqueueinfo+119/130>
> Trace; e01074e3 <system_call+33/38>

these are normal under network load. Of course they're harmless too.

Andrea
