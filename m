Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264984AbSL0PI1>; Fri, 27 Dec 2002 10:08:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264992AbSL0PI0>; Fri, 27 Dec 2002 10:08:26 -0500
Received: from lennier.cc.vt.edu ([198.82.162.213]:29188 "EHLO
	lennier.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S264984AbSL0PIU> convert rfc822-to-8bit; Fri, 27 Dec 2002 10:08:20 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Brad Tilley <rtilley@vt.edu>
Reply-To: rtilley@vt.edu
Organization: Virginia Tech
To: linux-kernel@vger.kernel.org
Subject: 2.5.53 make modules_install problem
Date: Fri, 27 Dec 2002 09:58:43 -0500
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200212270958.43939.rtilley@vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've finally got a config file that actually builds with the beta kernels, but 
when it gets to 'make modules_install' I get these error after it runs for a 
few minutes:

--------------------------

depmod: *** Unresolved symbols in 
/lib/modules/2.5.53/kernel/net/bridge/bridge.ko
depmod:         nf_unregister_hook
depmod:         _mmx_memcpy
depmod:         eth_type_trans
depmod:         __kfree_skb
depmod:         br_ioctl_hook
depmod:         alloc_skb
depmod:         __pskb_pull_tail
depmod:         ether_setup
depmod:         nf_hooks
depmod:         skb_under_panic
depmod:         dev_set_promiscuity
depmod:         kmalloc
depmod:         unregister_netdevice_notifier
depmod:         __up_wakeup
depmod:         ip_route_output_key
depmod:         netdev_finish_unregister
depmod:         unregister_netdev
depmod:         ip_route_input
depmod:         copy_to_user
depmod:         del_timer
depmod:         register_netdev
depmod:         dev_queue_xmit
depmod:         kfree
depmod:         ___pskb_trim
depmod:         nf_register_hook
depmod:         netif_rx
depmod:         skb_over_panic
depmod:         br_handle_frame_hook
depmod:         skb_clone
depmod:         register_netdevice_notifier
depmod:         copy_from_user
depmod:         jiffies
depmod:         dev_get_by_index
depmod:         printk
depmod:         add_timer
depmod:         irq_stat
depmod:         do_softirq
depmod:         nf_hook_slow
depmod:         __down_failed
depmod:         __dev_get_by_name
depmod: *** Unresolved symbols in 
/lib/modules/2.5.53/kernel/net/decnet/decnet.ko
depmod:         rtnetlink_links
depmod:         neigh_create
depmod:         send_sig
depmod:         sock_wfree
depmod:         __down_failed_trylock
depmod:         _mmx_memcpy
depmod:         dev_load
depmod:         sk_run_filter
depmod:         __get_user_2
depmod:         __get_user_4
depmod:         schedule_timeout
depmod:         __wake_up
depmod:         __kfree_skb
depmod:         alloc_skb
depmod:         sock_no_socketpair
depmod:         schedule
depmod:         nf_hooks
depmod:         skb_under_panic
depmod:         kmalloc
depmod:         skb_realloc_headroom
depmod:         register_gifconf
depmod:         unregister_netdevice_notifier
depmod:         __up_wakeup
depmod:         __rta_fill
depmod:         create_proc_entry
depmod:         add_wait_queue_exclusive
depmod:         rtnl_sem
depmod:         dev_mc_delete
depmod:         sock_unregister
depmod:         __get_free_pages
depmod:         netdev_finish_unregister
depmod:         neigh_table_clear
depmod:         default_wake_function
depmod:         __lock_sock
depmod:         neigh_destroy
depmod:         memcpy_toiovec
depmod:         remove_wait_queue
depmod:         sk_alloc
depmod:         neigh_parms_alloc
depmod:         __dst_free
depmod:         sysctl_intvec
depmod:         skb_copy
depmod:         panic
depmod:         copy_to_user
depmod:         __release_sock
depmod:         sysctl_string
depmod:         proc_dostring
depmod:         __kill_fasync
depmod:         netlink_set_err
depmod:         neigh_parms_release
depmod:         dev_remove_pack
depmod:         kmem_cache_create
depmod:         nf_setsockopt
depmod:         netlink_broadcast
depmod:         proc_dointvec
depmod:         unregister_sysctl_table
depmod:         del_timer
depmod:         net_ratelimit
depmod:         sk_free
depmod:         dev_mc_upload
depmod:         mod_timer
depmod:         dev_queue_xmit
depmod:         dst_alloc
depmod:         nf_getsockopt
depmod:         datagram_poll
depmod:         kfree
depmod:         ___pskb_trim
depmod:         dev_get_by_name
depmod:         remove_proc_entry
depmod:         __dev_get_by_index
depmod:         dev_base
depmod:         sock_no_sendpage
depmod:         skb_over_panic
depmod:         netlink_unicast
depmod:         add_wait_queue
depmod:         proc_net
depmod:         skb_clone
depmod:         memcpy_fromiovec
depmod:         rtnl_unlock
depmod:         sprintf
depmod:         kmem_cache_destroy
depmod:         rtnl
depmod:         dev_add_pack
depmod:         register_netdevice_notifier
depmod:         copy_from_user
depmod:         jiffies
depmod:         num_physpages
depmod:         dev_get_by_index
depmod:         rtnl_lock
depmod:         proc_dointvec_minmax
depmod:         printk
depmod:         add_timer
depmod:         irq_stat
depmod:         sock_register
depmod:         neigh_table_init
depmod:         dev_mc_add
depmod:         dev_ioctl
depmod:         register_sysctl_table
depmod:         do_softirq
depmod:         nf_hook_slow
depmod:         neigh_lookup
depmod:         sock_no_mmap
depmod:         dst_destroy
depmod:         neigh_ifdown
depmod:         sock_init_data
depmod:         sock_rfree
depmod:         loopback_dev
depmod:         __dev_get_by_name
depmod: *** Unresolved symbols in 
/lib/modules/2.5.53/kernel/sound/soundcore.ko
depmod:         kmalloc
depmod:         unregister_chrdev
depmod:         register_chrdev
depmod:         vfree
depmod:         sys_close
depmod:         request_module
depmod:         kfree
depmod:         vmalloc
depmod:         sprintf
depmod:         printk
make: *** [_modinst_post] Error 1

--------------------------------

What must I do to fix this? Please CC me as I'm not on the list.

Thanks,
Brad



