Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310158AbSCGLru>; Thu, 7 Mar 2002 06:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310186AbSCGLri>; Thu, 7 Mar 2002 06:47:38 -0500
Received: from holomorphy.com ([216.36.33.161]:25996 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S310158AbSCGLre>;
	Thu, 7 Mar 2002 06:47:34 -0500
Date: Thu, 7 Mar 2002 03:47:21 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
        riel@surriel.com, hch@infradead.org
Subject: Re: 2.4.19pre2aa1
Message-ID: <20020307114721.GD786@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
	riel@surriel.com, hch@infradead.org
In-Reply-To: <20020307092119.A25470@dualathlon.random> <20020307104942.GC786@holomorphy.com> <E16iw3h-00037V-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <E16iw3h-00037V-00@starship.berlin>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 7, 2002 11:49 am, William Lee Irwin III wrote:
>> 4096 threads blocked on I/O is already approaching or exceeding the
>> scalability limits of other core kernel subsystems.

On Thu, Mar 07, 2002 at 12:27:41PM +0100, Daniel Phillips wrote:
> I think he meant that with larger ram it's easy to justify making the wait
> table a little looser, to gain a tiny little bit of extra performance.
> That seems perfectly reasonable to me.  Oh, and there's also the observation
> that machines with larger ram tend to be more heavily loaded with processes,
> just because one can.


And these processes will not be waiting on pages as often, either, as
pages will be more plentiful.

>From the reports I've seen, typical numbers of waiters on pages, even
on large systems, are as much as an order of magnitude fewer in number
than 4096. It would seem applications need to wait on pages less with
the increased memory size.

Cheers,
Bill
