Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271603AbTGQW4R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 18:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271604AbTGQW4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 18:56:16 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:43256 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S271603AbTGQW4K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 18:56:10 -0400
Message-ID: <3F172CDB.3000005@mvista.com>
Date: Thu, 17 Jul 2003 16:10:19 -0700
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Bernardo Innocenti <bernie@develer.com>, linux-kernel@vger.kernel.org,
       rmk@arm.linux.org.uk, torvalds@osdl.org
Subject: Re: do_div64 generic
References: <3F1360F4.2040602@mvista.com>	<3F149747.3090107@mvista.com>	<200307162033.34242.bernie@develer.com>	<200307172310.48918.bernie@develer.com> <20030717141608.5f1b7710.akpm@osdl.org>
In-Reply-To: <20030717141608.5f1b7710.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Bernardo Innocenti <bernie@develer.com> wrote:
> 
>>2) replace all uses of div_long_long_rem() (I see onlt 4 of them in
>>   2.6.0-test1) with do_div(). This is slightly less efficient, but
>>   easier to maintain in the long term.
> 
> 
> Ths one's OK by me.  Let's just fix the bug with minimum risk and churn.

Uh, bug?  I was not aware that there was a bug.  As far as I know, 
nothing is broken.

> 
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

