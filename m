Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264622AbSIWFjG>; Mon, 23 Sep 2002 01:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264807AbSIWFjG>; Mon, 23 Sep 2002 01:39:06 -0400
Received: from holomorphy.com ([66.224.33.161]:18324 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S264622AbSIWFjE>;
	Mon, 23 Sep 2002 01:39:04 -0400
Date: Sun, 22 Sep 2002 22:36:00 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.38 vs. 2.5.38-mm1 dbench 512 oprofiles
Message-ID: <20020923053600.GJ25605@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.38 virgin:
Throughput 34.0847 MB/sec (NB=42.6059 MB/sec  340.847 MBit/sec)  512 procs
c01053ec 332946298 89.2647     poll_idle
c0114a48 11069332 2.96775     load_balance
c015c196 6290235  1.68645     .text.lock.dcache
c0154783 4966046  1.33142     .text.lock.namei
c0114ec0 3330213  0.892848    scheduler_tick
c0131e94 2213627  0.593485    generic_file_write_nolock
c01a10cb 2120138  0.568421    .text.lock.dec_and_lock
c011734d 1064379  0.285366    .text.lock.sched
c0111728 777966   0.208577    smp_apic_timer_interrupt
c0131460 485556   0.13018     file_read_actor
c013f950 439352   0.117793    blk_queue_bounce
c0106418 417379   0.111902    .text.lock.semaphore
c010604c 327813   0.0878884   __down
c01145b8 312618   0.0838146   try_to_wake_up
c01a1050 282950   0.0758604   atomic_dec_and_lock
c01151e4 280517   0.0752081   do_schedule
c0151fb8 233523   0.0626088   path_lookup
c01513f4 204300   0.0547739   link_path_walk
c01449a0 197412   0.0529272   generic_file_llseek
c015b120 186943   0.0501204   d_alloc
c015b2e4 173003   0.046383    d_instantiate
c013fbf6 158793   0.0425733   .text.lock.highmem
c0130e08 150974   0.040477    find_get_page


2.5.38-mm1:
Throughput 20.966 MB/sec (NB=26.2075 MB/sec  209.66 MBit/sec)  512 procs
c01053ec 332946298 89.2647     poll_idle
c0114a48 11069332 2.96775     load_balance
c015c196 6290235  1.68645     .text.lock.dcache
c0154783 4966046  1.33142     .text.lock.namei
c0114ec0 3330213  0.892848    scheduler_tick
c0131e94 2213627  0.593485    generic_file_write_nolock
c01a10cb 2120138  0.568421    .text.lock.dec_and_lock
c011734d 1064379  0.285366    .text.lock.sched
c0111728 777966   0.208577    smp_apic_timer_interrupt
c0131460 485556   0.13018     file_read_actor
c013f950 439352   0.117793    blk_queue_bounce
c0106418 417379   0.111902    .text.lock.semaphore
c010604c 327813   0.0878884   __down
c01145b8 312618   0.0838146   try_to_wake_up
c01a1050 282950   0.0758604   atomic_dec_and_lock
c01151e4 280517   0.0752081   do_schedule
c0151fb8 233523   0.0626088   path_lookup
c01513f4 204300   0.0547739   link_path_walk
c01449a0 197412   0.0529272   generic_file_llseek
c015b120 186943   0.0501204   d_alloc
c015b2e4 173003   0.046383    d_instantiate
c013fbf6 158793   0.0425733   .text.lock.highmem
c0130e08 150974   0.040477    find_get_page

