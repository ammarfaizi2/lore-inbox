Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281835AbRLRPTZ>; Tue, 18 Dec 2001 10:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282067AbRLRPTK>; Tue, 18 Dec 2001 10:19:10 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:32709 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S282508AbRLRPSw>;
	Tue, 18 Dec 2001 10:18:52 -0500
Date: Tue, 18 Dec 2001 16:18:45 +0100
From: David Weinehall <tao@acc.umu.se>
To: "M. Edward (Ed) Borasky" <znmeb@aracnet.com>
Cc: Eyal Sohya <linuz_kernel_q@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: The direction linux is taking
Message-ID: <20011218161844.P5235@khan.acc.umu.se>
In-Reply-To: <F25YXU6KJQcxQv8rcyN00007eb5@hotmail.com> <Pine.LNX.4.33.0112180622320.28881-100000@shell1.aracnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.LNX.4.33.0112180622320.28881-100000@shell1.aracnet.com>; from znmeb@aracnet.com on Tue, Dec 18, 2001 at 06:38:26AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2001 at 06:38:26AM -0800, M. Edward (Ed) Borasky wrote:
> On Tue, 18 Dec 2001, Eyal Sohya wrote:
> 
> > I've watched this List and have some questions to ask
> > which i would appreciate are answered. Some might not
> > have definite answers and we might be divided on them.
> 
> My opinions only!!
> 
> 
> > 1. Are we satisfied with the source code control system ?
> 
> With CVS, probably -- it's open source and rather universally known.
> With the version control *process* ... well ... I personally favor a
> full SEI CMM level 2 or even level 3 process. Whether there are open
> source tools to facilitate that process is another story.
> 
> > 2. Is there enough planning for documentation ? As another poster
> > mentioned, there are new API and we dont know about them.
> 
> There is, as it turns out, a tremendous *amount* of documentation,
> although it is not as centralized as it could be. Again, I favor the SEI
> CMM model.
> 
> > 3. There is no central bug tracking database. At least people should
> > know the status of the bugs they have found with some releases.
> 
> Absolutely! Bug tracking and source / version control ought to be
> integrated and centralized.
> 
> > 4. Aggressive nature of this mailing list itself may be a turn off to
> > many who would like to contribute.
> 
> Well ... peer review / code walkthroughs are part of SEI CMM level 3
> IIRC, and peer review is an important part of the scientific process. We
> all have our opinions and our reasons for being here and levels of
> contribution we are willing and able to make. When all is said and done,
> more is said than done :)). A lot *is* getting done! The only things I
> would change about this list are a reliable digest, a *vastly* better
> search engine and a better mailing list manager than majordomo.

With SEI CMM level 3 for the kernel, complete testing and documentation,
we'd be able to release a new kernel every 5 months, with new drivers
2 years after release of the device, and support for new platforms
2-3 years after their availability, as opposed to 1-2 years before
(IA-64, for instance...)

We'd also kill off all the advantages that the bazaar-style development
style actually has, while gaining nothing in particular, except for
a slow machinery of paper-work. No thanks.

I don't complain when people do proper documentation and testing of
their work; rather the opposite, but it needs to be done on a volunteer
basis, not being forced by some standard. Do you really think Linus
would be able to take all the extra work of software engineering? Think
again. Do you honestly believe he'd accept doing so in a million years?
Fat chance.

Grand software engineering based on PSP/CMM/whatever is fine when you
have a clear goal in mind; a plan stating what to do, detailing
everything meticously. Not so for something that changes directions on
pure whim from one week to the next, with the only goal being
improvement, expansion and (sometimes) simplification. Yes, some people
have a grand plan for their subsystems (I'm fairly convinced that
Alexander Viro has some plans up his sleeve for the VFS, and I'm sure it
involves a lot of ideas from Plan 9. But this is pure speculation, of
course...) and there are some goals (such as the pending transition to a
bigger dev_t, CML2, kbuild 2.5 et al), but most development takes place
as follows: idea -> post on lkml -> long discussion -> implementation ->
long discussion (about petty details) -> inclusion/rejection -> possible
rehash of this...


Regards: David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
