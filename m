Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264012AbUGLWiQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264012AbUGLWiQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 18:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264045AbUGLWiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 18:38:16 -0400
Received: from mail.tmr.com ([216.238.38.203]:3338 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S264012AbUGLWiO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 18:38:14 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: [announce] [patch] Voluntary Kernel Preemption Patch
Date: Mon, 12 Jul 2004 18:40:26 -0400
Organization: TMR Associates, Inc
Message-ID: <ccv3j4$suv$1@gatekeeper.tmr.com>
References: <20040711093209.GA17095@elte.hu><20040709182638.GA11310@elte.hu> <20040711024518.7fd508e0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1089671588 29663 192.168.12.100 (12 Jul 2004 22:33:08 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040608
X-Accept-Language: en-us, en
In-Reply-To: <20040711024518.7fd508e0.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Ingo Molnar <mingo@elte.hu> wrote:
> 
>>For all the
>> other 200 might_sleep() points it doesnt matter much.
> 
> 
> Sorry, but an additional 100 might_sleep()s is surely excessive for
> debugging purposes, and unneeded for latency purposes: all these sites are
> preemptible anyway.
> 
> Let me repeat that I am unconvinced as to the diagnosis of the current
> audio problems - more analysis might prove me wrong of course.
> 
> And I'm unconvinced that we need to do anything apart from identifying and
> fixing the remaining spinlocks which are holding off preemption for too
> long.
> 
> IOW, I am questioning the very need for a "voluntary preemption" feature
> at all when "involuntary preemption" works perfectly well.

You left off the smiley, if the existing approach worked perfectly well 
then users wouldn't complain and Ingo would be doing something else with 
his time.

Naturally after you identify and fix all those spinlock delays this will 
all work even better.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
