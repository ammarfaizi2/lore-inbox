Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266117AbTIKAXx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 20:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266119AbTIKAXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 20:23:53 -0400
Received: from mail.kroah.org ([65.200.24.183]:24450 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266117AbTIKAXv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 20:23:51 -0400
Date: Wed, 10 Sep 2003 17:12:01 -0700
From: Greg KH <greg@kroah.com>
To: Subodh Shrivastava <subodh@btopenworld.com>
Cc: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Power Management Update
Message-ID: <20030911001201.GA6996@kroah.com>
References: <Pine.LNX.4.44.0309101407450.19541-100000@cherise> <3F5F8D34.8020404@btopenworld.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F5F8D34.8020404@btopenworld.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 09:44:36PM +0100, Subodh Shrivastava wrote:
> 
> 
> Patrick Mochel wrote:
> 
> >>Any chance of this  patch to be released against mm series? BTW i have 
> >>tried suspend to disk (2.6.0-test4-mm6) with reiserfs filesystem
> >>it worked fine and no fs corruption.
> >>   
> >>
> >
> >Good to hear. Thanks for testing. 
> > 
> >
> Tried it with 2.6.0-test5-mm1.
> 
> When i tried suspend to disk with my usb modem (Alcatel Speedtouch) 
> attached, system generated oops, couldn't get a dump on disk, will send 
> the handwritten oops later. When i tried from X suspend to disk was 
> successful but resume failed and system rebooted itself, did not get a 
> chance to figure out what went wrong.

There was a patch by Pavel to fix the USB core bug.  To rule this out,
unload the usbcore module before suspending.

Sorry about that.

greg k-h
