Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263990AbTHLJwI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 05:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265591AbTHLJwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 05:52:08 -0400
Received: from smtp.preferred.com ([206.228.243.21]:7658 "EHLO
	smtp.preferred.com") by vger.kernel.org with ESMTP id S263990AbTHLJwF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 05:52:05 -0400
Message-ID: <3F38B8CE.7090007@xtn.net>
Date: Tue, 12 Aug 2003 05:52:14 -0400
From: Ed Cogburn <ecogburn@xtn.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030714 Debian/1.4-2
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] CodingStyle fixes for drm_agpsupport
References: <jnSd.6CM.1@gated-at.bofh.it> <jo20.6MB.31@gated-at.bofh.it> <jouY.7jw.9@gated-at.bofh.it> <jov3.7jw.37@gated-at.bofh.it> <joEI.7s9.9@gated-at.bofh.it> <joOj.7Aj.11@gated-at.bofh.it> <jphi.85s.1@gated-at.bofh.it> <jphn.85s.17@gated-at.bofh.it>
In-Reply-To: <jphn.85s.17@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:
> On Mon, Aug 11, 2003 at 01:53:17PM -0400, Jeff Garzik wrote:
> 
>>Larry McVoy wrote:
>>are function calls at a 10-nanosecond glance.  Also, having two styles 
>>of 'if' formatting in your example just screams "inconsistent" to me :)
> 
> 
> It is inconsistent, on purpose.  It's essentially like perl's
> 
> 	return unless pointer;
> 
> which is a oneliner, almost like an assert().
> 
> Maybe this will help: I insist on braces on anything with indentation so
> that I can scan them more quickly.  If I gave you a choice between
> 
> 	if (!pointer) {
> 		return (whatever);
> 	}
> 
> 	if (!pointer) return (whatever);
> 
> which one will you type more often?  I actually don't care which you use,
> I prefer the shorter one because I don't measure my self worth in lines 
> of code generated, I tend to favor lines of code deleted :)  But either
> one is fine, I tend to use the first one if it has been a problem area
> and I'm likely to come back and shove in some debugging.


I prefer keeping the conditional statement separate from the condition, but 
either way works.  One thing I've noticed though is that one line if statements 
are difficult to debug in a debugger because there is no way to tell by watching 
the current debug line whether the conditional statement was executed or not. 
For that reason I use a two line if.  Of course, rumor has it that real 
programmers don't use debuggers....  :)

I would rather use the extra lines for two line if statements, then make up for 
that used space by avoiding unnecessary braces.

