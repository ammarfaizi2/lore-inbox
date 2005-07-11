Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262169AbVGKARW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262169AbVGKARW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 20:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbVGKAOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 20:14:50 -0400
Received: from warden3-p.diginsite.com ([208.147.64.186]:25845 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id S261200AbVGKAOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 20:14:08 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Ed Cogburn <edcogburn@hotpop.com>
Cc: linux-kernel@vger.kernel.org
X-X-Sender: dlang@dlang.diginsite.com
Date: Sun, 10 Jul 2005 17:13:59 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: reiser4 vs politics: linux misses out again
In-Reply-To: <dascln$lq3$1@sea.gmane.org>
Message-ID: <Pine.LNX.4.62.0507101708160.7205@qynat.qvtvafvgr.pbz>
References: <200507100510.j6A5ATun010304@laptop11.inf.utfsm.cl>
 <200507100848.05090.tomlins@cam.org> <200507102006.27152.adobriyan@gmail.com>
 <20050710202129.GA3550@mail> <dascln$lq3$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Jul 2005, Ed Cogburn wrote:

>> But in most of the changesets on the bkbits site you can go back over 2
>> years and not see anything from namesys people. Nearly all of the fixes
>> commited in the past 2-3 years are from SuSe.
>
>
> So, for the sake of argument, if IBM were to drop official support for JFS,
> we'd yank JFS out of the kernel even if there was someone else willing to
> support it?  Why does it now *matter* who supports it, as long as its being
> maintained?  And will we now block IBM's hypothetical JFS2 from the kernel
> if IBM, from the programmers up to the CEO, doesn't swear on their momma's
> grave that they'll continue to support JFS1, even if JFS1 is being
> supported by others?  Jeez, this is why it doesn't take a kernel dev to see
> the problems here, common sense seems to be an increasingly rare ingredient
> in these arguments against R4.  If I didn't know better, I'd think you were
> making this stuff up as you went along....

you are completely missing the point.

the fact that the kernel group is going to have to maintain the code over 
the long run means that it must be acceptable to them before it gets 
added.

so saying that it's supported (for now) by namesys doesn't matter. if it's 
not something that is in a state that can be maintained over the long 
term by the kernel group then it can't be accepted, exactly BECOUSE nobody 
expects an outside orginization to maintain the code forever.

Namesys is allowed to maintain the code themselves outside the kernel for 
as long as they want to (and even fork the kernel if they need to make 
changes to it that aren't acceptable to the mainline). Namesys is asking 
the core kernel team to accept their code into the mainline so that it 
will be maintained by the core kernel team for the indefinate future. This 
is why it's up to Namesys to satisfy the concerns of the core team, not 
the other way around.

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
