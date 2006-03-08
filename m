Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932509AbWCHJP1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932509AbWCHJP1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 04:15:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932533AbWCHJP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 04:15:27 -0500
Received: from smtp.osdl.org ([65.172.181.4]:63423 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932509AbWCHJPZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 04:15:25 -0500
Date: Wed, 8 Mar 2006 01:12:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: 76306.1226@compuserve.com, torvalds@osdl.org, lee.schermerhorn@hp.com,
       michaelc@cs.wisc.edu, jesper.juhl@gmail.com,
       linux-kernel@vger.kernel.org, James.Bottomley@steeleye.com
Subject: Re: Slab corruption in 2.6.16-rc5-mm2
Message-Id: <20060308011254.6cc7a190.akpm@osdl.org>
In-Reply-To: <440E9DBE.209@yahoo.com.au>
References: <200603080129_MC3-1-BA15-47C9@compuserve.com>
	<440E969B.2080301@yahoo.com.au>
	<20060308004659.163b6e29.akpm@osdl.org>
	<440E9DBE.209@yahoo.com.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> > Often I'll check that a patch reverts successfully from the upstream tree
>  > before dropping it, but for an obvious one like that I guess I didn't
>  > bother, and assumed that James had taken it.  Only he hadn't - instead he'd
>  > gone and merged something else, hence the rejects.   Oh well.
>  > 
> 
>  You do a great job, but "push the work out to the end nodes", right?
>  That's how we get this network to scale. It is trivial for people to
>  verify their important patches have propogated as the release approaches.
> 
>  (A little harder for part-timers who aren't in the loop about exactly
>  when the release will happen, thanks to our -ridiculous-count release
>  system, but still easy compared with your having to double check
>  everything).

Well yes, Lee sent the fix to the guy who he got the kernel release from in
the reasonable expectation that I'd take care of getting it to where it
needed to be.

Problem is, a) I screwed up, b) James screwed up and c) someone just
happened to change those few lines of code in that place within a few-day
window.

That triple-combo doesn't happen very often.
