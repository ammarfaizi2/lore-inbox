Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270007AbTGPBWm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 21:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270005AbTGPBWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 21:22:42 -0400
Received: from mail.kroah.org ([65.200.24.183]:57762 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270014AbTGPBWk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 21:22:40 -0400
Date: Tue, 15 Jul 2003 18:37:43 -0700
From: Greg KH <greg@kroah.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Hotplug Oops Re: Linux v2.6.0-test1
Message-ID: <20030716013743.GA2112@kroah.com>
References: <Pine.LNX.4.44.0307132055080.2096-100000@home.osdl.org> <20030716012948.GA1877@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030716012948.GA1877@matchmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15, 2003 at 06:29:48PM -0700, Mike Fedyk wrote:
> Here's a nice oops for you guys.
> 
> Hotplug is the trigger.  I can't reproduce without hotplug.
> 
> hotplug tries to load ohci, ehci, and finally uhci (the correct module), it
> oopses for each driver with hotplug, but if I try without hotplug ('apt-get
> remove hotplug' before rebooting), I can load all three usb drivers with no
> oops.

If you just load these drivers by hand, does the oops happen?

Can you enable debugging in the kobject code, or the driver base code to
try to get some better debug messages of what is going on?

thanks,

greg k-h
