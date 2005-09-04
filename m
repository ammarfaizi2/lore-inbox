Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751186AbVIDVYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbVIDVYG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 17:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbVIDVYF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 17:24:05 -0400
Received: from zproxy.gmail.com ([64.233.162.196]:46044 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751186AbVIDVYE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 17:24:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jqSd/0rl6tSOy73BqkNFjHEijtFIEQwCWyoEi+HftNPqT740eiF6elj9bWIlM+v3wO6WEux8sZJGHlXn/yzCxG1u7ebUwIBXmqwsEJDVdNmkO/UAkvZXdb+J+rxjStLHh1/giFcwpzn0rozAHLUwm4a+6oEI04fNHaLx2a526WA=
Message-ID: <9a87484905090414245589a3c@mail.gmail.com>
Date: Sun, 4 Sep 2005 23:24:03 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.13-mm1
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20050903130632.3124e19b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050901035542.1c621af6.akpm@osdl.org>
	 <20050903122126.GM3657@stusta.de>
	 <20050903123410.1320f8ab.akpm@osdl.org>
	 <20050903195423.GP3657@stusta.de>
	 <20050903130632.3124e19b.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/3/05, Andrew Morton <akpm@osdl.org> wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> >
> > On Sat, Sep 03, 2005 at 12:34:10PM -0700, Andrew Morton wrote:
> > > Adrian Bunk <bunk@stusta.de> wrote:
> > > >
> > > > Hi Andrew,
> > > >
> > > > it seems you dropped
> > > > schedule-obsolete-oss-drivers-for-removal-version-2.patch, but there's
> > > > zero mentioning of this dropping in the changelog of 2.6.13-mm1.
> > > >
> > > > Can you explain why you did silently drop it?
> > >
> > > It spat rejects and when I looked at the putative removal date I just
> > > didn't believe it anyway.  Send a rediffed one if you like, but
> > > October 2005 is unrealistic.
> >
> > That the date is no longer realistic is clear. What disappoints me is
> > that you didn't mention in the changelog of 2.6.13-mm1 where I'd have
> > noticed it.
> 
> Sometimes I can't be bothered getting into email threads over relatively
> unimportant stuff.  Usually it's related to the number of bugs we have.
> 
> > It semms I need my own bookkeeping of patches I sent that are in -mm to
> > notice when they get lost.
> 
> This is called "quilt".
> 

I'm wondering if it would be too much trouble to have a mm-drops list
similar to the mm-commits list.

I also like to keep track of what patches of mine get accepted and
subsequently dropped.

What I'm thinking is that it seems you have the mails to mm-commit
pretty much automated (I may be wrong, but it seems that way to me).
If they are indeed automated, then how hard would it be to set your
end up to automatically send a mail to the same people who got the
original mm-commits mail + send it to a central mm-drops list that
those of us who care about this could subscribe to?

As far as I'm concerned the mails wouldn't even need to contain a
reason (although one would of course be nice) - just a mail stating
the fact that patch xyz was dropped from the mm tree would be great.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
