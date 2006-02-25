Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964817AbWBYAQG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964817AbWBYAQG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 19:16:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964818AbWBYAQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 19:16:05 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:27844 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964817AbWBYAQE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 19:16:04 -0500
Date: Sat, 25 Feb 2006 01:15:41 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Andreas Happe <andreashappe@snikt.net>, linux-kernel@vger.kernel.org,
       Suspend2 Devel List <suspend2-devel@lists.suspend2.net>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060225001541.GA2473@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060224131206.GB1717@elf.ucw.cz> <200602242122.53763.rjw@sisk.pl> <200602250911.54850.ncunningham@cyclades.com> <20060224235321.GA1930@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060224235321.GA1930@elf.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On So 25-02-06 00:53:21, Pavel Machek wrote:
> Hi!
> 
> > > > 2) shrink_all_memory() should be fixed. It should not really return if
> > > > there are more pages freeable.
> > >
> > > Well, that would be a long-run solution.  However, until it's fixed we can
> > > use a workaround IMHO. ;-)
> > 
> > Isn't trying to free as much memory as you can the wrong solution anyway? I 
> > mean, that only means that the poor system has more pages to fault back in at 
> > resume time, before the user can even begin to think about doing anything 
> > useful. You might be able to say "Every machine that suspend2 works on, 
> > swsusp works on", but the later will be a pretty sad definition of works!
> 
> We are trying to catch a bug here. suspend2 or not, it is a bug and it
> should be fixed (or at least understood).
> 
> [Also please try to tone down your messages. Your suspend2 may be more
> user-friendly, you do not want to start that flamewar again, do you?
> Saying "don't bother fixing that" is not nice thing to do.]

Heh, I guess I should apologize for being offtopic on suspend2 mailing
list... this was not about suspend2 any more.. 

I guess we should drop suspend2 and this huge cc list from future
discussion. (And fix subject.)

Anyway, Rafael, do you think you could commit your encryption patches?
Ready or not, bugs can be fixed later :-). [I'd like to do some work
based on them; I think I figured out easy way to setup suspend so that
password is needed only during resume...] 
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
