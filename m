Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265525AbTIESuJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 14:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265548AbTIESuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 14:50:09 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:14257 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S265525AbTIESuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 14:50:05 -0400
Date: Fri, 5 Sep 2003 20:49:59 +0200
From: Pavel Machek <pavel@suse.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: Rob Landley <rob@landley.net>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Fix up power managment in 2.6
Message-ID: <20030905184959.GL16859@atrey.karlin.mff.cuni.cz>
References: <200309050158.36447.rob@landley.net> <Pine.LNX.4.44.0309051044470.17174-100000@cherise>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309051044470.17174-100000@cherise>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > APM suspend doesn't work properly on my new thinkpad (suspends but hangs with 
> > the power LED still on and the hibernate light off, and the thing's a brick 
> > at that point; the only thing you can do is hold the power button down for 
> > ten seconds or pop the battery to get it to boot back up from scratch.)  So I 
> > have to shut the sucker down every time I want to move it, which is a pain...
> 
> What model is it? It probably doesn't support APM at all. I can't
> guarantee that ACPI suspend/resume will work on it, but I'm interested to 
> see if it does.. 

If it did not support APM at all, it would not crash because APM
module would not load. Try to see if 2.4 APM works. (2.6 APM is known
not to be in great shape).
								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
