Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932211AbWAEVR0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbWAEVR0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 16:17:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbWAEVR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 16:17:26 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:33036 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932211AbWAEVRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 16:17:25 -0500
Date: Thu, 5 Jan 2006 22:17:15 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Folkert van Heusden <folkert@vanheusden.com>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org,
       lnx4us@gmail.com
Subject: Re: bug reports ignored?
Message-ID: <20060105211715.GC7142@w.ods.org>
References: <38150.145.117.21.143.1136477335.squirrel@145.117.21.143> <9a8748490601050852t1e10ea6evd8769f2f4719186c@mail.gmail.com> <20060105185319.GB10923@vanheusden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060105185319.GB10923@vanheusden.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 07:53:20PM +0100, Folkert van Heusden wrote:
> > > Last couple of weeks I sent 2 bug-reports. They seem to be ignored. I was
> > > wondering: what is missing in them? Am I sending them to the incorrect
> > > address? One I also put into bugzilla (no reactions either).
> > Perhaps you could let us know the subjects & dates of those two
> > previous mails so they are easier to locate in the archives?
> 
> 20051219190137.GA13923@vanheusden.com
> Mon, 19 Dec 2005 20:01:47 +0100
> [2.6.13.3] occasional oops mostly in iget_locked
> 
> It seems that those oopses in iget_locked are gone since I ran 2.6.14.4
> and currently run 2.6.15.
> 
> 
> Other message:
> 20060103210252.GA2043@vanheusden.com
> Tue, 3 Jan 2006 22:03:36 +0100
> [2.6.15] reproducable hang
> 
> this one still happens. System loses total network connectivity. When I
> dial the system (by phone), asterisk (the software pabx) picks up the
> phone and plays a sample, then it becomes mute. After that, the system
> doesn't respond to anything at all. Even sysreq+t is ignored.
> The last message on the console is:
> eth1: transmit error tx status register 82

Then you're in the situation where you have to narrow the bug down to
something more reproduceable for other people. Possibly very few people
on the list have 2.6.15 + asterisk + a sample to play + etc...

Try to strace asterisk when this happens for instance, try to remove
a lot of loaded modules and configured options from your system, then
you will finally reach a case where you can simply reproduce it with
a 10-line C prog without a complex setup. With those info, it will be
too complex and boring to try to reproduce your problem on any
developer's system.

> >  - Sometimes bugs are reported with a *demand* that it be fixed *right
> > now* or with other abusive language towards developers in the email.
> > Such reports are usually ignored or, if responded to, don't get very
> > positive replies.
> 
> Haha no I did not do that :-)
> 
> 
> Folkert van Heusden

Willy

