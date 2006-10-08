Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751358AbWJHThG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbWJHThG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 15:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbWJHThF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 15:37:05 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:25755 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751358AbWJHThE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 15:37:04 -0400
Date: Sun, 8 Oct 2006 21:36:48 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Oliver Neukum <oliver@neukum.org>, David Brownell <david-b@pacbell.net>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] error to be returned while suspended
Message-ID: <20061008193648.GA4042@elf.ucw.cz>
References: <200610071703.24599.david-b@pacbell.net> <Pine.LNX.4.44L0.0610072153510.15825-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0610072153510.15825-100000@netrider.rowland.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > That is, the standard model is useless?  I think you've made
> > a few strange leaps of logic there ... care to fill in those
> > gaps and explain just _why_ that standard model is "useless"???
> > 
> > Recall by the way that the autosuspend stuff kicked off with
> > discussions about exactly how to make sure that Linux could
> > get the power savings inherent in suspending USB root hubs,
> > with remote wakeup enabling use of the mouse on that keyboard.
> > (I remember Len Brown talking to me a few years back about how
> > that was the "last" 2W per controller easily available to save
> > power on Centrino laptops ... now we're almost ready to claim
> > that savings.)
> 
> The most obvious model for suspending keyboards or mice is an inactivity 
> timeout (with the timeout limit set from userspace), but other policies 
> certainly could be useful in specific circumstances.
> 
> Considering that we have virtually no autosuspend capability now, taking
> the first few simple steps will be a big help.  Just getting an
> infrastructure in place is a good start, even without a userspace API.  
> Later on, when we have a better idea of what we want, bells and whistles
> can be added.

<AOL>Mee too</AOL>

Please, lets do few "autosuspend" things, and when we know how it
looks, we can think about doing something more advanced.

								Pavel 

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
