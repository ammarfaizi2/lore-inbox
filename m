Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269013AbUJQCyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269013AbUJQCyU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 22:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269014AbUJQCyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 22:54:20 -0400
Received: from mail.kroah.org ([69.55.234.183]:9088 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269013AbUJQCyS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 22:54:18 -0400
Date: Sat, 16 Oct 2004 19:53:44 -0700
From: Greg KH <greg@kroah.com>
To: Chris Rankin <rankincj@yahoo.com>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [OOPS] Linux 2.6.8.1 with PL2303 USB serial converter
Message-ID: <20041017025344.GA17007@kroah.com>
References: <20041016225332.GA20284@kroah.com> <20041017005445.33808.qmail@web52905.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041017005445.33808.qmail@web52905.mail.yahoo.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 17, 2004 at 01:54:45AM +0100, Chris Rankin wrote:
>  --- Greg KH <greg@kroah.com> wrote: 
> > pl2303 devices will not work when connected to USB
> > 2.0 hubs, sorry. Care to try it out without the hub
> > in the way?
> 
> Hmm, is this a design limitation in the pl2303 driver?
> Or the hub driver? Or does the problem lie with the
> hardware somehow?

It's an issue with the ehci driver right now.  The author of it knows
about the problem.

> > Also, can you try out 2.6.9-final and see if that
> > oopses in the same way?
> 
> I'll definitely be trying this with 2.6.9 when it's
> released; what's with this '-final' notation?

It's what Linus released today.  Please try it, and if there's still an
issue, I can fix it to be included when 2.6.9 is released.

thanks,

greg k-h
