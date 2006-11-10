Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946711AbWKJPtl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946711AbWKJPtl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 10:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946712AbWKJPtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 10:49:41 -0500
Received: from [212.33.187.219] ([212.33.187.219]:40832 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1946711AbWKJPtl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 10:49:41 -0500
From: Al Boldi <a1426z@gawab.com>
To: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: A proposal; making 2.6.20 a bugfix only version.
Date: Fri, 10 Nov 2006 18:52:14 +0300
User-Agent: KMail/1.5
References: <200611090757.48744.a1426z@gawab.com> <20061109090502.4d5cd8ef@freekitty>
In-Reply-To: <20061109090502.4d5cd8ef@freekitty>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611101852.14715.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger wrote:
> Al Boldi <a1426z@gawab.com> wrote:
> > Andreas Mohr wrote:
> > > On Wed, Nov 08, 2006 at 11:40:27PM +0100, Jesper Juhl wrote:
> > > > Let me make one very clear statement first: -stabel is a GREAT think
> > > > and it is working VERY well.
> > > > That being said, many of the fixes I see going into -stable are
> > > > regression fixes. Maybe not the majority, but still, regression
> > > > fixes going into -stable tells me that the kernel should have seen
> > > > more testing/bugfixing before being declared a stable release.
> > >
> > > Nice theory, but of course I'm pretty sure that it wouldn't work
> >
> > Agreed.
> >
> > > (as has been said numerous time before by other people).
> > >
> > > You cannot do endless testing/bugfixing, it's a psychological issue.
> >
> > Agreed.
> >
> > > If you do that, then you end up with -preXX (or worse, -preXXX)
> > > version numbers, which would cause too many people to wait and wait
> > > and wait with upgrading until "that next stable" kernel version
> > > finally becomes available.
> > > IOW, your tester base erodes, awfully, and development progress
> > > stalls.
> >
> > IMHO, the psycho-problem is that you cannot intertwine development and
> > stable in the same cycle.  In that respect, the 2.6 development cycle is
> > a real flop, as it does not allow for focus.
> >
> > And focus is needed to achieve stability.
> >
> > Think catch22...
> >
> >
> > Thanks!
> >
> > --
> > Al
>
> There are bugfixes which are too big for stable or -rc releases, that are
> queued for 2.6.20. "Bugfix only" is a relative statement. Do you include,
> new hardware support, new security api's, performance fixes.  It gets to
> be real hard to decide, because these are the changes that often cause
> regressions; often one major bug fix causes two minor bugs.

That's exactly the point I'm trying to get across; the 2.6 dev model tries to 
be two cycles in one, dev and stable, which yields an awkward catch22 
situation.

The only sane way forward in such a situation is to realize the mistake and 
return to the focused dev-only / stable-only model.

This would probably involve pushing the current 2.6 kernel into 2.8 and 
starting 2.9 as a dev-cycle only, once 2.8 has structurally stabilized.


Thanks!

--
Al

