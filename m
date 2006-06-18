Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbWFRHRM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbWFRHRM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 03:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbWFRHRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 03:17:12 -0400
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:1682 "HELO
	smtp106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750799AbWFRHRL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 03:17:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=xNINa53kLFgoLZYiOHAzClAsn5+t3MFhcpUqMgLgYAbnA9yaubSYpKiV0436Apt40JT55uM1qKsx2fQCWrL7hBsZUuME1/psGNTUwFsiMybsbzZT2VLiHlOhJE9j/K6wcYQ0WBH4aokBm4dTKboR62zhD4FJYr/coWPzxjNJYB8=  ;
Message-ID: <4494FDEF.1000604@yahoo.com.au>
Date: Sun, 18 Jun 2006 17:17:03 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Sam Vilain <sam@vilain.net>
CC: vatsa@in.ibm.com, Kirill Korotaev <dev@openvz.org>,
       Mike Galbraith <efault@gmx.de>, Ingo Molnar <mingo@elte.hu>,
       Peter Williams <pwil3058@bigpond.net.au>, Andrew Morton <akpm@osdl.org>,
       sekharan@us.ibm.com, Balbir Singh <balbir@in.ibm.com>,
       linux-kernel@vger.kernel.org, maeda.naoaki@jp.fujitsu.com,
       kurosawa@valinux.co.jp
Subject: Re: [RFC] CPU controllers?
References: <20060615134632.GA22033@in.ibm.com> <4493C1D1.4020801@yahoo.com.au> <20060617164812.GB4643@in.ibm.com> <4494DF50.2070509@yahoo.com.au> <4494EA66.8030305@vilain.net> <4494EE86.7090209@yahoo.com.au> <4494F549.7040605@vilain.net>
In-Reply-To: <4494F549.7040605@vilain.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Vilain wrote:
> Nick Piggin wrote:
> 
>>> The answer is quite simple, people who are consolidating systems and 
>>> working with fewer, larger systems, want to mark processes, groups of 
>>> processes or entire containers into CPU scheduling classes, then 
>>> either fair balance between them, limit them or reserve them a 
>>> portion of the CPU - depending on the user and what their 
>>> requirements are. What is unclear about that?
>>>
>>
>> It is unclear whether we should have hard limits, or just nice like
>> priority levels. Whether virtualisation (+/- containers) could be a
>> good solution, etc.
> 
> 
> Look, that was actually answered in the paragraph you're responding to. 
> Once again, give me a set of possible requirements and I'll find you a 
> set of users that have them. I am finding this sub-thread quite redundant.

Clearly we can't stuff everything into the kernel. What I'm asking is
what the important functionality is that people want to cover. I don't
know how you could possibly interpret it as anything else.

> 
>> If you want to *completely* isolate N groups of users, surely you
>> have to use virtualisation, unless you are willing to isolate memory
>> management, pagecache, slab caches, network and disk IO, etc.
> 
> 
> No, you have to use separate hardware. Try to claim otherwise and you're 
> glossing over the corner cases.

Well, virtualisation seems like it would get you a lot further than
containers for the same amount of work.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
