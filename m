Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265725AbSJXWep>; Thu, 24 Oct 2002 18:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265726AbSJXWep>; Thu, 24 Oct 2002 18:34:45 -0400
Received: from franka.aracnet.com ([216.99.193.44]:28869 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S265725AbSJXWeo>; Thu, 24 Oct 2002 18:34:44 -0400
Date: Thu, 24 Oct 2002 15:38:36 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Erich Focht <efocht@ess.nec.de>, Michael Hohnbaum <hohnbaum@us.ibm.com>,
       landley@trommello.org
cc: linux-kernel@vger.kernel.org
Subject: Re: Crunch time -- the musical.  (2.5 merge candidate list 1.5)
Message-ID: <2862423467.1035473915@[10.10.2.3]>
In-Reply-To: <200210242351.56719.efocht@ess.nec.de>
References: <200210242351.56719.efocht@ess.nec.de>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The situation is really funny: Everybody seems to agree that the design
> ideas in my NUMA aproach are sane and exactly what we want to have on
> a NUMA platform in the end. But instead of concentrating on tuning the
> parameters for the many different NUMA platforms and reshaping this
> aproach to make it acceptable, IBM concentrates on a very much stripped
> down aproach.

>From my point of view, the reason for focussing on this was that 
your scheduler degraded the performance on my machine, rather than
boosting it. Half of that was the more complex stuff you added on
top ... it's a lot easier to start with something simple that works 
and build on it, than fix something that's complex and doesn't work
well.

I still haven't been able to get your scheduler to boot for about 
the last month without crashing the system. Andrew says he has it 
booting somehow on 2.5.44-mm4, so I'll steal his kernel tommorow and
see how it looks. If the numbers look good for doing boring things
like kernel compile, SDET, etc, I'm happy.

M.

