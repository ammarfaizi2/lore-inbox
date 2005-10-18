Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751206AbVJRGcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbVJRGcM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 02:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbVJRGcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 02:32:12 -0400
Received: from waste.org ([216.27.176.166]:32738 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1751206AbVJRGcM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 02:32:12 -0400
Date: Mon, 17 Oct 2005 23:30:31 -0700
From: Matt Mackall <mpm@selenic.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Esben Nielsen <simlo@phys.au.dk>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: ketchup+rt with ktimers added.
Message-ID: <20051018063031.GR26160@waste.org>
References: <Pine.LNX.4.58.0510170316310.5859@localhost.localdomain> <20051017213915.GN26160@waste.org> <Pine.LNX.4.58.0510180211320.13581@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0510180211320.13581@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2005 at 02:20:38AM -0400, Steven Rostedt wrote:
> 
> On Mon, 17 Oct 2005, Matt Mackall wrote:
> 
> > On Mon, Oct 17, 2005 at 03:38:49AM -0400, Steven Rostedt wrote:
> > >
> 
> >
> > Thomas has indicated that these trees might not be very long-lived. So
> > instead, I've added the ability to make local extensions:
> >
> > .ketchuprc:
> >
> > local_trees = {
> >     '2.6-kt': (latest_dir,
> >                "http://www.tglx.de/projects/ktimers/patch-%(full)s.patch",
> >                r'patch-(2.6.*?)',
> >                0, "Thomas Gleixner's ktimers."),
> >     '2.6-kthrt': (latest_dir,
> >                   "http://www.tglx.de/projects/ktimers/patch-%(full)s.patch",
> >                   r'patch-(2.6.*?)',
> >                   0, "Thomas Gleixner's ktimers and HRT patches.")
> >     }
> >
> > $ ./ketchup -s 2.6-kt
> > 2.6.14-rc4-kthrt3.patch
> 
> I did not know about this extension.  Good to know, thanks.

Didn't exist until today, motivated entirely by your message.

> > > Since the base version of Michal Schmidt's ketchup-0.9+rt didn't include
> > > Esben Nielsen's addition of handling Ingo's older kernels, I again
> > > included it with this patch.
> >
> > That's been in tip for a while:
> >
> > http://selenic.com/repo/ketchup/
> >
> 
> I didn't know about your repo directory.  Sorry, didn't have time to look
> too deep into this. I just did a few searches on the web and found
> different links scattered around.  I was just interested in the RT stuff,
> so I didn't go to deep.
> 
> Actually, if you had a link to the repo from
> http://www.selenic.com/ketchup/ I would have found it.

It's here:

http://www.selenic.com/ketchup/wiki/

-- 
Mathematics is the supreme nostalgia of our time.
