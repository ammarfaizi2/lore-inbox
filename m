Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265336AbSJaSmb>; Thu, 31 Oct 2002 13:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265337AbSJaSmb>; Thu, 31 Oct 2002 13:42:31 -0500
Received: from ptldme-smtp2.maine.rr.com ([204.210.65.67]:40080 "EHLO
	ptldme-mls2.maine.rr.com") by vger.kernel.org with ESMTP
	id <S265336AbSJaSma>; Thu, 31 Oct 2002 13:42:30 -0500
Message-ID: <3DC17BF8.2010005@maine.rr.com>
Date: Thu, 31 Oct 2002 13:52:40 -0500
From: "David B. Stevens" <dsteven3@maine.rr.com>
Organization: Penguin Preservation Society
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021025
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.45 compile time warnings
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't think I'll be playing with this kernel right off, few gremlins to run down first.

Report of gouls follows:

In file included from arch/i386/kernel/timers/timer_pit.c:15:
arch/i386/mach-generic/do_timer.h: In function `do_timer_interrupt_hook':
arch/i386/mach-generic/do_timer.h:23: warning: implicit declaration of function `x86_do_profile'
drivers/base/base.h:64: warning: `class_hotplug' defined but not used
drivers/base/base.h:64: warning: `class_hotplug' defined but not used
drivers/base/base.h:64: warning: `class_hotplug' defined but not used
drivers/base/base.h:64: warning: `class_hotplug' defined but not used
drivers/base/base.h:64: warning: `class_hotplug' defined but not used
net/ipv4/route.c: In function `ip_rt_init':
net/ipv4/route.c:2544: warning: implicit declaration of function `xfrm_init'
Root device is (3, 7)
Boot sector 512 bytes.
Setup is 4856 bytes.
System is 761 kB
drivers/char/agp/agp.h:87: warning: `global_cache_flush' defined but not used
drivers/char/agp/agp.h:87: warning: `global_cache_flush' defined but not used
drivers/message/i2o/i2o_pci.c: In function `i2o_pci_core_attach':
drivers/message/i2o/i2o_pci.c:371: warning: implicit declaration of function `i2o_sys_init'
drivers/message/i2o/i2o_block.c: In function `i2o_block_init':
drivers/message/i2o/i2o_block.c:1672: warning: implicit declaration of function `BLK_DEFAULT_QUEUE'
drivers/message/i2o/i2o_block.c:1672: warning: passing arg 1 of `blk_cleanup_queue_R06279b1c' makes pointer from integer without a cast
drivers/message/i2o/i2o_lan.c:28: #error Please convert me to Documentation/DMA-mapping.txt
drivers/message/i2o/i2o_lan.c:119: parse error before `struct'
drivers/message/i2o/i2o_lan.c: In function `i2o_lan_receive_post_reply':
drivers/message/i2o/i2o_lan.c:385: `run_i2o_post_buckets_task' undeclared (first use in this function)
drivers/message/i2o/i2o_lan.c:385: (Each undeclared identifier is reported only once
drivers/message/i2o/i2o_lan.c:385: for each function it appears in.)
drivers/message/i2o/i2o_lan.c: In function `i2o_lan_register_device':
drivers/message/i2o/i2o_lan.c:1406: structure has no member named `list'
drivers/message/i2o/i2o_lan.c:1406: structure has no member named `list'
drivers/message/i2o/i2o_lan.c:1406: structure has no member named `list'
drivers/message/i2o/i2o_lan.c:1406: structure has no member named `list'
drivers/message/i2o/i2o_lan.c:1407: structure has no member named `sync'
make[4]: *** [drivers/message/i2o/i2o_lan.o] Error 1
make[3]: *** [drivers/message/i2o] Error 2
make[2]: *** [drivers/message] Error 2
make[1]: *** [drivers] Error 2
make: *** [modules] Error 2

Cheers,
   Dave

PS: The lkcd guys could resort to the brew bribe method no???


