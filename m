Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261571AbVHASQM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261571AbVHASQM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 14:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261761AbVHASQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 14:16:12 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:15533 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261571AbVHASOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 14:14:15 -0400
Date: Mon, 1 Aug 2005 11:13:57 -0700
From: Greg KH <gregkh@suse.de>
To: Jamey Hicks <jamey.hicks@hp.com>
Cc: Andrey Volkov <avolkov@varma-el.com>,
       linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Where is place of arch independed companion chips?
Message-ID: <20050801181357.GA31144@suse.de>
References: <42EB6A12.70100@varma-el.com> <42EE15AF.5050902@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42EE15AF.5050902@hp.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2005 at 08:29:35AM -0400, Jamey Hicks wrote:
> Andrey Volkov wrote:
> 
> >Hi Greg,
> >
> >While I write driver for SM501 CC (which have graphics controller, USB
> >MASTER/SLAVE, AC97, UART, SPI  and VIDEO CAPTURE onboard),
> >I bumped with next ambiguity:
> >Where is a place of this chip's Kconfig/drivers in
> >kernel config/drivers tree? May be create new node in drivers subtree?
> >Or put it under graphics node (since it's main function of this CC)?
> >
> >AFAIK, this is not one such multifunctional monster in the world, so
> >somebody bumped with this problem again in future.
> >
> > 
> >
> Good question.  I was about to submit a patch that created 
> drivers/platform because the toplevel driver for MQ11xx is a 
> platform_device driver.  Any thoughts on this?

drivers/platform sounds good to me.

thanks,

greg k-h
