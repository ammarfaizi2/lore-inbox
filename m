Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271089AbTHGXEq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 19:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271103AbTHGXEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 19:04:46 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:25532 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S271089AbTHGXEn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 19:04:43 -0400
Date: Fri, 8 Aug 2003 00:35:42 +0200
From: Pavel Machek <pavel@suse.cz>
To: David Brownell <david-b@pacbell.net>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] OHCI problems with suspend/resume
Message-ID: <20030807223541.GA124@elf.ucw.cz>
References: <20030723220805.GA278@elf.ucw.cz> <3F2673C4.9010302@pacbell.net> <20030731141807.GC16463@atrey.karlin.mff.cuni.cz> <3F2AA64F.3090404@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F2AA64F.3090404@pacbell.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>Here's a patch that makes things slightly better. ....
> >>
> >>Where "better" means that it seems functional after the
> >>first suspend/resume cycle, and re-enumerates the device
> >>that's connected ... but there's still strangeness.  And
> >>I can see how some of it would be generic.
> >
> >For me it:
> >
> >reports problem after first suspend, and ohci stops working
> 
> When you say "reports problem", what do you mean?

I fixed PCI powermangment, and OHCI problems are gone (replaced by
"machine-feels-like-XT-because-keventd-spins"). I'm looking onto that.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
