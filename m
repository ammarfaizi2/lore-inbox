Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262388AbUDKQGW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Apr 2004 12:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262399AbUDKQGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Apr 2004 12:06:21 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:46604 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262388AbUDKQGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Apr 2004 12:06:00 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: List of oversized inlines
Date: Sun, 11 Apr 2004 19:05:49 +0300
User-Agent: KMail/1.5.4
Cc: Matt Mackall <mpm@selenic.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404111905.49443.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Below you may find a list of inlines which have multiple callers
and which compile to more than 39 bytes.

Size was measured by compiling functions
	void measure_foo(void) { foo(0,0,0); }
and obtaining their sizes.

I am sure there are few false positives anf some inlines managed
to slip through, but this is a good start.

Tool used to obtain this list will be published when
I will polish it a bit.

Thanks to Matt Mackall <mpm@selenic.com> for his -tiny tree
and inspiration.
--
vda

size  callers name
======== ==== ==============
     628    2 ahc_queue_scb
     517    2 ahd_queue_scb
     488    2 ahc_intr
     428    2 ahd_intr
     297    2 __tcp_push_pending_frames
     290    4 ahd_unpause
     289    4 ahd_unpause
     288    4 ahd_unpause
     257    3 sock_queue_rcv_skb
     198    4 tcp_done
     194    2 wait_for_ctrl_irq
     193    2 wait_for_ctrl_irq
     186    2 vlan_hwaccel_rx
     159    2 ahd_outl
     159    2 ahc_outl
     158    2 ahd_outl
     158    2 ahc_outl
     156    2 ahd_inw_scbram
     151   43 put_page
     150    3 ahc_pause
     149    3 ahc_pause
     141    3 tcp_enter_cwr
     141    2 ahd_inl
     141    2 ahc_inl
     140    2 ahc_inl
     139    2 ahd_inl
     134    2 tcp_writequeue_purge
     120   14 dev_kfree_skb_any
     112    8 skb_queue_purge
     112   11 __nlmsg_put
     111   11 __nlmsg_put
     109    2 netif_rx_schedule
     107    5 netif_device_attach
     104    5 __skb_queue_purge
      99    4 ahd_save_modes
      99    4 ahc_unpause
      98    4 ahd_save_modes
      97    2 fat_get_entry
      93    6 sk_del_node_init
      93    2 scm_send
      93    2 scm_recv
      93    3 nfs_list_remove_request
      93    3 ahd_set_scbptr
      88    2 ahd_pause
      88    2 ahd_get_scbptr
      87    2 ahd_pause
      86   14 seq_puts
      86    4 __netif_rx_schedule
      85    2 tcp_fast_path_check
      84    2 tcp_fast_path_check
      84    6 blkdev_dequeue_request
      83    2 load_LDT
      83    6 blkdev_dequeue_request
      82    3 inet_putpeer
      81    2 xfrm_sk_free_policy
      81    2 nfs_unlock_request
      80    2 tcp_synq_drop
      80    4 ahd_set_modes
      79    4 rpc_call
      79    2 next_unix_socket
      79    4 ahd_set_modes
      79    3 ahd_restore_modes
      78    2 tlb_finish_mmu
      78  108 copy_from_user
      76    2 ahd_inb_scbram
      75    2 skb_cow
      74    3 tcp_initialize_rcv_mss
      74    2 tcp_acceptq_queue
      73    2 netif_rx_complete
      72   51 netif_wake_queue
      70    2 ahc_inw
      69    2 tcp_sync_left_out
      69    2 ___add_to_page_cache
      68    3 __netif_rx_complete
      67    2 netif_schedule
      67    6 le_ih_k_type
      67    3 cpu_key_k_type
      66    2 tcp_may_send_now
      66    6 sk_dst_reset
      66    2 __sk_dst_set
      66    2 __sk_dst_reset
      65    2 tcp_prequeue_init
      65    4 set_le_ih_k_offset
      65  109 copy_to_user
      65  108 copy_from_user
      63   18 skb_trim
      63    6 skb_dequeue
      62   18 skb_trim
      61   18 skb_trim
      61    4 pskb_trim
      61    3 load_esp0
      61    2 elf_core_copy_regs
      61    4 clear_highpage
      60   72 skb_put
      59   72 skb_put
      58    5 sock_recv_timestamp
      58    7 __skb_dequeue
      58    2 __alloc_percpu
      57    5 skb_share_check
      57   10 le_key_k_type
      57   14 iget
      57   33 dev_kfree_skb_irq
      56    3 tcp_set_state
      56    2 tcp_current_mss
      56    3 jiffies_to_timeval
      56    2 csum_and_copy_from_user
      56    2 crypto_yield
      55    2 get_expiry
      55    2 crypto_yield
      54    4 fib_res_put
      54    2 __sk_dst_check
      53    3 xdr_decode_hyper
      53    2 tcp_v4_setup_caps
      53    2 sock_graft
      53    3 save_init_fpu
      53   11 list_move
      52    6 sock_orphan
      52    2 skb_queue_head
      52    6 sk_add_node
      52    7 d_drop
      52    4 cache_put
      52    2 __skb_trim
      52    2 __pskb_trim
      52    5 __d_drop
      51    2 tty_insert_flip_char
      51    3 skb_queue_tail
      51    4 nfs_revalidate_inode
      51    6 __skb_unlink
      51    2 __skb_dequeue_tail
      50    8 sema_init
      50   16 netif_carrier_on
      50    8 ip_fast_csum
      50    6 init_MUTEX_LOCKED
      50   23 init_MUTEX
      50    3 dst_free
      49    2 hlist_del_init
      48    2 sk_filter_release
      48    2 ahc_get_scb
      48    2 add_page_to_active_list
      47    7 map_bh
      47    4 ahc_is_paused
      47    3 ahc_flush_device_writes
      47    4 __skb_queue_head
      47    5 __ext3_journal_get_write_access
      46    5 xfrm4_policy_check
      46    7 set_cpu_key_k_offset
      46    3 ip_select_ident
      46   12 down_interruptible
      46   18 cond_resched
      46    4 ahc_is_paused
      46    3 ahc_flush_device_writes
      46   11 __skb_queue_tail
      46    2 __skb_append
      45    5 xfrm4_policy_check
      45    2 tlb_gather_mmu
      45    4 rb_link_node
      45    2 locks_verify_locked
      45   12 lock_buffer
      45   13 list_splice_init
      45    2 init_sigpending
      45    2 ide_init_hwif_ports
      45    2 hlist_del
      45    2 exit_namespace
      45   35 down_write
      44    6 lock_super
      44    2 first_unix_socket
      44    2 __ext3_journal_get_create_access
      44    5 __ext3_journal_dirty_metadata
      43    3 skb_orphan
      43    3 sk_wake_async
      43    2 crypto_digest_update
      43    2 add_page_to_inactive_list
      42    4 skb_set_owner_w
      42    8 list_move_tail
      42   12 down_interruptible
      42    2 __add_wait_queue
      41   52 list_del_init
      41   83 list_del
      41    6 hlist_add_head
      41   35 down_write
      41  110 down
      41    4 ahd_is_paused
      41    2 __remove_wait_queue
      41    2 __neigh_lookup_errno
      41    2 __add_wait_queue_tail
      40   10 skb_push
      40   12 set_page_dirty
      40   10 init_completion
      40    3 crypto_digest_final
      40    3 ahd_outb
      40    4 ahd_is_paused

