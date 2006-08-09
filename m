Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbWHINdn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbWHINdn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 09:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbWHINdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 09:33:42 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:11720 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750755AbWHINdm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 09:33:42 -0400
Date: Wed, 9 Aug 2006 15:33:27 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@osdl.org>
Subject: Re: [RFC][PATCH -mm 2/5] swsusp: Use memory bitmaps during resume
Message-ID: <20060809133327.GH3808@elf.ucw.cz>
References: <200608091152.49094.rjw@sisk.pl> <200608091304.35746.rjw@sisk.pl> <20060809113335.GP3308@elf.ucw.cz> <200608091351.06596.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608091351.06596.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I'm still not sure if highmem support is worth the complexity -- I
> > hope highmem dies painful death in next 3 weeks or so.
> 
> metoo, but currently quite a lot of Core Duo-based notebooks with 1 GB of RAM
> and more are still being sold, let alone the Celerons, Semprons etc.

Well, 1GB should still be reasonably well supported, even with current
code. 3GB+ machines will be different story.

> The patch is designed so that the higmem-related parts are just dropped by the
> compiler if CONFIG_HIGHMEM is not set.  That makes it a bit larger, but then
> they don't get in the way when they are not needed.
> 
> [Well, I've been using 64-bit machines only for quite some time anyway, but
> I thought it would be nice to do something for the others, too. ;-) ]

Okay.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
