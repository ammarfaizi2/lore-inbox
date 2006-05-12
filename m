Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751035AbWELMNe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbWELMNe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 08:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbWELMNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 08:13:34 -0400
Received: from wr-out-0506.google.com ([64.233.184.231]:59728 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751035AbWELMNd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 08:13:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GTpcDCZG4xAZBaWgE6DA+5y0WIgjHlfR6hQw/7TI5tjIRaIWLhSCi3prvTC73QqMKFoi1y3DlmhHe5FdN9wuyRt9Iwr+3SOU+0P4Li0kU7SaB/o/rQmPIGLjNq/jv6yZeE0fbFG76Ize9g1x2O4Jk3WC1TQwfH70qqcsB5Bolpc=
Message-ID: <9a8748490605120513w4b078642k816dfef6ab907823@mail.gmail.com>
Date: Fri, 12 May 2006 14:13:32 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Patrick McHardy" <kaber@trash.net>
Subject: Re: [PATCH] fix mem-leak in netfilter
Cc: "David S. Miller" <davem@davemloft.net>, willy@w.ods.org,
       sfrost@snowman.net, gcoady.lk@gmail.com, laforge@netfilter.org,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       marcelo@kvack.org
In-Reply-To: <44647280.1030602@trash.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060507093640.GF11191@w.ods.org>
	 <egts52hm2epfu4g1b9kqkm4s9cdiv3tvt9@4ax.com>
	 <20060508050748.GA11495@w.ods.org>
	 <20060507.224339.48487003.davem@davemloft.net>
	 <44643BFD.3040708@trash.net>
	 <9a8748490605120409x3851ca4fn14fc9c52500701e4@mail.gmail.com>
	 <44647280.1030602@trash.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/06, Patrick McHardy <kaber@trash.net> wrote:
> Jesper Juhl wrote:
> > On 5/12/06, Patrick McHardy <kaber@trash.net> wrote:
> >
> >> I haven't seen any cleanup patches so far, so I think I'm
> >> going to start my nth try at cleaning up this mess.
> >> Unfortunately its even immune to Lindent ..
> >>
> >
> > If you get too fed up with it, let me know, and I'll give it a go as well.
>
> Thanks, I'm about half-way through (and about to kill someone),
> just started with the biggest pile of crap (the match function)
> and already noticed a possible endless loop within the first
> couple of lines.
>
> Unfortunately this stuff is so unreadable that I'm not exactly
> sure if the loop really won't terminate, an extra pair of eyes
> would be appreciated.
>

Sure thing.

I don't have time to look at it today (friends comming over for
dinner), but I should have plenty of time for it tomorrow. So, if you
could send me your patch once you are done for the day, then I'll look
it over and see if I can find anything to add on top of your work (or
have anything to comment on) and bounce it back to you sometime during
tomorrow.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
