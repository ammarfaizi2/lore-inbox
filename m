Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267222AbTBXPhX>; Mon, 24 Feb 2003 10:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267227AbTBXPhX>; Mon, 24 Feb 2003 10:37:23 -0500
Received: from bitmover.com ([192.132.92.2]:11215 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S267222AbTBXPhW>;
	Mon, 24 Feb 2003 10:37:22 -0500
Date: Mon, 24 Feb 2003 07:47:25 -0800
From: Larry McVoy <lm@bitmover.com>
To: William Lee Irwin III <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Larry McVoy <lm@bitmover.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030224154725.GB5665@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0302221417120.2686-100000@coffee.psychology.mcmaster.ca> <1510000.1045942974@[10.10.2.4]> <20030222195642.GI1407@work.bitmover.com> <2080000.1045947731@[10.10.2.4]> <20030222231552.GA31268@work.bitmover.com> <3610000.1045957443@[10.10.2.4]> <20030224045616.GB4215@work.bitmover.com> <48940000.1046063797@[10.10.2.4]> <20030224065826.GA5665@work.bitmover.com> <20030224075142.GA10396@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030224075142.GA10396@holomorphy.com>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 23, 2003 at 11:51:42PM -0800, William Lee Irwin III wrote:
> Now it's time to turn the question back around on you. Why do you not
> want Linux to work well on a broader range of systems than it does now?

I never said that I didn't.  I'm just taking issue with the choosen path
which has been demonstrated to not work.

"Let's scale Linux by multi threading"

    "Err, that really sucked for everyone who has tried it in the past, all
    the code paths got long and uniprocessor performance suffered"

"Oh, but we won't do that, that would be bad".

    "Great, how about you measure the changes carefully and really show that?"

"We don't need to measure the changes, we know we'll do it right".

And just like in every other time this come up in every other engineering
organization, the focus is in 2x wherever we are today.  It is *never*
about getting to 100x or 1000x.

If you were looking at the problem assuming that the same code had to
run on uniprocessor and a 1000 way smp, right now, today, and designing
for it, I doubt very much we'd have anything to argue about.  A lot of
what I'm saying starts to become obviously true as you increase the 
number of CPUs but engineers are always seduced into making it go 2x 
farther than it does today.  Unfortunately, each of those 2x increases
comes at some cost and they add up.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
