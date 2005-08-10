Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932603AbVHJXb6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932603AbVHJXb6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 19:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932604AbVHJXb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 19:31:57 -0400
Received: from mail.kroah.org ([69.55.234.183]:47335 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932603AbVHJXb5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 19:31:57 -0400
Date: Wed, 10 Aug 2005 16:31:44 -0700
From: Greg KH <greg@kroah.com>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problem with usb-storage and /dev/sd?
Message-ID: <20050810233144.GA6718@kroah.com>
References: <20050810192243.GA620@DervishD> <20050810215032.GA27982@irc.pl> <20050810220616.GA918@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050810220616.GA918@DervishD>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2005 at 12:06:16AM +0200, DervishD wrote:
>     Hi Tomasz :)
> 
>  * Tomasz Torcz <zdzichu@irc.pl> dixit:
> > On Wed, Aug 10, 2005 at 09:22:43PM +0200, DervishD wrote:
> > >     The problem is that if I plug my USB memory, unplug it and plug
> > > my MP3 player, it gets /dev/sdb this time, not /dev/sda. The mess is
> > > even greater if I plug my card reader, which has four LUN's...
> >  That's what udev is for.
> 
>     I know, but I use a 2.4.x kernel (which I didn't mention in my
> original message, sorry O:)), and udev needs a 2.6.x kernel, am I
> wrong?

That is correct, udev needs 2.6.  So, with 2.4 you are on your own here,
sorry.

thanks,

greg k-h
