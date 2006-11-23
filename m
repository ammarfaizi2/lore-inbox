Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757481AbWKWVlJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757481AbWKWVlJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 16:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757480AbWKWVlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 16:41:09 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:58756 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1757481AbWKWVlI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 16:41:08 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: [patch] PM: suspend/resume debugging should depend on SOFTWARE_SUSPEND
Date: Thu, 23 Nov 2006 22:36:56 +0100
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@suse.cz>, Linus Torvalds <torvalds@osdl.org>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <200611190320_MC3-1-D21B-111C@compuserve.com> <20061123133904.GD5561@ucw.cz> <1164317804.6222.11.camel@Homer.simpson.net>
In-Reply-To: <1164317804.6222.11.camel@Homer.simpson.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611232236.58444.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 23 November 2006 22:36, Mike Galbraith wrote:
> On Thu, 2006-11-23 at 13:39 +0000, Pavel Machek wrote:
> > Hi!
> > 
> > > > > > Sane people use suspend-to-ram, and that's when you need the suspend and 
> > > > > > resume debugging.
> > > > > 
> > > > > Here I am wishing I had the _opportunity_ to be sane.  With my ATI X850
> > > > > AGP card, I have no choices except swsusp or reboot.
> > > > 
> > > > Have you tried s2ram (http://en.opensuse.org/S2ram)?
> > > 
> > > Cool.  That shows potential.  On an 2.6.19-rc6-rt4 kernel, it looked
> > > like it _might_ have eventually gotten past boot.  At one line of kernel
> > > output every ~10 seconds though, I gave up.  Virgin 2.6.19-rc6 went
> > > panic with a black screen... have options, will tinker.
> > 
> > Try that -rt kernel, but turn off dyntick/hires timers. Also try
> > hitting keyboard while resuming.
> 
> Hmm, I'll try that.  Interesting (read odd from my perspective) that the
> rt kernel gets much further.  This is pretty hard to look at.

Is your system an i386?
