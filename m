Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964816AbWIPQUh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbWIPQUh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 12:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964819AbWIPQUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 12:20:37 -0400
Received: from 1wt.eu ([62.212.114.60]:47634 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S964816AbWIPQUg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 12:20:36 -0400
Date: Sat, 16 Sep 2006 18:05:20 +0200
From: Willy Tarreau <w@1wt.eu>
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, Tom Mortensen <tmmlkml@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.x libata resync
Message-ID: <20060916160520.GB18409@1wt.eu>
References: <a52a95e30609152214uc7a2114qfe681781a50db24e@mail.gmail.com> <20060916053713.GJ541@1wt.eu> <450B9940.5030609@gmail.com> <20060916063808.GK541@1wt.eu> <450C1CF2.4080308@garzik.org> <20060916155141.GA18409@1wt.eu> <450C2134.7040200@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <450C2134.7040200@garzik.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 16, 2006 at 12:07:16PM -0400, Jeff Garzik wrote:
> Willy Tarreau wrote:
> >On Sat, Sep 16, 2006 at 11:49:06AM -0400, Jeff Garzik wrote:
> >>Willy Tarreau wrote:
> >>>There are a bunch of small patches in the early 2.6 version which look
> >>>like bugfixes, but with non-descriptive comments, so I'm not sure what
> >>>they fix. Several of them would apply to 2.4, but I don't want to touch
> >>>this area as long as nobody complains about problems.
> >>Oh there are tons of SATA bug fixes that 2.4.x is missing.  One of the 
> >>biggest is the completely crappy exception handling.  If a SATA device 
> >>is unplugged or spazzes out, the system may or may not recover.
> >
> >Already encountered on sata_nv in a sun x2100 :-)
> >
> >Jeff, I did not want to blindly merge patches from 2.6 to 2.4, but if
> >you point me to a few ones you consider important, I'm willing to merge
> >them.
> 
> As was hinted, it's not that easy, otherwise someone would have done it 
> by now.  libata bug fixes require infrastructure that isn't present on 
> 2.4.  The overall codebase is just too different to easily pull out 
> select bug fixes.

Of course for those. I was thinking about those which just change one
register or things like this that I cannot identify the expected effect.
If you agree, I'll enumerate the ones I've already noticed so that you
just have to say yes/no/unknown on them. Don't worry, I don't want to
spend lots of hours on this, since as I said, I do not receive any
feedback from SATA users on 2.4 (neither positive nor negative).

Willy

