Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261507AbUBYSV1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 13:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261530AbUBYSUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 13:20:00 -0500
Received: from gprs151-5.eurotel.cz ([160.218.151.5]:7043 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261507AbUBYSTk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 13:19:40 -0500
Date: Wed, 25 Feb 2004 19:19:18 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Bill Peck <bill@pecknet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3 kernel, USB and suspend/resume
Message-ID: <20040225181918.GF1214@elf.ucw.cz>
References: <1077471586.8116.53.camel@bilbo.home.pecknet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1077471586.8116.53.camel@bilbo.home.pecknet.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I am trying to get a suspend/resume to work on a Via C3 (Epia M10000). 
> The system suspends and comes back up after resuming.. But USB is not
> too happy.  I'm seeing the "Unlink after no-IRQ?" error in
> /var/log/messages after resuming.  I had been removing the uhci-hcd, and
> ehci-hcd modules before suspend and loading them after resume.  
> 
> I guess I'm looking for any suggestions on different ideas to try..  or
> someone to say "Forget it for now.. its broken".  I've been trying
> 2.6.3, 2.6.3-bk[34], 2.6.3-mm[12] wouldn't compile for me.  

Consult usb-specific lists.

> as an aside note the via-rhine ethernet driver doesn't come back after
> resume either.  and it shares an irq with the USB system.  I tried

Hmm, via-rhine has no suspend/resume support. No wonder it does not
work.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
