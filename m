Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267854AbTCFHBu>; Thu, 6 Mar 2003 02:01:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267857AbTCFHBu>; Thu, 6 Mar 2003 02:01:50 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:59125 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S267854AbTCFHBt>;
	Thu, 6 Mar 2003 02:01:49 -0500
Message-ID: <3E66F4BA.3000904@mvista.com>
Date: Wed, 05 Mar 2003 23:11:54 -0800
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] Making it easy to add system calls
References: <3E66A44A.6000808@mvista.com> <3E66BF21.4010608@pobox.com>
In-Reply-To: <3E66BF21.4010608@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> Your patch makes it impossible to tell at an easy glance which syscall 
> is which number.  The current code makes it quite obvious which numbers 
> are assigned to which syscalls, and which syscall numbers are available 
> for use.  We lose valuable information with this patch, even if it does 
> wind up to be functionally equivalent.

Of course the numbers as well as comments on the inactive or unused 
entries could be added, just as they are today.  I had also considered 
the possiblility of adding the system call proto type as a parameter 
in the macro.  This could lead to a rather complete one entry 
description of the call.

Still, it seems to not be in favor, so I will let it drop.

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

