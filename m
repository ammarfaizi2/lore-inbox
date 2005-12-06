Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932447AbVLFRS1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932447AbVLFRS1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 12:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932473AbVLFRS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 12:18:27 -0500
Received: from mail.kroah.org ([69.55.234.183]:35293 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932447AbVLFRS1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 12:18:27 -0500
Date: Tue, 6 Dec 2005 08:47:00 -0800
From: Greg KH <greg@kroah.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: Tim Bird <tim.bird@am.sony.com>, Dave Airlie <airlied@gmail.com>,
       David Woodhouse <dwmw2@infradead.org>, arjan@infradead.org,
       andrew@walrond.org, linux-kernel@vger.kernel.org
Subject: Re: Linux in a binary world... a doomsday scenario
Message-ID: <20051206164700.GA2596@kroah.com>
References: <21d7e9970512051610n1244467am12adc8373c1a4473@mail.gmail.com> <4394DA1D.3090007@am.sony.com> <20051206040820.GB26602@kroah.com> <20051206060734.GB7096@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051206060734.GB7096@alpha.home.local>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2005 at 07:07:34AM +0100, Willy Tarreau wrote:
> It's not about being dumb, but this problem is -I think- what prevents
> some companies from releasing drivers for their hardware (when they
> don't consider that opening it will give their IP away). I've played
> several times with opensource drivers for ADSL modems, LCD modules,
> watchdogs, ethernet adapters, IDE drivers, etc... and their problem
> was that what worked well in 2.4.21 did not even build in 2.4.22
> and became difficult to fix starting with 2.4.23. Most of those
> small companies who propose a Linux driver simply start by paying
> a student during summer for porting their windows/sco/whatever
> driver to linux. They think the job is done when he leaves.
> Unfortunately, they receive complaints 3 months later from users
> because the driver is broken and does not build. They don't have
> the resources to keep a permanent developer on it, and they
> quickly understand that Linux is just a "geek OS" and that it's
> the last time they release any driver.

That's why Documentation/HOWTO was written, to help those people realize
what needs to be done in order to do it properly.

thanks,

greg k-h
