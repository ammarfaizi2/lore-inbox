Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317622AbSHOXZU>; Thu, 15 Aug 2002 19:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317623AbSHOXZU>; Thu, 15 Aug 2002 19:25:20 -0400
Received: from holomorphy.com ([66.224.33.161]:34748 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317622AbSHOXZR>;
	Thu, 15 Aug 2002 19:25:17 -0400
Date: Thu, 15 Aug 2002 16:27:35 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.31 kmap_atomic copy_*_user benefits
Message-ID: <20020815232735.GT15685@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20020815232126.GR15685@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020815232126.GR15685@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2002 at 04:21:26PM -0700, William Lee Irwin III wrote:
> In the follow-ups I'll include oprofile numbers for each and vmstat logs.

after:


c0105394 2429647  69.5933     default_idle
c012f760 383024   10.9711     generic_file_write
c0114a40 139836   4.00538     scheduler_tick
c01145f8 77154    2.20995     load_balance
c014393c 76891    2.20242     __block_prepare_write
c01d54eb 32084    0.918994    .text.lock.ll_rw_blk
c0136732 20643    0.591285    .text.lock.page_alloc
c016e628 20171    0.577766    ext2_free_branches
c0135c1c 18996    0.54411     rmqueue
c012e96c 16750    0.479777    file_read_actor
c0140664 15094    0.432343    vfs_write
c01564d6 11752    0.336617    .text.lock.dcache
c014f1a2 11128    0.318744    .text.lock.namei
c012e4a8 11016    0.315536    find_get_page
c01d1f70 9011     0.258106    elevator_linus_merge
c01360e0 8451     0.242065    __alloc_pages
c01556c4 8283     0.237253    d_instantiate
c013e1b8 8014     0.229548    __set_page_dirty_nobuffers
c016e0a0 7710     0.220841    ext2_get_block
c0196c45 6642     0.190249    .text.lock.dec_and_lock
c0142248 6612     0.18939     __find_get_block_slow
c0134780 6507     0.186383    activate_page
