Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964963AbVJDUfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964963AbVJDUfo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 16:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964964AbVJDUfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 16:35:44 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:9230 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S964963AbVJDUfn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 16:35:43 -0400
Message-ID: <4342E7B6.7050500@tmr.com>
Date: Tue, 04 Oct 2005 16:36:06 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dan C Marinescu <dan_c_marinescu@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: The price of SELinux (CPU)
References: <43421F46.8030202@comcast.net> <20051004070609.18835.qmail@web35504.mail.mud.yahoo.com>
In-Reply-To: <20051004070609.18835.qmail@web35504.mail.mud.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan C Marinescu wrote:
> the benchmark "results" _look_ like being authored by
> some qa engineers... or sysadmins or something...
> 
> *** only a deep/intimate knowledge of kernel and fs
> and acl implementation details and many other areas
> could suggest a credible conclusion (most likely
> without even needing any "profiling" at all... on pure
> theoretical basis, mostly because you would know what
> goes where and when and how and why and how much it
> adds here and there, etc, etc, etc)

Any results not based on actual measurement are called "guesses" rather 
than "data." Such deep knowlege is useful to determine what to measure, 
not what you would measure if you thought it were necessary.

The measurements are very useful, in that they show the magnitude of the 
performance impact using a benchmark which was constructed to emulate 
certain real world loads. Since no one number or even series of numbers 
can fully describe what *will* happen, but these numbers show what 
*could* happen.
> 
> and i personally have a strong doubt that if the cpu
> activity was statistically increased with 7% for the
> very same elementary I/O, linus would have accepted
> this degradation... my $0.02... :-)

For some applications the issue isn't how fast the O/S runs, but if it 
is secure enough to be run at all. Given the speed of even commodity 
computers, it's probable that even a 2:1 slowdown would still result in 
useful operation, compared to doing the work without a computer.

I can't speak for Linus' thinking of course, but I have worked in secure 
environments before, both DOD and DOE, and information control is vital.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
