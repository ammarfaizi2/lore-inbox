Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbTIRLgm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 07:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261155AbTIRLfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 07:35:25 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:63977 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261171AbTIRLfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 07:35:13 -0400
Date: Wed, 17 Sep 2003 16:14:50 +0200
From: Pavel Machek <pavel@suse.cz>
To: joshk@triplehelix.org, linux-kernel@vger.kernel.org, mochel@osdl.org
Subject: Re: Swsusp weirdness with ACPI
Message-ID: <20030917141450.GB9125@openzaurus.ucw.cz>
References: <20030913210722.GA264@anemic> <Pine.LNX.4.33.0309150955360.950-100000@localhost.localdomain> <20030917024011.GA11587@triplehelix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030917024011.GA11587@triplehelix.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Also, if you're willing, I would recommend trying 2.6.0-test5-mm2, which
> > will allow you to try the original swsusp code (via /proc/acpi/sleep)
> > independently of the more recent suspend-to-disk code (via 
> > /sys/power/state).
> 
> With 2.6.0-test5-mm2, 
> 
> - 4/4bios don't do anything
> - 3 will stop tasks... I got a "<6>Strange, ircd not stopped" once, and
>   I removed my wifi card and it was good. (Yes, ircd was listening on
>   it.)
> 
>   But after all of this hubbub it still won't come back to life. :(
> 
> I will try the other stuff later, I'm short of time these days.
> Thanks for your help so far.

Can you try to do reboot(SW_SUSPEND) syscall? Did it work with -test3?
				Pavel

-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

