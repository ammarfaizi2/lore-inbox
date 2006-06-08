Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964989AbWFHUiL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964989AbWFHUiL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 16:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964991AbWFHUiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 16:38:11 -0400
Received: from smtp101.sbc.mail.mud.yahoo.com ([68.142.198.200]:37488 "HELO
	smtp101.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964989AbWFHUiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 16:38:10 -0400
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [PATCH] limit power budget on spitz
Date: Thu, 8 Jun 2006 13:38:05 -0700
User-Agent: KMail/1.7.1
Cc: Richard Purdie <rpurdie@rpsys.net>, Pavel Machek <pavel@suse.cz>,
       Russell King <rmk+lkml@arm.linux.org.uk>, lenz@cs.wisc.edu,
       David Liontooth <liontooth@cogweb.net>,
       Oliver Neukum <oliver@neukum.org>,
       kernel list <linux-kernel@vger.kernel.org>
References: <447EB0DC.4040203@cogweb.net> <200606081126.20142.david-b@pacbell.net> <1149797216.16945.234.camel@localhost.localdomain>
In-Reply-To: <1149797216.16945.234.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606081338.07489.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The PXA platform does have an existing mechanism to pass platform data
> (I added it a while back). I've added
> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=3547/1
> into the patch system replacing Pavel's version.

OK, I see now.  Simple enough, better than the original.  Go for it.

There was a PXA issue I was alluding to that's still open, though.
It's the way there's no selectivity about what platform devices are
registered ... even kernels running on boards where OHCI isn't hooked
up to anything will be registering an OHCI controller, as one of many
examples.  Won't affect this particular case, but in general that'd
be nice to see fixed.

- Dave

