Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263108AbTJPTDC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 15:03:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263110AbTJPTDC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 15:03:02 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:39614 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263108AbTJPTC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 15:02:58 -0400
Date: Thu, 16 Oct 2003 16:06:45 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.0-test7 - Suspend to Disk success
Message-ID: <20031016140644.GJ1659@openzaurus.ucw.cz>
References: <Pine.LNX.4.44.0310081235280.4017-100000@home.osdl.org> <20031015172742.GZ30375@earth.li> <20031015210054.GA1492@picchio.gall.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031015210054.GA1492@picchio.gall.it>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Just a quick note to say that 2.6.0-test7 is the first kernel I've been
> > able to successfully suspend to disk with and then resume. Using
> > "echo -n disk > /sys/power/state" now works just fine and I haven't
> > needed to reboot my laptop (a Compaq Evo N200) since I started running
> > the kernel last week. Thanks!
> 
> Same for me, using pmdisk.
> Only thing is that the shell used to issue the echo -n disk > /sys/power/state
> gets killed for an unhadled page request.
> 
> Good bargain for a working suspend, though ;-)
> For me it is actually a feature, since I use su to issue the suspend
> command, on resume I get back my user (not sudoed) shell...
> 

Look at the logs, perhaps you have an oops?
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

