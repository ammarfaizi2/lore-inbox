Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263628AbTKRPbB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 10:31:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263632AbTKRPbB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 10:31:01 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:26346 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S263628AbTKRPa7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 10:30:59 -0500
Date: Tue, 18 Nov 2003 07:30:54 -0800
From: Larry McVoy <lm@bitmover.com>
To: Sven Dowideit <svenud@ozemail.com.au>
Cc: Larry McVoy <lm@bitmover.com>, Andrew Walrond <andrew@walrond.org>,
       linux-kernel@vger.kernel.org
Subject: Re: kernel.bkbits.net off the air
Message-ID: <20031118153054.GB10584@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Sven Dowideit <svenud@ozemail.com.au>,
	Larry McVoy <lm@bitmover.com>, Andrew Walrond <andrew@walrond.org>,
	linux-kernel@vger.kernel.org
References: <fa.eto0cvm.1v20528@ifi.uio.no> <200311141624.32108.andrew@walrond.org> <20031114164640.GA1618@work.bitmover.com> <200311141734.57122.andrew@walrond.org> <20031114174303.GC32466@work.bitmover.com> <1068959565.889.5.camel@sven>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1068959565.889.5.camel@sven>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 16, 2003 at 04:12:45PM +1100, Sven Dowideit wrote:
> On Sat, 2003-11-15 at 04:43, Larry McVoy wrote:
> > The points are
> >     a) I'm not at all convinced this is going to make anyone other than you
> >        happy.  They all want a BK replacement, not a tarball+patch replacement.
> As a quite irrelevant (from a kernel development point - as i don't do
> anything other than test / use and bug report) data point, this is
> somehting I would like to see, and preferably with a license that would
> make it possible to incluse in the mainline debian distribution. that
> way it would be possible for more people to test bk repository versions
> of software (not jsut the kernel) without having to install the full
> version of BK. 
> 
> so all I'd like is to be able to do a get/update to the head revision of
> the repository, and if possible get/convert to a tagged version. 
> 
> having the second would have made chasing down what version of the
> kernel broke my pcmcia support easier :)

We'd be happy to build this if there was some indication that it would
actually make a lot more people happy.  Examples of that would be
agreement from the debian crowd to include it, find some BK flamers who
say this would resolve their issues, etc.

We've been burned once by doing a bunch of work and getting beat up for
it, i.e., doing the BK2CVS converter and people still aren't happy.
We spend a lot of unseen time maintaining bkbits.net and the hosting
machines.  I'd *love* to have a better relationship with the open source
world but if this is a solution for a handful of people but it does
nothing for the other people then we aren't moving forward.

Just to be clear, what we are talking about is a free client which talks to
a modified BK server.  The client has the ability to 

    - get a workspace (bk clone equiv)
    - get a version of the workspace as of any tag (bk clone -r equiv)
    - update a workspace (bk pull equiv)

Anything more than that could be done but would be left to you to extend 
the client (you'd get source to the client).   
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
