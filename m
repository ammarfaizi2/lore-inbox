Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264059AbTE0TuF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 15:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264062AbTE0TuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 15:50:04 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:44531 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S264059AbTE0TuD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 15:50:03 -0400
Message-ID: <3ED3C433.6020002@mvista.com>
Date: Tue, 27 May 2003 13:01:55 -0700
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: davidm@hpl.hp.com
CC: Andrew Morton <akpm@digeo.com>,
       Richard C Bilson <rcbilson@plg2.math.uwaterloo.ca>,
       linux-kernel@vger.kernel.org, Eric Piel <Eric.Piel@Bull.Net>,
       Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
Subject: Re: setitimer 1 usec fails
References: <20030526142555.67a79694.akpm@digeo.com>	<3ED28E95.6000701@mvista.com> <16083.44589.855335.531141@napali.hpl.hp.com>
In-Reply-To: <16083.44589.855335.531141@napali.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger wrote:
>>>>>>On Mon, 26 May 2003 15:00:53 -0700, george anzinger <george@mvista.com> said:
> 
> 
>   George> As a test, you might try your test with HZ=1000 (a number I
>   George> recommend for ia64, if at all possible).
> 
> I suspect you might have a slightly biased view on this. ;-) Yes,
> HZ=1000 makes some problems easier to convert ticks to real time, but
> slower to convert real time to ticks.

Ulrich has written something on this.  Maybe he could comment  :)

-g

> 
> Besides, the Linux kernel MUST work with (fairly) arbitrary HZ values,
> because some platforms just don't have much of a choice (e.g., Alpha
> is pretty much forced to 1024Hz).
> 
> But, yes, on ia64 we can choose HZ to our liking.  If someone presents
> evidence that shows a real benefit for a value other than 1024, I'm
> certainly willing to listen.
> 
> 	--david
> 
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

