Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbUDPTbz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 15:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263612AbUDPTbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 15:31:55 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:31242 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261262AbUDPTay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 15:30:54 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Subject: inline_hunter 0.2 and it's results
Date: Fri, 16 Apr 2004 22:30:40 +0300
User-Agent: KMail/1.5.4
Cc: Matt Mackall <mpm@selenic.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_gRDgAxGcFkLWzch"
Message-Id: <200404162230.40530.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_gRDgAxGcFkLWzch
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This is next version of 'inline hunter', a tool designed to find
inlines which are large. It has bug fixes and improvements suggested
by readers of lkml. Tarball and results are below sig.

Matt, you may simply replace earlier version with this one.
--
vda

Size  Uses Wasted Name and definition
===== ==== ====== ================================================
   56  461  16560 copy_from_user	include/asm/uaccess.h
  122  119  12036 skb_dequeue	include/linux/skbuff.h
  164   78  11088 skb_queue_purge	include/linux/skbuff.h
   97  141  10780 netif_wake_queue	include/linux/netdevice.h
   43  468  10741 copy_to_user	include/asm/uaccess.h
   43  461  10580 copy_from_user	include/asm/uaccess.h
  145   77   9500 put_page	include/linux/mm.h
   49  313   9048 skb_put	include/linux/skbuff.h
  109  101   8900 skb_queue_tail	include/linux/skbuff.h
  381   21   7220 sock_queue_rcv_skb	include/net/sock.h
   55  191   6650 init_MUTEX	include/asm/semaphore.h
   61  163   6642 unlock_kernel	include/linux/smp_lock.h
   59  165   6396 lock_kernel	include/linux/smp_lock.h
  127   59   6206 dev_kfree_skb_any	include/linux/netdevice.h
   41  289   6048 list_del	include/linux/list.h
 2892    3   5744 do_read_onechip	drivers/mtd/chips/cfi_cmdset_0020.c drivers/mtd/chips/cfi_cmdset_0002.c drivers/mtd/chips/cfi_cmdset_0001.c
 4852    2   4832 do_write_buffer	drivers/mtd/chips/cfi_cmdset_0020.c drivers/mtd/chips/cfi_cmdset_0001.c
 4832    2   4812 do_write_buffer	drivers/mtd/chips/cfi_cmdset_0020.c drivers/mtd/chips/cfi_cmdset_0001.c
   73   83   4346 dev_kfree_skb_irq	include/linux/netdevice.h
  131   39   4218 netif_device_attach	include/linux/netdevice.h
 3994    2   3974 do_erase_oneblock	drivers/mtd/chips/cfi_cmdset_0020.c drivers/mtd/chips/cfi_cmdset_0002.c
  110   44   3870 skb_queue_head	include/linux/skbuff.h
   84   59   3712 seq_puts	include/linux/seq_file.h
 3721    2   3701 do_erase_oneblock	drivers/mtd/chips/cfi_cmdset_0020.c drivers/mtd/chips/cfi_cmdset_0002.c
   57   75   2738 skb_trim	include/linux/skbuff.h
   45   96   2375 skb_queue_head_init	include/linux/skbuff.h
   41  111   2310 list_del_init	include/linux/list.h
 1074    3   2108 line_info	drivers/char/synclinkmp.c drivers/char/synclink.c drivers/char/pcmcia/synclink_cs.c
  102   23   1804 __nlmsg_put	include/linux/netlink.h
  870    3   1700 check_entry	net/ipv6/netfilter/ip6_tables.c net/ipv4/netfilter/ip_tables.c net/ipv4/netfilter/arp_tables.c
  850    3   1660 check_entry	net/ipv6/netfilter/ip6_tables.c net/ipv4/netfilter/ip_tables.c net/ipv4/netfilter/arp_tables.c
  212    9   1536 hci_recv_frame	include/net/bluetooth/hci_core.h
  762    3   1484 line_info	drivers/char/synclinkmp.c drivers/char/synclink.c drivers/char/pcmcia/synclink_cs.c
  738    3   1436 line_info	drivers/char/synclinkmp.c drivers/char/synclink.c drivers/char/pcmcia/synclink_cs.c
  101   18   1377 sock_orphan	include/net/sock.h
  115   14   1235 d_drop	include/linux/dcache.h
   90   18   1190 sk_del_node_init	include/net/sock.h
   55   35   1190 sema_init	include/asm/semaphore.h
   47   45   1188 iget	include/linux/fs.h
 1199    2   1179 ser12_rx	drivers/net/hamradio/baycom_ser_hdx.c drivers/net/hamradio/baycom_ser_fdx.c
   60   28   1080 writereg	drivers/isdn/hisax/teles3.c drivers/isdn/hisax/sedlbauer.c drivers/isdn/hisax/saphir.c drivers/isdn/hisax/s0box.c drivers/isdn/hisax/niccy.c drivers/isdn/hisax/mic.c drivers/isdn/hisax/ix1_micro.c drivers/isdn/hisax/elsa.c drivers/isdn/hisax/diva.c drivers/isdn/hisax/bkm_a8.c drivers/isdn/hisax/bkm_a4t.c drivers/isdn/hisax/avm_a1.c drivers/isdn/hisax/asuscom.c drivers/isdn/hisax/teleint.c drivers/isdn/hisax/gazel.c
   46   41   1040 netif_device_detach	include/linux/netdevice.h
 1043    2   1023 wv_mmc_init	drivers/net/wireless/wavelan_cs.c drivers/net/wireless/wavelan.c
 1038    2   1018 wv_mmc_init	drivers/net/wireless/wavelan_cs.c drivers/net/wireless/wavelan.c
   55   30   1015 init_MUTEX_LOCKED	include/asm/semaphore.h
   45   41   1000 init_completion	include/linux/completion.h
   56   28    972 readreg	drivers/isdn/hisax/teles3.c drivers/isdn/hisax/sedlbauer.c drivers/isdn/hisax/saphir.c drivers/isdn/hisax/s0box.c drivers/isdn/hisax/niccy.c drivers/isdn/hisax/mic.c drivers/isdn/hisax/ix1_micro.c drivers/isdn/hisax/elsa.c drivers/isdn/hisax/diva.c drivers/isdn/hisax/bkm_a8.c drivers/isdn/hisax/bkm_a4t.c drivers/isdn/hisax/avm_a1.c drivers/isdn/hisax/asuscom.c drivers/isdn/hisax/teleint.c drivers/isdn/hisax/gazel.c
  990    2    970 wv_set_frequency	drivers/net/wireless/wavelan_cs.c drivers/net/wireless/wavelan.c
  982    2    962 wv_set_frequency	drivers/net/wireless/wavelan_cs.c drivers/net/wireless/wavelan.c
  150    8    910 sk_dst_reset	include/net/sock.h
  132    9    896 skb_unlink	include/linux/skbuff.h
  305    4    855 ahd_unpause	drivers/scsi/aic7xxx/aic79xx_inline.h
  443    3    846 do_read_onechip	drivers/mtd/chips/cfi_cmdset_0020.c drivers/mtd/chips/cfi_cmdset_0002.c drivers/mtd/chips/cfi_cmdset_0001.c
  441    3    842 get_block	fs/minix/itree_common.c
  299    4    837 fh_unlock	include/linux/nfsd/nfsfh.h
  295    4    825 fh_unlock	include/linux/nfsd/nfsfh.h
  183    6    815 vlan_hwaccel_receive_skb	include/linux/if_vlan.h
  426    3    812 get_block	fs/minix/itree_common.c
   49   28    783 writereg	drivers/isdn/hisax/teles3.c drivers/isdn/hisax/sedlbauer.c drivers/isdn/hisax/saphir.c drivers/isdn/hisax/s0box.c drivers/isdn/hisax/niccy.c drivers/isdn/hisax/mic.c drivers/isdn/hisax/ix1_micro.c drivers/isdn/hisax/elsa.c drivers/isdn/hisax/diva.c drivers/isdn/hisax/bkm_a8.c drivers/isdn/hisax/bkm_a4t.c drivers/isdn/hisax/avm_a1.c drivers/isdn/hisax/asuscom.c drivers/isdn/hisax/teleint.c drivers/isdn/hisax/gazel.c
   49   28    783 readreg	drivers/isdn/hisax/teles3.c drivers/isdn/hisax/sedlbauer.c drivers/isdn/hisax/saphir.c drivers/isdn/hisax/s0box.c drivers/isdn/hisax/niccy.c drivers/isdn/hisax/mic.c drivers/isdn/hisax/ix1_micro.c drivers/isdn/hisax/elsa.c drivers/isdn/hisax/diva.c drivers/isdn/hisax/bkm_a8.c drivers/isdn/hisax/bkm_a4t.c drivers/isdn/hisax/avm_a1.c drivers/isdn/hisax/asuscom.c drivers/isdn/hisax/teleint.c drivers/isdn/hisax/gazel.c
  208    5    752 wait_for_ctrl_irq	drivers/pci/hotplug/pciehp.h drivers/pci/hotplug/cpqphp.h drivers/pci/hotplug/shpchp.h
  103   10    747 __skb_queue_purge	include/linux/skbuff.h
  166    6    730 stop_adc	sound/oss/sonicvibes.c sound/oss/maestro.c sound/oss/esssolo1.c sound/oss/es1371.c sound/oss/es1370.c sound/oss/cmpci.c
   58   20    722 __skb_dequeue	include/linux/skbuff.h
   44   31    720 skb_set_owner_w	include/net/sock.h
   44   31    720 netif_carrier_on	include/linux/netdevice.h
  158    6    690 stop_adc	sound/oss/sonicvibes.c sound/oss/maestro.c sound/oss/esssolo1.c sound/oss/es1371.c sound/oss/es1370.c sound/oss/cmpci.c
  363    3    686 check_entry	net/ipv6/netfilter/ip6_tables.c net/ipv4/netfilter/ip_tables.c net/ipv4/netfilter/arp_tables.c
  189    5    676 wait_for_ctrl_irq	drivers/pci/hotplug/pciehp.h drivers/pci/hotplug/cpqphp.h drivers/pci/hotplug/shpchp.h
  242    4    666 _radeon_engine_idle	drivers/video/aty/radeonfb.h drivers/video/radeonfb.c
   75   13    660 blkdev_dequeue_request	include/linux/blkdev.h
  347    3    654 stop_dac	sound/oss/sonicvibes.c sound/oss/esssolo1.c sound/oss/cmpci.c
   51   22    651 tty_insert_flip_char	include/linux/tty_flip.h
   46   26    650 __skb_queue_tail	include/linux/skbuff.h
  100    9    640 sch_tree_lock	include/net/pkt_sched.h
  179    5    636 tcp_done	include/net/tcp.h
  650    2    630 ip_vs_control_add	include/net/ip_vs.h
   53   20    627 list_move	include/linux/list.h
   96    9    608 list_inlist	include/linux/netfilter_ipv4/listhelp.h
  141    6    605 clear_advance	sound/oss/sonicvibes.c sound/oss/maestro.c sound/oss/esssolo1.c sound/oss/es1371.c sound/oss/es1370.c sound/oss/cmpci.c
   80   11    600 kmem_zone_zalloc	fs/xfs/linux/kmem.h
  619    2    599 wv_packet_write	drivers/net/wireless/wavelan_cs.c drivers/net/wireless/wavelan.c
   51   20    589 skb_share_check	include/linux/skbuff.h
  213    4    579 list_named_insert	include/linux/netfilter_ipv4/listhelp.h
   92    9    576 tcf_destroy	include/net/pkt_cls.h
   47   22    567 wait_ms	include/linux/usb.h include/linux/gameport.h drivers/video/aty/radeonfb.h drivers/media/video/meye.c
  584    2    564 wv_packet_read	drivers/net/wireless/wavelan_cs.c drivers/net/wireless/wavelan.c
   53   18    561 sk_add_node	include/net/sock.h
   48   21    560 map_bh	include/linux/buffer_head.h
  112    7    552 __netif_rx_schedule	include/linux/netdevice.h
   46   22    546 wait_ms	include/linux/usb.h include/linux/gameport.h drivers/video/aty/radeonfb.h drivers/media/video/meye.c
  553    2    533 wv_packet_read	drivers/net/wireless/wavelan_cs.c drivers/net/wireless/wavelan.c
  284    3    528 prog_dmabuf_adc	sound/oss/esssolo1.c sound/oss/es1371.c sound/oss/es1370.c
   86    9    528 list_prepend	include/linux/netfilter_ipv4/listhelp.h
   45   22    525 init_rwsem	include/asm/rwsem.h
   85    9    520 list_prepend	include/linux/netfilter_ipv4/listhelp.h
  539    2    519 ahc_queue_scb	drivers/scsi/aic7xxx/aic7xxx_inline.h
  123    6    515 DQUOT_ALLOC_SPACE	include/linux/quotaops.h
   66   12    506 in_dev_get	include/linux/inetdevice.h
  524    2    504 complete_command	drivers/block/cpqarray.c drivers/block/cciss.c
   62   13    504 parent_ino	include/linux/fs.h
  187    4    501 find_inlist_lock_noload	net/ipv6/netfilter/ip6_tables.c net/ipv4/netfilter/ip_tables.c net/ipv4/netfilter/arp_tables.c net/bridge/netfilter/ebtables.c
  516    2    496 ahd_queue_scb	drivers/scsi/aic7xxx/aic79xx_inline.h
   82    9    496 list_inlist	include/linux/netfilter_ipv4/listhelp.h
  266    3    492 do_read_onechip	drivers/mtd/chips/cfi_cmdset_0020.c drivers/mtd/chips/cfi_cmdset_0002.c drivers/mtd/chips/cfi_cmdset_0001.c
   68   11    480 kmem_zalloc	fs/xfs/linux/kmem.h
  491    2    471 wv_init_info	drivers/net/wireless/wavelan_cs.c drivers/net/wireless/wavelan.c
  114    6    470 DQUOT_FREE_SPACE	include/linux/quotaops.h
   51   16    465 __skb_unlink	include/linux/skbuff.h
  471    2    451 ser12_rx	drivers/net/hamradio/baycom_ser_hdx.c drivers/net/hamradio/baycom_ser_fdx.c
   95    7    450 dget_parent	include/linux/dcache.h
   76    9    448 sch_tree_unlock	include/net/pkt_sched.h
  456    2    436 truncate	fs/minix/itree_common.c
   68   10    432 skb_cow	include/linux/skbuff.h
  449    2    429 truncate	fs/minix/itree_common.c
  104    6    420 stop_adc	sound/oss/sonicvibes.c sound/oss/maestro.c sound/oss/esssolo1.c sound/oss/es1371.c sound/oss/es1370.c sound/oss/cmpci.c
  122    5    408 _INPLL	drivers/video/aty/radeonfb.h drivers/video/radeonfb.c
  222    3    404 cleanup_entry	net/ipv6/netfilter/ip6_tables.c net/ipv4/netfilter/ip_tables.c net/ipv4/netfilter/arp_tables.c
  221    3    402 cleanup_entry	net/ipv6/netfilter/ip6_tables.c net/ipv4/netfilter/ip_tables.c net/ipv4/netfilter/arp_tables.c
   45   17    400 list_splice_init	include/linux/list.h
  219    3    398 isdn_net_get_locked_lp	drivers/isdn/i4l/isdn_net.h
   98    6    390 stop_adc	sound/oss/sonicvibes.c sound/oss/maestro.c sound/oss/esssolo1.c sound/oss/es1371.c sound/oss/es1370.c sound/oss/cmpci.c
  402    2    382 ahc_intr	drivers/scsi/aic7xxx/aic7xxx_inline.h
   83    7    378 netif_schedule	include/linux/netdevice.h
  114    5    376 skb_append	include/linux/skbuff.h
   42   18    374 claim_dma_lock	include/asm/dma.h
   61   10    369 sock_recv_timestamp	include/net/sock.h
  388    2    368 wv_init_info	drivers/net/wireless/wavelan_cs.c drivers/net/wireless/wavelan.c
   44   16    360 usb_serial_debug_data	drivers/usb/serial/usb-serial.h
   41   18    357 snd_mask_min	include/sound/pcm_params.h
   91    6    355 stop_adc	sound/oss/sonicvibes.c sound/oss/maestro.c sound/oss/esssolo1.c sound/oss/es1371.c sound/oss/es1370.c sound/oss/cmpci.c
   42   17    352 lock_buffer	include/linux/buffer_head.h
  195    3    350 hdlcdrv_getbits	include/linux/hdlcdrv.h
   55   11    350 le_key_k_type	include/linux/reiserfs_fs.h
  136    4    348 netif_rx_schedule	include/linux/netdevice.h
  190    3    340 ntfs_map_page	fs/ntfs/ntfs.h
  132    4    336 ahd_set_modes	drivers/scsi/aic7xxx/aic79xx_inline.h
  355    2    335 push_ctxt	fs/intermezzo/intermezzo_fs.h
   87    6    335 clear_advance	sound/oss/sonicvibes.c sound/oss/maestro.c sound/oss/esssolo1.c sound/oss/es1371.c sound/oss/es1370.c sound/oss/cmpci.c
  186    3    332 NCR5380_pread	drivers/scsi/t128.c drivers/scsi/pas16.c drivers/scsi/dtc.c
   50   12    330 ip_fast_csum	include/asm/checksum.h
  183    3    326 ip6_dst_store	include/net/ip6_route.h
  342    2    322 ahd_intr	drivers/scsi/aic7xxx/aic79xx_inline.h
   55   10    315 sock_i_ino	include/net/sock.h
  177    3    314 cls_set_class	include/net/pkt_sched.h
   72    7    312 netif_rx_complete	include/linux/netdevice.h
   59    9    312 pskb_trim	include/linux/skbuff.h
  330    2    310 ipq_rcv_skb	net/ipv6/netfilter/ip6_queue.c net/ipv4/netfilter/ip_queue.c
  329    2    309 init_rx_bufs	drivers/net/lp486e.c drivers/net/82596.c
  123    4    309 ahd_save_modes	drivers/scsi/aic7xxx/aic79xx_inline.h
  123    4    309 __stop_dac	sound/oss/trident.c sound/oss/i810_audio.c sound/oss/cs46xx.c sound/oss/ali5455.c
   97    5    308 hci_dev_put	include/net/bluetooth/hci_core.h
   42   15    308 list_move_tail	include/linux/list.h
  325    2    305 snd_intel8x0_update	sound/pci/intel8x0m.c sound/pci/intel8x0.c
  121    4    303 _sv_wait	fs/xfs/linux/sv.h
  321    2    301 xdr_encode_sattr	fs/nfs/nfs3xdr.c fs/nfs/nfs2xdr.c
  321    2    301 tcp_prequeue	include/net/tcp.h
  321    2    301 init_stripe	drivers/md/raid6main.c drivers/md/raid5.c
  313    2    293 vlan_put_tag	include/linux/if_vlan.h
  311    2    291 hdlc_empty_fifo	drivers/isdn/hisax/hisax_fcpcipnp.c drivers/isdn/hisax/avm_pci.c
  310    2    290 complete_command	drivers/block/cpqarray.c drivers/block/cciss.c
  165    3    290 NCR5380_pwrite	drivers/scsi/t128.c drivers/scsi/pas16.c drivers/scsi/dtc.c
  302    2    282 splice_branch	fs/sysv/itree.c fs/minix/itree_common.c
  160    3    280 dealloc_dmabuf	sound/oss/esssolo1.c sound/oss/es1371.c sound/oss/es1370.c
   76    6    280 get_task_mm	include/linux/sched.h
   55    9    280 sock_i_uid	include/net/sock.h
  159    3    278 switch_mm	include/asm/mmu_context.h
   66    7    276 in6_dev_get	include/net/addrconf.h
  156    3    272 show_version	drivers/net/wan/pc300_drv.c drivers/atm/horizon.c drivers/atm/ambassador.c
   54    9    272 on_each_cpu	include/linux/smp.h
   65    7    270 tulip_restart_rxtx	drivers/net/tulip/tulip.h
   47   11    270 __skb_queue_head	include/linux/skbuff.h
  286    2    266 check_match	net/ipv6/netfilter/ip6_tables.c net/ipv4/netfilter/ip_tables.c
  285    2    265 __release_stripe	drivers/md/raid6main.c drivers/md/raid5.c
  152    3    264 tcp_synq_drop	include/net/tcp.h
  151    3    262 prog_dmabuf_adc	sound/oss/esssolo1.c sound/oss/es1371.c sound/oss/es1370.c
  151    3    262 dealloc_dmabuf	sound/oss/esssolo1.c sound/oss/es1371.c sound/oss/es1370.c
   85    5    260 list_append	include/linux/netfilter_ipv4/listhelp.h
  149    3    258 DoC_Command	drivers/mtd/devices/doc2001plus.c drivers/mtd/devices/doc2001.c drivers/mtd/devices/doc2000.c
  277    2    257 __tcp_push_pending_frames	include/net/tcp.h
   84    5    256 list_append	include/linux/netfilter_ipv4/listhelp.h
  145    3    250 ntfs_unmap_page	fs/ntfs/ntfs.h
  103    4    249 tcf_tree_lock	include/net/pkt_sched.h
  268    2    248 init_stripe	drivers/md/raid6main.c drivers/md/raid5.c
  144    3    248 add_to_done_queue	drivers/scsi/qla2xxx/qla_listops.h
  265    2    245 BLEND_OP	crypto/sha512.c crypto/sha256.c
  142    3    244 ahd_set_scbptr	drivers/scsi/aic7xxx/aic79xx_inline.h
  101    4    243 list_named_insert	include/linux/netfilter_ipv4/listhelp.h
  141    3    242 tcp_enter_cwr	include/net/tcp.h
   42   12    242 bt_skb_alloc	include/net/bluetooth/bluetooth.h
  100    4    240 _radeon_engine_idle	drivers/video/aty/radeonfb.h drivers/video/radeonfb.c
  254    2    234 xdr_encode_sattr	fs/nfs/nfs3xdr.c fs/nfs/nfs2xdr.c
  254    2    234 pop_ctxt	fs/intermezzo/intermezzo_fs.h
   78    5    232 xfs_bawrite	fs/xfs/linux/xfs_buf.h
   97    4    231 sk_filter	include/net/sock.h
  133    3    226 inet_putpeer	include/net/inetpeer.h
   65    6    225 le_ih_k_type	include/linux/reiserfs_fs.h
  132    3    224 ahd_restore_modes	drivers/scsi/aic7xxx/aic79xx_inline.h
   76    5    224 cfi_read	include/linux/mtd/cfi.h
  131    3    222 ahc_pause	drivers/scsi/aic7xxx/aic7xxx_inline.h
  237    2    217 splice_branch	fs/sysv/itree.c fs/minix/itree_common.c
   51    8    217 __skb_dequeue_tail	include/linux/skbuff.h
  236    2    216 sk_dst_check	include/net/sock.h
  128    3    216 prog_dmabuf_adc	sound/oss/esssolo1.c sound/oss/es1371.c sound/oss/es1370.c
  127    3    214 tcp_writequeue_purge	include/net/tcp.h
  231    2    211 splice_branch	fs/sysv/itree.c fs/minix/itree_common.c
  124    3    208 load_LDT	include/asm/desc.h
  124    3    208 NCR5380_pwrite	drivers/scsi/t128.c drivers/scsi/pas16.c drivers/scsi/dtc.c
   88    4    204 __stop_dac	sound/oss/trident.c sound/oss/i810_audio.c sound/oss/cs46xx.c sound/oss/ali5455.c
   71    5    204 snd_ice1712_restore_gpio_status	sound/pci/ice1712/ice1712.h
  223    2    203 LOAD_OP	crypto/sha512.c crypto/sha256.c
  121    3    202 rxrpc_discard_my_signals	net/rxrpc/internal.h
   87    4    201 ahc_unpause	drivers/scsi/aic7xxx/aic7xxx_inline.h
   52    7    192 __d_drop	include/linux/dcache.h
  115    3    190 NCR5380_pwrite	drivers/scsi/t128.c drivers/scsi/pas16.c drivers/scsi/dtc.c
  115    3    190 NCR5380_pread	drivers/scsi/t128.c drivers/scsi/pas16.c drivers/scsi/dtc.c
  209    2    189 fh_lock	include/linux/nfsd/nfsfh.h
   83    4    189 __stop_adc	sound/oss/trident.c sound/oss/i810_audio.c sound/oss/cs46xx.c sound/oss/ali5455.c
   41   10    189 hlist_add_head	include/linux/list.h
   67    5    188 snd_ice1712_restore_gpio_status	sound/pci/ice1712/ice1712.h
  206    2    186 __ip_vs_wlc_schedule	net/ipv4/ipvs/ip_vs_lblcr.c net/ipv4/ipvs/ip_vs_lblc.c
  112    3    184 hdlcdrv_putbits	include/linux/hdlcdrv.h
   81    4    183 baycom_int_freq	drivers/net/hamradio/baycom_ser_hdx.c drivers/net/hamradio/baycom_ser_fdx.c drivers/net/hamradio/baycom_par.c drivers/net/hamradio/baycom_epp.c
  201    2    181 hdlc_empty_fifo	drivers/isdn/hisax/hisax_fcpcipnp.c drivers/isdn/hisax/avm_pci.c
   50    7    180 DQUOT_INIT	include/linux/quotaops.h
   40   10    180 ip_select_ident	include/net/ip.h
  109    3    178 NCR5380_pread	drivers/scsi/t128.c drivers/scsi/pas16.c drivers/scsi/dtc.c
  108    3    176 orinoco_lock	drivers/net/wireless/orinoco.h
   45    8    175 ld2	sound/oss/trident.h sound/oss/sonicvibes.c sound/oss/esssolo1.c sound/oss/es1371.c sound/oss/es1370.c sound/oss/cmpci.c include/sound/pcm_params.h drivers/usb/class/audio.c
  194    2    174 sock_queue_err_skb	include/net/sock.h
   78    4    174 tcf_tree_unlock	include/net/pkt_sched.h
   63    5    172 jbd_lock_bh_state	include/linux/jbd.h
  188    2    168 waitforCEC	drivers/isdn/hisax/jade_irq.c drivers/isdn/hisax/hscx_irq.c
  104    3    168 stop_dac	sound/oss/sonicvibes.c sound/oss/esssolo1.c sound/oss/cmpci.c
  104    3    168 snd_gf1_select_voice	include/sound/gus.h
   76    4    168 cfi_read_query	include/linux/mtd/cfi.h
  187    2    167 isdn_net_rm_from_bundle	drivers/isdn/i4l/isdn_net.h
  103    3    166 sock_graft	include/net/sock.h
  185    2    165 wv_packet_write	drivers/net/wireless/wavelan_cs.c drivers/net/wireless/wavelan.c
   53    6    165 cache_put	include/linux/sunrpc/cache.h
  183    2    163 vlan_hwaccel_rx	include/linux/if_vlan.h
  182    2    162 wv_frequency_list	drivers/net/wireless/wavelan_cs.c drivers/net/wireless/wavelan.c
  101    3    162 cleanup_entry	net/ipv6/netfilter/ip6_tables.c net/ipv4/netfilter/ip_tables.c net/ipv4/netfilter/arp_tables.c
   74    4    162 ata_wait_idle	include/linux/libata.h
  100    3    160 NCR5380_pwrite	drivers/scsi/t128.c drivers/scsi/pas16.c drivers/scsi/dtc.c
  100    3    160 NCR5380_pread	drivers/scsi/t128.c drivers/scsi/pas16.c drivers/scsi/dtc.c
   73    4    159 rpc_call	include/linux/sunrpc/clnt.h
   98    3    156 stop_dac	sound/oss/sonicvibes.c sound/oss/esssolo1.c sound/oss/cmpci.c
   72    4    156 tcp_initialize_rcv_mss	include/net/tcp.h
   72    4    156 __stop_dac	sound/oss/trident.c sound/oss/i810_audio.c sound/oss/cs46xx.c sound/oss/ali5455.c
   72    4    156 __stop_adc	sound/oss/trident.c sound/oss/i810_audio.c sound/oss/cs46xx.c sound/oss/ali5455.c
   46    7    156 set_cpu_key_k_offset	include/linux/reiserfs_fs.h
   46    7    156 dst_free	include/net/dst.h
   42    8    154 affs_bread	include/linux/amigaffs.h
   58    5    152 llc_pdu_decode_sa	include/net/llc_pdu.h
   95    3    150 addQ	drivers/block/cciss.c drivers/block/cpqarray.c
   45    7    150 rb_link_node	include/linux/rbtree.h
   57    5    148 jbd_unlock_bh_state	include/linux/jbd.h
   49    6    145 read_reg	drivers/net/irda/stir4200.c drivers/block/paride/pt.c drivers/block/paride/pg.c drivers/block/paride/pf.c drivers/block/paride/pd.c drivers/block/paride/pcd.c
   68    4    144 DQUOT_ALLOC_INODE	include/linux/quotaops.h
   67    4    141 llc_pdu_header_init	include/net/llc_pdu.h
   66    4    138 get_int	include/linux/sunrpc/cache.h
   43    7    138 write_seqlock	include/linux/seqlock.h
   88    3    136 nfs_list_remove_request	include/linux/nfs_page.h
   65    4    135 snd_pcm_stream_lock_irq	include/sound/pcm.h
   65    4    135 set_le_ih_k_offset	include/linux/reiserfs_fs.h
   65    4    135 DQUOT_TRANSFER	include/linux/quotaops.h
   47    6    135 ahc_list_lock	drivers/scsi/aic7xxx/aic7xxx_osm.h
   87    3    134 cfi_write	include/linux/mtd/cfi.h
   86    3    132 save_init_fpu	include/asm/i387.h
   64    4    132 find_inlist_lock_noload	net/ipv6/netfilter/ip6_tables.c net/ipv4/netfilter/ip_tables.c net/ipv4/netfilter/arp_tables.c net/bridge/netfilter/ebtables.c
   42    7    132 write_sequnlock	include/linux/seqlock.h
  151    2    131 tlb_gather_mmu	include/asm-generic/tlb.h
  151    2    131 prog_dmabuf_dac2	sound/oss/es1371.c sound/oss/es1370.c
   46    6    130 diva_os_enter_spin_lock	drivers/isdn/hardware/eicon/platform.h
   63    4    129 writehscx	drivers/isdn/hisax/telespci.c drivers/isdn/hisax/teles0.c
   63    4    129 readhscx	drivers/isdn/hisax/telespci.c drivers/isdn/hisax/teles0.c
  148    2    128 ah_hmac_digest	include/net/ah.h
  147    2    127 tcp_openreq_init	include/net/tcp.h
  146    2    126 ahd_outl	drivers/scsi/aic7xxx/aic79xx_inline.h
   62    4    126 snd_pcm_stream_unlock_irq	include/sound/pcm.h
   62    4    126 is_overloaded	net/ipv4/ipvs/ip_vs_sh.c net/ipv4/ipvs/ip_vs_lblcr.c net/ipv4/ipvs/ip_vs_lblc.c net/ipv4/ipvs/ip_vs_dh.c
   62    4    126 cpufreq_verify_within_limits	include/linux/cpufreq.h
  145    2    125 dir_put_page	fs/sysv/dir.c fs/minix/dir.c
  142    2    122 llc_pdu_init_as_test_rsp	include/net/llc_pdu.h
  141    2    121 __start_adc	sound/oss/i810_audio.c sound/oss/ali5455.c
  139    2    119 radeon_engine_flush	drivers/video/radeonfb.c drivers/video/aty/radeonfb.h
  139    2    119 prog_dmabuf_dac1	sound/oss/es1371.c sound/oss/es1370.c
  139    2    119 esp_hmac_digest	include/net/esp.h
  139    2    119 XFS_bwrite	fs/xfs/linux/xfs_buf.h
   79    3    118 hci_conn_put	include/net/bluetooth/hci_core.h
  137    2    117 add_to_retry_queue	drivers/scsi/qla2xxx/qla_listops.h
   59    4    117 svc_take_page	include/linux/sunrpc/svc.h
   59    4    117 add_two_Xsig	arch/i386/math-emu/poly.h
  136    2    116 ahd_get_scbptr	drivers/scsi/aic7xxx/aic79xx_inline.h
   49    5    116 __pskb_trim	include/linux/skbuff.h
   43    6    115 snd_ice1712_save_gpio_status	sound/pci/ice1712/ice1712.h
   43    6    115 ahc_list_unlock	drivers/scsi/aic7xxx/aic7xxx_osm.h
  134    2    114 locks_verify_truncate	include/linux/fs.h
  134    2    114 ahd_inw_scbram	drivers/scsi/aic7xxx/aic79xx_inline.h
  134    2    114 ahd_inl	drivers/scsi/aic7xxx/aic79xx_inline.h
  131    2    111 ahc_outl	drivers/scsi/aic7xxx/aic7xxx_inline.h
   57    4    111 tcp_set_state	include/net/tcp.h
  130    2    110 isdn_net_add_to_bundle	drivers/isdn/i4l/isdn_net.h
   75    3    110 tcp_prequeue_init	include/net/tcp.h
  129    2    109 add_to_scsi_retry_queue	drivers/scsi/qla2xxx/qla_listops.h
  128    2    108 prog_dmabuf_dac2	sound/oss/es1371.c sound/oss/es1370.c
  128    2    108 _ubh_find_next_zero_bit_	fs/ufs/util.h
   47    5    108 ahd_list_lock	drivers/scsi/aic7xxx/aic79xx_osm.h
  127    2    107 affs_getzeroblk	include/linux/amigaffs.h
  125    2    105 prog_dmabuf_dac1	sound/oss/es1371.c sound/oss/es1370.c
   55    4    105 llc_pdu_decode_da	include/net/llc_pdu.h
   46    5    104 xfs_buf_undelay	fs/xfs/linux/xfs_buf.h
   46    5    104 __skb_trim	include/linux/skbuff.h
  123    2    103 DQUOT_PREALLOC_SPACE	include/linux/quotaops.h
   71    3    102 context_destroy	security/selinux/ss/context.h
  121    2    101 task_sectors	include/linux/ide.h
  121    2    101 fee_wait	drivers/net/wireless/wavelan_cs.c drivers/net/wireless/wavelan.c
  121    2    101 afs_discard_my_signals	fs/afs/internal.h
  120    2    100 dump_skb	drivers/atm/horizon.c drivers/atm/ambassador.c
   45    5    100 qla2x00_debounce_register	drivers/scsi/qla2xxx/qla_inline.h
   45    5    100 nfs_revalidate_inode	include/linux/nfs_fs.h
   40    6    100 snd_seq_oss_fill_addr	sound/core/seq/oss/seq_oss_device.h
  119    2     99 ahc_inl	drivers/scsi/aic7xxx/aic7xxx_inline.h
   53    4     99 xdr_decode_hyper	include/linux/sunrpc/xdr.h
  117    2     97 dump_skb	drivers/atm/horizon.c drivers/atm/ambassador.c
   68    3     96 inet_reset_saddr	include/net/ip.h
  115    2     95 waitforCEC	drivers/isdn/hisax/jade_irq.c drivers/isdn/hisax/hscx_irq.c
  115    2     95 fee_wait	drivers/net/wireless/wavelan_cs.c drivers/net/wireless/wavelan.c
   67    3     94 __netif_rx_complete	include/linux/netdevice.h
  113    2     93 try_address	drivers/i2c/algos/i2c-algo-pcf.c drivers/i2c/algos/i2c-algo-bit.c
   51    4     93 __stop_dac	sound/oss/trident.c sound/oss/i810_audio.c sound/oss/cs46xx.c sound/oss/ali5455.c
  112    2     92 fib6_walker_unlink	include/net/ip6_fib.h
  112    2     92 ata_irq_on	include/linux/libata.h
   66    3     92 sk_dst_get	include/net/sock.h
   43    5     92 ahd_list_unlock	drivers/scsi/aic7xxx/aic79xx_osm.h
  111    2     91 waitforXFW	drivers/isdn/hisax/jade_irq.c drivers/isdn/hisax/hscx_irq.c
   50    4     90 get_expiry	include/linux/sunrpc/cache.h
  109    2     89 csr1212_rom_cache_malloc	drivers/ieee1394/csr1212.h
  108    2     88 ___add_to_page_cache	include/linux/pagemap.h
   64    3     88 vn_flagset	fs/xfs/linux/xfs_vnode.h
   64    3     88 cpu_key_k_type	include/linux/reiserfs_fs.h
   49    4     87 invalidate_remote_inode	include/linux/fs.h
   49    4     87 hlist_del_init	include/linux/list.h
  106    2     86 next_request	drivers/block/paride/pf.c drivers/block/paride/pcd.c
   63    3     86 __sk_dst_reset	include/net/sock.h
  104    2     84 exit_namespace	include/linux/namespace.h
  104    2     84 cleanup_match	net/ipv6/netfilter/ip6_tables.c net/ipv4/netfilter/ip_tables.c
   62    3     84 skb_unshare	include/linux/skbuff.h
   62    3     84 add_entry_to_counter	net/ipv6/netfilter/ip6_tables.c net/ipv4/netfilter/ip_tables.c net/ipv4/netfilter/arp_tables.c
   48    4     84 fib_res_put	include/net/ip_fib.h
   48    4     84 __stop_adc	sound/oss/trident.c sound/oss/i810_audio.c sound/oss/cs46xx.c sound/oss/ali5455.c
   41    5     84 ax25_cb_put	include/net/ax25.h
  102    2     82 parport_generic_irq	include/linux/parport.h
  101    2     81 __ipq_reset	net/ipv6/netfilter/ip6_queue.c net/ipv4/netfilter/ip_queue.c
   47    4     81 snd_i2c_unlock	include/sound/i2c.h
   47    4     81 snd_i2c_lock	include/sound/i2c.h
  100    2     80 dn_rt_finish_output	include/net/dn_route.h
   60    3     80 add_counter_to_entry	net/ipv6/netfilter/ip6_tables.c net/ipv4/netfilter/ip_tables.c net/ipv4/netfilter/arp_tables.c
   99    2     79 dc390_Going_remove	drivers/scsi/tmscsim.c
   46    4     78 ahd_unlock	drivers/scsi/aic7xxx/aic79xx_osm.h
   46    4     78 ahd_lock	drivers/scsi/aic7xxx/aic79xx_osm.h
   46    4     78 ahc_unlock	drivers/scsi/aic7xxx/aic7xxx_osm.h
   46    4     78 ahc_lock	drivers/scsi/aic7xxx/aic7xxx_osm.h
   46    4     78 __stop_adc	sound/oss/trident.c sound/oss/i810_audio.c sound/oss/cs46xx.c sound/oss/ali5455.c
   95    2     75 mmc_encr	drivers/net/wireless/wavelan_cs.c drivers/net/wireless/wavelan.c
   45    4     75 ipv6_addr_set	include/net/ipv6.h
   45    4     75 ide_init_hwif_ports	include/asm/ide.h
   45    4     75 __sk_dst_check	include/net/sock.h
   94    2     74 fat_get_entry	include/linux/msdos_fs.h
   92    2     72 mmc_in	drivers/net/wireless/wavelan_cs.c drivers/net/wireless/wavelan.c
   92    2     72 WaitForBusy	drivers/isdn/hisax/hfc_2bs0.c drivers/isdn/hisax/hfc_2bds0.c
   56    3     72 timer_action	drivers/usb/host/ehci.h
   56    3     72 load_esp0	include/asm/processor.h
   56    3     72 fs16_add	fs/ufs/swab.h fs/sysv/sysv.h
   56    3     72 DoC_Command	drivers/mtd/devices/doc2001plus.c drivers/mtd/devices/doc2001.c drivers/mtd/devices/doc2000.c
   91    2     71 tlb_finish_mmu	include/asm-generic/tlb.h
   91    2     71 stop_dac2	sound/oss/es1371.c sound/oss/es1370.c
   91    2     71 stop_dac1	sound/oss/es1371.c sound/oss/es1370.c
   91    2     71 llc_pdu_init_as_xid_rsp	include/net/llc_pdu.h
   91    2     71 llc_pdu_init_as_xid_cmd	include/net/llc_pdu.h
   91    2     71 hci_conn_hash_lookup_ba	include/net/bluetooth/hci_core.h
   90    2     70 qla2x00_enable_intrs	drivers/scsi/qla2xxx/qla_inline.h
   90    2     70 qla2x00_disable_intrs	drivers/scsi/qla2xxx/qla_inline.h
   90    2     70 mmc_encr	drivers/net/wireless/wavelan_cs.c drivers/net/wireless/wavelan.c
   90    2     70 hci_dev_hold	include/net/bluetooth/hci_core.h
   90    2     70 __ipq_enqueue_entry	net/ipv6/netfilter/ip6_queue.c net/ipv4/netfilter/ip_queue.c
   55    3     70 snd_vx_inb	include/sound/vx_core.h
   89    2     69 waitforCEC	drivers/isdn/hisax/jade_irq.c drivers/isdn/hisax/hscx_irq.c
   89    2     69 vlan_get_tag	include/linux/if_vlan.h
   89    2     69 WaitForBusy	drivers/isdn/hisax/hfc_2bs0.c drivers/isdn/hisax/hfc_2bds0.c
   43    4     69 verify_chain	fs/sysv/itree.c fs/minix/itree_common.c fs/ext3/inode.c fs/ext2/inode.c
   88    2     68 rdebi	drivers/media/dvb/ttpci/av7110_hw.h
   88    2     68 mmc_in	drivers/net/wireless/wavelan_cs.c drivers/net/wireless/wavelan.c
   54    3     68 DoC_WaitReady	drivers/mtd/devices/doc2001plus.c drivers/mtd/devices/doc2001.c drivers/mtd/devices/doc2000.c
   87    2     67 scm_recv	include/net/scm.h
   86    2     66 scm_send	include/net/scm.h
   42    4     66 clear_highpage	include/linux/highmem.h
   85    2     65 insert_hash	drivers/md/raid6main.c drivers/md/raid5.c
   83    2     63 tcp_fast_path_check	include/net/tcp.h
   83    2     63 actcapi_nextsmsg	drivers/isdn/act2000/capi.h
   41    4     63 secpath_reset	include/net/xfrm.h
   41    4     63 IP_ECN_set_ce	include/net/inet_ecn.h
   82    2     62 create_debug_files	drivers/usb/host/ohci-dbg.c drivers/usb/host/ehci-dbg.c
   51    3     62 parport_yield_blocking	include/linux/parport.h
   51    3     62 fs16_add	fs/ufs/swab.h fs/sysv/sysv.h
   81    2     61 __add_to_done_queue	drivers/scsi/qla2xxx/qla_listops.h
   80    2     60 waitforCEC	drivers/isdn/hisax/jade_irq.c drivers/isdn/hisax/hscx_irq.c
   80    2     60 remove_rx_bufs	drivers/net/lp486e.c drivers/net/82596.c
   40    4     60 wait_for_idle	drivers/video/aty/atyfb.h drivers/video/riva/fbdev.c
   40    4     60 ntfs_malloc_nofs	fs/ntfs/malloc.h
   40    4     60 ahc_is_paused	drivers/scsi/aic7xxx/aic7xxx_inline.h
   78    2     58 xdr_decode_fhandle	fs/nfs/nfs3xdr.c fs/nfs/nfs2xdr.c
   78    2     58 ehci_qtd_init	drivers/usb/host/ehci-mem.c
   78    2     58 ecp_sync	drivers/scsi/ppa.c drivers/scsi/imm.c
   78    2     58 __start_dac	sound/oss/i810_audio.c sound/oss/ali5455.c
   77    2     57 waitforCEC	drivers/isdn/hisax/jade_irq.c drivers/isdn/hisax/hscx_irq.c
   77    2     57 cs46xx_dsp_scb_set_volume	sound/pci/cs46xx/dsp_spos.h
   48    3     56 print_name	net/ipv6/netfilter/ip6_tables.c net/ipv4/netfilter/ip_tables.c net/ipv4/netfilter/arp_tables.c
   48    3     56 dn_fib_res_put	include/net/dn_fib.h
   75    2     55 waitforCEC	drivers/isdn/hisax/jade_irq.c drivers/isdn/hisax/hscx_irq.c
   75    2     55 remove_rx_bufs	drivers/net/lp486e.c drivers/net/82596.c
   75    2     55 ahd_pause	drivers/scsi/aic7xxx/aic79xx_inline.h
   74    2     54 waitforCEC	drivers/isdn/hisax/jade_irq.c drivers/isdn/hisax/hscx_irq.c
   74    2     54 tcp_acceptq_queue	include/net/tcp.h
   74    2     54 nfs_unlock_request	include/linux/nfs_page.h
   74    2     54 get_status	drivers/net/wan/wanxl.c drivers/net/3c505.c
   74    2     54 dn_sk_ports_copy	include/net/dn.h
   74    2     54 __ipq_flush	net/ipv6/netfilter/ip6_queue.c net/ipv4/netfilter/ip_queue.c
   47    3     54 scsi_populate_tag_msg	include/scsi/scsi_tcq.h
   47    3     54 bt_skb_send_alloc	include/net/bluetooth/bluetooth.h
   73    2     53 ecp_sync	drivers/scsi/ppa.c drivers/scsi/imm.c
   72    2     52 ipip_ecn_decapsulate	net/ipv4/xfrm4_input.c net/ipv4/ipip.c
   72    2     52 decode_fh	fs/nfsd/nfsxdr.c fs/nfsd/nfs3xdr.c
   71    2     51 offset_ptr	sound/pci/trident/trident_memory.c sound/pci/emu10k1/memory.c
   71    2     51 BLEND_OP	crypto/sha512.c crypto/sha256.c
   70    2     50 waitforXFW	drivers/isdn/hisax/jade_irq.c drivers/isdn/hisax/hscx_irq.c
   70    2     50 waitforCEC	drivers/isdn/hisax/jade_irq.c drivers/isdn/hisax/hscx_irq.c
   70    2     50 ipip_ecn_decapsulate	net/ipv4/xfrm4_input.c net/ipv4/ipip.c
   70    2     50 ipip6_ecn_decapsulate	net/ipv6/xfrm6_input.c net/ipv6/sit.c
   45    3     50 DoC_WaitReady	drivers/mtd/devices/doc2001plus.c drivers/mtd/devices/doc2001.c drivers/mtd/devices/doc2000.c
   69    2     49 encode_fh	fs/nfsd/nfsxdr.c fs/nfsd/nfs3xdr.c
   69    2     49 __start_adc	sound/oss/i810_audio.c sound/oss/ali5455.c
   68    2     48 line_set	drivers/i2c/busses/i2c-parport.c drivers/i2c/busses/i2c-parport-light.c
   68    2     48 fh_copy	include/linux/nfsd/nfsfh.h
   44    3     48 rxrpc_put_message	include/rxrpc/message.h
   44    3     48 jiffies_to_timeval	include/linux/time.h
   66    2     46 waitforCEC	drivers/isdn/hisax/jade_irq.c drivers/isdn/hisax/hscx_irq.c
   66    2     46 ahd_inb_scbram	drivers/scsi/aic7xxx/aic79xx_inline.h
   43    3     46 orinoco_unlock	drivers/net/wireless/orinoco.h
   65    2     45 next_unix_socket	include/net/af_unix.h
   65    2     45 __start_dac	sound/oss/i810_audio.c sound/oss/ali5455.c
   65    2     45 __del_from_retry_queue	drivers/scsi/qla2xxx/qla_listops.h
   65    2     45 RGB24_PUTPIXEL	drivers/usb/media/usbvideo.h
   64    2     44 snd_mask_refine	include/sound/pcm_params.h
   64    2     44 WaitNoBusy	drivers/isdn/hisax/hfc_2bs0.c drivers/isdn/hisax/hfc_2bds0.c
   42    3     44 crypto_comp_decompress	include/linux/crypto.h
   42    3     44 crypto_comp_compress	include/linux/crypto.h
   63    2     43 xfrm_sk_free_policy	include/net/xfrm.h
   63    2     43 writeisac	drivers/isdn/hisax/telespci.c drivers/isdn/hisax/teles0.c
   63    2     43 waitforCEC	drivers/isdn/hisax/jade_irq.c drivers/isdn/hisax/hscx_irq.c
   63    2     43 tcp_select_initial_window	include/net/tcp.h
   63    2     43 tcp_listen_lock	include/net/tcp.h
   63    2     43 readisac	drivers/isdn/hisax/telespci.c drivers/isdn/hisax/teles0.c
   63    2     43 bit_spin_lock	include/linux/spinlock.h
   63    2     43 __sk_dst_set	include/net/sock.h
   63    2     43 __ipq_find_dequeue_entry	net/ipv6/netfilter/ip6_queue.c net/ipv4/netfilter/ip_queue.c
   62    2     42 snd_vx_outb	include/sound/vx_core.h
   62    2     42 WaitNoBusy	drivers/isdn/hisax/hfc_2bs0.c drivers/isdn/hisax/hfc_2bds0.c
   41    3     42 crypto_cipher_set_iv	include/linux/crypto.h
   41    3     42 DoC_WaitReady	drivers/mtd/devices/doc2001plus.c drivers/mtd/devices/doc2001.c drivers/mtd/devices/doc2000.c
   61    2     41 elf_core_copy_regs	include/linux/elfcore.h
   61    2     41 decode_fh	fs/nfsd/nfsxdr.c fs/nfsd/nfs3xdr.c
   60    2     40 decode_filename	fs/nfsd/nfsxdr.c fs/nfsd/nfs3xdr.c
   40    3     40 ahc_flush_device_writes	drivers/scsi/aic7xxx/aic7xxx_osm.h
   59    2     39 dev_get_idx	net/core/dev.c net/atm/resources.c
   59    2     39 crypto_cipher_encrypt_iv	include/linux/crypto.h
   59    2     39 crypto_cipher_decrypt_iv	include/linux/crypto.h
   59    2     39 ahc_inw	drivers/scsi/aic7xxx/aic7xxx_inline.h
   58    2     38 tcp_may_send_now	include/net/tcp.h
   57    2     37 tcp_sync_left_out	include/net/tcp.h
   56    2     36 ipip6_ecn_decapsulate	net/ipv6/xfrm6_input.c net/ipv6/sit.c
   56    2     36 __del_from_pending_queue	drivers/scsi/qla2xxx/qla_listops.h
   56    2     36 __INPLL	drivers/video/aty/radeonfb.h
   55    2     35 wl_spy_gather	drivers/net/wireless/wavelan_cs.c drivers/net/wireless/wavelan.c
   54    2     34 vx_reset_dsp	include/sound/vx_core.h
   54    2     34 mmc_out	drivers/net/wireless/wavelan_cs.c drivers/net/wireless/wavelan.c
   54    2     34 csum_and_copy_from_user	include/net/checksum.h
   54    2     34 bit_spin_unlock	include/linux/spinlock.h
   53    2     33 tcp_v4_setup_caps	include/net/tcp.h
   53    2     33 hermes_present	drivers/net/wireless/hermes.h
   53    2     33 context_cpy	security/selinux/ss/context.h
   53    2     33 LOAD_OP	crypto/sha512.c crypto/sha256.c
   52    2     32 radeon_engine_flush	drivers/video/radeonfb.c drivers/video/aty/radeonfb.h
   52    2     32 mmc_out	drivers/net/wireless/wavelan_cs.c drivers/net/wireless/wavelan.c
   51    2     31 wr_mem	drivers/atm/horizon.c drivers/atm/ambassador.c
   50    2     30 dev_is_ethdev	drivers/net/wan/lapbether.c drivers/net/hamradio/bpqether.c
   49    2     29 tcp_current_mss	include/net/tcp.h
   49    2     29 remove_debug_files	drivers/usb/host/ohci-dbg.c drivers/usb/host/ehci-dbg.c
   49    2     29 hci_proto_disconn_ind	include/net/bluetooth/hci_core.h
   49    2     29 create_debug_files	drivers/usb/host/ohci-dbg.c drivers/usb/host/ehci-dbg.c
   49    2     29 D_L1L2	drivers/isdn/hisax/st5481_d.c drivers/isdn/hisax/hisax_isac.c
   48    2     28 xdr_decode_fhandle	fs/nfs/nfs3xdr.c fs/nfs/nfs2xdr.c
   48    2     28 irdebi	drivers/media/dvb/ttpci/av7110_hw.h
   48    2     28 hci_conn_hash_lookup_handle	include/net/bluetooth/hci_core.h
   48    2     28 add_page_to_inactive_list	include/linux/mm_inline.h
   48    2     28 add_page_to_active_list	include/linux/mm_inline.h
   47    2     27 snd_interval_setinteger	include/sound/pcm_params.h
   47    2     27 rd_mem	drivers/atm/horizon.c drivers/atm/ambassador.c
   47    2     27 hisax_findcard	drivers/isdn/hisax/config.c drivers/isdn/hisax/callc.c
   47    2     27 frag_kfree_skb	net/ipv6/reassembly.c net/ipv4/ip_fragment.c
   47    2     27 dn_dn2eth	include/net/dn.h
   47    2     27 check_sticky	fs/namei.c fs/intermezzo/vfs.c
   47    2     27 addrconf_addr_solict_mult	include/net/addrconf.h
   47    2     27 __ipq_dequeue_entry	net/ipv6/netfilter/ip6_queue.c net/ipv4/netfilter/ip_queue.c
   46    2     26 sk_filter_release	include/net/sock.h
   46    2     26 sk_add_bind_node	include/net/sock.h
   46    2     26 irttp_listen	include/net/irda/irttp.h
   46    2     26 dn_dev_islocal	include/net/dn_dev.h
   46    2     26 dc390_findDCB	drivers/scsi/tmscsim.c
   46    2     26 __skb_append	include/linux/skbuff.h
   46    2     26 __sk_add_node	include/net/sock.h
   46    2     26 B_L1L2	drivers/isdn/hisax/st5481_b.c drivers/isdn/hisax/hisax_fcpcipnp.c
   45    2     25 percpu_counter_init	include/linux/percpu_counter.h
   45    2     25 jbd_trylock_bh_state	include/linux/jbd.h
   45    2     25 ipv6_addr_all_routers	include/net/addrconf.h
   45    2     25 ipv6_addr_all_nodes	include/net/addrconf.h
   45    2     25 init_sigpending	include/linux/signal.h
   45    2     25 hlist_del	include/linux/list.h
   45    2     25 bitset_set	sound/core/oss/pcm_plugin.h
   44    2     24 skb_fill_page_desc	include/linux/skbuff.h
   44    2     24 r128_update_ring_snapshot	drivers/char/drm/r128_drv.h
   44    2     24 ahc_get_scb	drivers/scsi/aic7xxx/aic7xxx_inline.h
   44    2     24 __set_tss_desc	include/asm/desc.h
   43    2     23 locks_verify_locked	include/linux/fs.h
   43    2     23 line_set	drivers/i2c/busses/i2c-parport.c drivers/i2c/busses/i2c-parport-light.c
   43    2     23 crypto_cipher_get_iv	include/linux/crypto.h
   42    2     22 raid6_after_mmx	drivers/md/raid6x86.h
   42    2     22 chan2dev	drivers/isdn/pcbit/layer2.h
   42    2     22 __add_wait_queue	include/linux/wait.h
   41    2     21 first_unix_socket	include/net/af_unix.h
   41    2     21 dirty_sb	fs/sysv/sysv.h
   41    2     21 aac_list_del	drivers/scsi/aacraid/aacraid.h
   41    2     21 __remove_wait_queue	include/linux/wait.h
   41    2     21 __add_wait_queue_tail	include/linux/wait.h
   40    2     20 tcp_listen_unlock	include/net/tcp.h
   40    2     20 snd_ice1712_gpio_write_bits	sound/pci/ice1712/ice1712.h
   40    2     20 ser12_set_divisor	drivers/net/hamradio/baycom_ser_hdx.c drivers/net/hamradio/baycom_ser_fdx.c
   40    2     20 ip_vs_check_diff	include/net/ip_vs.h
           ======
           309519 Total bytes wasted

--Boundary-00=_gRDgAxGcFkLWzch
Content-Type: application/x-tgz;
  name="inline_hunter.tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="inline_hunter.tar.gz"

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

--Boundary-00=_gRDgAxGcFkLWzch--

