Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932131AbWFRHtU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbWFRHtU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 03:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932118AbWFRHtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 03:49:20 -0400
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214]:8832 "HELO
	smtp104.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932131AbWFRHtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 03:49:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=ApEv7CJ6EsMLXyk6J2tKWnLLv/gLpbkrBP9qV1aJX3zFWa6lLf6DFqQK2NVcv3YWM7XtVcgp+mo8kXnB0hr9aKV83NjmXjDr66QVoZS6NGXBn/qq/srsB3jKHRjLH2Zn93h8yPGoiXcDMgIMOZ3NVU9xmil8tsgP4FP1199WgHg=  ;
Message-ID: <44950578.1070800@yahoo.com.au>
Date: Sun, 18 Jun 2006 17:49:12 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>
CC: Andrew Morton <akpm@osdl.org>, sam@vilain.net, vatsa@in.ibm.com,
       dev@openvz.org, mingo@elte.hu, pwil3058@bigpond.net.au,
       sekharan@us.ibm.com, balbir@in.ibm.com, linux-kernel@vger.kernel.org,
       maeda.naoaki@jp.fujitsu.com, kurosawa@valinux.co.jp
Subject: Re: [RFC] CPU controllers?
References: <20060615134632.GA22033@in.ibm.com>	 <4493C1D1.4020801@yahoo.com.au> <20060617164812.GB4643@in.ibm.com>	 <4494DF50.2070509@yahoo.com.au> <4494EA66.8030305@vilain.net>	 <4494EE86.7090209@yahoo.com.au>  <20060617234259.dc34a20c.akpm@osdl.org> <1150616176.7985.50.camel@Homer.TheSimpsons.net>
In-Reply-To: <1150616176.7985.50.camel@Homer.TheSimpsons.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:
> On Sat, 2006-06-17 at 23:42 -0700, Andrew Morton wrote:
> 
>>On Sun, 18 Jun 2006 16:11:18 +1000
>>Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>>Again, I don't care about the solutions at this stage. I want to know
>>>what the problem is. Please?
>>
>>Isolation.  To prevent one group of processes from damaging the performance
>>of other groups, by providing manageability of the resource consumption of
>>each group.  There are plenty of applications of this, not just
>>server-consolidation-via-server-virtualisation.
> 
> 
> Scheduling contexts do sound useful.  They're easily defeated though, as
> evolution mail demonstrates to me every time it's GUI hangs and I see
> that a nice 19 find is running, eating very little CPU, but effectively
> DoSing evolution nonetheless (journal).  I wonder how often people who
> tried to distribute CPU would likewise be stymied by other resources.

Not entirely infrequently. Which is why it really doesn't seem like
it could be useful from a security point of view without a *huge*
amount of work and complexity... and even from a guaranteed-service
point of view, it still seems (to me) like a pretty big and complex
problem.

As a check box for marketing it sounds pretty cool though, I admit ;)

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
