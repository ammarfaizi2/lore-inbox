Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964898AbWGEO6O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964898AbWGEO6O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 10:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964899AbWGEO6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 10:58:14 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:23432 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964898AbWGEO6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 10:58:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:x-x-sender:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type:from;
        b=TpJcKAnqHHyo3voJyEQL5Kqq3ai9yby/BrXpcEVc9NXFK8f7zUYtKdekhLIrAIr/lMj1iUDfB88rl0i3qLQGwkBnPgvnEdTC5cpg0wrqrJypoa619muzuS/DV++038VkR3YFQAtv1l5OpXmcqJ7lcRhzXAR5+g7i8p1yq7bsDTA=
Date: Wed, 5 Jul 2006 16:58:31 +0100 (BST)
X-X-Sender: simlo@localhost.localdomain
To: Mark Hounschell <dmarkh@cfl.rr.com>
cc: Esben Nielsen <nielsen.esben@googlemail.com>,
       Ulrich Drepper <drepper@gmail.com>, linux-kernel@vger.kernel.org,
       glibc-cvs@sourceware.org
Subject: Re: Where can I get glibc with PI futex support (for -RT tests) ?
In-Reply-To: <44AB8257.7000406@cfl.rr.com>
Message-ID: <Pine.LNX.4.64.0607051657550.27580@localhost.localdomain>
References: <Pine.LNX.4.64.0607050133240.2448@localhost.localdomain>
 <a36005b50607041728h1442ebaapdd9d13b5d13fd3c4@mail.gmail.com>
 <Pine.LNX.4.64.0607051032070.4248@localhost.localdomain> <44AB8257.7000406@cfl.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
From: Esben Nielsen <nielsen.esben@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 5 Jul 2006, Mark Hounschell wrote:

> Esben Nielsen wrote:
>> On Tue, 4 Jul 2006, Ulrich Drepper wrote:
>>
>>> On 7/4/06, Esben Nielsen <nielsen.esben@googlemail.com> wrote:
>>>>  The answer is probably on the list, but I can't find it in the
>>>>  archives..:-(
>>>
>>> You have to wait your turn like everybody else.  Ingo/Thomas have one
>>> more bug to fix.  After that I'll check in the patches into the cvs
>>> archive.
>>>
>>
>> Can I get what you have now? Then I can do some testing.
>> I might very well be that the bug doesn't matter for me. What is the bug?
>>
>> I tried to check out from cvs
>> (:pserver:anoncvs@sources.redhat.com:/cvs/glibc) but that can't even
>> compile because PTHREAD_MUTEX_PRIO_INHERIT_NP and
>> PTHREAD_MUTEX_PRIO_PROTECT_NP isn't defined for pthread_mutex_init.c
>>
>> Esben
>>
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
>
> Isn't Ingo's patch for glibc-2.4 here?
>
> http://people.redhat.com/mingo/PI-futex-patches/glibc-PI-futex.patch
>
> Builds for me.
>

Ok, thanks! It builds and it seems to work too :-)

Esben


> Mark
>
