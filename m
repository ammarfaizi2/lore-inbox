Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752268AbWKLSRF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752268AbWKLSRF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 13:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752250AbWKLSQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 13:16:49 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:63500 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1752249AbWKLSQs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 13:16:48 -0500
Date: Sun, 12 Nov 2006 14:55:50 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc5: grub is much slower resuming from suspend-to-disk than in 2.6.18
Message-ID: <20061112145549.GC4371@ucw.cz>
References: <200611121436.46436.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611121436.46436.arvidjaar@mail.ru>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 12-11-06 14:36:41, Andrey Borzenkov wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> This is rather funny; in 2.6.19-rc5 grub is *really* slow loading kernel when 
> I switch on the system after suspend to disk. Actually, after kernel has been 
> loaded, the whole resuming (up to the point I have usable desktop again) 
> takes about three time less than the process of loading kernel + initrd. 
> During loading disk LED is constantly lit. This almost looks like kernel 
> leaves HDD in some strange state, although I always assumed HDD/IDE is 
> completely reinitialized in this case.

Seems like broken hw, really. No state should survive machine
poweroff.

Is it notebook?

Can you try to unplug system for a few minutes / unplug battery if
notebook to see if it helps?
							Pavel
-- 
Thanks for all the (sleeping) penguins.
