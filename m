Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130473AbQL0CWj>; Tue, 26 Dec 2000 21:22:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130480AbQL0CW2>; Tue, 26 Dec 2000 21:22:28 -0500
Received: from paloma17.e0k.nbg-hannover.de ([62.159.219.17]:63990 "HELO
	paloma17.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S130473AbQL0CWQ>; Tue, 26 Dec 2000 21:22:16 -0500
From: Dieter Nützel <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: "Linux Kernel List" <linux-kernel@vger.kernel.org>
Subject: test13-preX: DRM (tdfx.o) unresolved symbols fixed?
Date: Wed, 27 Dec 2000 02:54:08 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="iso-8859-1"
Cc: "Rik Faith" <faith@valinux.com>,
        "Dri-devel" <Dri-devel@lists.sourceforge.net>
MIME-Version: 1.0
Message-Id: <00122702540800.15395@SunWave1>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello to all of you,

I got this since test13-pre1 (pre4, now):

SunWave1>depmod -e
depmod: *** Unresolved symbols in 
/lib/modules/2.4.0-test13-pre4/kernel/drivers/char/drm/tdfx.o
depmod:         remap_page_range
depmod:         _mmx_memcpy
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
depmod:         irq_stat
depmod:         __generic_copy_to_user

Something missing in the 'new' drm/Makefile?

Thanks,
	Dieter
-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
Cognitive Systems Group
Vogt-Kölln-Straße 30
D-22527 Hamburg, Germany

email: nuetzel@kogs.informatik.uni-hamburg.de
@home: Dieter.Nuetzel@hamburg.de
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
