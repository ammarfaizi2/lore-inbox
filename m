Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261966AbTJSE7Y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 00:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261968AbTJSE7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 00:59:24 -0400
Received: from diesel.grid4.com ([208.49.116.17]:2240 "EHLO diesel.grid4.com")
	by vger.kernel.org with ESMTP id S261966AbTJSE7W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 00:59:22 -0400
Date: Sun, 19 Oct 2003 01:00:19 -0400
From: Paul <set@pobox.com>
To: Larry McVoy <lm@work.bitmover.com>,
       Norman Diamond <ndiamond@wta.att.ne.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Blockbusting news, results are in
Message-ID: <20031019050019.GE13549@squish.home.loc>
Mail-Followup-To: Paul <set@pobox.com>,
	Larry McVoy <lm@work.bitmover.com>,
	Norman Diamond <ndiamond@wta.att.ne.jp>, linux-kernel@vger.kernel.org
References: <1c6401c395e7$16630d00$3eee4ca5@DIAMONDLX60> <20031019041553.GA25372@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031019041553.GA25372@work.bitmover.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy <lm@bitmover.com>, on Sat Oct 18, 2003 [09:15:53 PM] said:
> On Sun, Oct 19, 2003 at 11:16:42AM +0900, Norman Diamond wrote:
> > We need those bad block lists.  They are as necessary as they ever were.
> 
> I'm not sure why this is a news flash.  When I was at Sun a 2GB drive
> cost us $4000.  I think we sold them for $6000.  You can't buy a 2GB
> drive today nor a 20GB drive.  A 200GB drive costs $160.  That's 100
> times bigger for 25 times less money, or a net increase of price/capacity
> of 2500.  In the same period of time, CPUs have not kept up though they
> are close.
> 
> You're suprised that drives are unreliable?  Please.  You are getting
> unbelievable value from those drives and you demanded it.  Price is the
> only way people make purchasing decisions, that's why DEC got out of the
> drive business, then HP did, and then IBM did.  They couldn't afford to
> compete with the cutrate junk that we call drives today.
> 
> I'm not blaming you, I'm as bad as the next guy, I buy based on price
> as well but I have no illusions that what I am buying is reliable.
> The drives we put into servers here go through a couple weeks of all bit
> patterns being changed and even then we don't depend on them, everything
> is backed up.
> 
> I've told you guys over and over that you need to CRC the data in user
> space, we do that in our backup scripts and it tells us when the drives
> are going bad.  So we don't get burned and you wouldn't either if you
> did the same thing.
> 
> Drives are amazingly cheap, it's a miracle that they work at all, don't
> be so suprised when they don't.
> -- 
> ---
> Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
        Hi;

        I think you may be missing the point he is trying to make
in order to take your hobby horse for a spin;) He is trying to
claim, that he has a disk that is not dying, that has a bad
sector that he cant get remapped, and thus, there needs to be
support for bad blocks in the filesystem layer. (in the face
of the argument that modern disks make filesystem support of
bad blocks irrelevant.)
        As a side note, I also have a 6gig disk, which a few
years ago was, ahem, bumped during a write. It now has a handful
of screwy sectors, that I cant get rid of, even after doing
the stuff Norman describes. I used the -c option to e2fsck,
and its been doing great ever since-- a few years of use without
more bad sectors.

Paul
set@pobox.com

