Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751171AbVJXRCP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbVJXRCP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 13:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbVJXRCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 13:02:15 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:26104 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1751168AbVJXRCN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 13:02:13 -0400
In-Reply-To: <1130125681.5296.5.camel@imap.mvista.com>
References: <DFD605A2-4406-11DA-8ABF-000A959BB91E@mvista.com> <1130125681.5296.5.camel@imap.mvista.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <dd482d921b104651fc20959ad4acf161@mvista.com>
Content-Transfer-Encoding: 7bit
Cc: Roy Reichwein <rreichwein@mvista.com>, robustmutexes@lists.osdl.org,
       linux-kernel@vger.kernel.org, Kevin Morgan <kmorgan@mvista.com>
From: david singleton <dsingleton@mvista.com>
Subject: Re: Robust Futexes status
Date: Mon, 24 Oct 2005 10:02:11 -0700
To: Sven-Thorsten Dietrich <sven@mvista.com>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Oct 23, 2005, at 8:48 PM, Sven-Thorsten Dietrich wrote:

> On Sun, 2005-10-23 at 13:52 -0700, david singleton wrote:
>> 	Inaky Perez-Gonzalez   has a wonderful suite of performance, stress 
>> and
>> functionality tests for the fusyn pthreads mutex package.
>
>> 	The graphs are just to show relative performance for the different
>> flavor kernels.  The
>> kernel's perform quite closely regardless of the 'flavor' of kernel.
>> The kernels have quite a few
>> debugging options turned so I can look for any problems so performance
>> is not optimal.
>>
>
> The Mutex ownership change seems to climb with waiting threads.
>
> Its hard to tell with the log-n X-axis scale, but does this possibly
> correlate to the deadlock-detect option?

It could be.  I have been running all the tests mainly as stress and
functionality tests.
>
> If Deadlock-detect is enabled we should be seeing a graph proportional
> to n-squared on a linear X axis.
>
> If deadlock detect is disabled, the wait time should plateau for very
> large N.

The original run script ran up to 7500 waiting threads.  I ran a version
that only went up to 400 threads.

When I get full performance data I'll post it.

David
>
> Sven
>
>
>> 	It appears the robust futex functionality is healthy in all flavors 
>> of
>> kernel.
>>
>> 	
>>
>> David
>>
>>
>>
>>
> -- 
> ***********************************
> Sven-Thorsten Dietrich
> Real-Time Software Architect
> MontaVista Software, Inc.
> 1237 East Arques Ave.
> Sunnyvale, CA 94085
>
> Phone: 408.992.4515
> Fax: 408.328.9204
>
> http://www.mvista.com
> Platform To Innovate
> ***********************************
>

