Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317434AbSGaABU>; Tue, 30 Jul 2002 20:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317437AbSGaABU>; Tue, 30 Jul 2002 20:01:20 -0400
Received: from [213.4.129.129] ([213.4.129.129]:62761 "EHLO tsmtp5.mail.isp")
	by vger.kernel.org with ESMTP id <S317434AbSGaABT>;
	Tue, 30 Jul 2002 20:01:19 -0400
Date: Wed, 31 Jul 2002 02:05:30 +0200
From: Diego Calleja <diegocg@teleline.es>
To: linux-kernel@vger.kernel.org
Subject: profile of 2.4.19-rc3-ac4
Message-Id: <20020731020530.35cb7fc5.diegocg@teleline.es>
X-Mailer: Sylpheed version 0.7.4claws (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the profile of a 2.4.19-rc3-ac4 after a heavy disk /swap usage.
I send it because it seems that page_referenced takes a lot of time....

607951 default_idle                             15198,7750
  1019 page_referenced                           16,9833
   831 serial_in                                 15,9808
   406 __rdtsc_delay                             14,5000
   836 unlock_page                                6,3333
   242 sock_poll                                  6,0500
   126 fget                                       3,1500
   287 handle_IRQ_event                           3,1196
   409 idedisk_end_request                        2,5562
   163 page_over_rsslimit                         2,5469
   155 system_call                                2,4219
   279 unix_poll                                  2,1136
    77 serial_icr_write                           1,9250
   109 __generic_copy_to_user                     1,8167
    58 add_wait_queue                             1,4500
    40 reiserfs_clean_and_file_buffer             1,2500
   109 __wake_up                                  1,2386
   285 do_anonymous_page                          1,2284
    89 find_inode                                 1,1711
   478 is_leaf                                    1,0864
   149 get_hash_table                             1,0643
    93 __generic_copy_from_user                   1,0568
   483 do_select                                  1,0147
   284 ide_wait_stat                              1,0143
<snip.....>
