Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262073AbVADHBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262073AbVADHBs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 02:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbVADHBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 02:01:48 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:51091 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262073AbVADHBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 02:01:41 -0500
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: "L. A. Walsh" <law@tlinx.org>, linux-kernel@vger.kernel.org
Subject: Re: Reviving the concept of a stable series (was Re: starting with 2.7)
References: <200501031424.j03EOV2t029019@laptop11.inf.utfsm.cl>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 04 Jan 2005 00:00:19 -0700
In-Reply-To: <200501031424.j03EOV2t029019@laptop11.inf.utfsm.cl>
Message-ID: <m1zmzpr858.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand <vonbrand@inf.utfsm.cl> writes:

> "L. A. Walsh" <law@tlinx.org> said:
> 
> > It seems that some developers have the opinion that the end-user base
> > no longer is their problem or audience and that the distros will patch
> > all the little boo-boo's in each unstable 2.6 release.
> 
> AFAIU, the current development model is designed to _diminish_ the need of
> custom patching by distributions. For example, RH 9 2.4 kernels were mostly
> 2.6 via backports and random patches. But the patches were only maintained
> by RH, so it was a large duplication of effort (not even counting the other
> distributions). With 2.6 everybody can work on a up-to-date code base, much
> less need of distribution backports and patches (and associated random
> incompatibilities) benefits every user.

And that idea I really appreciate it.  From the looks of things though
it does not feel like the distros have caught on.  I know at least that
it has been painful working with SuSE's 2.6.ancient fork when I have
perfectly good code that runs in 2.6.latest.

If the distros will update their base kernel once a year or so I can
seem some benefits to the new dev model.  But so far I have not seen
the updates and when you have to use a distro kernel is seems to
be the same old same old.

> >                          It seems like it would become quite a chore
> > to decide what code is let into the stable version.  It's also
> > considered by many to be "less" fun, not only to "manage the
> > stable distro", but backport code into the previous distro. 
> 
> Lots of rather pointless work. Much of it something each distribution has
> to do on their own (because f.ex. vanilla 2.4 is _just fixes_, no backports
> of cool (and required) new functionality), instead of cooperating in
> building a better overall kernel.

Except some features did make it into 2.4.x like native pci-express support.
That is certainly more than just fixes.
 
> > Nevertheless, it would be nice to see a no-new-features, stable series
> > spun off from these development kernels, maybe .4th number releases,
> > like 2.6.10 also becomes a 2.6.10.0 that starts a 2.6.10.1, then 2.6.10.2,
> > etc...with iteritive bug fixes to the same kernel and no new features
> > in such a branch, it might become stable enough for users to have confidence
> > installing them on their desktop or stable machines.
> 
> See above. The 2.6.9-x kernels from Red Hat/Fedora are targeted to be
> exactly that...

Ah another fork that makes support from third parties a pain.  So it
appears Red Hat is going the same way I have observed with SuSE.

I do believe a model where we stabilize features and let them shake out
independently.  Is where we need to go for Linux.  But we seem still
to be at the teething stage and I am frustrated.

Eric
