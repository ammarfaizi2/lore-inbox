Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263680AbTLDXqU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 18:46:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263702AbTLDXqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 18:46:20 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:12978 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S263680AbTLDXqS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 18:46:18 -0500
Date: Thu, 4 Dec 2003 15:44:54 -0800
From: Larry McVoy <lm@bitmover.com>
To: cliff white <cliffw@osdl.org>
Cc: Larry McVoy <lm@bitmover.com>, hannal@us.ibm.com,
       lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: Minutes from OSDL talk at LSE call today
Message-ID: <20031204234454.GA15799@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	cliff white <cliffw@osdl.org>, Larry McVoy <lm@bitmover.com>,
	hannal@us.ibm.com, lse-tech@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <189470000.1070500829@w-hlinder> <20031204033535.GA2370@work.bitmover.com> <20031204134517.0c7a4ec4.cliffw@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031204134517.0c7a4ec4.cliffw@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 04, 2003 at 01:45:17PM -0800, cliff white wrote:
> On Wed, 3 Dec 2003 19:35:35 -0800
> Larry McVoy <lm@bitmover.com> wrote:
> 
> > On Wed, Dec 03, 2003 at 05:20:29PM -0800, Hanna Linder wrote:
> > > The Mozilla Tinderbox is based on CVS and can do fancy things with
> > > triggers. The kernel one is not as fancy because they are still
> > > working out issues with BK.
> > 
> > If we could get a list of these issues we'll try and see what we can do
> > to help.  My response has been a bit spotty lately, I've needed to take
> > some personal time, so pinging support@bitmover.com is more likely to
> > get you help.
> 
> We've exchanged some email with support@bitmover.com, and they've been
> a great help.  Really, there are two things.
> 
> The first is triggers. The Mozilla tinderbox is driven by triggers from
> CVS commits.  I believe that triggers are resevered for the commercial
> version of BK.

That's not true.  Trigger support is identical in both versions.

> However, unlike CVS, BK has a nice way of asking the remote repository
> if new changes exist, so we really don't need a trigger to tell us when
> to start a build.  

Right.  Your problem is deciding which trees you want to track.  There is 
Linus/Marcelo trees but there are probably another 200+ trees of the kernel
on bkbits.net and who knows how many elsewhere (we've counted over 10,000
before we stopped counting).  Obviously you don't want to track all of those
but some of them might be interesting.

> The main issue here is finding the proper syntax for the bkweb url so
> we get all of the changesets included in the commit. We've recieved a
> few examples from your support people, and we're using one currently.

So are there any open issues?  The call implied there were.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
