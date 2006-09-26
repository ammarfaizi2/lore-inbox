Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964830AbWIZVik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964830AbWIZVik (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 17:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964835AbWIZVik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 17:38:40 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:2224 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S964830AbWIZVik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 17:38:40 -0400
Subject: Re: When will the lunacy end? (Was Re: [PATCH] uswsusp: add
	pmops->{prepare,enter,finish} support (aka "platform mode"))
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Adrian Bunk <bunk@stusta.de>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>, Stefan Seyfried <seife@suse.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200609262235.14816.rjw@sisk.pl>
References: <20060925071338.GD9869@suse.de>
	 <20060925224500.GB2540@elf.ucw.cz> <20060926201437.GH4547@stusta.de>
	 <200609262235.14816.rjw@sisk.pl>
Content-Type: text/plain
Date: Wed, 27 Sep 2006 07:38:31 +1000
Message-Id: <1159306711.7485.13.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, 2006-09-26 at 22:35 +0200, Rafael J. Wysocki wrote:
> On Tuesday, 26 September 2006 22:14, Adrian Bunk wrote:
> > On Tue, Sep 26, 2006 at 12:45:00AM +0200, Pavel Machek wrote:
> > >...
> > > solid)
> > > 	apart from HIGHMEM64G fiasco, and related agpgart fiasco long
> > > 	time before that... these are driver problems...
> > >...
> > 
> > One point that seems to be a bit forgotten is that driver problems do 
> > actually matter a lot:
> > 
> > I for one do not care much whether I can abort suspending (I can always 
> > resume) or whether dancing penguins are displayed during suspending - 
> > but the fact that my saa7134 card only outputs the picture but no sound 
> > after resuming from suspend-to-disk is a real show-stopper for me.

Agreed that some things are more important than others. But to some
people, user interface does matter. After all, we want (well I want)
people considering converting from Windows to see that free software can
be better than proprietary stuff, not just imitate what they're doing. 

Suspend2 doesn't actually provide dancing penguins while suspending -
it's a simple progress bar in either pure text or overlayed on an image
of your choosing.

The support for aborting is really just fall out from the work on
debugging and testing failure paths.

> Certainly, but neither me, nor Pavel can fix all drivers with suspend-related
> problems.

(Or me - Suspend2 doesn't touch drivers, though I do from time to time
include driver patches that a good number of people seem to need, while
I wait for them to be merged upstream).

> I think the only way to get the drivers' problems fixed eventually is to file
> bug reports in bugzilla and generally complain about them to the people
> who write/maintain these drivers.

Amen.

Nigel

