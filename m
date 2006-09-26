Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964788AbWIZUcz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964788AbWIZUcz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 16:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964790AbWIZUcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 16:32:55 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:65247 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S964788AbWIZUcy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 16:32:54 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: When will the lunacy end? (Was Re: [PATCH] uswsusp: add pmops->{prepare,enter,finish} support (aka "platform mode"))
Date: Tue, 26 Sep 2006 22:35:13 +0200
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       Stefan Seyfried <seife@suse.de>, linux-kernel@vger.kernel.org
References: <20060925071338.GD9869@suse.de> <20060925224500.GB2540@elf.ucw.cz> <20060926201437.GH4547@stusta.de>
In-Reply-To: <20060926201437.GH4547@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609262235.14816.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 26 September 2006 22:14, Adrian Bunk wrote:
> On Tue, Sep 26, 2006 at 12:45:00AM +0200, Pavel Machek wrote:
> >...
> > solid)
> > 	apart from HIGHMEM64G fiasco, and related agpgart fiasco long
> > 	time before that... these are driver problems...
> >...
> 
> One point that seems to be a bit forgotten is that driver problems do 
> actually matter a lot:
> 
> I for one do not care much whether I can abort suspending (I can always 
> resume) or whether dancing penguins are displayed during suspending - 
> but the fact that my saa7134 card only outputs the picture but no sound 
> after resuming from suspend-to-disk is a real show-stopper for me.

Certainly, but neither me, nor Pavel can fix all drivers with suspend-related
problems.

I think the only way to get the drivers' problems fixed eventually is to file
bug reports in bugzilla and generally complain about them to the people
who write/maintain these drivers.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
