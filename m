Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263902AbTLJTiz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 14:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263904AbTLJTiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 14:38:55 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:40203
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S263902AbTLJTiv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 14:38:51 -0500
Date: Wed, 10 Dec 2003 11:32:43 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Linus Torvalds <torvalds@osdl.org>
cc: Hua Zhong <hzhong@cisco.com>, "'Arjan van de Ven'" <arjanv@redhat.com>,
       Valdis.Kletnieks@vt.edu, "'Kendall Bennett'" <KendallB@scitechsoft.com>,
       linux-kernel@vger.kernel.org
Subject: RE: Linux GPL and binary module exception clause?
In-Reply-To: <Pine.LNX.4.58.0312100923370.29676@home.osdl.org>
Message-ID: <Pine.LNX.4.10.10312101109380.3805-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

How can the additional words alter the mean of GPL itself?
I am not baiting this time.  Does the simple addition of your meaning
imposed create an effective restriction?  Does that applied meaning make
the kernel license invalid for all?  I am sure there were no changes in
the text of the COPYING file, but the additions to the "coyrighted" file
appears to alter intent.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Wed, 10 Dec 2003, Linus Torvalds wrote:

> 
> 
> On Wed, 10 Dec 2003, Hua Zhong wrote:
> >
> > > What has meaning for "derived work" is whether it stands on its own or
> > > not, and how tightly integrated it is. If something works
> > > with just one particular version of the kernel - or depends on things like
> > > whether the kernel was compiled with certain options etc - then it pretty
> > > clearly is very tightly integrated.
> >
> > Many userspace programs fall into this category too.
> 
> Absolutely.
> 
> Trust me, REAL LAWYERS WERE WORRIED about this. It wasn't just random tech
> people discussing issues on a technical (or, right now, not-so-technical)
> mailing list.
> 
> There's a reason for those lines at the top of the COPYING file saying
> that user space is not covered, and there are literally lawyers who say it
> would hold up in a court of law.
> 
> Exactly because you _can_ argue that user-space might be covered. It's an
> argument that almost certainly would fail very quickly due to "documented
> interfaces" and ABI issues, but it is an argument that lawyers have made,
> and it's that argument that makes the disclaimer in COPYING be worth it.
> 
> In other words: even without that disclaimer of derivation, user space
> would almost certainly (with a very high probability indeed) be safe from
> a copyright infringement suit. Such a suit would most likely be thrown out
> very early, exactly because the UNIX system call interface is clearly
> extensively documented, and the Linux implementation of it has strived to
> be a stable ABI for a long time.
> 
> In fact, a user program written in 1991 is actually still likely to run,
> if it doesn't do a lot of special things. So user programs really are a
> hell of a lot more insulated than kernel modules, which have been known to
> break weekly.
> 
> Similarly, things like /proc etc are clearly intended to be ways to
> interface to the kernel in user space, so there's a clear intent there
> that nobody can reasonably deny (again, that intent is made _clearer_ by
> the COPYING disclaimer, but it would be hard to argue against even in the
> absense of that).
> 
> But even DESPITE these strong arguments that user-space clearly isn't a
> derived work, and real lawyers worried, and felt much happier with the
> explicit disclaimer in the COPYING file.
> 
> That should tell you something. In particular, it should tell you to be
> careful: some courts have made so broad "derivative work" judgements that
> it's scary - think about the "Gone With the Wind" parody (I think the
> ruling was eventually overturned on First Amendment grounds, but the
> point is that you should be very careful, and while source code has
> the potential for First Amendment protection, binary modules sure as hell
> do not).
> 
> And please note that I am _not_ arguing for those overly broad judgements:
> I'm just pointing out that you should not assume that "derivative" is
> something simple. If an author claims your work is derivative, you should
> step very very lightly.
> 
> And I claim that binary-only kernel modules ARE derivative "by default",
> by virtue of having no meaning without the kernel.
> 
> 		Linus
> 

