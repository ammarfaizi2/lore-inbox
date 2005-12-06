Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964999AbVLFSDV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964999AbVLFSDV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 13:03:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964990AbVLFSCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 13:02:51 -0500
Received: from mail.kroah.org ([69.55.234.183]:3309 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964998AbVLFSCa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 13:02:30 -0500
Date: Tue, 6 Dec 2005 09:46:21 -0800
From: Greg KH <greg@kroah.com>
To: Florian Weimer <fw@deneb.enyo.de>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051206174621.GD3084@kroah.com>
References: <20051203135608.GJ31395@stusta.de> <9a8748490512030629t16d0b9ebv279064245743e001@mail.gmail.com> <20051203201945.GA4182@kroah.com> <873bl7eh21.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <873bl7eh21.fsf@mid.deneb.enyo.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2005 at 03:48:06PM +0100, Florian Weimer wrote:
> * Greg KH:
> 
> > On Sat, Dec 03, 2005 at 03:29:54PM +0100, Jesper Juhl wrote:
> >> 
> >> Why can't this be done by distributors/vendors?
> >
> > It already is done by these people, look at the "enterprise" Linux
> > distributions and their 5 years of maintance (or whatever the number
> > is.)
> >
> > If people/customers want stability, they already have this option.
> 
> It seems that vendor kernels lack most DoS-related fixes.  I'm only
> aware of a single vendor which tracks them to the point that CVE names
> are assigned.

If those DoS-related problems are only related to local user DoS's, yes,
that is understandable.  If you have questions about this, ask the
vendor, they usually have a good reason for not including those fixes.

> Vendor kernels are not a panacea, either.  With some of the basic
> support contracts (in the four-figure range per year and CPU), the
> vendor won't look extensively at random kernel crashes which could (in
> theory) be attributed to faulty hardware, *and* you don't get
> community support for these heavily patched kernel collages.

Yes, the lack of community support is one thing you do give up with
them.

thanks,

greg k-h
