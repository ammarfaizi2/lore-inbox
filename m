Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbTISWYN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 18:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbTISWYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 18:24:13 -0400
Received: from mail.kroah.org ([65.200.24.183]:51946 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261797AbTISWYK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 18:24:10 -0400
Date: Fri, 19 Sep 2003 15:24:27 -0700
From: Greg KH <greg@kroah.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: David Brownell <david-b@pacbell.net>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: USB APM suspend
Message-ID: <20030919222427.GA7808@kroah.com>
References: <Pine.LNX.4.44L0.0309191755590.763-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0309191755590.763-100000@ida.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 19, 2003 at 06:14:29PM -0400, Alan Stern wrote:
> 
> P.S.: Greg, what on Earth does "GREG: gregindex = 0" mean?

Heh, using the linuxusb.bkbits.net/usb-2.5 tree are ya?  :)

It's some debugging code left in by me for some module loading code
changes I've been working on in my spare time.  It's to implement only
loading signed kernel modules.  That message means that the "gregindex"
section in the elf records of the kernel module was not found.  It if
is, lots of other code gets kicked off.  I'll try to clean it all up
into a reasonable state next week and make a patch available for those
that want to play with it.

Sorry about leaving that in there, I'll go delete it.  I try to make all
my debugging code start with GREG: so I'll never send it off for
inclusion in someone else's tree.

greg k-h
