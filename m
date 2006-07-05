Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932159AbWGEIeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbWGEIeK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 04:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbWGEIeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 04:34:10 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:2295 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932159AbWGEIeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 04:34:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:x-x-sender:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type:from;
        b=crP9WnpwhJI4j7zm+MlBNPmLnAHdE+kEwcKwQCe7ny3ckacfQdJZBVfiyqesKmulKTrNWHm/g48xls4pjw3hMacNmTP+4COJP2lt4UwoVS4qIOEoQkmHu5cjMB0m2vVemvkF+iZK67h/ySEOTHpY6RzpoAQXSFriE8PaE1jsIQo=
Date: Wed, 5 Jul 2006 10:34:19 +0100 (BST)
X-X-Sender: simlo@localhost.localdomain
To: Ulrich Drepper <drepper@gmail.com>
cc: linux-kernel@vger.kernel.org, glibc-cvs@sourceware.org
Subject: Re: Where can I get glibc with PI futex support (for -RT tests) ?
In-Reply-To: <a36005b50607041728h1442ebaapdd9d13b5d13fd3c4@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0607051032070.4248@localhost.localdomain>
References: <Pine.LNX.4.64.0607050133240.2448@localhost.localdomain>
 <a36005b50607041728h1442ebaapdd9d13b5d13fd3c4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
From: Esben Nielsen <nielsen.esben@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jul 2006, Ulrich Drepper wrote:

> On 7/4/06, Esben Nielsen <nielsen.esben@googlemail.com> wrote:
>>  The answer is probably on the list, but I can't find it in the
>>  archives..:-(
>
> You have to wait your turn like everybody else.  Ingo/Thomas have one
> more bug to fix.  After that I'll check in the patches into the cvs
> archive.
>

Can I get what you have now? Then I can do some testing.
I might very well be that the bug doesn't matter for me. What is the bug?

I tried to check out from cvs 
(:pserver:anoncvs@sources.redhat.com:/cvs/glibc) but that can't even 
compile because PTHREAD_MUTEX_PRIO_INHERIT_NP and 
PTHREAD_MUTEX_PRIO_PROTECT_NP isn't defined for pthread_mutex_init.c

Esben

