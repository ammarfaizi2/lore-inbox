Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263935AbTDWCYB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 22:24:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263936AbTDWCYB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 22:24:01 -0400
Received: from [203.94.130.164] ([203.94.130.164]:32956 "EHLO bad-sports.com")
	by vger.kernel.org with ESMTP id S263935AbTDWCYA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 22:24:00 -0400
Date: Wed, 23 Apr 2003 12:17:40 +1000 (EST)
From: Brett <generica@email.com>
X-X-Sender: brett@bad-sports.com
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 kernel hangs system
In-Reply-To: <20030423023128.GJ1249@Master.Bellsouth.net>
Message-ID: <Pine.LNX.4.44.0304231215340.798-100000@bad-sports.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Apr 2003, Murray J. Root wrote:

> On Tue, Apr 22, 2003 at 06:55:11PM -0700, Randy.Dunlap wrote:
> > > On Wed, Apr 23, 2003 at 01:11:46AM +0200, Felipe Alfaro Solana wrote:
> > >> On Tue, 2003-04-22 at 23:00, Richard B. Johnson wrote:
> > >> > First, I don't understand how as you say, "suggestions are
> > >> > desperately needed" on a developmental kernel. These things are
> > >> > not known to work on all configurations and some information like
> > >> > "It gives me hex codes..." is worthless. Please write down
> > >> > these "hex-codes" and, after booting a version the works, run them
> > >> > through ksymoops. If you don't know what that is:
> > >>
> > >> ksymoops? I thought 2.5 kernels didn't need ksymoops anymore and that
> > >> function names were automatically "guessed" in call stack traces.
> > >>
> > >
> > > IFF you use "include symbols" when building you shouldn't need ksymoops.
> > > IMO, if you're using 2.5.x you really should include the symbols - chances
> > > are you'll need em.
> > 
> > Maybe we are reading this differently, but it sounded to me like the
> > original system hang never reached the kernel | system log and that
> > some hex codes were the only clues.  In that case, pushing them thru
> > ksymoops does still make some sense, doesn't it?
> > How else would you determine where the hang occurred?
> > 
> I read it that he was getting an oops with just hex values cause 
> he didn't have the symbols included (note the reference to "it 
> just gives hex codes"). I could be wrong, since I'm only looking
> at the quote of a quote of someone's interpretation. :)
> With symbols included an oops DOES print the actual call trace in
> readable form. (I've seen enough oops to be certain of that :)
> 
> 

I agree with > > 

I'd say he's getting the same thing as me  
<http://marc.theaimsgroup.com/?l=linux-kernel&m=105099066618652&w=2>

the 'hex codes' are the last line of grub loading the kernel

so where to from here ??

	/ Brett

