Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262380AbVADV7Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262380AbVADV7Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 16:59:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262160AbVADV5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 16:57:08 -0500
Received: from mail.tmr.com ([216.238.38.203]:46095 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S262266AbVADVvr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 16:51:47 -0500
Date: Tue, 4 Jan 2005 16:28:20 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Pavel Machek <pavel@ucw.cz>
cc: Adrian Bunk <bunk@stusta.de>, Diego Calleja <diegocg@teleline.es>,
       Willy Tarreau <willy@w.ods.org>, wli@holomorphy.com, aebr@win.tue.nl,
       solt2@dns.toxicfilms.tv, linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
In-Reply-To: <20050104210424.GA1619@elf.ucw.cz>
Message-ID: <Pine.LNX.3.96.1050104162400.3306B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jan 2005, Pavel Machek wrote:

> Hi!
> 
> > > Yes, -mm gives a bit more testing coverage, but it doesn't seem to be 
> > > enough for this vast amount of changes.
> > 
> > I have to say that with a few minor exceptions the introduction of new
> > features hasn't created long term (more than a few days) of problems. And
> > we have had that in previous stable versions as well. New features
> > themselves may not be totally stable, but in most cases they don't break
> > existing features, or are fixed in bk1 or bk2. What worries me is removing
> > features deliberately, and I won't beat that dead horse again, I've said
> > my piece.
> > 
> > The "few minor exceptions:"
> > 
> > SCSI command filtering - while I totally support the idea (and always
> > have), I miss running cdrecord as a normal user. Multisession doesn't work
> > as a normal user (at least if you follow the man page) because only root
> > can use -msinfo. There's also some raw mode which got a permission denied,
> > don't remember as I was trying something not doing production stuff.
> > 
> > APM vs. ACPI - shutdown doesn't reliably power down about half of the
> > machines I use, and all five laptops have working suspend and non-working
> > resume. APM seems to be pretty unsupported beyond "use ACPI for that."
> 
> Go ahead and become APM maintainer... APM needs some care. 
> 
> Problem is that ACPI needs driver model changes, and those affect APM
> too. But noone is using APM these days, so when something breaks
> there, it takes long to discover.

I wouldn't try it if ACPI support worked on my machines, and I really
wasn't suggesting that effort should go into APM so much as refuting the
notion that people could just use ACPI. I would rather see resources go
into ACPI, as I would be delighted to move into the future.
> 
> So even someone testing APM at regular (like every -rc and every -mm)
> basis would help...
> 								Pavel
> -- 
> People were complaining that M$ turns users into beta-testers...
> ...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
> 

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

