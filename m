Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269226AbTGVDrj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 23:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269358AbTGVDrj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 23:47:39 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.92.226.49]:47602 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S269226AbTGVDrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 23:47:37 -0400
Subject: Re: AMD MP, SMP, Tyan 2466
From: Jason <jason@project-lace.org>
To: Artur Jasowicz <kernel@mousebusiness.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <BB41BCD3.17A02%kernel@mousebusiness.com>
References: <BB41BCD3.17A02%kernel@mousebusiness.com>
Content-Type: text/plain
Message-Id: <1058846559.8494.17.camel@big-blue.project-lace.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 22 Jul 2003 00:02:39 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm coming into this conversation a bit late, so I might be missing
something and appologize if I am.  But  I have the same board and
experienced some intersting weirdness with PC2100 NON ECC chips on this
board as well.  I was using High performance ram from Mushkin at the
time.  Now here's the interesting part, according to some small print in
the manual, non ecc ram works up to 1.5Gb.  Knowing this, I bought 1Gb
of it, 2 512MB sticks.  I put them both in, and the board only sees
512Mb.  So I talk to Mushkin about it, apparently they've done some
testing with this board.  Non ECC memory is EXTREMELY flakey in this
board.  So flakey that Tyan, unofficially mind you, recommened to them
that they not suggest to their customers to put non ecc memory in this
board.  So I got 1Gb of ECC Registered memory, and have yet to have a
problem with it.

That's just my $.02 and I hope it helps in some way.

Oh yeah, and I am running 2.4.21 config'ed for AMD and SMP and still, no
problems.

On Mon, 2003-07-21 at 16:52, Artur Jasowicz wrote:
> Joe,
> Thanks for your suggestions. I've tried Kingston registered DIMMs and got
> the same result (crashes in SMP, runs ok with "nosmp" boot parameter)
> 
> I am currently trying to extract your kernel from .deb package, but am
> running into RPM hell of circular dependency while trying to install alien
> to access .deb archive.
> 
> Any chance I could bother you to put a tgz archive with kernel on your
> dowlnoads site?
> 
> I've also downloaded source archive from your site, but I am not sure if it
> is for the AMD mobo. The file linux-2.4.21.tz seems to be configured for
> Intel chips, judging from .config file.
> 
> I'd rather borrow your kernel source than use your ready-made kernel. I
> still have to compile Promise SX6000 drivers for it.
> 
> Thanks again
> 
> Artur
> 
> > 
> > I shipped out two machines last week using the Tyan 2466, 2.4.21 compiled for
> > SMP on Debian Woody.  My kernel includes support for promise, hpt, and 3ware
> > ide raid cards. I shipped one unit with the 3ware 7000-2 and 2 WD-2000-JB
> > drives and 4 x bt878 frame-grabbers, and the 2nd with 3ware 8500 (8-channel)
> > and 8 x WD1200-JB drives.  Both machines went through their 48-hour
> > heavy-load burn-in period without incident.
> > 
> > If the exact kernel tree and config would help, you can get it at:
> > 
> > wget http://www.briggsmedia.com/downloads/kernel-2.4.21.tz
> > 
> > Forgot to mention -
> > I tried this board with PC2100 bought from the local computer store (don't
> > know the name) and I got all kinds of weird problems like boot failure, file
> > system corruption, everything except a memory error.  I then tried a 512 mb
> > stick of kingston pc2100 and it completely solved the problems.
> > 
> 


