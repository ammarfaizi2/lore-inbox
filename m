Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265223AbUAJIMP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 03:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265225AbUAJIMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 03:12:15 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:18933 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S265223AbUAJIMN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 03:12:13 -0500
Message-ID: <3FFFB3D6.1050505@mvista.com>
Date: Sat, 10 Jan 2004 00:12:06 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
CC: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: kgdb cleanups
References: <20040109183826.GA795@elf.ucw.cz> <3FFF2304.8000403@mvista.com> <20040110044722.GY18208@waste.org>
In-Reply-To: <20040110044722.GY18208@waste.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:
> On Fri, Jan 09, 2004 at 01:54:12PM -0800, George Anzinger wrote:
> 
>>Pavel Machek wrote:
>>
>>>Hi!
>>>
>>>No real code changes, but cleanups all over the place. What about
>>>applying?
>>>
>>>Ouch and arch-dependend code is moved to kernel/kgdb.c. I'll probably
>>>do x86-64 version so that is rather important.
>>>
>>>								Pavel
>>
>>A few comments:
>>
>>I like the code seperation.  Does it follow what Amit is doing?  It would 
>>be nice if Amit's version and this one could come together around this.
>>
>>I don't think we want to merge the eth and regular kgdb just yet.  I would, 
>>however, like to keep eth completly out of the stub.  Possibly a new module 
>>which just takes care of steering the I/O to the correct place.
> 
> 
> I've sent Amit the start of an plug interface for abstracting the
> communication layer. Should be relatively painless and allow for
> starting sessions on the interface of your choice.
> 
May I see?
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

