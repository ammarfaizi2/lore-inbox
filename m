Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317606AbSHOXYf>; Thu, 15 Aug 2002 19:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317622AbSHOXYf>; Thu, 15 Aug 2002 19:24:35 -0400
Received: from holomorphy.com ([66.224.33.161]:34492 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317606AbSHOXYe>;
	Thu, 15 Aug 2002 19:24:34 -0400
Date: Thu, 15 Aug 2002 16:26:51 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.31 kmap_atomic copy_*_user benefits
Message-ID: <20020815232651.GS15685@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20020815232126.GR15685@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: profile numbers
Content-Disposition: inline
In-Reply-To: <20020815232126.GR15685@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2002 at 04:21:26PM -0700, William Lee Irwin III wrote:
> In the follow-ups I'll include oprofile numbers for each and vmstat logs.

oprofile numbers before:

c013bf64 7205865  63.7904     .text.lock.highmem
c0105394 1392984  12.3315     default_idle
c013b5cc 1013797  8.97471     kmap_high
c013b7c0 864121   7.64969     kunmap_high
c0114820 144253   1.27701     scheduler_tick
c013bcac 103670   0.917746    blk_queue_bounce
c012f250 73437    0.650106    generic_file_write
c01143d8 50347    0.4457      load_balance
c012deb0 39488    0.34957     unlock_page
c013563c 35625    0.315373    rmqueue
c01432ac 32983    0.291984    __block_prepare_write
c013b548 28023    0.248076    flush_all_zero_pkmaps
c0141bb8 17749    0.157124    __find_get_block_slow
c012dca4 15073    0.133435    add_to_page_cache
c014e7ab 8010     0.0709091   .text.lock.namei
c013428c 7957     0.0704399   lru_cache_add
c016db38 7334     0.0649248   ext2_free_branches
c016d5b0 7030     0.0622336   ext2_get_block
c012e100 6578     0.0582322   find_lock_page
c01435e8 6559     0.058064    __block_commit_write
c012e52c 6368     0.0563732   file_read_actor
c013c34c 5913     0.0523453   mempool_alloc
