Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbQLTGc6>; Wed, 20 Dec 2000 01:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129431AbQLTGcs>; Wed, 20 Dec 2000 01:32:48 -0500
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:11392 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S129226AbQLTGck>;
	Wed, 20 Dec 2000 01:32:40 -0500
Message-ID: <3A404B62.1AC4AABE@pobox.com>
Date: Tue, 19 Dec 2000 22:02:11 -0800
From: J Sloan <jjs@pobox.com>
Organization: Mirai Consulting Group
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test13pre3-ac3 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test13-pre3 woes
In-Reply-To: <Pine.LNX.4.30.0012180702380.16423-100000@hafnium.nkbj.dk> <3A3DD010.225F721C@pobox.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The saga continues into test13-pre3-ac3:
(last good tdfx.o was from test12)

# uname -a
Linux jyro.mirai.cx 2.4.0-test13pre3-ac3 #1 Tue Dec 19 21:26:36 PST 2000 i586
unknown

# lsmod
Module                  Size  Used by
iptable_filter          1872   0 (autoclean) (unused)
ip_nat_ftp              3424   0 (unused)
iptable_nat            12672   1 [ip_nat_ftp]
ip_conntrack_ftp        2048   0 (unused)
ip_conntrack           13056   2 [ip_nat_ftp iptable_nat ip_conntrack_ftp]
ip_tables              10624   4 [iptable_filter iptable_nat]
ide-scsi                8096   0
8139too                15024   2 (autoclean)
emu10k1                45248   0

# modprobe tdfx
/lib/modules/2.4.0-test13pre3-ac3/kernel/drivers/char/drm/tdfx.o: unresolved
sym
bol remap_page_range
/lib/modules/2.4.0-test13pre3-ac3/kernel/drivers/char/drm/tdfx.o: unresolved
sym
bol __wake_up
/lib/modules/2.4.0-test13pre3-ac3/kernel/drivers/char/drm/tdfx.o: unresolved
sym
bol mtrr_add
/lib/modules/2.4.0-test13pre3-ac3/kernel/drivers/char/drm/tdfx.o: unresolved
sym
bol __generic_copy_from_user
/lib/modules/2.4.0-test13pre3-ac3/kernel/drivers/char/drm/tdfx.o: unresolved
sym
bol schedule
/lib/modules/2.4.0-test13pre3-ac3/kernel/drivers/char/drm/tdfx.o: unresolved
sym
bol kmalloc
/lib/modules/2.4.0-test13pre3-ac3/kernel/drivers/char/drm/tdfx.o: unresolved
sym
bol si_meminfo
/lib/modules/2.4.0-test13pre3-ac3/kernel/drivers/char/drm/tdfx.o: unresolved
sym
bol create_proc_entry
/lib/modules/2.4.0-test13pre3-ac3/kernel/drivers/char/drm/tdfx.o: unresolved
sym
bol inter_module_put
/lib/modules/2.4.0-test13pre3-ac3/kernel/drivers/char/drm/tdfx.o: unresolved
sym
bol __get_free_pages
/lib/modules/2.4.0-test13pre3-ac3/kernel/drivers/char/drm/tdfx.o: unresolved
sym
bol boot_cpu_data
/lib/modules/2.4.0-test13pre3-ac3/kernel/drivers/char/drm/tdfx.o: unresolved
sym
bol inter_module_get
/lib/modules/2.4.0-test13pre3-ac3/kernel/drivers/char/drm/tdfx.o: unresolved
sym
bol remove_wait_queue
/lib/modules/2.4.0-test13pre3-ac3/kernel/drivers/char/drm/tdfx.o: unresolved
sym
bol high_memory
/lib/modules/2.4.0-test13pre3-ac3/kernel/drivers/char/drm/tdfx.o: unresolved
sym
bol iounmap
/lib/modules/2.4.0-test13pre3-ac3/kernel/drivers/char/drm/tdfx.o: unresolved
sym
bol free_pages
/lib/modules/2.4.0-test13pre3-ac3/kernel/drivers/char/drm/tdfx.o: unresolved
sym
bol __ioremap
/lib/modules/2.4.0-test13pre3-ac3/kernel/drivers/char/drm/tdfx.o: unresolved
sym
bol del_timer
/lib/modules/2.4.0-test13pre3-ac3/kernel/drivers/char/drm/tdfx.o: unresolved
sym
bol interruptible_sleep_on
/lib/modules/2.4.0-test13pre3-ac3/kernel/drivers/char/drm/tdfx.o: unresolved
sym
bol __pollwait
/lib/modules/2.4.0-test13pre3-ac3/kernel/drivers/char/drm/tdfx.o: unresolved
sym
bol kfree
/lib/modules/2.4.0-test13pre3-ac3/kernel/drivers/char/drm/tdfx.o: unresolved
sym
bol remove_proc_entry
/lib/modules/2.4.0-test13pre3-ac3/kernel/drivers/char/drm/tdfx.o: unresolved
sym
bol pci_find_slot
/lib/modules/2.4.0-test13pre3-ac3/kernel/drivers/char/drm/tdfx.o: unresolved
sym
bol kill_fasync
/lib/modules/2.4.0-test13pre3-ac3/kernel/drivers/char/drm/tdfx.o: unresolved
sym
bol fasync_helper
/lib/modules/2.4.0-test13pre3-ac3/kernel/drivers/char/drm/tdfx.o: unresolved
sym
bol add_wait_queue
/lib/modules/2.4.0-test13pre3-ac3/kernel/drivers/char/drm/tdfx.o: unresolved
sym
bol do_mmap_pgoff
/lib/modules/2.4.0-test13pre3-ac3/kernel/drivers/char/drm/tdfx.o: unresolved
sym
bol mem_map
/lib/modules/2.4.0-test13pre3-ac3/kernel/drivers/char/drm/tdfx.o: unresolved
sym
bol sprintf
/lib/modules/2.4.0-test13pre3-ac3/kernel/drivers/char/drm/tdfx.o: unresolved
sym
bol jiffies
/lib/modules/2.4.0-test13pre3-ac3/kernel/drivers/char/drm/tdfx.o: unresolved
sym
bol printk
/lib/modules/2.4.0-test13pre3-ac3/kernel/drivers/char/drm/tdfx.o: unresolved
sym
bol add_timer
/lib/modules/2.4.0-test13pre3-ac3/kernel/drivers/char/drm/tdfx.o: unresolved
sym
bol __generic_copy_to_user
/lib/modules/2.4.0-test13pre3-ac3/kernel/drivers/char/drm/tdfx.o: insmod
/lib/mo
dules/2.4.0-test13pre3-ac3/kernel/drivers/char/drm/tdfx.o failed

Hope this helps -

jjs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
