Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264807AbSIWFtK>; Mon, 23 Sep 2002 01:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264834AbSIWFtK>; Mon, 23 Sep 2002 01:49:10 -0400
Received: from holomorphy.com ([66.224.33.161]:19348 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S264807AbSIWFtJ>;
	Mon, 23 Sep 2002 01:49:09 -0400
Date: Sun, 22 Sep 2002 22:46:04 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.38 vs. 2.5.38-mm1 dbench 512 oprofiles
Message-ID: <20020923054604.GY3530@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20020923053600.GJ25605@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020923053600.GJ25605@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 22, 2002 at 10:36:00PM -0700, William Lee Irwin III wrote:
sorry real 2.5.38-mm1 profile:
c01053dc 884615995 93.5551     poll_idle
c0114c28 38573436 4.07944     load_balance
c01150a0 7901071  0.8356      scheduler_tick
c0111788 2659487  0.281262    smp_apic_timer_interrupt
c0131600 1442967  0.152605    file_read_actor
c01402a4 1199079  0.126812    blk_queue_bounce
c01320f4 1054365  0.111507    generic_file_write_nolock
c010d718 730020   0.0772053   timer_interrupt
c01a2abb 725817   0.0767608   .text.lock.dec_and_lock
c01175fb 674730   0.071358    .text.lock.sched
c0106408 356493   0.0377019   .text.lock.semaphore
c0115454 326529   0.034533    do_schedule
c011f6f0 309224   0.0327029   do_softirq
c0122eb4 262417   0.0277527   update_one_process
c0122fe8 222659   0.0235479   timer_bh
c010603c 191642   0.0202676   __down
c0114798 159658   0.0168851   try_to_wake_up
c015c66c 153232   0.0162055   d_lookup
c0145b50 141098   0.0149222   generic_file_llseek
c01391cc 123761   0.0130887   rmqueue
c01408d1 123358   0.0130461   .text.lock.highmem
c0147160 117950   0.0124741   get_empty_filp
c0174f00 105235   0.0111294   ext2_new_block

