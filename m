Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751360AbWINGOi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbWINGOi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 02:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbWINGOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 02:14:37 -0400
Received: from mail.kroah.org ([69.55.234.183]:24220 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751360AbWINGOh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 02:14:37 -0400
Date: Wed, 13 Sep 2006 22:57:20 -0700
From: Greg KH <greg@kroah.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC] Simple userspace interface for PCI drivers
Message-ID: <20060914055720.GB18031@kroah.com>
References: <20060830062338.GA10285@kroah.com> <20060912194714.GA1970@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060912194714.GA1970@uranus.ravnborg.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2006 at 09:47:14PM +0200, Sam Ravnborg wrote:
> On Tue, Aug 29, 2006 at 11:23:38PM -0700, Greg KH wrote:
> > 
> > So, here's the code.  I think it does a bit too much all at once, but it
> > is an example of how this can be done.  This is working today in some
> > industrial environments, successfully handling hardware controls of very
> > large and scary machines.
> 
> At present it is named uio in -mm. But that seems to conflict with a
> few cases (uio.h + Solaris).
> 
> How about:
> Universal User IO => uuio
> 
> A quick google did not turn up anything conflicting.

Ah, I like that better.  I had made the header file be called
uio_driver.h to get around the namespace issue, but uuio sounds nice.

thanks,

greg k-h
