Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964779AbWGEJMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964779AbWGEJMS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 05:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964780AbWGEJMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 05:12:18 -0400
Received: from ms-smtp-05.tampabay.rr.com ([65.32.5.135]:34300 "EHLO
	ms-smtp-05.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S964779AbWGEJMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 05:12:17 -0400
Message-ID: <44AB8257.7000406@cfl.rr.com>
Date: Wed, 05 Jul 2006 05:11:51 -0400
From: Mark Hounschell <dmarkh@cfl.rr.com>
Reply-To: dmarkh@cfl.rr.com
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: Esben Nielsen <nielsen.esben@googlemail.com>
CC: Ulrich Drepper <drepper@gmail.com>, linux-kernel@vger.kernel.org,
       glibc-cvs@sourceware.org
Subject: Re: Where can I get glibc with PI futex support (for -RT tests) ?
References: <Pine.LNX.4.64.0607050133240.2448@localhost.localdomain> <a36005b50607041728h1442ebaapdd9d13b5d13fd3c4@mail.gmail.com> <Pine.LNX.4.64.0607051032070.4248@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.64.0607051032070.4248@localhost.localdomain>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Esben Nielsen wrote:
> On Tue, 4 Jul 2006, Ulrich Drepper wrote:
> 
>> On 7/4/06, Esben Nielsen <nielsen.esben@googlemail.com> wrote:
>>>  The answer is probably on the list, but I can't find it in the
>>>  archives..:-(
>>
>> You have to wait your turn like everybody else.  Ingo/Thomas have one
>> more bug to fix.  After that I'll check in the patches into the cvs
>> archive.
>>
> 
> Can I get what you have now? Then I can do some testing.
> I might very well be that the bug doesn't matter for me. What is the bug?
> 
> I tried to check out from cvs
> (:pserver:anoncvs@sources.redhat.com:/cvs/glibc) but that can't even
> compile because PTHREAD_MUTEX_PRIO_INHERIT_NP and
> PTHREAD_MUTEX_PRIO_PROTECT_NP isn't defined for pthread_mutex_init.c
> 
> Esben
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Isn't Ingo's patch for glibc-2.4 here?

http://people.redhat.com/mingo/PI-futex-patches/glibc-PI-futex.patch

Builds for me.

Mark
