Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262291AbTJNMmJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 08:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262312AbTJNMmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 08:42:09 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:43502 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262291AbTJNMmG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 08:42:06 -0400
Message-ID: <3F8BEF14.6050503@mvista.com>
Date: Tue, 14 Oct 2003 05:41:56 -0700
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: "'high-res-timers-discourse@lists.sourceforge.net'" 
	<high-res-timers-discourse@lists.sourceforge.net>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] VST (tick elimination) is now available
References: <3F873067.9020805@mvista.com> <20031014110218.GA20211@elf.ucw.cz>
In-Reply-To: <20031014110218.GA20211@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> 
>>The first release of the VST package is now available.  VST or 
>>Variable Scheduling Timeouts (or if you prefer, Variable Sleep Times) 
>>contains code that, from the idle task, scans the timer list and, if 
>>no timer is near, skips the timer interrupts that would otherwise be 
>>generated.  The patch name is hrtimers-vst-*
>>
>>The net result is that a quite system will use far less power as it 
>>does not need to wake up ever 1/HZ timer tick.
> 
> 
> Do you have some measurements of how much power does it save? Making
> Sharp Zaurus run longer on batteries would certainly be nice ;-).
> 								Pavel

Not just yet.  This is a first cut and a good deal of work still needs 
doing.  I could also say that that is why I put it out there :)
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

