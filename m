Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965327AbWI0FKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965327AbWI0FKK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 01:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965328AbWI0FKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 01:10:10 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:19941 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S965327AbWI0FKH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 01:10:07 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: When will the lunacy end? (Was Re: [PATCH] uswsusp: add pmops->{prepare,enter,finish} support (aka "platform mode"))
Date: Wed, 27 Sep 2006 07:12:33 +0200
User-Agent: KMail/1.9.1
Cc: Nigel Cunningham <ncunningham@linuxmail.org>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>, Stefan Seyfried <seife@suse.de>,
       linux-kernel@vger.kernel.org
References: <20060925071338.GD9869@suse.de> <200609270131.46686.rjw@sisk.pl> <20060926233903.GK4547@stusta.de>
In-Reply-To: <20060926233903.GK4547@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609270712.34082.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 27 September 2006 01:39, Adrian Bunk wrote:
> On Wed, Sep 27, 2006 at 01:31:46AM +0200, Rafael J. Wysocki wrote:
> > On Wednesday, 27 September 2006 01:05, Nigel Cunningham wrote:
> > > On Wed, 2006-09-27 at 00:31 +0200, Adrian Bunk wrote:
> > > > On Wed, Sep 27, 2006 at 07:38:31AM +1000, Nigel Cunningham wrote:
> > > > > Hi.
> > > > > 
> > > > > On Tue, 2006-09-26 at 22:35 +0200, Rafael J. Wysocki wrote:
> > > > > > On Tuesday, 26 September 2006 22:14, Adrian Bunk wrote:
> > > > > > > On Tue, Sep 26, 2006 at 12:45:00AM +0200, Pavel Machek wrote:
> > > > > > > >...
> > > > > > > > solid)
> > > > > > > > 	apart from HIGHMEM64G fiasco, and related agpgart fiasco long
> > > > > > > > 	time before that... these are driver problems...
> > > > > > > >...
> > > > > > > 
> > > > > > > One point that seems to be a bit forgotten is that driver problems do 
> > > > > > > actually matter a lot:
> > > > > > > 
> > > > > > > I for one do not care much whether I can abort suspending (I can always 
> > > > > > > resume) or whether dancing penguins are displayed during suspending - 
> > > > > > > but the fact that my saa7134 card only outputs the picture but no sound 
> > > > > > > after resuming from suspend-to-disk is a real show-stopper for me.
> > > > > 
> > > > > Agreed that some things are more important than others. But to some
> > > > > people, user interface does matter. After all, we want (well I want)
> > > > > people considering converting from Windows to see that free software can
> > > > > be better than proprietary stuff, not just imitate what they're doing. 
> > > > > 
> > > > > Suspend2 doesn't actually provide dancing penguins while suspending -
> > > > > it's a simple progress bar in either pure text or overlayed on an image
> > > > > of your choosing.
> > > > > 
> > > > > The support for aborting is really just fall out from the work on
> > > > > debugging and testing failure paths.
> > > > >...
> > > > 
> > > > Sorry if this sounded as if I was against improvements of suspend.
> > > > That was not my intention.
> > > > 
> > > > But as long as there are driver problems, suspend as a whole can not be 
> > > > called solid. The core itself might be solid or not, but without working 
> > > > drivers this doesn't buy users much.
> > > > 
> > > > A user might be impressed by a progress bar on a nifty image, but if one 
> > > > or more of his drivers have problems with suspend the user won't get a 
> > > > good impression of Linux.
> > > > 
> > > > How many driver problems with suspend are buried in emails and
> > > > Bugzillas (will problems like kernel Bugzilla #6035 ever be debugged?)?
> > > 
> > > I fully agree. One of the largest issues I'm regularly dealing with is
> > > people reporting problems with drivers.
> > 
> > Well, can we please have these reports forwarded to LKML or placed
> > in the bugzilla?
> 
> The main question is:
> 
> Who will track these bugs, debug them (who is e.g. responsible for 
> kernel Bugzilla #6035?) and repeatingly poke maintainers to fix such 
> issues?
> 
> If you are saying you will do this job, I can try to redirect such bug 
> reports to the kernel Bugzilla, create a "suspend driver problems" meta 
> bug there, assign it to you and create the dependencies that it tracks 
> the already existing bugs in the kernel Bugzilla.

Yes, please do this.

[I must say I'm a bit afraid of that but anyway someone has to do it ... ;-)]

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
