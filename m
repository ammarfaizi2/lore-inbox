Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751402AbWHIWTU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbWHIWTU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 18:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbWHIWTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 18:19:20 -0400
Received: from mx1.suse.de ([195.135.220.2]:25753 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751402AbWHIWTT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 18:19:19 -0400
Date: Wed, 9 Aug 2006 15:18:54 -0700
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Chuck Ebbert <76306.1226@compuserve.com>, Pavel Machek <pavel@suse.cz>,
       Josh Boyer <jwboyer@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Adrian Bunk is now taking over the 2.6.16-stable branch
Message-ID: <20060809221854.GA15395@kroah.com>
References: <200608091749_MC3-1-C796-5E8D@compuserve.com> <20060809220048.GE3691@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060809220048.GE3691@stusta.de>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2006 at 12:00:49AM +0200, Adrian Bunk wrote:
> On Wed, Aug 09, 2006 at 05:45:53PM -0400, Chuck Ebbert wrote:
> > In-Reply-To: <20060808195509.GR3691@stusta.de>
> > 
> > On Tue, 8 Aug 2006 21:55:10 +0200, Adrian Bunk wrote:
> > 
> > > > > > I believe I had 'fix pdflush after suspend' queued in Greg's tree. Is
> > > > > > it still queued or should I resend?
> > > > > 
> > > > > Is this "pdflush: handle resume wakeups"?
> > > > 
> > > > Yes. Do you have it somewhere or should I dig it up?
> > > 
> > > I've applied it.
> > 
> > Umm, is there some place we can check to see what you've applied?
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git

No, I would not use the main git tree to queue patches up.  What happens
when you want to rip the middle one out because in review it turns out
that it is incorrect?

Please use a quilt tree of patches instead, and then only commit the
patches when you do a release.  It's much simpler that way.

thanks,

greg k-h
