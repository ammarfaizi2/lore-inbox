Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272983AbTHKSMJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 14:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272989AbTHKSMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 14:12:09 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54252 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S272983AbTHKSLu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 14:11:50 -0400
Message-ID: <3F37DC58.503@pobox.com>
Date: Mon, 11 Aug 2003 14:11:36 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
CC: davej@redhat.com, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       dri-devel@lists.sourceforge.net
Subject: Re: [PATCH] CodingStyle fixes for drm_agpsupport
References: <E19mF4Y-0005Eg-00@tetrachloride> <20030811164012.GB858@work.bitmover.com> <3F37CB44.5000307@pobox.com> <20030811170425.GA4418@work.bitmover.com> <3F37CF4E.3010605@pobox.com> <20030811172333.GA4879@work.bitmover.com> <3F37D80D.5000703@pobox.com> <20030811175941.GB4879@work.bitmover.com>
In-Reply-To: <20030811175941.GB4879@work.bitmover.com>
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

perl is a yucky language full of hacks like this... one of the reasons 
why I love it :)

So while perl's syntax sugar allows my hands to type a bit less, I'll 
often find myself following a C style and doing

	return
		unless statement;

In general, I will continue to say the 'if' test should be completely 
separately from the statement, no matter how short either are.


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
> 
> Before you say "lose the braces" try reading more code and see how much faster
> it is if all indented stuff has braces.  You whiz through it.

Unless you get more than one or two independent 'if' tests like that, 
then all those braces for a one-line test eat up wasted screen real 
estate, slowing down the person reading the code.

So, if you gave me the choice above, I would choose option C, neither :)


>>Absolutely not.  I'm cooler, so my opinion counts more.
> 
> 
> You are in North Carolina, I'm in San Francisco.  No competition, you are
> sweating like a pig :)
> 
> 
>>>Same for your eyes when you get to my age.  
>>
>>I bet when you were in school, you had to chip your homework into slate, 
>>and dinner was brontosaurus-kebob, right?
> 
> 
> Dinner?  You got dinner?  Damn, you were spoiled.

hehe :)

	Jeff



