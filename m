Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264409AbTIJDcw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 23:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264438AbTIJDcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 23:32:52 -0400
Received: from mail.kroah.org ([65.200.24.183]:60848 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264409AbTIJDcv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 23:32:51 -0400
Date: Tue, 9 Sep 2003 20:33:06 -0700
From: Greg KH <greg@kroah.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Patrick Mochel <mochel@osdl.org>,
       Linux usb mailing list 
	<linux-usb-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] [PATCH] Re: Driver model problems in -test5: usb this time
Message-ID: <20030910033306.GC9760@kroah.com>
References: <20030909230118.GF211@elf.ucw.cz> <Pine.LNX.4.44.0309091628000.695-100000@cherise> <20030910001955.GF217@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030910001955.GF217@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 02:19:56AM +0200, Pavel Machek wrote:
> Hi!
> 
> > > > The latter two functions do not exist in -test5. It would helpful if you 
> > > > tried to reproduce with a virgin -test5. It would be courteous to state 
> > > > what patches you applied on top of the virgin -test5 kernel. 
> > > 
> > > Lot of them, but only "revert to -test3 swsusp" should be important
> > > here.
> > 
> > Then all bets are off. I cannot expect to reproduce the problems until you 
> > narrow down which patch causes the problem or verify that it appears on a 
> > standard kernel release.
> 
> Here's patch that should fix it. [First part of first hunk defitely
> triggered twice during suspend, and made machine survive that.] Please
> apply,

Doh, thanks for catching this, I'll add this to my tree and send it in
my next batch to Linus.

This was my fault, nothing that Pat added.

thanks,

greg k-h
