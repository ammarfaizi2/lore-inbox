Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750873AbWBCWwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873AbWBCWwz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 17:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751502AbWBCWwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 17:52:55 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:30883 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750873AbWBCWwz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 17:52:55 -0500
Date: Fri, 3 Feb 2006 23:52:37 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Pekka Enberg <penberg@cs.helsinki.fi>,
       linux-kernel@vger.kernel.org
Subject: Re: [ 01/10] [Suspend2] kernel/power/modules.h
Message-ID: <20060203225237.GB3251@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602031020.46641.nigel@suspend2.net> <200602030957.48626.rjw@sisk.pl> <200602032147.23782.nigel@suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200602032147.23782.nigel@suspend2.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Pá 03-02-06 21:47:18, Nigel Cunningham wrote:
> On Friday 03 February 2006 18:57, Rafael J. Wysocki wrote:
> > On Friday 03 February 2006 01:20, Nigel Cunningham wrote:
> > > On Friday 03 February 2006 08:10, Rafael J. Wysocki wrote:

> > The biggest advantage of the userland-based approach I see is that there
> > may be _many_ implementations of the suspending and resuming tools
> > and they will not conflict.  For example, if Distributor X needs an exotic
> > feature Y wrt suspend (various vendor-specific eye-candies come to mind or
> > transferring the image over a network), he can implement it in his userland
> > tools without modifying the kernel.  Similarly, if Vendor V wants to use
> > paranoid encryption algorithm Z to encrypt the image, she can do that
> > _herself_ in the user space.
> 
> True, but can you really imagine people doing that? The one instance I can 
> think of was the donation of LZF support to Suspend2 a couple of
> years back.

Yes, I expect them to do so. Desktop distros have different needs than
for example embedded vendors, wanting to use swsusp for fast boot.

> > We only need to provide reference tools and we won't be asked to implement
> > every feature that people may want in the kernel.
> 
> I don't want it to be true, but I think you're being naive in saying that :) 
> We'll see, won't we?

I think I have a volunteer inside suse doing at least some of userland
swsusp work.
								Pavel
-- 
Thanks, Sharp!
