Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129568AbQL1OHV>; Thu, 28 Dec 2000 09:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129881AbQL1OHL>; Thu, 28 Dec 2000 09:07:11 -0500
Received: from mx7.sac.fedex.com ([199.81.194.38]:18439 "EHLO
	mx7.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S129568AbQL1OG6>; Thu, 28 Dec 2000 09:06:58 -0500
Date: Thu, 28 Dec 2000 21:32:46 +0800
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
Message-Id: <200012281332.eBSDWkv20288@silk.corp.fedex.com>
To: linux-kernel@silk.corp.fedex.com, jchua@fedex.com
Subject: unresolved symbols in 2.4.0-test13-pre4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


upgraded to test13-pre4. When I ran "depmod -a", I got a lot of errors
about unresolved symbols for the drm modules ...

depmod: *** Unresolved symbols in /lib/modules/2.4.0-test13-pre4/kernel/drivers/char/drm/i810.o
depmod: *** Unresolved symbols in /lib/modules/2.4.0-test13-pre4/kernel/drivers/char/drm/mga.o
depmod: *** Unresolved symbols in /lib/modules/2.4.0-test13-pre4/kernel/drivers/char/drm/r128.o
depmod: *** Unresolved symbols in /lib/modules/2.4.0-test13-pre4/kernel/drivers/char/drm/tdfx.o


"depmod -ae" shows the following ....


depmod: *** Unresolved symbols in /lib/modules/2.4.0-test13-pre4/kernel/drivers/char/drm/i810.o
depmod:         remap_page_range
depmod:         __wake_up
depmod:         mtrr_add
depmod:         __generic_copy_from_user
depmod:         schedule
depmod:         kmalloc
depmod:         si_meminfo
depmod:         create_proc_entry
depmod:         inter_module_put
depmod:         __get_free_pages
depmod:         boot_cpu_data
depmod:         inter_module_get
depmod:         remove_wait_queue
depmod:         high_memory
depmod:         iounmap
depmod:         free_pages
depmod:         __ioremap
depmod:         del_timer
depmod:         interruptible_sleep_on
depmod:         __pollwait
depmod:         kfree
depmod:         remove_proc_entry
depmod:         pci_find_slot
depmod:         kill_fasync
depmod:         fasync_helper
depmod:         add_wait_queue
depmod:         do_mmap_pgoff
depmod:         mem_map
depmod:         sprintf
depmod:         jiffies
depmod:         printk
depmod:         add_timer
depmod:         __generic_copy_to_user

(repeat for the other 3 modules ...)


Jeff.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
