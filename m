Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310468AbSDQRFW>; Wed, 17 Apr 2002 13:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310470AbSDQRFV>; Wed, 17 Apr 2002 13:05:21 -0400
Received: from bitmover.com ([192.132.92.2]:7877 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S310468AbSDQRFU>;
	Wed, 17 Apr 2002 13:05:20 -0400
Date: Wed, 17 Apr 2002 10:05:20 -0700
From: Larry McVoy <lm@bitmover.com>
To: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: [Linux-fbdev-devel] Fbdev Bitkeeper repository
Message-ID: <20020417100520.P745@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10204161542470.29030-100000@www.transvirtual.com> <20020416225752.GA5897@0xd6.org> <20020416160121.B24069@work.bitmover.com> <20020417000818.GB5897@0xd6.org> <20020416181034.C24069@work.bitmover.com> <20020417024149.GC5897@0xd6.org> <20020416203721.B27525@work.bitmover.com> <20020417164718.GA22767@ravel.coda.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2002 at 12:47:18PM -0400, Jan Harkes wrote:
> Where is that $1/GB drive that can replace the 800MB drive in my Compaq
> 1120 laptop? There isn't any, because Compaq locked the drive geometry
> in the bios to only work with this one particular 800MB drive that isn't
> produced anymore. And that drive, even if I find another one, is
> definitely not going to be 80 cents.

You're right, it's $79.95 for the whole laptop at the buy-it-now price
on Ebay, go get it.

http://cgi.ebay.com/ws/eBayISAPI.dll?ViewItem&item=2017735168

> rate for dialup, but what about people that have to pay by the minute
> for their 5KB/s dialup connection. Saving 100MB in data transfer will
> not just save them 5 hours and 41 minutes of download time, but also
> a whole lot in phone charges.

Indeed.  So how about you go make a test tree with BK and the same test
tree with CVS, do a set of operations like checkout, update, etc., with
both and report back on the bandwidth stats?  What you'll find is that
they are about the same for the initial checkout, BK will be a bit more
actually because it copies the revision files not the checked out files,
and then for ever subsequent operation, BK is less.

Suppose you have the linux-2.5 tree and you want to get the USB tree,
you can _locally_ clone the 2.5 tree to usb and then pull from the USB
tree.  Thereby saving lotso bandwidth.  One of our developers is behind
a modem and he does this sort of thing all the time.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
