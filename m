Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267577AbTCFE5D>; Wed, 5 Mar 2003 23:57:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267687AbTCFE5D>; Wed, 5 Mar 2003 23:57:03 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:62970 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S267577AbTCFE5C>;
	Wed, 5 Mar 2003 23:57:02 -0500
Message-ID: <3E66D77D.4050800@mvista.com>
Date: Wed, 05 Mar 2003 21:07:09 -0800
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Making it easy to add system calls
References: <Pine.LNX.4.44.0303051926180.10651-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0303051926180.10651-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Wed, 5 Mar 2003, george anzinger wrote:
> 
>>SYS_CALL(clock_nanosleep) \
>>
>>This will put "sys_clock_nanosleep" in the call table in entry.S and 
>>define the "__NR_clock_nanosleep" for unistd.  The last entry of the 
>>enum is NR_syscalls, thus defineing and keeping this symbol current.
> 
> 
> Me no likee.

Cool.  It was just a thought that I could not put down with out doing 
the code :)


-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

