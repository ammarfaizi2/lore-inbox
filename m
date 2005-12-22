Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751073AbVLZJPz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbVLZJPz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 04:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751074AbVLZJPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 04:15:55 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:53515 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1751071AbVLZJPz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 04:15:55 -0500
Date: Thu, 22 Dec 2005 16:02:44 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Greg KH <greg@kroah.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Stern <stern@rowland.harvard.edu>,
       David Brownell <david-b@pacbell.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: USB rejecting sleep
Message-ID: <20051222160244.GA2747@ucw.cz>
References: <1134937642.6102.85.camel@gaston> <20051218215051.GA18257@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051218215051.GA18257@kroah.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > What exactly changed in the recent USB stacks that is causing it to
> > abort system suspend much more often ? I'm getting lots of user reports
> > with 2.6.15-rc5 saying that they can't put their internal laptops to
> > sleep, apparently because a driver doesn't have a suspend method
> > (internal bluetooth in this case).
> > 
> > It's never been mandatory so far for all drivers of all connected
> > devices to have a suspend method... didn't we decide back then that
> > disconneting those was the right way to go ?
> 
> Yes it is, and I have a patch in my tree now that fixes this up and
> keeps the suspend process working properly for usb drivers that do not
> have a suspend function.
> 
> Hm, I wonder if it should go in for 2.6.15?

It would be nice to have some fixes in 2.6.15, so we are
not swamped with bugreports. Its a regression after all.

-- 
Thanks, Sharp!
