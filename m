Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932475AbWBPFSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932475AbWBPFSb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 00:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932477AbWBPFSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 00:18:31 -0500
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:31867 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932475AbWBPFSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 00:18:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=p48IpwDaQc7BuBcnQYu/s+VoLaA31z5cPfM2wu/kQ7gzZCndnOB55o8j4hHjt5YvItqfPJsKlgQ10Djb0sQ7Tj2f19T7dARDMkr5dFr3JZ0qFnQ8tbhpITuuGuKqox5RP6kQsPSqPc3WdG+IPCcjOfWZC8G97DQC5jO2A1Vn0Ys=  ;
Message-ID: <43F407FE.6070204@yahoo.com.au>
Date: Thu, 16 Feb 2006 16:05:02 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Coywolf Qi Hunt <qiyong@fc-cn.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [patch] make sysctl_overcommit_memory enumeration sensible
References: <20060215085456.GA2481@localhost.localdomain> <43F2EDD6.7000204@yahoo.com.au> <20060216012827.GA2702@localhost.localdomain>
In-Reply-To: <20060216012827.GA2702@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Coywolf Qi Hunt wrote:
> On Wed, Feb 15, 2006 at 08:01:10PM +1100, Nick Piggin wrote:
> 
>>Coywolf Qi Hunt wrote:
>>
>>>I see system admins often confused when they sysctl vm.overcommit_memory.
>>>This patch makes overcommit_memory enumeration sensible.
>>>
>>
>>What's the point? The current has been there for a long time, and
>>is well documented.
> 
> 
> Yes, the current is well documented and for a long time. But the design is
> insane, no matter how well and how long it is documented. Users have to read
> the document for *many times*.
> 
> The new way is logical so it would let us "read once, remember always".
> 
> 

That's just not how it's done, full stop.

If it was really a big problem, you'd add a new sysctl with the new
behaviour, put a warning printk in the kernel that says the old one
is deprecated, wait for a year or so, then remove the old one.

But I suspect it simply doesn't matter that much in this case.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
