Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267536AbSLSIq7>; Thu, 19 Dec 2002 03:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267573AbSLSIq7>; Thu, 19 Dec 2002 03:46:59 -0500
Received: from holomorphy.com ([66.224.33.161]:15552 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267536AbSLSIq6>;
	Thu, 19 Dec 2002 03:46:58 -0500
Date: Thu, 19 Dec 2002 00:54:26 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: 2.5.52-mm2
Message-ID: <20021219085426.GJ1922@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>,
	linux-mm@kvack.org
References: <3E015ECE.9E3BD19@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E015ECE.9E3BD19@digeo.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2002 at 09:53:18PM -0800, Andrew Morton wrote:
> url: http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.52/2.5.52-mm2/

Kernel compile on ramfs, shpte off, overcommit on (probably more like a
stress test for shpte):

c0116810 187174   0.528821    pfn_to_nid
c01168b8 192912   0.545032    x86_profile_hook
c0163c0c 267362   0.755375    d_lookup
c014e530 286920   0.810632    get_empty_filp
c01b0b18 287959   0.813567    __copy_from_user
c01320cc 307597   0.86905     find_get_page
c011a6b0 331219   0.935789    scheduler_tick
c0140890 342427   0.967455    vm_enough_memory
c013fc60 353705   0.999319    handle_mm_fault
c014eb49 358710   1.01346     .text.lock.file_table
c011a1f8 379521   1.07226     load_balance
c01b0ab0 840162   2.3737      __copy_to_user
c013f5a0 1040429  2.93951     do_anonymous_page
c01358c8 1056576  2.98513     __get_page_state
c014406c 1260931  3.56249     page_remove_rmap
c0143e68 1265355  3.57499     page_add_rmap
c0106f38 21236731 59.9999     poll_idle

shpte on will follow.


Bill

