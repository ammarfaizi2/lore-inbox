Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030321AbWGTXI2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030321AbWGTXI2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 19:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030326AbWGTXI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 19:08:28 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:62694 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1030321AbWGTXI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 19:08:27 -0400
Date: Fri, 21 Jul 2006 10:07:35 +0200
From: Pavel Machek <pavel@ucw.cz>
To: George Nychis <gnychis@cmu.edu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Jeff Chua <jchua@fedex.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: suspend/hibernate to work on thinkpad x60s?
Message-ID: <20060721080735.GA1741@elf.ucw.cz>
References: <30DF6C25102A6E4BBD30B26C4EA1DCCC0162E099@MEMEXCH10V.corp.ds.fedex.com> <44BCFDA6.3030909@cmu.edu> <200607190005.02351.rjw@sisk.pl> <44BE4B33.6090009@cmu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44BE4B33.6090009@cmu.edu>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2006-07-19 11:09:39, George Nychis wrote:
> Okay, I was missing that, thanks
> 
> So, i suspended to disk the first time and it seemed to suspend
> properly, then I hit the power button on the thinkpad and it took me to
> the thinkpad screen, back to grub, and booted the OS from the beginning.
>  Did I resume the wrong way?
> 
> So, after it rebooted, i tried to suspend it to disk again:
> x60s gnychis # echo platform > /sys/power/disk; echo disk > /sys/power/state
> bash: echo: write error: No such device
> 
> So now it won't even suspend to disk.

> Any ideas?

Read the docs?

Then you'll need AHCI suspend support, it went on lkml few hours ago.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
