Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751136AbVJJSMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbVJJSMX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 14:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbVJJSMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 14:12:23 -0400
Received: from tentacle.s2s.msu.ru ([193.232.119.109]:22210 "EHLO
	tentacle.sectorb.msk.ru") by vger.kernel.org with ESMTP
	id S1751136AbVJJSMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 14:12:23 -0400
Date: Mon, 10 Oct 2005 22:12:16 +0400
From: "Vladimir B. Savkin" <master@sectorb.msk.ru>
To: john stultz <johnstul@us.ibm.com>
Cc: Andi Kleen <ak@suse.de>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, discuss@x86-64.org
Subject: Re: [PATCH] x86-64: Fix bad assumption that dualcore cpus have synced TSCs
Message-ID: <20051010181216.GA21548@tentacle.sectorb.msk.ru>
References: <1127157404.3455.209.camel@cog.beaverton.ibm.com> <20051007122624.GA23606@tentacle.sectorb.msk.ru> <200510071431.47245.ak@suse.de> <20051008101153.GA1541@tentacle.sectorb.msk.ru> <1128967404.8195.419.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1128967404.8195.419.camel@cog.beaverton.ibm.com>
X-Organization: Moscow State Univ., Institute of Mechanics
X-Operating-System: Linux 2.6.13.3
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2005 at 11:03:24AM -0700, john stultz wrote:
> >From your dmesg, it appears that there are no other timesources other
> then the TSC available on your hardware. So I'm guessing idle=poll is
> keeping the CPUs from halting the TSC and keeping them synched. 
> 
> 
> I would think that the ACPI PM timer would be supported, but I don't see
> anything about it in your dmesg. Could you make sure it is properly
> configured in?

Yes, I tried different combinations of PM_TIMER and HPET options.
In this try, PM_TIMER was definetly enabled in kernel config.

What kind of kernel message did you expect from workibf PM timer?

~
:wq
                                        With best regards, 
                                           Vladimir Savkin. 

