Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbTIEK0b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 06:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262360AbTIEK0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 06:26:31 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:45984 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262328AbTIEK0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 06:26:30 -0400
Date: Fri, 5 Sep 2003 12:26:28 +0200
From: Pavel Machek <pavel@suse.cz>
To: Rob Landley <rob@landley.net>
Cc: Patrick Mochel <mochel@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Fix up power managment in 2.6
Message-ID: <20030905102628.GB16859@atrey.karlin.mff.cuni.cz>
References: <Pine.LNX.4.44.0309011509450.5614-100000@cherise> <200309050158.36447.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309050158.36447.rob@landley.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > In all actuality, I don't need swsusp. I have a better suspend-to-disk
> > implementation that is faster, smaller, and cleaner. I've hesitated
> > merging it because I thought swsusp improvements would be more welcome.
> > Obviously they're not; or you haven't actually taken the time to read the
> > code.
> 
> Is there somewhere we can download your code?  swsusp in -test3 hung my box 
> immediately without touching the disk, and in -test4 there doesn't seem to be 
> any way to trigger it under /proc or /sys...

echo -n disk > /sys/power/disk, but it is broken.

> I've been subscribed to the swsusp list for two weeks now and 2.6 has only 
> been mentioned _once_, and that was a two message thread with somebody asking 
> about it and nigel saying he didn't have time to work on it right now.  It's 
> a apparently a 2.4-only list, and I don't use 2.4 anymore.

2.6 swsusp development is not really done on that list.

									Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
