Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267679AbTBYFt7>; Tue, 25 Feb 2003 00:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267686AbTBYFt7>; Tue, 25 Feb 2003 00:49:59 -0500
Received: from holomorphy.com ([66.224.33.161]:41652 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267679AbTBYFt6>;
	Tue, 25 Feb 2003 00:49:58 -0500
Date: Mon, 24 Feb 2003 21:59:09 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: James Bourne <jbourne@mtroyal.ab.ca>
Cc: mingo@elte.hu, Mike Sullivan <mike.sullivan@alltec.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Scheduling with HyperThreading
Message-ID: <20030225055909.GX10411@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	James Bourne <jbourne@mtroyal.ab.ca>, mingo@elte.hu,
	Mike Sullivan <mike.sullivan@alltec.com>,
	linux-kernel@vger.kernel.org
References: <3E5AC10B.6010705@alltec.com> <Pine.LNX.4.51.0302242240400.20688@skuld.mtroyal.ab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.51.0302242240400.20688@skuld.mtroyal.ab.ca>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Feb 2003, Mike Sullivan wrote:
>> What kernel versions will attempt to distribute jobs across physical CPUs on
>> Xeon SMP configurations.

On Mon, Feb 24, 2003 at 10:45:18PM -0700, James Bourne wrote:
> From what I've heard, Arjans' user space daemon might be the way
> things are going, it's at http://people.redhat.com/arjanv/irqbalance/ .
> The other way that you might try is the irq load balance patch that Ingo
> produced.  There is a patch that is from 2.4.20 at
> http://www.hardrock.org/kernel/2.4.20/ and it is what I'm using at work on
> our current Xeon systems (until I have the chance to test the user space
> daemon at least).

I think he's referring to the cpu scheduler, not interrupt load
balancing. mingo might have some insight into current patches for
this and current results thereof. I don't really participate in
the scheduler aside from very occasional bugfixing.


-- wli
