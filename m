Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265168AbSLHH1m>; Sun, 8 Dec 2002 02:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265171AbSLHH1m>; Sun, 8 Dec 2002 02:27:42 -0500
Received: from holomorphy.com ([66.224.33.161]:16020 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S265168AbSLHH1l>;
	Sun, 8 Dec 2002 02:27:41 -0500
Date: Sat, 7 Dec 2002 23:35:05 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.50-bk6-wli-1
Message-ID: <20021208073505.GO11023@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

New in this release are the node-local pgdat allocation patches (which
wasn't recently written, but never mind that), Manfred's slab ctor
return code patch, and the patch to attach pmd's in the pgd slab ctor,
which relies on Manfred's patch.

	ftp://ftp.kernel.org/pub/linux/people/wli/kernels/2.5.50-bk6-wli-1/

wli-2.5.50-bk6-1  fix for still-broken driverfs memblk & node stuff
wli-2.5.50-bk6-2  remove tasklist iteration from __do_SAK()
wli-2.5.50-bk6-3  remove for_each_process() from proc_fill_super()
wli-2.5.50-bk6-4  remove do_each_thread() from cap_set_pg()
wli-2.5.50-bk6-5  remove do_each_thread() from vm86 (actually a bugfix)
wli-2.5.50-bk6-6  remove for_each_process() from UML's get_task()
wli-2.5.50-bk6-7  speed up NUMA-Q highmem mem_map initialization
wli-2.5.50-bk6-8  allocate pgdats from node-local memory on NUMA-Q
wli-2.5.50-bk6-9  remove has_stopped_jobs(), which is unused
wli-2.5.50-bk6-10 drop node > 0 IO-APIC's and PCI buses for my NUMA-Q box
wli-2.5.50-bk6-11 bump up the size of the inode cache wait table
wli-2.5.50-bk6-12 Manfred Spraul's patch for slab ctor error return codes
wli-2.5.50-bk6-13 allocate pmd's in pgd slab ctors, and use a pmd slab too


Bill
