Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264871AbUD2VeD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264871AbUD2VeD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 17:34:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264989AbUD2VeC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 17:34:02 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:27921 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S264871AbUD2VcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 17:32:25 -0400
Message-ID: <4091757B.3090209@techsource.com>
Date: Thu, 29 Apr 2004 17:36:59 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Paul Wagland <paul@wagland.net>
CC: Rik van Riel <riel@redhat.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       David Gibson <david@gibson.dropbear.id.au>,
       Marc Boucher <marc@linuxant.com>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
References: <Pine.LNX.4.44.0404291114150.9152-100000@chimarrao.boston.redhat.com> <4FE43C97-9A20-11D8-B804-000A95CD704C@wagland.net>
In-Reply-To: <4FE43C97-9A20-11D8-B804-000A95CD704C@wagland.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Paul Wagland wrote:
> 
> On Apr 29, 2004, at 17:14, Rik van Riel wrote:
> 
>> On Thu, 29 Apr 2004, Timothy Miller wrote:
>>
>>>> "Due to $MOD_FOO's license ($BLAH), the Linux kernel community
>>>> cannot resolve problems you may encounter. Please contact
>>>> $MODULE_VENDOR for support issues."
>>>
>>>
>>> Sounds very "politically correct", but certainly more descriptive and
>>> less alarming.
>>
>>
>> More importantly, it directs the support burden to where
>> it, IMHO, belongs.
> 
> 
> Just to throw in my two cents at the end of this long debate... :-)
> 
> I heartily endorse (for what little that is worth ;-) the change in 
> text. It adds clarity, it provides more information as to where to go 
> for information. It is hard to misconstrue as a message of impending 
> doom, consider that a good synonym for tainted is corrupted, and a 
> corrupted kernel is a bad thing :-).
> 
> Cheers,
> Paul


While we're on all of this, are we going to change "tained" to some 
other less alarmist word?  Say there is a /proc file or some report that 
you can generate about the kernel that simply wants to indicate that the 
kernel contains closed-source modules, and we want to use a short, 
concise word like "tainted" for this.  "An untrusted module has been 
loaded into this kernel" would be just a bit too long to qualify.

Hmmm... how about "untrusted"?  Not sure...

