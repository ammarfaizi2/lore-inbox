Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263475AbTLSRMm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 12:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263496AbTLSRMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 12:12:42 -0500
Received: from mx2.mail.ru ([194.67.23.22]:51980 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S263475AbTLSRMk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 12:12:40 -0500
Message-ID: <3FE33179.5000705@mail.ru>
Date: Fri, 19 Dec 2003 12:12:25 -0500
From: Yaroslav Klyukin <skintwin@mail.ru>
User-Agent: Mozilla/5.0 (ICQ: 1045670, AIM: infiniteparticle)
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Danny Van Elsen <danny.van.elsen_remove@skynet.be>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.23 compilation error
References: <pan.2003.12.19.16.08.21.742541@skynet.be>
In-Reply-To: <pan.2003.12.19.16.08.21.742541@skynet.be>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam: Not detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Danny Van Elsen wrote:
> hello all,
> 
> I've reused my .config from 2.4.21, accepted all default answers from
> 'make oldconfig', and after 'make dep clean bzImage modules' I now have an
> error in 'make modules_install':

Try to save .config file, then run  "make mrproper"
Restore .config file, run "make menuconfig" or "make oldconfig"
Then repeat "make dep bzImage modules modules_install install"
I hope, this is as simple.

> 
> depmod: *** Unresolved symbols in /lib/modules/2.4.23/kernel/drivers/block/loop.o
> depmod:         register_disk_R1b56eb03
> depmod:         __free_pages_R88128961
> depmod:         schedule_timeout_R17d59d01
> depmod:         blk_queue_make_request_R845d53c0
> depmod:         kmem_cache_free_R891f2686
> depmod:         kmalloc_R93d4cfe6
> depmod:         blksize_size_R2f30b4b6
> depmod:         __down_failed_interruptible
> depmod:         zone_table_Rdf69790d
> depmod:         __up_wakeup
> depmod:         unlock_page_Rd1bff43b
> depmod:         kernel_thread_R7ca341af
> depmod:         flush_signals_R6bcc7377
> depmod:         reparent_to_init_Rec6158d0
> depmod:         generic_make_request_R3ab29a08
> depmod:         blk_ioctl_Re7800428
> depmod:         blk_dev_R3cb24670
> depmod:         _alloc_pages_Rd0aa5a8b
> depmod:         bh_cachep_Rdcc0bb37
> depmod:         find_or_create_page_Reaf41236
> depmod:         tq_disk_R5373dbb6
> depmod:         sprintf_R1d26aa98
> depmod:         daemonize_Rd66a354a
> depmod:         fput_R90784591
> depmod:         blk_size_Ra2e0a082
> 
> and so on.
> 
> what would I have done wrong?
> 
> thanks in advance for any response!


