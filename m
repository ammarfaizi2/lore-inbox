Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265857AbTBCCkM>; Sun, 2 Feb 2003 21:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265863AbTBCCkM>; Sun, 2 Feb 2003 21:40:12 -0500
Received: from franka.aracnet.com ([216.99.193.44]:11471 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S265857AbTBCCkM>; Sun, 2 Feb 2003 21:40:12 -0500
Date: Sun, 02 Feb 2003 18:49:47 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: Benchmarking 59 vs -mm vs -mjb
Message-ID: <133570000.1044240585@[10.10.2.4]>
In-Reply-To: <130380000.1044239907@[10.10.2.4]>
References: <130380000.1044239907@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Going from virgin to -mjb gives a small degredation on SDET 1,2,4. 
> but a good boost on SDET 8 up to 64. I presume this is a NUMA scheduler
> effect, but haven't confirmed yet. I have Ingo's B0 patch apart from the
> topo cleanup ... not really too worried about this - slight effect on
> a huge machine at very low loads.

I mean the degradation is NUMA sched. The improvement is dcache_rcu.

M.

