Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbUCATMh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 14:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbUCATMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 14:12:37 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:27319 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S261406AbUCATMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 14:12:33 -0500
Message-ID: <40438AF8.4080206@matchmail.com>
Date: Mon, 01 Mar 2004 11:11:52 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Wagland <paul@wagland.net>
CC: Joachim B Haga <c.j.b.haga@fys.uio.no>, Peter Williams <peterw@aurema.com>,
       Timothy Miller <miller@techsource.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] O(1) Entitlement Based Scheduler
References: <fa.ftul5bl.nlk3pr@ifi.uio.no> <fa.cvc8vnj.ahebjd@ifi.uio.no>	 <yydjvflp9b8g.fsf@galizur.uio.no> <1078136291.16756.5.camel@paulw-desktop.allshare.nl>
In-Reply-To: <1078136291.16756.5.camel@paulw-desktop.allshare.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Wagland wrote:
> On Mon, 2004-03-01 at 10:18, Joachim B Haga wrote:
> 
>>Peter Williams <peterw@aurema.com> writes:
>>
>>
>>>>It seems to me that much of this could be solved if the user *were*
>>>>allowed to lower nice values (down to 0).
>>
>>[snip]
>>
>>>>to 10 (normal) to 20. Negative values could still be root-only.  So
>>>>why shouldn't this be possible? Because a greedy user in a
>>
>> 
>>
>>>More importantly it would allow ordinary users to override root's
>>>settings e.g. if (for whatever reason) the sysadmin decided to
> 
> 
>>And it's not a *security* concern, as long as the lower values are
>>still reserved.
>>
>>I would say the benefit is very small (I mean: who has ever relied on
>>it?) compared to the difficulties created for users.
> 
> 
> Under Linux, I can't say, but certainly on my old school machine (~10
> years ago) all student accounts would run at +5, all staff accounts
> would run at +0. This was handled by the login process, so re-logging in
> would not help you at all....

I think you can do this with pam or login under linux.  I know I did 
something like this, but since most of my users were samba users, it 
wasn't very useful at the time
