Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263665AbTFPKdT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 06:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263676AbTFPKdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 06:33:19 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:37644 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263665AbTFPKdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 06:33:18 -0400
Date: Mon, 16 Jun 2003 12:47:10 +0200
From: Pavel Machek <pavel@suse.cz>
To: CaT <cat@zip.com.au>
Cc: swsusp@lister.fornax.hu, linux-kernel@vger.kernel.org
Subject: Re: [FIX, please test] Re: 2.5.70-bk16 - nfs interferes with s4bios suspend
Message-ID: <20030616104710.GA12173@atrey.karlin.mff.cuni.cz>
References: <20030613033703.GA526@zip.com.au> <20030615183111.GD315@elf.ucw.cz> <20030616001141.GA364@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030616001141.GA364@zip.com.au>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ahoj!

> > >  stopping tasks failed (2 tasks remaining)
> > > Suspend failed: Not all processes stopped!
> > > Restarting tasks...<6> Strange, rpciod not stopped
> > 
> > This should fix it... Someone please test it.
> 
> I didn't have any actual nfs mounts at the time but I tried it
> with an otherwise similar system. It went through, got to freeing
> memory, showed me a bunch of fullstops being drawn and then went
> into an endless BUG loop. All I could pick out (after many a moment
> of staring) was 'schedule in atmoic'.
> 
> I'll do a proper test with a console cable present in a few days. I
> can't atm cos I'm not on the same network and don't have a 2nd 
> computer to hook up the null-modem cable to.
> 
> Pre-empt is on btw.

Turn it off. You don't want to debug preempt and nfs at the same time.

								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
