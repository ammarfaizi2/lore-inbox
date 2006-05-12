Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751212AbWELMlM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbWELMlM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 08:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbWELMlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 08:41:12 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:47877 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751212AbWELMlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 08:41:12 -0400
Date: Fri, 12 May 2006 14:40:41 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Patrick McHardy <kaber@trash.net>, "David S. Miller" <davem@davemloft.net>,
       sfrost@snowman.net, gcoady.lk@gmail.com, laforge@netfilter.org,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       marcelo@kvack.org
Subject: Re: [PATCH] fix mem-leak in netfilter
Message-ID: <20060512124041.GA31714@w.ods.org>
References: <20060507093640.GF11191@w.ods.org> <egts52hm2epfu4g1b9kqkm4s9cdiv3tvt9@4ax.com> <20060508050748.GA11495@w.ods.org> <20060507.224339.48487003.davem@davemloft.net> <44643BFD.3040708@trash.net> <9a8748490605120409x3851ca4fn14fc9c52500701e4@mail.gmail.com> <44647280.1030602@trash.net> <9a8748490605120513w4b078642k816dfef6ab907823@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490605120513w4b078642k816dfef6ab907823@mail.gmail.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2006 at 02:13:32PM +0200, Jesper Juhl wrote:
> On 5/12/06, Patrick McHardy <kaber@trash.net> wrote:
> >Jesper Juhl wrote:
> >> On 5/12/06, Patrick McHardy <kaber@trash.net> wrote:
> >>
> >>> I haven't seen any cleanup patches so far, so I think I'm
> >>> going to start my nth try at cleaning up this mess.
> >>> Unfortunately its even immune to Lindent ..
> >>>
> >>
> >> If you get too fed up with it, let me know, and I'll give it a go as 
> >well.
> >
> >Thanks, I'm about half-way through (and about to kill someone),
> >just started with the biggest pile of crap (the match function)
> >and already noticed a possible endless loop within the first
> >couple of lines.
> >
> >Unfortunately this stuff is so unreadable that I'm not exactly
> >sure if the loop really won't terminate, an extra pair of eyes
> >would be appreciated.
> >
> 
> Sure thing.
> 
> I don't have time to look at it today (friends comming over for
> dinner), but I should have plenty of time for it tomorrow. So, if you
> could send me your patch once you are done for the day, then I'll look
> it over and see if I can find anything to add on top of your work (or
> have anything to comment on) and bounce it back to you sometime during
> tomorrow.

Please post it to the list, this coding style needs far more than two
pairs of eyes to be fixed. It has already discouraged several people,
the more we will be, the least pain we will feel :-)

Cheers
Willy

