Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbTJWUJm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 16:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261776AbTJWUIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 16:08:24 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:8391 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261779AbTJWUIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 16:08:13 -0400
Date: Thu, 23 Oct 2003 15:55:24 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Rob Landley <rob@landley.net>
Cc: Voicu Liviu <pacman@mscc.huji.ac.il>, linux-kernel@vger.kernel.org
Subject: Re: Wow.  Suspend to disk works for me in test8. :)
Message-ID: <20031023135523.GE643@openzaurus.ucw.cz>
References: <200310200225.11367.rob@landley.net> <3F93BCCB.1050406@mscc.huji.ac.il> <200310201556.43520.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310201556.43520.rob@landley.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> A couple of down sides I've noticed: I have to run "hwclock --hctosys" after a 
> resume because the time you saved at is the time the system thinks it is when 
> you resume (ouch).  And because of that, things that should time out and 
> renew themselves (like dhcp leases) have to be thumped manually.

I sent fix for that yesterday... but you'd need to fix swsusp.c's
sysdev handling and mtrr-s => better wait.
			Pavel
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

