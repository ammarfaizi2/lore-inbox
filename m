Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130753AbQL3TA4>; Sat, 30 Dec 2000 14:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131178AbQL3TAq>; Sat, 30 Dec 2000 14:00:46 -0500
Received: from f1j.dsl.xmission.com ([166.70.20.140]:16935 "EHLO
	f1j.dsl.xmission.com") by vger.kernel.org with ESMTP
	id <S130753AbQL3TAf>; Sat, 30 Dec 2000 14:00:35 -0500
Message-ID: <3A4E29A0.33641EE8@xmission.com>
Date: Sat, 30 Dec 2000 11:29:52 -0700
From: Frank Jacobberger <f1j@xmission.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test13-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: modutils 2.3.23 fails with tdfx.o with test13-pre6
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can't get the latest modutils to work with loading
tdfx.o... Even went to the directory where tdfx.o resides
and did a insmod -S tdfx.o and got the following :

BTW - test13-pre6 here

tdfx.o: unresolved symbol remap_page_range
tdfx.o: unresolved symbol __wake_up
tdfx.o: unresolved symbol mtrr_add
tdfx.o: unresolved symbol __generic_copy_from_user
tdfx.o: unresolved symbol schedule
tdfx.o: unresolved symbol kmalloc
tdfx.o: unresolved symbol si_meminfo
tdfx.o: unresolved symbol create_proc_entry
tdfx.o: unresolved symbol inter_module_put
tdfx.o: unresolved symbol __get_free_pages
tdfx.o: unresolved symbol boot_cpu_data
tdfx.o: unresolved symbol inter_module_get
tdfx.o: unresolved symbol remove_wait_queue
tdfx.o: unresolved symbol high_memory
tdfx.o: unresolved symbol iounmap
tdfx.o: unresolved symbol free_pages
tdfx.o: unresolved symbol __ioremap
tdfx.o: unresolved symbol del_timer
tdfx.o: unresolved symbol interruptible_sleep_on
tdfx.o: unresolved symbol __pollwait
tdfx.o: unresolved symbol kfree
tdfx.o: unresolved symbol remove_proc_entry
tdfx.o: unresolved symbol pci_find_slot
tdfx.o: unresolved symbol kill_fasync
tdfx.o: unresolved symbol fasync_helper
tdfx.o: unresolved symbol add_wait_queue
tdfx.o: unresolved symbol do_mmap_pgoff
tdfx.o: unresolved symbol mem_map
tdfx.o: unresolved symbol sprintf
tdfx.o: unresolved symbol jiffies
tdfx.o: unresolved symbol printk
tdfx.o: unresolved symbol add_timer
tdfx.o: unresolved symbol __generic_copy_to_user

So what gives here?

Frank

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
