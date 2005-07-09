Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263089AbVGIDCK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263089AbVGIDCK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 23:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263095AbVGIDCK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 23:02:10 -0400
Received: from main.gmane.org ([80.91.229.2]:51387 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S263089AbVGIDCI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 23:02:08 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ed Cogburn <edcogburn@hotpop.com>
Subject: Re: reiser4 vs politics: linux misses out again
Date: Fri, 08 Jul 2005 23:25:39 -0400
Message-ID: <danen6$h3p$1@sea.gmane.org>
References: <200507040211.j642BL6f005488@laptop11.inf.utfsm.cl> <028601c581a0$cb1f3e20$2800000a@pc365dualp2> <dan077$n4t$1@sea.gmane.org> <200507082026.49404.tomlins@cam.org> <Pine.LNX.4.62.0507081737120.4458@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: nc-65-40-175-252.dyn.sprint-hsd.net
User-Agent: KNode/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang wrote:

> On Fri, 8 Jul 2005, Ed Tomlinson wrote:
> 
>>
>> No Flame from me.  One thing to remember is that Hans and friends _have_
>> supported
>> R3 for years.  This is an undisputed fact.  Second third parties have be
>> able to add much
>> function (like journaling) to R3 so the code must be sort of readable... 
>> With R4 they have created a new FS that is _fast_ and _can_ do things no
>> other FS can - I also expect they have
>> written cleaner code...  Why are we fighting about adding this sort of
>> function to the kernel?
>> Yes it may not be the absolute best way to do things.  How many times has
>> tcpip be rewritten
>> for linux?  The answer is more than once.  Lets put R4 in, see how it
>> works, generalize the ideas and if we have to rewrite and rethink part of
>> it lets do so.
> 
> remember that Hans is on record (over a year ago) arguing that R3 should
> not be fixed becouse R4 was replacing it.
> 
> This type of thing is one of the reasons that you see arguments that
> aren't 'purely code-related' becouse the kernel folks realize that _they_
> will have to maintain the code over time, Hans and company will go on and
> develop R5 (R10, whatever) and consider R4 obsolete and stop maintaining
> it.



Maybe its because Hans and Co., having only a finite amount of dev time,
would much prefer to spend that time on R4 rather than R3?  Maybe if we
were to let R4 into the kernel, it wouldn't be long after that R3 could be
retired because everyone has moved to R4?  Maybe if R4 had been allowed
into the mainstream kernel a year ago, this ENTIRE ARGUMENT would be moot?

Since when has there been a requirement for all new code to have a signed
support contract before it enters the kernel?  Don't tell me this is
normal, because I damn well know its not.  Early on and for the most part
even today, good stuff gets into the kernel without any explicit or at
least meaningful promises of long term support.  That stuff stays in the
kernel as long as there is someone willing to maintain it, and it
disappears from the kernel when there is no one left willing to keep it
up-to-date.  That has always been the basic rule, without it Linux would
never have gone beyond the stage of being Linus's toy, because if Linus had
demanded such a support commitment up front, people would have lost
interest in hacking on his toy.

Devs should be free to work on whatever they want, because most of them are
doing this on their own time anyway, otherwise they might just decide to
hack on some other OS, or a fork of Linux instead.  Demanding long term
support commitment from volunteers is just bizarre, since pretty soon, you
won't have many volunteers left, with the ones still remaining consistently
lying to you as everyone will know that the promises they are making can't
be enforced.....  As for code from companies, has Linus gotten a signed
support contract from IBM for JFS?  If he asked, do you really think they
would agree to one?

So this business of demanding a perpetual support contract from Hans for R3
before you even let R4 into the kernel is patently absurd.  Such a contract
won't be needed once R4 gets into widespread use and stabilizes, allowing
R3 users to switch over to it, never mind that this has not been required
to my knowledge of anyone else.  Either you're putting the cart before the
horse on this one without realizing it, or you're just another member of
the 'say-no-to-change' group (or worse, the say-no-to-Hans group) using any
excuse that pops into your head for why you keep saying 'no'.


