Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbWHAVEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbWHAVEx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 17:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750850AbWHAVEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 17:04:53 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:53777 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1750799AbWHAVEw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 17:04:52 -0400
Date: Tue, 1 Aug 2006 20:59:35 +0000
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Al Boldi <a1426z@gawab.com>, linux-kernel@vger.kernel.org
Subject: Re: swsusp hangs on headless resume-from-ram
Message-ID: <20060801205935.GB7601@ucw.cz>
References: <200607262206.48801.a1426z@gawab.com> <200607262207.46773.rjw@sisk.pl> <200607270034.47532.a1426z@gawab.com> <200607281055.47526.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607281055.47526.rjw@sisk.pl>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > swsusp is really great, most of the time.  But sometimes it hangs after
> > > > coming out of STR.  I suspect it's got something to do with display
                      ~~~

> > > > access, as this problem seems hw related.  So I removed the display
> > > > card, and it positively does not resume from ram on 2.6.16+.
> > > >
> > > > Any easy fix for this?
> > >
> > > I have one idea, but you'll need a patch to test.  I'll try to prepare it
> > > tomorrow.
> > >
> > > I guess your box is an i386?
> > 
> > That should be assumed by default :)
> 
> I had hoped I would be able to test it somewhere, but I couldn't.  I hope
> it will compile. :-)
> 
> If it does, please send me the output of dmesg after a fresh boot.

It seems to me Al is talking suspend-to-RAM (?).

-- 
Thanks for all the (sleeping) penguins.
