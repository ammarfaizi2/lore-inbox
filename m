Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261286AbVG1Dvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261286AbVG1Dvy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 23:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261283AbVG1Dvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 23:51:54 -0400
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:62635 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261286AbVG1Dvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 23:51:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=J/U1lHb1d+V7dLqCFEiLaB6fmPAbYXB6dhOuDvr7RY73utH8jJkiW9JRAcV/UVVeuEyas/v98g+95LRbyWdWbcYWLXW74ZyTqQ5CG3pzzQxO82g33NS/XmVncraKaBgu7ZJRwtUrxS/I4vJ+6Oat8tK81co6O1TxnN0S/kJkDsU=  ;
Message-ID: <42E8564B.9070407@yahoo.com.au>
Date: Thu, 28 Jul 2005 13:51:39 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: Daniel Walker <dwalker@mvista.com>, LKML <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [RFC][PATCH] Make MAX_RT_PRIO and MAX_USER_RT_PRIO configurable
References: <1122473595.29823.60.camel@localhost.localdomain>	 <1122512420.5014.6.camel@c-67-188-6-232.hsd1.ca.comcast.net>	 <1122513928.29823.150.camel@localhost.localdomain>	 <1122519999.29823.165.camel@localhost.localdomain>	 <1122521538.29823.177.camel@localhost.localdomain> <1122522328.29823.186.camel@localhost.localdomain>
In-Reply-To: <1122522328.29823.186.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:

>OK, still looks like the generic ffb can be changed.  Unless I'm missing
>something, this shows that I probably should be sending in a patch now
>to replace the find_first_bit.  Ingo's sched_find_first_bit is still the
>winner, but that is customed to the scheduler, until we need a
>configurable priority.
>
>What do you think?
>
>  
>

Sure, if it is correct and faster.
Just don't mark the (*b) test as unlikely.


Send instant messages to your online friends http://au.messenger.yahoo.com 
