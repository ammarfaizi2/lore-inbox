Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261993AbVADAPR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261993AbVADAPR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 19:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261972AbVADAMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 19:12:42 -0500
Received: from mail.tmr.com ([216.238.38.203]:6925 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S261995AbVADAF7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 19:05:59 -0500
Date: Mon, 3 Jan 2005 18:42:24 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
cc: Adrian Bunk <bunk@stusta.de>, Diego Calleja <diegocg@teleline.es>,
       Willy Tarreau <willy@w.ods.org>, wli@holomorphy.com, aebr@win.tue.nl,
       solt2@dns.toxicfilms.tv, linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7 
In-Reply-To: <200501032103.j03L33eb004694@laptop11.inf.utfsm.cl>
Message-ID: <Pine.LNX.3.96.1050103183503.30038C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jan 2005, Horst von Brand wrote:

> Bill Davidsen <davidsen@tmr.com> said:
> 
> [...]
> 
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
> 
> It had very nasty security problems. After a short discussion here, it was
> deemed much more important to have a secure system than a (very minor)
> convenience. AFAIU, the patch was backported to 2.4 (or should be ASAP).

As I said, I supported that, but the check is done in such a way that not
even making the application setuid helps, so users can't burn multisession
(and some other obscure forms of) CDs.
> 
> > APM vs. ACPI - shutdown doesn't reliably power down about half of the
> > machines I use, and all five laptops have working suspend and non-working
> > resume. APM seems to be pretty unsupported beyond "use ACPI for that."
> 
> Many never machines just don't have APM.

What's your point? I'm damn sure there are more machines with APM than 386
CPUs, AHA1540 SCSI controllers, or a lot of other supported stuff. Most
machines which have APM at all have a functional power off capability,
which is a desirable thing for most people.

> 
> > None of these would prevent using 2.6 if there were some feature not in
> > 2.4 which gave a reason to switch.
> 
> Like 2.6 works fine, 2.4 has no chance on some machines?

Haven't hit one of those yet, although after you get away from Intel I'm
sure there are some.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

