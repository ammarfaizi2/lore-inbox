Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261501AbTDBEK6>; Tue, 1 Apr 2003 23:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261508AbTDBEK6>; Tue, 1 Apr 2003 23:10:58 -0500
Received: from modemcable226.131-200-24.mtl.mc.videotron.ca ([24.200.131.226]:10493
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S261501AbTDBEK5>; Tue, 1 Apr 2003 23:10:57 -0500
Date: Tue, 1 Apr 2003 23:17:59 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Joe Korty <joe.korty@ccur.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] smp_call_function needs mb()
In-Reply-To: <Pine.LNX.4.50.0304011919300.8773-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.50.0304012313000.8773-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0304010305510.8773-100000@montezuma.mastecende.com>
 <20030401220004.GB30989@tsunami.ccur.com>
 <Pine.LNX.4.50.0304011919300.8773-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Apr 2003, Zwane Mwaikambo wrote:

> On Tue, 1 Apr 2003, Joe Korty wrote:
> 
> > This should be sent to Marcello as well.
> > Joe
> 
> I'll try oops 2.4.20 and send.

2.4.21-pre5-ac3 Nothing happened.. mainly because the whole box was 
completely useless during the whole test run. There was no real progress 
during the entire run so i stoppped it. I'll send to Alan anyway

305485 total                                      0.1583
246390 default_idle                             3849.8438
 11361 .text.lock.inode                          50.9462
  9027 generic_file_write                         4.7411
  1374 invalidate_bdev                            2.5257
  1166 do_get_write_access                        0.7288
  1116 journal_add_journal_head                   2.2500
  1061 __make_request                             0.6197
   913 shrink_cache                               0.5764
   872 kmem_cache_reap                            0.5737
   848 unlock_buffer                             10.6000
   846 journal_dirty_metadata                     1.7625
   796 .text.lock.sched                           1.5191
   792 do_anonymous_page                          1.7679
   755 kmem_cache_alloc                           1.1509
   738 get_hash_table                             3.8438
   688 .text.lock.buffer                          1.1486
   630 rmqueue                                    0.7572
   620 ext3_do_update_inode                       0.7045
   613 __rdtsc_delay                             19.1562
   588 do_wp_page                                 0.6682
   574 write_some_buffers                         1.8882
   560 journal_get_write_access                   5.8333
   542 journal_unlock_journal_head                2.8229
   524 journal_cancel_revoke                      2.5192
   519 schedule                                   0.4569
   502 try_to_free_buffers                        0.9508
   460 __wake_up                                  2.6136
   454 kmalloc                                    0.6168
   399 ext3_new_block                             0.1651
   379 .text.lock.ioctl                           9.0238

