Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267542AbTGMSwb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 14:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270334AbTGMSwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 14:52:31 -0400
Received: from mail.kroah.org ([65.200.24.183]:30340 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267542AbTGMSwa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 14:52:30 -0400
Date: Sun, 13 Jul 2003 12:07:02 -0700
From: Greg KH <greg@kroah.com>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.75-mm1: lockup when inserting USB storage device
Message-ID: <20030713190702.GB15094@kroah.com>
References: <1058050082.4831.70.camel@ixodes.goop.org> <20030713042422.GF2695@kroah.com> <1058113235.4997.3.camel@ixodes.goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058113235.4997.3.camel@ixodes.goop.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 13, 2003 at 09:20:35AM -0700, Jeremy Fitzhardinge wrote:
> On Sat, 2003-07-12 at 21:24, Greg KH wrote:
> > Most people get the suspend/resume cycle to work properly for USB by
> > unloading and then loading the host controller drivers.  Does that solve
> > this problem?
> > 
> > Yeah, I know it's not a perfect solution, sorry.  Hopefully we will get
> > better power management stuff soon...
> 
> Thanks, I'll try that out.
> 
> What about the 2nd part of the problem, in which the USB storage device
> is detected but unusable after insertion?

That's something the usb-storage developers should look at.  Try asking
them on their mailing list, or on the linux-usb-devel list.

Good luck,

greg k-h
