Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267524AbTAQPfa>; Fri, 17 Jan 2003 10:35:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267527AbTAQPfa>; Fri, 17 Jan 2003 10:35:30 -0500
Received: from franka.aracnet.com ([216.99.193.44]:12513 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267524AbTAQPfa>; Fri, 17 Jan 2003 10:35:30 -0500
Date: Fri, 17 Jan 2003 07:44:25 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: 2.5.58-mjb2 (scalability / NUMA patchset)
Message-ID: <208640000.1042818262@titus>
In-Reply-To: <20030117094956.GF940@holomorphy.com>
References: <821470000.1041579423@titus> <214500000.1041821919@titus> <676880000.1042101078@titus> <922170000.1042183282@titus> <437220000.1042531505@titus> <190030000.1042787514@titus> <20030117094956.GF940@holomorphy.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Speed up page init on boot (Bill Irwin)
>> local_pgdat					Bill Irwin
>> 	Move the pgdat structure into the remapped space with lmem_map
> 
> Any chance you could push these Linus-ward? akpm appears to have
> lost the intestinal fortitude to carry NUMA-Q/Summit -specific stuff
> himself, which is fine, I'd just rather not see these lost in the
> shuffle, esp. as a day or two was burned on each.

The first one isn't in the tree as yet ... I just haven't been excited
enough about speeding up boot speed, to be perfectly honest, seeing as 
it still takes 5 minutes anyway. It might make more sense once kexec
works, and the percentage improvement would become significant.

The local_pgdat stuff definitely makes sense ... I'd kind of prefer it 
to go after the mem_map so I don't have to think about alignment
issues so much, but it's been stable for ages, so I guess I'll push it
as soon as Linus returns from vacation ...

M.

