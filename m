Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262934AbUB1CKl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 21:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262999AbUB1CKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 21:10:41 -0500
Received: from mail.kroah.org ([65.200.24.183]:3025 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262934AbUB1CKk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 21:10:40 -0500
Date: Fri, 27 Feb 2004 18:10:41 -0800
From: Greg KH <greg@kroah.com>
To: Daniel Robbins <drobbins@gentoo.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-bk9 QA testing: firewire good, USB printing dead
Message-ID: <20040228021040.GA14836@kroah.com>
References: <1077933682.14653.23.camel@wave.gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1077933682.14653.23.camel@wave.gentoo.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 27, 2004 at 07:01:22PM -0700, Daniel Robbins wrote:
> However, 2.6.3-bk9's USB printing support appears to be dead. I can't
> get it to work reliably. Tested on Epson Stylus Photo 960 and a Brother
> Laser printer. catting files to /dev/usb/lp? tends to fail (process will
> get "stuck") and printer data stops flowing. This is on an Athlon XP
> (NForce2) system using the on-board USB. The official 2.6.3 release
> works fine. I'd expect these USB printing death symptoms to be easily
> reproducable on quite a few systems -- the problems hit me in the first
> few seconds of print testing. If they end up being more elusive, I can
> try to dig up more info for anyone who's interested in trying to isolate
> the problem.

Yes, I am.  Do you get any error messages in your syslog when the
printer hangs?

thanks,

greg k-h
