Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750727AbVKWMCG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbVKWMCG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 07:02:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbVKWMCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 07:02:06 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:37020 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750727AbVKWMB6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 07:01:58 -0500
Date: Wed, 23 Nov 2005 13:01:42 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Bj?rn Mork <bmork@dod.no>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org,
       Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: Resume from swsusp stopped working with 2.6.14 and 2.6.15-rc1
Message-ID: <20051123120142.GA18403@elf.ucw.cz>
References: <87zmoa0yv5.fsf@obelix.mork.no> <200511220026.55589.dtor_core@ameritech.net> <20051122184739.GB1748@elf.ucw.cz> <200511222315.31033.rjw@sisk.pl> <20051122225120.GI1748@elf.ucw.cz> <87hda3d6b8.fsf@obelix.mork.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87hda3d6b8.fsf@obelix.mork.no>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> > Well, I do not think this problem will surface again. It is first
> >> > failure in pretty long time. If it happens again, I'll take your
> >> > patch.
> >> 
> >> If so, could you please make it printk() a message after the timeout has
> >> passed?  This way the user will know what's going on at least.
> >
> > We do have messages there, they even tell you name of process that was
> > not stopped. That's enough to debug failure quickly.
> 
> I don't think so.  The example said
> 
>  "Strange, kseriod not stopped"
> 
> This names a process that admittedly took a long time to stop, but not
> the real *cause* of the failure.  There was nothing wrong with kseriod.
> 
> FWIW, debugging this was way out of my league.  I might have had a
> better chance if it mentioned a short, fixed timeout.  I also noticed
> that it wasn't very obvious to you either at first.  The first thought
> was a failing serio driver, although that admittedly might be because
> I mislead you in my attempt to pinpoint the failure.

Ok, can you suggest better wording?
								Pavel
-- 
Thanks, Sharp!
