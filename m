Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272464AbSISTW3>; Thu, 19 Sep 2002 15:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272493AbSISTW3>; Thu, 19 Sep 2002 15:22:29 -0400
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:4621 "EHLO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S272464AbSISTW1> convert rfc822-to-8bit; Thu, 19 Sep 2002 15:22:27 -0400
x-mimeole: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: TPC-C benchmark used standard RH kernel
Date: Thu, 19 Sep 2002 14:27:22 -0500
Message-ID: <45B36A38D959B44CB032DA427A6E106402D09E43@cceexc18.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: TPC-C benchmark used standard RH kernel
Thread-Index: AcJgCI5NeISs3vUXSa6Q4M1Qa5XbdAACYsuA
From: "Bond, Andrew" <Andrew.Bond@hp.com>
To: "Dave Hansen" <haveblue@us.ibm.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 19 Sep 2002 19:27:23.0951 (UTC) FILETIME=[94A7FBF0:01C26012]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This isn't as recent as I would like, but it will give you an idea.  Top 75 from readprofile.  This run was not using bigpages though.

Andy

00000000 total                                      7872   0.0066
c0105400 default_idle                               1367  21.3594
c012ea20 find_vma_prev                               462   2.2212
c0142840 create_bounce                               378   1.1250
c0142540 bounce_end_io_read                          332   0.9881
c0197740 __make_request                              256   0.1290
c012af20 zap_page_range                              231   0.1739
c012e9a0 find_vma                                    214   1.6719
c012e780 avl_rebalance                               160   0.4762
c0118d80 schedule                                    157   0.1609
c010ba50 do_gettimeofday                             145   1.0069
c0130c30 __find_lock_page                            144   0.4500
c0119150 __wake_up                                   142   0.9861
c01497c0 end_buffer_io_kiobuf_async                  140   0.6250
c0113020 flush_tlb_mm                                128   1.0000
c0168000 proc_pid_stat                               125   0.2003
c012d010 do_no_page                                  125   0.2056
c0107128 system_call                                 107   1.9107
c01488d0 end_buffer_io_kiobuf                         91   0.9479
c0142760 alloc_bounce_bh                              91   0.4062
c01489a0 brw_kiovec                                   90   0.1250
c011fe90 sys_gettimeofday                             89   0.5563
c012edd0 do_munmap                                    88   0.1310
c0142690 alloc_bounce_page                            87   0.4183
c01402b0 shmem_getpage                                84   0.3281
c01498a0 brw_kvec_async                               77   0.0859
c0142490 bounce_end_io_write                          72   0.4091
c012f3d0 __insert_vm_struct                           70   0.1823
c012e1d0 do_mmap_pgoff                                66   0.0581
c0137cb0 kmem_cache_alloc                             59   0.2169
c012e090 lock_vma_mappings                            57   1.1875
c0137ba0 free_block                                   52   0.1912
c012d450 handle_mm_fault                              51   0.1226
c013cb50 __free_pages                                 50   1.5625
c0198020 submit_bh                                    47   0.3672
c0147260 set_bh_page                                  46   0.7188
c0145730 fget                                         45   0.7031
c012b450 mm_follow_page                               45   0.1339
c01182d0 try_to_wake_up                               45   0.1278
c0107380 page_fault                                   45   3.7500
c0199730 elevator_linus_merge                         44   0.1375
c0137f20 kmem_cache_free                              44   0.3438
c0178b50 try_atomic_semop                             39   0.1283
c0183000 batch_entropy_store                          37   0.1927
c0197440 account_io_start                             36   0.4500
c0181f30 rw_raw_dev                                   32   0.0444
c0137aa0 kmem_cache_alloc_batch                       32   0.1250
c012e8d0 avl_remove                                   32   0.1538
c0162490 sys_io_submit                                30   0.0193
c0161d00 aio_complete                                 29   0.1133
c0117870 do_page_fault                                29   0.0224
c0196fd0 generic_plug_device                          28   0.2917
c012d800 mm_map_user_kvec                             28   0.0312
c0107171 restore_all                                  28   1.2174
c011a4a0 remove_wait_queue                            26   0.4062
c0197410 disk_round_stats                             25   0.5208
c0148930 wait_kio                                     25   0.2232
c012a980 pte_alloc_map                                25   0.0473
c0227668 csum_partial_copy_generic                    24   0.0968
c01283f0 getrusage                                    24   0.0326
c0144ce0 sys_pread                                    22   0.0688
c013c3d0 rmqueue                                      22   0.0255
c0118690 load_balance                                 22   0.0241
c01973a0 locate_hd_struct                             21   0.1875
c010c0e0 sys_mmap2                                    21   0.1313
c015bfd0 end_kio_request                              20   0.2083
c012a800 __free_pte                                   20   0.1562
c0123ea0 add_timer                                    20   0.0735
c01ef250 ip_queue_xmit                                19   0.0154
c0197490 account_io_end                               19   0.2375
c015c300 kiobuf_wait_for_io                           19   0.1080
c012b5c0 map_user_kiobuf                              19   0.0247
c0161e00 aio_read_evt                                 18   0.1875
c012db80 unmap_kvec                                   18   0.1607
c010c8b0 restore_fpu                                  18   0.5625
c01f4130 tcp_sendmsg                                  17   0.0036

> -----Original Message-----
> From: Dave Hansen [mailto:haveblue@us.ibm.com]
> Sent: Thursday, September 19, 2002 2:15 PM
> To: Bond, Andrew
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: TPC-C benchmark used standard RH kernel
> 
> 
> Bond, Andrew wrote:
>  > I believe I need to clarify my earlier posting about 
> kernel features that
>  > gave the benchmark a boost.  The kernel that we used in 
> the benchmark was an
>  > unmodified Red Hat Advanced Server 2.1 kernel.  We did 
> tune the kernel via
>  > standard user space tuning, but the kernel was not 
> patched.  HP, Red Hat, and
>  > Oracle have worked closely together to make sure that the 
> features I
>  > mentioned were in the Advanced Server kernel "out of the box."
> 
> Have you done much profiling of that kernel?  I'm sure a lot 
> of people would be 
> very interested to see even readprofile results from a piece 
> of the cluster 
> during a TPC run.
> 
> -- 
> Dave Hansen
> haveblue@us.ibm.com
> 
> 
