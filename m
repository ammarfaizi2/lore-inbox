Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270696AbTGUUhx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 16:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270702AbTGUUhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 16:37:53 -0400
Received: from ip-66-80-37-197.chi.megapath.net ([66.80.37.197]:34569 "HELO
	srvr1.mousebusiness.com") by vger.kernel.org with SMTP
	id S270696AbTGUUhv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 16:37:51 -0400
User-Agent: Microsoft-Outlook-Express-Macintosh-Edition/5.02.2022
Date: Mon, 21 Jul 2003 15:52:52 -0500
Subject: Re: AMD MP, SMP, Tyan 2466
From: Artur Jasowicz <kernel@mousebusiness.com>
To: joe briggs <jbriggs@briggsmedia.com>,
       Brian Jackson <brian@brianandsara.net>,
       Bart SCHELSTRAETE <Bart.SCHELSTRAETE@dhl.com>,
       <linux-kernel@vger.kernel.org>
Message-ID: <BB41BCD3.17A02%kernel@mousebusiness.com>
In-Reply-To: <200306251451.40496.jbriggs@briggsmedia.com>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe,
Thanks for your suggestions. I've tried Kingston registered DIMMs and got
the same result (crashes in SMP, runs ok with "nosmp" boot parameter)

I am currently trying to extract your kernel from .deb package, but am
running into RPM hell of circular dependency while trying to install alien
to access .deb archive.

Any chance I could bother you to put a tgz archive with kernel on your
dowlnoads site?

I've also downloaded source archive from your site, but I am not sure if it
is for the AMD mobo. The file linux-2.4.21.tz seems to be configured for
Intel chips, judging from .config file.

I'd rather borrow your kernel source than use your ready-made kernel. I
still have to compile Promise SX6000 drivers for it.

Thanks again

Artur

> 
> I shipped out two machines last week using the Tyan 2466, 2.4.21 compiled for
> SMP on Debian Woody.  My kernel includes support for promise, hpt, and 3ware
> ide raid cards. I shipped one unit with the 3ware 7000-2 and 2 WD-2000-JB
> drives and 4 x bt878 frame-grabbers, and the 2nd with 3ware 8500 (8-channel)
> and 8 x WD1200-JB drives.  Both machines went through their 48-hour
> heavy-load burn-in period without incident.
> 
> If the exact kernel tree and config would help, you can get it at:
> 
> wget http://www.briggsmedia.com/downloads/kernel-2.4.21.tz
> 
> Forgot to mention -
> I tried this board with PC2100 bought from the local computer store (don't
> know the name) and I got all kinds of weird problems like boot failure, file
> system corruption, everything except a memory error.  I then tried a 512 mb
> stick of kingston pc2100 and it completely solved the problems.
> 

