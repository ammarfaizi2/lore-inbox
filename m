Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262907AbTJGWUT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 18:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262930AbTJGWUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 18:20:19 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:25077 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262907AbTJGWUP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 18:20:15 -0400
Message-ID: <3F833C06.7000802@mvista.com>
Date: Tue, 07 Oct 2003 15:19:50 -0700
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Clayton Weaver <cgweav@email.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Circular Convolution scheduler
References: <20031006161733.24441.qmail@email.com>
In-Reply-To: <20031006161733.24441.qmail@email.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I'll admit my ignorance.  What is circular convolution?  Where can 
I learn more?

-g

Clayton Weaver wrote:
> Though the mechanism is doubtless familiar
> to signal processing and graphics implementers,
> it's probably not thought of much in a
> process scheduling contex (although there was
> the Evolution Scheduler of a few years ago,
> whose implementer may have had something like
> circular convolution in mind). It just seems to me
> (intuition) that the concept of what circular convolution does is akin to what we've been
> feeling around for with these ad hoc heuristic
> tweaks to the scheduler to adjust for interactivity
> and batch behavior, searching for an incremental self-adjusting mechanism that favors interactivity
> on demand.
> 
> I've never implemented a circular convolver in
> any context, so I was wondering if anyone who
> has thinks scheduler prioritization would be
> simpler if implemented directly as a circular convolution.
> 
> (If nothing else, it seems to me that the abstract model of what the schedule prioritizer is doing
> would be more coherent than it is with ad hoc
> code. This perhaps reduces the risk of unexpected side-effects of incremental tweaks to the scheduler. The behavior of an optimizer that implements
> an integer approximation of a known mathematical transform when you change its inputs is fairly predictable.)
> 
> Regards,
> 
> Clayton Weaver
> <mailto: cgweav@email.com>
> 
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

