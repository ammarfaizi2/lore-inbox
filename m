Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933085AbWKSTvx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933085AbWKSTvx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 14:51:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933114AbWKSTvx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 14:51:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:40375 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S933085AbWKSTvw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 14:51:52 -0500
X-Authenticated: #14349625
Subject: Re: [patch] PM: suspend/resume debugging should depend on 
	SOFTWARE_SUSPEND
From: Mike Galbraith <efault@gmx.de>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <200611191958.15152.rjw@sisk.pl>
References: <200611190320_MC3-1-D21B-111C@compuserve.com>
	 <Pine.LNX.4.64.0611190930370.3692@woody.osdl.org>
	 <1163958727.5977.15.camel@Homer.simpson.net>
	 <200611191958.15152.rjw@sisk.pl>
Content-Type: text/plain
Date: Sun, 19 Nov 2006 20:53:36 +0100
Message-Id: <1163966016.5744.8.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-11-19 at 19:58 +0100, Rafael J. Wysocki wrote:
> On Sunday, 19 November 2006 18:52, Mike Galbraith wrote:
> > On Sun, 2006-11-19 at 09:33 -0800, Linus Torvalds wrote:
> > > 
> > > On Sun, 19 Nov 2006, Chuck Ebbert wrote:
> > > >
> > > > When doing 'make oldconfig' we should ask about suspend/resume
> > > > debug features when SOFTWARE_SUSPEND is not enabled.
> > > 
> > > That's wrong.
> > > 
> > > I never use SOFTWARE_SUSPEND, and I think the whole concept is totally 
> > > broken.
> > > 
> > > Sane people use suspend-to-ram, and that's when you need the suspend and 
> > > resume debugging.
> > 
> > Here I am wishing I had the _opportunity_ to be sane.  With my ATI X850
> > AGP card, I have no choices except swsusp or reboot.
> 
> Have you tried s2ram (http://en.opensuse.org/S2ram)?

Cool.  That shows potential.  On an 2.6.19-rc6-rt4 kernel, it looked
like it _might_ have eventually gotten past boot.  At one line of kernel
output every ~10 seconds though, I gave up.  Virgin 2.6.19-rc6 went
panic with a black screen... have options, will tinker.

(i _was_ quite content with swsusp, but now i want it all;)

	Thanks,

	-Mike

