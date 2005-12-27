Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932211AbVL0EUE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbVL0EUE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 23:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbVL0EUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 23:20:04 -0500
Received: from mail.kroah.org ([69.55.234.183]:60297 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932211AbVL0EUD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 23:20:03 -0500
Date: Mon, 26 Dec 2005 20:17:47 -0800
From: Greg KH <greg@kroah.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Bodo Eggert <7eggert@gmx.de>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH] USB_BANDWIDTH documentation change
Message-ID: <20051227041747.GA23916@kroah.com>
References: <Pine.LNX.4.58.0512262244480.22764@be1.lrz> <Pine.LNX.4.44L0.0512261731001.10595-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0512261731001.10595-100000@netrider.rowland.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 26, 2005 at 05:35:29PM -0500, Alan Stern wrote:
> On Mon, 26 Dec 2005, Bodo Eggert wrote:
> 
> > On Mon, 26 Dec 2005, Lee Revell wrote:
> > > On Mon, 2005-12-26 at 11:25 +0100, Bodo Eggert wrote:
> > 
> > > > Document the current status of CONFIG_USB_BANDWITH implementation.
> > > 
> > > Since most systems use uhci-hcd and/or ehci-hcd maybe we should just
> > > mark it BROKEN?  Or EXPERIMENTAL?
> > 
> > It is EXPERIMENTAL, but the current documentation sounds like "YOU REALLY
> > WANT THIS !!!1", and I /guess/ that would be true for ohci-hcd users.
> 
> CONFIG_USB_BANDWIDTH isn't _really_ needed.  What it does (or rather, what 
> it would do if it worked properly) is prevent the kernel from 
> overcommitting on USB bandwidth.

I just saw (but can't find again, sorry) a gentoo bug of an external usb
driver on x86-64 that oopses _unless_ this config option is set.  So for
some people it is necessary and not broken.

thanks,

greg k-h
