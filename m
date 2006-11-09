Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424135AbWKIRFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424135AbWKIRFe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 12:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424140AbWKIRFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 12:05:34 -0500
Received: from hera.kernel.org ([140.211.167.34]:35557 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1424135AbWKIRFd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 12:05:33 -0500
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: A proposal; making 2.6.20 a bugfix only version.
Date: Thu, 9 Nov 2006 09:05:02 -0800
Organization: OSDL
Message-ID: <20061109090502.4d5cd8ef@freekitty>
References: <200611090757.48744.a1426z@gawab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1163091902 8587 10.8.0.54 (9 Nov 2006 17:05:02 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Thu, 9 Nov 2006 17:05:02 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; i486-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Nov 2006 07:57:48 +0300
Al Boldi <a1426z@gawab.com> wrote:

> Andreas Mohr wrote:
> > On Wed, Nov 08, 2006 at 11:40:27PM +0100, Jesper Juhl wrote:
> > > Let me make one very clear statement first: -stabel is a GREAT think
> > > and it is working VERY well.
> > > That being said, many of the fixes I see going into -stable are
> > > regression fixes. Maybe not the majority, but still, regression fixes
> > > going into -stable tells me that the kernel should have seen more
> > > testing/bugfixing before being declared a stable release.
> >
> > Nice theory, but of course I'm pretty sure that it wouldn't work
> 
> Agreed.
> 
> > (as has been said numerous time before by other people).
> >
> > You cannot do endless testing/bugfixing, it's a psychological issue.
> 
> Agreed.
> 
> > If you do that, then you end up with -preXX (or worse, -preXXX)
> > version numbers, which would cause too many people to wait and wait
> > and wait with upgrading until "that next stable" kernel version
> > finally becomes available.
> > IOW, your tester base erodes, awfully, and development progress stalls.
> 
> IMHO, the psycho-problem is that you cannot intertwine development and stable 
> in the same cycle.  In that respect, the 2.6 development cycle is a real 
> flop, as it does not allow for focus.  
> 
> And focus is needed to achieve stability.  
> 
> Think catch22...
> 
> 
> Thanks!
> 
> --
> Al

There are bugfixes which are too big for stable or -rc releases, that are
queued for 2.6.20. "Bugfix only" is a relative statement. Do you include,
new hardware support, new security api's, performance fixes.  It gets to
be real hard to decide, because these are the changes that often cause
regressions; often one major bug fix causes two minor bugs.

Interestingly, adding a new feature often causes no bugs in the rest
of the code, but it does increase the possible bug surface so most of
the problems related to feature X are bugs in feature X. 


-- 
Stephen Hemminger <shemminger@osdl.org>
