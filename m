Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263593AbUEKUSX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263593AbUEKUSX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 16:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263596AbUEKUSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 16:18:22 -0400
Received: from altus.drgw.net ([209.234.73.40]:36006 "EHLO kalmia.hozed.org")
	by vger.kernel.org with ESMTP id S263593AbUEKUSU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 16:18:20 -0400
Date: Tue, 11 May 2004 15:18:18 -0500
From: Troy Benjegerdes <hozer@hozed.org>
To: Andrew Morton <akpm@osdl.org>
Cc: "Peter J. Braam" <braam@clusterfs.com>,
       intermezzo-devel@lists.sourceforge.net, arjanv@redhat.com,
       linux-kernel@vger.kernel.org, anton@samba.org
Subject: Re: 9/10 intermezzos prefer eating memory
Message-ID: <20040511201818.GN11346@kalmia.hozed.org>
References: <1083486146.3842.1.camel@laptop.fenrus.com> <20040509090249.A78D03100BD@moraine.clusterfs.com> <20040509023621.00e9c1f8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20040509023621.00e9c1f8.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 09, 2004 at 02:36:21AM -0700, Andrew Morton wrote:
> "Peter J. Braam" <braam@clusterfs.com> wrote:
> >
> >  
> > Hi Andrew, 
> > 
> > I would just like to say that I have no difficulties with intermezzo being
> > rm -rf'd.  There are probably only a handful of users.   
> > 
> > In the past 4 years nobody has supported InterMezzo sufficiently for it to
> > become successful. I have been fortunate to get really good support for the
> > Lustre project.  So I have focussed on that.  Lustre 1.X has become really
> > solid.
> > 
> > The disconnected operation, caching and mirroring functionality of
> > InterMezzo will become available in Lustre as a new feature in version 2.  
> > 
> > So I see no point in keeping InterMezzo if it is a nuisance.  
> > 
> > I am also entirely happy to ask my one part time InterMezzo programmer to do
> > a better job of repeatedly sending pathes until they are in.
> > 
> > Please guide me along.  Thanks!
> > 
> 
> Thanks - such opportunities are all too rare.
> 
> Are there any distro people out there who have a significant Intermezzo
> user base, or who see any problems with this?

As one of the apparently 3 or 4 longtime users of Intermezzo, I like the
architecture, but the user-level utilities for manageing it (aka, for
resolving conflicts that occured during disconnected operation) just
aren't there, and nobody (including myself) has really had time to
devote to getting them in working shape.

I'd love to get my hands on Lustre version 2 and start beating up the
disconnected operation. If that's available in CVS somewhere, I'd vote
for rm -rf of intermezzo.

--------------------------------------------------------------------------
Troy Benjegerdes                'da hozer'                hozer@hozed.org  

Somone asked my why I work on this free (http://www.fsf.org/philosophy/)
software stuff and not get a real job. Charles Shultz had the best answer:

"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's why
I draw cartoons. It's my life." -- Charles Shultz
