Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279788AbRK0OIU>; Tue, 27 Nov 2001 09:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279790AbRK0OIK>; Tue, 27 Nov 2001 09:08:10 -0500
Received: from c842c.nat.may.ka0.zugschlus.de ([212.126.200.66]:26130 "EHLO
	torres.ka0.zugschlus.de") by vger.kernel.org with ESMTP
	id <S279788AbRK0OIC>; Tue, 27 Nov 2001 09:08:02 -0500
Date: Tue, 27 Nov 2001 15:08:01 +0100
From: Marc Haber <mh+linux-kernel@zugschlus.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.16, 8139too not loadable as a module - unresolved symbols
Message-ID: <20011127150800.A25438@torres.ka0.zugschlus.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

on my only 2.4.16 system, modprobe 8139too gives the following errors:
/lib/modules/2.4.16/kernel/drivers/net/8139too.o: unresolved symbol flush_signals
/lib/modules/2.4.16/kernel/drivers/net/8139too.o: unresolved symbol eth_type_trans
/lib/modules/2.4.16/kernel/drivers/net/8139too.o: unresolved symbol __kfree_skb
/lib/modules/2.4.16/kernel/drivers/net/8139too.o: unresolved symbol alloc_skb
/lib/modules/2.4.16/kernel/drivers/net/8139too.o: unresolved symbol pci_register_driver
/lib/modules/2.4.16/kernel/drivers/net/8139too.o: unresolved symbol pci_free_consistent
/lib/modules/2.4.16/kernel/drivers/net/8139too.o: unresolved symbol pci_enable_device
/lib/modules/2.4.16/kernel/drivers/net/8139too.o: unresolved symbol pci_read_config_byte
/lib/modules/2.4.16/kernel/drivers/net/8139too.o: unresolved symbol alloc_etherdev
/lib/modules/2.4.16/kernel/drivers/net/8139too.o: unresolved symbol reparent_to_init
/lib/modules/2.4.16/kernel/drivers/net/8139too.o: unresolved symbol cpu_raise_softirq
/lib/modules/2.4.16/kernel/drivers/net/8139too.o: unresolved symbol free_irq
/lib/modules/2.4.16/kernel/drivers/net/8139too.o: unresolved symbol unregister_netdev
/lib/modules/2.4.16/kernel/drivers/net/8139too.o: unresolved symbol kill_proc
/lib/modules/2.4.16/kernel/drivers/net/8139too.o: unresolved symbol iounmap
/lib/modules/2.4.16/kernel/drivers/net/8139too.o: unresolved symbol pci_alloc_consistent
/lib/modules/2.4.16/kernel/drivers/net/8139too.o: unresolved symbol interruptible_sleep_on_timeout
/lib/modules/2.4.16/kernel/drivers/net/8139too.o: unresolved symbol __ioremap
/lib/modules/2.4.16/kernel/drivers/net/8139too.o: unresolved symbol pci_read_config_word
/lib/modules/2.4.16/kernel/drivers/net/8139too.o: unresolved symbol skb_copy_and_csum_dev
/lib/modules/2.4.16/kernel/drivers/net/8139too.o: unresolved symbol register_netdev
/lib/modules/2.4.16/kernel/drivers/net/8139too.o: unresolved symbol kfree
/lib/modules/2.4.16/kernel/drivers/net/8139too.o: unresolved symbol pci_release_regions
/lib/modules/2.4.16/kernel/drivers/net/8139too.o: unresolved symbol wait_for_completion
/lib/modules/2.4.16/kernel/drivers/net/8139too.o: unresolved symbol request_irq
/lib/modules/2.4.16/kernel/drivers/net/8139too.o: unresolved symbol netif_rx
/lib/modules/2.4.16/kernel/drivers/net/8139too.o: unresolved symbol pci_unregister_driver
/lib/modules/2.4.16/kernel/drivers/net/8139too.o: unresolved symbol skb_over_panic
/lib/modules/2.4.16/kernel/drivers/net/8139too.o: unresolved symbol pci_set_master
/lib/modules/2.4.16/kernel/drivers/net/8139too.o: unresolved symbol rtnl_unlock
/lib/modules/2.4.16/kernel/drivers/net/8139too.o: unresolved symbol pci_write_config_word
/lib/modules/2.4.16/kernel/drivers/net/8139too.o: unresolved symbol daemonize
/lib/modules/2.4.16/kernel/drivers/net/8139too.o: unresolved symbol jiffies
/lib/modules/2.4.16/kernel/drivers/net/8139too.o: unresolved symbol softnet_data
/lib/modules/2.4.16/kernel/drivers/net/8139too.o: unresolved symbol rtnl_lock
/lib/modules/2.4.16/kernel/drivers/net/8139too.o: unresolved symbol printk
/lib/modules/2.4.16/kernel/drivers/net/8139too.o: unresolved symbol complete_and_exit
/lib/modules/2.4.16/kernel/drivers/net/8139too.o: unresolved symbol kernel_thread
/lib/modules/2.4.16/kernel/drivers/net/8139too.o: unresolved symbol __const_udelay
/lib/modules/2.4.16/kernel/drivers/net/8139too.o: unresolved symbol pci_request_regions
/lib/modules/2.4.16/kernel/drivers/net/8139too.o: insmod /lib/modules/2.4.16/kernel/drivers/net/8139too.o failed
/lib/modules/2.4.16/kernel/drivers/net/8139too.o: insmod 8139too failed

The same kernel, with the only config change being "y" instead of "m"
for 8139too, works fine, and the network interface is useable.

Did I do something wrong?

Greetings
Marc

-- 
-----------------------------------------------------------------------------
Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
Karlsruhe, Germany |  lose things."    Winona Ryder | Fon: *49 721 966 32 15
Nordisch by Nature |  How to make an American Quilt | Fax: *49 721 966 31 29
