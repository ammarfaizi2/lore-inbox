Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266052AbUFEJZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266052AbUFEJZV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 05:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266057AbUFEJZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 05:25:21 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:51598 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266052AbUFEJZP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 05:25:15 -0400
Date: Sat, 5 Jun 2004 11:24:48 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Ed Tomlinson <edt@aei.ca>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: ide errors in 7-rc1-mm1 and later
Message-ID: <20040605092447.GB13641@suse.de>
References: <1085689455.7831.8.camel@localhost> <200406041438.44706.bzolnier@elka.pw.edu.pl> <20040604124704.GA1946@suse.de> <200406041534.48688.bzolnier@elka.pw.edu.pl> <20040604152347.GD1946@suse.de> <40C0B191.2040201@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40C0B191.2040201@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04 2004, Jeff Garzik wrote:
> Jens Axboe wrote:
> >else that works for barriers. It's mind boggling that nothing so far has
> >come out of t13 to address this, I guess data integrity isn't high on
> >their list.
> 
> 
> Chuckle :)
> 
> Personally I look at it the other way around -- why hasn't anybody on 
> the OS side written up a proposal that satisfies 100% of the OS barrier 
> needs?
> 
> We've got the device manufacturer contacts these days to get serious 
> attention paid, IMO.  Just need the proposal now.
> 
> Just like Linux, ATA evolves in the direction that people speak up 
> about...  I'll leave it to the audience to decide if Windows and data 
> integrity go hand-in-hand <grin>

I did suggest this a few years ago. The comment I received was that
they didn't take suggestions from OS people, if I didn't have a drive
implementation to go with the proposal they couldn't use it for
anything. Which was interesting, since that seemed to suggest that t13
had little steering in ata development, they mainly put into the ATA
specs what drive manufacturers shoved at them. Of course this isn't 100%
true, but it does explain a lot of things :-)

Andre even tried getting FUA to do what we needed, no such luck there.
Some other bigger OS wanted it differently, the rest is history.

There's nothing I would love more than being able to kill the pre and
post flushes and use something more effective. So if we can write up a
proposal that has some chance of being debated, I'm all for it.

-- 
Jens Axboe

