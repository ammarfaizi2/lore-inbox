Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316173AbSEKANj>; Fri, 10 May 2002 20:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316176AbSEKANi>; Fri, 10 May 2002 20:13:38 -0400
Received: from asooo.flowerfire.com ([63.254.226.247]:64652 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S316173AbSEKANh>; Fri, 10 May 2002 20:13:37 -0400
Date: Fri, 10 May 2002 19:13:05 -0500
From: Ken Brownfield <ken@irridia.com>
To: Luigi Genoni <kernel@Expansa.sns.it>
Cc: Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@redhat.com>, dank@kegel.com,
        arjanv@redhat.com, marcelo@conectiva.com.br, khttpd-users@alt.org,
        linux-kernel@vger.kernel.org
Subject: Re: khttpd rotten?
Message-ID: <20020510191305.B17142@asooo.flowerfire.com>
In-Reply-To: <20020509110925.A10839@infradead.org> <Pine.LNX.4.44.0205091502290.490-100000@Expansa.sns.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been using it quite fruitfully.  I think taking it out of 2.4 isn't
a good decision.  If 2.4 is supposed to be a stable tree with few major
changes, suddenly taking out functionality that some people rely on
seems inconsistent with that goal.  This action would be much more fatal
for the average person who doesn't routinely add feature patchsets to
their kernels, unlike most of us.

However, I am by no means saying khttpd deserves to be in the kernel,
per se.  But the decision to remove or not should be a consensus either
way.

Taking it out of 2.5 seems like a very good idea, especially if it's not
being maintained, and especially once TUX2 becomes production-quality,

Replace khttpd with TUX2 in 2.5, says this 'more silent' khttpd user. :)
-- 
Ken.
ken@irridia.com


On Thu, May 09, 2002 at 03:04:26PM +0200, Luigi Genoni wrote:
| 
| 
| On Thu, 9 May 2002, Christoph Hellwig wrote:
| 
| > On Thu, May 09, 2002 at 02:49:12AM -0700, David S. Miller wrote:
| > >    > have little time to fix it.  I say pull it from
| > >    > 2.4.19-pre9.  Marcello, put it out of its misery asap, please...
| > >    > it'd time for khttpd to become a standalone patch again.
| > >
| > >    Okay, what about the following:
| > >
| > > Are you willing to start being the khttp maintainer?
| > >
| > > I have not seen updates or any attempts at maintaining the
| > > thing in about 2 years.  Basically, since it went into the
| > > tree.
| > >
| > > If we aren't changing that situation, we are not removing
| > > the impetus for taking khttpd out of the tree entirely.
| >
| > If khttpd is out-of-tree I volunteer for collecting patches if that
| > is enough for the maintainer status.  But I have to admit that I don't
| > really care for it..
| > -
|  I do care, but I have no time at all.
| Onestly, I do not think I am the only one using khttpd fruitfully, but I
| tend to suspect that people using it are more silent in front of people
| who do not care for it.
| 
| 
| 
| 
| 
| -
| To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
| Please read the FAQ at  http://www.tux.org/lkml/
