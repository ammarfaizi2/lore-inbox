Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264529AbTDPQ4U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 12:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264521AbTDPQ4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 12:56:03 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:18317 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264509AbTDPQyu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 12:54:50 -0400
Date: Wed, 16 Apr 2003 10:08:14 -0700
From: Greg KH <greg@kroah.com>
To: Robert Schwebel <robert@schwebel.de>
Cc: David Brownell <david-b@pacbell.net>,
       linux-usb-devel <linux-usb-devel@lists.sourceforge.net>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Chosing the right Linux "USB Gadget" API and Driver Framework
Message-ID: <20030416170814.GA18854@kroah.com>
References: <20030416073635.GA10886@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030416073635.GA10886@pengutronix.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 16, 2003 at 09:36:35AM +0200, Robert Schwebel wrote:
> I'm currently working on support for the USB gadget controller inside
> the Intel PXA25x XScale processor. David Brownell has recently published
> a new USB gadget API which was discussed on linux-usb-devel and which
> seems to be a good starting point.
> 
> As there is at least one other API (by Belcarra, former Lineo code) I'm
> wondering what Greg's and Linus' position concerning the new USB gadget
> API is. A comment from your side would be welcome. 

I've looked at both apis, and think the one from David looks much better
than the old Lineo code (don't know if that has been updated in a long
time, I might not be aware of newer developments with that code.)

So, barring any unforseen pushes from the ex-Lineo developers I expect
David's code to make it into the main kernel tree eventually.

Hope this helps,

greg k-h
