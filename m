Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264801AbUEEUaX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264801AbUEEUaX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 16:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264804AbUEEUaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 16:30:23 -0400
Received: from mail.tmr.com ([216.238.38.203]:34824 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S264801AbUEEUaU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 16:30:20 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: 2.6.6-rc3-mm2 (4KSTACK)
Date: Wed, 05 May 2004 16:31:59 -0400
Organization: TMR Associates, Inc
Message-ID: <c7bin8$fg7$1@gatekeeper.tmr.com>
References: <200405051312.30626.dominik.karall@gmx.net> <20040505043002.2f787285.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1083788841 15879 192.168.12.100 (5 May 2004 20:27:21 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
In-Reply-To: <20040505043002.2f787285.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Dominik Karall <dominik.karall@gmx.net> wrote:
> 
>>On Wednesday 05 May 2004 10:31, you wrote:
>>
>>>+make-4k-stacks-permanent.patch
>>>
>>> Fill my inbox.
>>
>>Hi Andrew!
>>
>>Is there any reason why this patch was applied? Because NVidia users can't 
>>work with the original drivers now without removing this patch every time.
>>
> 
> 
> We need to push this issue along quickly.  The single-page stack generally
> gives us a better kernel and having the stack size configurable creates
> pain.

Add my voice to those who don't think 4k stacks are a good idea as a 
default, they break some things and seem to leave other paths (as others 
have noted) on the edge. I'm not sure what you have in mind as a "better 
kernel" but I'd rather have a worse kernel and not have to check 4k 
stack as a possible problem before looking at other things if I get bad 
behaviour.

Reliability first, performance later. We've lived with the config for a 
while, pain there is better than pain at runtime.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
