Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261276AbULTJNz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbULTJNz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 04:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261287AbULTJNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 04:13:54 -0500
Received: from gprs215-234.eurotel.cz ([160.218.215.234]:57730 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261276AbULTJKh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 04:10:37 -0500
Date: Mon, 20 Dec 2004 10:10:22 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10-rc3-mm1: swsusp
Message-ID: <20041220091022.GA23473@elf.ucw.cz>
References: <200412181852.31942.rjw@sisk.pl> <20041219173433.GA1130@elf.ucw.cz> <200412200144.00945.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412200144.00945.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I'm not sure why swsusp critical section interferes with 
> > serial, perhaps serial console support has to "know" about serial
> > console and not suspend it during suspend() call?
> 
> It didn't do that before 2.6.9 or so.  Something must have changed afterwards.  
> And the serial console shows messages that appear right before writing the 
> image to swap (like "swsusp: Version: ..." etc.).

You may want to remove suspend() support from serial drivers and see
what happens... Or find exact patch that broke it.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
