Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262500AbTANMOp>; Tue, 14 Jan 2003 07:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262506AbTANMOp>; Tue, 14 Jan 2003 07:14:45 -0500
Received: from holomorphy.com ([66.224.33.161]:60549 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262500AbTANMOo>;
	Tue, 14 Jan 2003 07:14:44 -0500
Date: Tue, 14 Jan 2003 04:23:34 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21pre2aa2
Message-ID: <20030114122334.GE919@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
References: <20021226102814.GB6938@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021226102814.GB6938@dualathlon.random>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 26, 2002 at 11:28:14AM +0100, Andrea Arcangeli wrote:
> I'm leaving for vacations in 5 minutes so hopefully this will compile
> for everybody ;) [I know, mylex still doesn't compile without backing
> out the elevator-lowlatency patch but I hadn't time to fix it yet], I'll
> be back online on 3 Jan.

Hmm. Where is init_one_highpage() defined?


Thanks,
Bill


$ grep -nr init_one_highpage .                   
./arch/i386/mm/discontig.c:47:extern void init_one_highpage(struct page *, int, int);
./arch/i386/mm/discontig.c:297:                 init_one_highpage((struct page *) (zone_mem_map + node_pfn), zone_start_pfn + node_pfn, bad_ppro);
Binary file ./arch/i386/mm/discontig.o matches
Binary file ./arch/i386/mm/mm.o matches

