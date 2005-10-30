Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932248AbVJ3TcT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbVJ3TcT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 14:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbVJ3TcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 14:32:18 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:42906 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S932226AbVJ3TcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 14:32:16 -0500
Date: Sun, 30 Oct 2005 14:11:53 +0100
From: Pavel Machek <pavel@suse.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [git patches] 2.6.x libata updates
Message-ID: <20051030131152.GD657@openzaurus.ucw.cz>
References: <20051029182228.GA14495@havoc.gtf.org> <20051029121454.5d27aecb.akpm@osdl.org> <4363CB60.2000201@pobox.com> <Pine.LNX.4.64.0510291229330.3348@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0510291229330.3348@g5.osdl.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Even so, it's easy, to I'll ask him to test 2.6.14, 2.6.14-git1, and
> > (tonight's upcoming) 2.6.14-git2 (with my latest pull included) to see if
> > anything breaks.
> 
> Side note: one of the downsides of the new "merge lots of stuff early in 
> the development series" approach is that the first few daily snapshots end 
> up being _huge_. 
> 
> So the -git1 and -git2 patches are/will be very big indeed.
> 
> For example, patch-2.6.14-git1 literally ended up being a megabyte 
> compressed. Right now my diff to 2.6.14 (after just two days) is 1.6MB 
> compressed.
...
> Now, I've gotten several positive comments on how easy "git bisect" is to 
> use, and I've used it myself, but this is the first time that patch users 
> _really_ become very much second-class citizens, and you can't necessarily 
> always do useful things with just the tar-trees and patches. That's sad, 
> and possibly a really big downside.
> 
> Don't get me wrong - I personally think that the new merge policy is a 
> clear improvement, but it does have this downside.

Well, git bisect helps a bit, but does not really cut it. If changes are
merged slowly enough, you usually don't need to go through history;
you know it is broken, you know it worked yesterday, and diff is small enough...

				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

