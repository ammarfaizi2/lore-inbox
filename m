Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261398AbVCCAF3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261398AbVCCAF3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 19:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbVCBX4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 18:56:52 -0500
Received: from mail.kroah.org ([69.55.234.183]:2705 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261407AbVCBX4C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 18:56:02 -0500
Date: Wed, 2 Mar 2005 15:55:32 -0800
From: Greg KH <greg@kroah.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050302235532.GA10075@kroah.com>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org> <20050302230400.GA9394@kroah.com> <20050302233459.GB30106@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050302233459.GB30106@alpha.home.local>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2005 at 12:34:59AM +0100, Willy Tarreau wrote:
> On Wed, Mar 02, 2005 at 03:04:01PM -0800, Greg KH wrote:
> > /me kills my patchbomb script for now
> > 
> > On Wed, Mar 02, 2005 at 02:21:38PM -0800, Linus Torvalds wrote:
> > > 
> > >  - 2.6.<even>: even at all levels, aim for having had minimally intrusive 
> > >    patches leading up to it (timeframe: a week or two)
> > > 
> > > with the odd numbers going like:
> > > 
> > >  - 2.6.<odd>: still a stable kernel, but accept bigger changes leading up 
> > >    to it (timeframe: a month or two).
> > 
> > Ok, that's acceptable to me, but realize that this puts a bigger burden
> > on the maintainers to queue up patches for you.  It's not that big of a
> > deal, just something to be aware of.
> 
> Not necessaruly, because the rules could be more relaxed during -rc stage
> in an odd release, and stable releases could be shorter, so at the end, the
> "patch fridge" would be needed only between the very end of the odd version
> and the start of the even one.

It's still a lot of work to queue up pending patches.  Over a certian
limit, it gets pretty unstable, trust me.  I'm not complaining, just
letting you know that this will push more work on the maintainers, but
hey, we scale, so it's not that big of a deal :)

> Another possibility is for developpers to start to submit/merge patches for
> the next odd release while the even one is still in -rc.

No, that's not ok to do.  We want people to focus on getting a -rc out.

thanks,

greg k-h
