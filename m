Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261265AbREQHYl>; Thu, 17 May 2001 03:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261294AbREQHYb>; Thu, 17 May 2001 03:24:31 -0400
Received: from zeus.kernel.org ([209.10.41.242]:63659 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261289AbREQHYS>;
	Thu, 17 May 2001 03:24:18 -0400
Date: Tue, 15 May 2001 16:26:28 +0000
From: Pavel Machek <pavel@suse.cz>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Getting FS access events
Message-ID: <20010515162627.C38@toy.ucw.cz>
In-Reply-To: <200105150620.f4F6KKd22491@vindaloo.ras.ucalgary.ca> <Pine.LNX.4.21.0105142324140.23912-100000@penguin.transmeta.com> <200105150649.f4F6nwD22946@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200105150649.f4F6nwD22946@vindaloo.ras.ucalgary.ca>; from rgooch@ras.ucalgary.ca on Tue, May 15, 2001 at 12:49:58AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> And because your suspend/resume idea isn't really going to help me
> much. That's because my boot scripts have the notion of
> "personalities" (change the boot configuration by asking the user
> early on in the boot process). If I suspend after I've got XDM
> running, it's too late.

Why not e2defrag so that everything needed for bootup is linear on the
start of disk? Use strace to collect statistics of what happens during 
bootup. [strac should be good enough. If not, uml is.]
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

