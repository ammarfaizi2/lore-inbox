Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964822AbWBYApO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964822AbWBYApO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 19:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932655AbWBYApN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 19:45:13 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:41632 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932654AbWBYApL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 19:45:11 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Sat, 25 Feb 2006 01:45:06 +0100
User-Agent: KMail/1.9.1
Cc: Nigel Cunningham <ncunningham@cyclades.com>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Andreas Happe <andreashappe@snikt.net>, linux-kernel@vger.kernel.org,
       Userland Suspend Devel <suspend-devel@lists.sourceforge.net>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060224235321.GA1930@elf.ucw.cz> <20060225001541.GA2473@elf.ucw.cz>
In-Reply-To: <20060225001541.GA2473@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602250145.07588.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Saturday 25 February 2006 01:15, Pavel Machek wrote:
> On So 25-02-06 00:53:21, Pavel Machek wrote:
> > > > > 2) shrink_all_memory() should be fixed. It should not really return if
> > > > > there are more pages freeable.
> > > >
> > > > Well, that would be a long-run solution.  However, until it's fixed we can
> > > > use a workaround IMHO. ;-)
> > > 
> > > Isn't trying to free as much memory as you can the wrong solution anyway? I 
> > > mean, that only means that the poor system has more pages to fault back in at 
> > > resume time, before the user can even begin to think about doing anything 
> > > useful. You might be able to say "Every machine that suspend2 works on, 
> > > swsusp works on", but the later will be a pretty sad definition of works!
> > 
> > We are trying to catch a bug here. suspend2 or not, it is a bug and it
> > should be fixed (or at least understood).
> > 
> > [Also please try to tone down your messages. Your suspend2 may be more
> > user-friendly, you do not want to start that flamewar again, do you?
> > Saying "don't bother fixing that" is not nice thing to do.]
> 
> Heh, I guess I should apologize for being offtopic on suspend2 mailing
> list... this was not about suspend2 any more.. 
> 
> I guess we should drop suspend2 and this huge cc list from future
> discussion. (And fix subject.)
> 
> Anyway, Rafael, do you think you could commit your encryption patches?
> Ready or not, bugs can be fixed later :-). [I'd like to do some work
> based on them; I think I figured out easy way to setup suspend so that
> password is needed only during resume...] 

Done.  I've also committed the patch to arrange the error messages in suspend
in a better way.

Greetings,
Rafael
