Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261507AbVCBXiq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261507AbVCBXiq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 18:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbVCBXgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 18:36:44 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:6418 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261346AbVCBXfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 18:35:14 -0500
Date: Thu, 3 Mar 2005 00:34:59 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Greg KH <greg@kroah.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050302233459.GB30106@alpha.home.local>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org> <20050302230400.GA9394@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050302230400.GA9394@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Wed, Mar 02, 2005 at 03:04:01PM -0800, Greg KH wrote:
> /me kills my patchbomb script for now
> 
> On Wed, Mar 02, 2005 at 02:21:38PM -0800, Linus Torvalds wrote:
> > 
> >  - 2.6.<even>: even at all levels, aim for having had minimally intrusive 
> >    patches leading up to it (timeframe: a week or two)
> > 
> > with the odd numbers going like:
> > 
> >  - 2.6.<odd>: still a stable kernel, but accept bigger changes leading up 
> >    to it (timeframe: a month or two).
> 
> Ok, that's acceptable to me, but realize that this puts a bigger burden
> on the maintainers to queue up patches for you.  It's not that big of a
> deal, just something to be aware of.

Not necessaruly, because the rules could be more relaxed during -rc stage
in an odd release, and stable releases could be shorter, so at the end, the
"patch fridge" would be needed only between the very end of the odd version
and the start of the even one.

Another possibility is for developpers to start to submit/merge patches for
the next odd release while the even one is still in -rc.

> Speaking of which, does this mean I shouldn't hit you with all of my
> pending stuff?  I know some of the other subsystem maintainers have a
> lot of stuff queued up too.  Should we start this new numbering scheme
> as of today?  Or wait until 2.6.13?

if there is so much pending stuff, why not sacrifice 2.6.12, use 2.6.13
to fix a bit and merge even more, then 2.6.14 would be the real first
stable release ?

Regards,
Willy

