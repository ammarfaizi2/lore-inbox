Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262134AbUJZGGW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262134AbUJZGGW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 02:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbUJZGGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 02:06:15 -0400
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:50343 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262170AbUJZGC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 02:02:58 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Stelian Pop <stelian@popies.net>
Subject: Re: [PATCH 0/5] Sonypi driver model & PM changes
Date: Tue, 26 Oct 2004 01:02:54 -0500
User-Agent: KMail/1.6.2
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
References: <200410210154.58301.dtor_core@ameritech.net> <20041025220921.GA5207@elf.ucw.cz> <20041026055530.GA2885@deep-space-9.dsnet>
In-Reply-To: <20041026055530.GA2885@deep-space-9.dsnet>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410260102.55097.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 26 October 2004 12:55 am, Stelian Pop wrote:
> On Tue, Oct 26, 2004 at 12:09:21AM +0200, Pavel Machek wrote:
> 
> > > Ok. Suspending never really worked on my laptop so I'll have to assume
> > > you're correct. :)
> > > 
> > > [ Just tried once again to do a suspend to ram, seems that there were
> > > some enhancements in this area lately. 
> > > 
> > >   No luck. Machine suspends ok, but upon waking up, the power led goes
> > >   greek ok, the disk led lights up, but the keyboard is dead, the
> > >   network card is dead, the screen doesn't turn on...
> > > 
> > >   Since this laptop has no serial port I don't see what else I can do,
> > >   except wait another 6 months and try again... :(
> > 
> > Debug using pc speaker... Or paralel port, or something like that.
> 
> This is a laptop which has no serial or parallel port.
> 
> All the interfaces it has are all too high level to be used for
> debugging (USB, firewire, pcmcia etc).
> 
> I think the speaker would probably work. I'll give it a try and
> see if it helps next time...
> 

I'd try to get suspend-to-disk working first.. ACPI S3 seems to be much
trickier.

-- 
Dmitry
