Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267346AbSLRTPz>; Wed, 18 Dec 2002 14:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267347AbSLRTPz>; Wed, 18 Dec 2002 14:15:55 -0500
Received: from bitmover.com ([192.132.92.2]:18600 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S267346AbSLRTPy>;
	Wed, 18 Dec 2002 14:15:54 -0500
Date: Wed, 18 Dec 2002 11:23:51 -0800
From: Larry McVoy <lm@bitmover.com>
To: Alan Cox <alan@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Dave Jones <davej@codemonkey.org.uk>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@digeo.com>
Subject: Re: Freezing.. (was Re: Intel P6 vs P7 system call performance)
Message-ID: <20021218112351.H7976@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Alan Cox <alan@redhat.com>, Linus Torvalds <torvalds@transmeta.com>,
	Dave Jones <davej@codemonkey.org.uk>,
	Horst von Brand <vonbrand@inf.utfsm.cl>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>
References: <Pine.LNX.4.44.0212180936550.2891-100000@home.transmeta.com> <200212181908.gBIJ82M03155@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200212181908.gBIJ82M03155@devserv.devel.redhat.com>; from alan@redhat.com on Wed, Dec 18, 2002 at 02:08:02PM -0500
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make it async.  So anyone can review stuff and record their feelings in a
centralized place.  We have a spare machine set up, kernel.bkbits.net, 
that could be used as a dumping grounds for patches and reviews if
master.kernel.org is too locked down.

If you force the review process into a "push" model where patches are 
sent to someone, then you are stuck waiting for them to review it and
it may or may not happen.  Do the reviews in a centralized place where
everyone can see them and add their own comments.

On Wed, Dec 18, 2002 at 02:08:02PM -0500, Alan Cox wrote:
> > And I think it could work for the kernel too, especially the stable
> > releases and for the process of getting there. I just don't really know
> > how to set it up well.
> 
> A start might be
> 
> 1.	Ack large patches you don't want with "Not for 2.6" instead
> 	of ignoring them. I'm bored of seeing the 18th resend of 
> 	this and that wildly bogus patch. 
> 
> 	Then people know the status
> 
> 2.	Apply patches only after they have been approved by the maintainer
> 	of that code area.
> 
> 	Where it is core code run it past Andrew, Al and other people
> 	with extremely good taste.
> 
> 3.	Anything which changes core stuff and needs new tools, setup
> 	etc please just say NO to for now. Modules was a mistake (hindsight
> 	I grant is a great thing), but its done. We don't want any more
> 
> 
> 4.	Violate 1-3 when appropriate as always, but preferably not to
> 	often and after consulting the good taste department 8)
> 
> Alan
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
