Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263045AbTDFSIp (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 14:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263048AbTDFSIp (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 14:08:45 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:65284 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263045AbTDFSIo (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 14:08:44 -0400
Date: Sun, 6 Apr 2003 20:20:17 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: swsusp - 2.5.66 incremental
Message-ID: <20030406182016.GA17666@atrey.karlin.mff.cuni.cz>
References: <1049537149.1709.6.camel@laptop-linux.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1049537149.1709.6.camel@laptop-linux.cunninghams>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Here's the first incremental patch for you, Pavel. As requested, I've
> sent patches to Alan Cox (ide-disk.c) and Richard Gooch (mtrrs - I
> didn't implement the driver model - just attached the relevant portion
> and asked for his feedback). This is patch 3, then.

You really should have moved it to the driver model... having #ifdef
in suspend.c for every driver would be very ugly.

> It's pretty simple - just replaces (temporarily) the assembly with code
> that we can patch, as we've previously discussed. You'll remember that I
> found I needed to use the 2.4 version to get it working - that's what's
> included here. Only one small change - it uses longs rather than chars
> during copying, making restoring the image take 1/4 of the time. (Not
> significant when there are only 2000 pages being saved, but remember
> this is groundwork for future patches).

I'm not going to take this, because I would not be able to sync this
to Linus (and have enough problems keeping my patches up-to-date
already).

								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
