Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932210AbVLDXZq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbVLDXZq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 18:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbVLDXZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 18:25:46 -0500
Received: from mail.kroah.org ([69.55.234.183]:52174 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932210AbVLDXZp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 18:25:45 -0500
Date: Sun, 4 Dec 2005 15:24:54 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051204232454.GG8914@kroah.com>
References: <20051203135608.GJ31395@stusta.de> <9a8748490512030629t16d0b9ebv279064245743e001@mail.gmail.com> <20051203201945.GA4182@kroah.com> <9a8748490512031948m26b04d3ds9fbc652893ead40@mail.gmail.com> <20051204115650.GA15577@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051204115650.GA15577@merlin.emma.line.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 04, 2005 at 12:56:50PM +0100, Matthias Andree wrote:
> The problem is the upstream breaking backwards compatibility for no good
> reason. This can sometimes be a genuine unintended regression (aka.
> bug), but quite often this is deliberate breakage because someone wants
> to get rid of cruft. While the motivation is sound, breaking between
> 2.6.N and 2.6.M must stop.

What are we breaking that people are complaining so much about?
Specifics please.

And if you bring up udev, please see my previous comments in this thread
about that issue.

It isn't userspace stuff that is breaking, as applications built on 2.2
still work just fine here on 2.6 for me.

Yes we break in-kernel apis, all the time, that's fine.  See
Documentation/stable-api-nonsense.txt for details about why we do that.

So again, specifics please?

thanks,

greg k-h
