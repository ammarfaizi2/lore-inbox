Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270014AbTGPBbz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 21:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270022AbTGPBby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 21:31:54 -0400
Received: from ip67-95-245-82.z245-95-67.customer.algx.net ([67.95.245.82]:60689
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S270014AbTGPBbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 21:31:52 -0400
Date: Tue, 15 Jul 2003 18:46:50 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Greg KH <greg@kroah.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Hotplug Oops Re: Linux v2.6.0-test1
Message-ID: <20030716014650.GB2681@matchmail.com>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0307132055080.2096-100000@home.osdl.org> <20030716012948.GA1877@matchmail.com> <20030716013743.GA2112@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030716013743.GA2112@kroah.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15, 2003 at 06:37:43PM -0700, Greg KH wrote:
> On Tue, Jul 15, 2003 at 06:29:48PM -0700, Mike Fedyk wrote:
> > Here's a nice oops for you guys.
> > 
> > Hotplug is the trigger.  I can't reproduce without hotplug.
> > 
> > hotplug tries to load ohci, ehci, and finally uhci (the correct module), it
> > oopses for each driver with hotplug, but if I try without hotplug ('apt-get
> > remove hotplug' before rebooting), I can load all three usb drivers with no
> > oops.
> 
> If you just load these drivers by hand, does the oops happen?
> 

I didn't look into the hotplug scripts to see which hotplug modules (and
they are modules for me) were being loaded and in which order.

I did load the usb drivers by hand with no oops though.

> Can you enable debugging in the kobject code, or the driver base code to
> try to get some better debug messages of what is going on?
> 

Please tell me which file that's in, and what I need to change, or give a
patch.

Thanks.
