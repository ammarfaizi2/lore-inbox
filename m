Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291693AbSBALMN>; Fri, 1 Feb 2002 06:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291694AbSBALMD>; Fri, 1 Feb 2002 06:12:03 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:42142 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S291693AbSBALLz>; Fri, 1 Feb 2002 06:11:55 -0500
Message-Id: <200202011111.g11BBVf0009257@tigger.cs.uni-dortmund.de>
To: Larry McVoy <lm@work.bitmover.com>, Keith Owens <kaos@ocs.com.au>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin 
In-Reply-To: Message from Larry McVoy <lm@bitmover.com> 
   of "Thu, 31 Jan 2002 17:04:28 PST." <20020131170428.V1519@work.bitmover.com> 
Date: Fri, 01 Feb 2002 12:11:30 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy <lm@bitmover.com> said:
> On Fri, Feb 01, 2002 at 11:29:58AM +1100, Keith Owens wrote:
> > That sounds almost like what I was looking for, with two differences.
> > 
> > (1) Implement the collapsed set so bk records that it is equivalent to
> >     the individual patchsets.  Only record that information in my tree.
> >     I need the detailed history of what changes went into the collapsed
> >     set, nobody else does.
> > 
> > (2) Somebody else creates a change against the collapsed set and I pull
> >     that change.  bk notices that the change is again a collapsed set
> >     for which I have local detail.  The external change becomes a
> >     branch off the last detailed patch in the collapsed set.
> 
> This is certainly possible to do.  However, unless you are willing to fund
> this development, we aren't going to do it.  We will pick up the costs of
> making changes that you want if and only if we have commercial customers
> who want (or are likely to want) the same thing.  Nothing personal, it's
> a business and we make tradeoffs like that all the time.

I wonder how your commercial customers develop code then. Either each
programmer futzes around in his/her own tree, and then creates a patch (or
some such) for everybody to see (then I don't see the point of source
control as a help to the individual developer), or everybody sees all the
backtracking going on everywhere (in which case the repository is a mostly
useless mess AFAICS).
-- 
Horst von Brand			     http://counter.li.org # 22616
