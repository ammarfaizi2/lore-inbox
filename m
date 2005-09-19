Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbVISW4D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbVISW4D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 18:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbVISW4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 18:56:03 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:51943 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S932680AbVISW4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 18:56:02 -0400
Subject: Re: PATCH: Fix race in cpu_down (hotplug cpu)
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Ingo Molnar <mingo@elte.hu>, Li Shaohua <shaohua.li@intel.com>,
       vatsa@in.ibm.com, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       lkml <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
In-Reply-To: <1127115425.5272.21.camel@npiggin-nld.site>
References: <59D45D057E9702469E5775CBB56411F171F7E0@pdsmsx406>
	 <20050919051024.GA8653@in.ibm.com>
	 <1127107887.3958.9.camel@linux-hp.sh.intel.com>
	 <20050919055715.GE8653@in.ibm.com> <1127110271.9696.97.camel@localhost>
	 <20050919062336.GA9466@in.ibm.com>
	 <1127111830.4087.3.camel@linux-hp.sh.intel.com>
	 <1127111784.5272.10.camel@npiggin-nld.site>
	 <1127113930.4087.6.camel@linux-hp.sh.intel.com>
	 <1127114538.5272.16.camel@npiggin-nld.site>
	 <20050919072842.GA11293@elte.hu>
	 <1127115425.5272.21.camel@npiggin-nld.site>
Content-Type: text/plain
Organization: Cyclades
Message-Id: <1127170547.18737.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 20 Sep 2005 08:55:47 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, 2005-09-19 at 17:37, Nick Piggin wrote:
> Thanks for the confirmation Ingo. This is part of my "cleanup resched
> and cpu_idle" patch FYI. It should already be in -mm, but has some
> trivial EM64T bug in it that Andrew hits but I can't reproduce.
> 
> I'll dust it off and send it out, hopefully someone will be able to
> reproduce the problem!

I got on the same page eventually :). When you have it ready, I'll be
happy to try it. Apart from trying another 75 suspends (which I'm happy
to do), I'm not really sure how we can be totally sure that the patch
fixes it. Do you have any thoughts in this regard?

Regards,

Nigel


