Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751124AbVHXQfV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbVHXQfV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 12:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbVHXQfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 12:35:21 -0400
Received: from zproxy.gmail.com ([64.233.162.193]:2580 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751124AbVHXQfU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 12:35:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Tw+HpE0tNQDzMflmJlSRF8T2MMR9RwPuhpMHUgy4zbWbQeCQbC3vGB7uhIA9E+OB1oS4qISBMDeIPx4fNaoY6XPh+JdGETVFkl8vL1qeGSE0/cdDcGg5SYOJu6DSzBFFnWlxkqZrbYFbDJcmrVJrrLOC0nSnGhPX3jL5WyXK52I=
Message-ID: <9a87484905082409356c549512@mail.gmail.com>
Date: Wed, 24 Aug 2005 18:35:16 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: danial_thom@yahoo.com
Subject: Re: 2.6.12 Performance problems
Cc: Patrick McHardy <kaber@trash.net>,
       Helge Hafting <helge.hafting@aitel.hist.no>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050824162425.62228.qmail@web33304.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <430B5B14.5070105@trash.net>
	 <20050824162425.62228.qmail@web33304.mail.mud.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/05, Danial Thom <danial_thom@yahoo.com> wrote:
> --- Patrick McHardy <kaber@trash.net> wrote:
> 
> > Danial Thom wrote:
> > > I think part of the problem is the continued
> > > misuse of the word "latency". Latency, in
> > > language terms, means "unexplained delay".
> > Its
> > > wrong here because for one, its explainable.
> > But
> > > it also depends on your perspective. The
> > > "latency" is increased for kernel tasks,
> > while it
> > > may be reduced for something that is getting
> > the
> > > benefit of preempting the kernel. So you
> > really
> > > can't say "the price of reduced latency is
> > lower
> > > throughput", because thats simply backwards.
> > > You've increased the kernel tasks latency by
> > > allowing it to be pre-empted. Reduced latency
> > > implies higher efficiency. All you've done
> > here
> > > is shift the latency from one task to
> > another, so
> > > there is no reduction overall, in fact there
> > is
> > > probably a marginal increase due to the
> > overhead
> > > of pre-emption vs doing nothing.
> >
> > If instead of complaining you would provide the
> > information
> > I've asked for two days ago someone might
> > actually be able
> > to help you.
> 
> Because gaining an understanding of how the
> settings work is better than having 30 guys
> telling me to tune something that is only going
> to make a marginal difference. I didn't ask you
> to tell me what was wrong with my setup, only
> whether its expected that 2.6 would be less
> useful in a UP setup than 2.4, which I think
> you've answered.
> 

I hope you're implying that the answer is; no, it's not expected that
2.6 is less useful in a UP setup than 2.4  :-)

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
