Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750949AbVJOCS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbVJOCS6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 22:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750969AbVJOCS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 22:18:58 -0400
Received: from mail.kroah.org ([69.55.234.183]:34954 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750946AbVJOCS5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 22:18:57 -0400
Date: Fri, 14 Oct 2005 19:18:18 -0700
From: Greg KH <greg@kroah.com>
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: akpm@osdl.org, Christian Krause <chkr@plauener.de>,
       linux-kernel@vger.kernel.org, stable@kernel.org,
       Chris Wright <chrisw@osdl.org>
Subject: Re: [PATCH] Re: bug in handling of highspeed usb HID devices
Message-ID: <20051015021818.GA12951@kroah.com>
References: <m34q7mwlvv.fsf@gondor.middle-earth.priv> <m3oe5riwib.fsf@gondor.middle-earth.priv> <20051014234225.GA11301@kroah.com> <200510142143.21944.kernel-stuff@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510142143.21944.kernel-stuff@comcast.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2005 at 09:43:21PM -0400, Parag Warudkar wrote:
> On Friday 14 October 2005 19:42, Greg KH wrote:
> > Did you try this patch out? ?It is wrong. ?Please look at the
> > compiler warning that this change generates and redo the patch.
> 
> [CC'ed Andrew - likely he has the wrong patch queued up.]

Andrew's already dropped the wrong patch.

> And to save Christian some time, here is a hint - interval is used 
> uninitialized!

Which leads me to believe that Christian never tried the patch :(

thanks,

greg k-h
