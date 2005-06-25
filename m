Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263311AbVFYD1e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263311AbVFYD1e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 23:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263313AbVFYD1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 23:27:34 -0400
Received: from mail.kroah.org ([69.55.234.183]:21945 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263311AbVFYD1a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 23:27:30 -0400
Date: Fri, 24 Jun 2005 20:27:15 -0700
From: Greg KH <greg@kroah.com>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: Add the ability to unbind drivers to devices from userspace
Message-ID: <20050625032715.GB3934@kroah.com>
References: <20050624051229.GA24621@kroah.com> <20050624051442.GB24621@kroah.com> <Pine.LNX.4.50.0506240855460.24799-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0506240855460.24799-100000@monsoon.he.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2005 at 08:57:15AM -0700, Patrick Mochel wrote:
> 
> On Thu, 23 Jun 2005, Greg KH wrote:
> 
> > This adds a single file, "unbind", to the sysfs directory of every
> > device that is currently bound to a driver.  To unbind the driver from
> > the device, write anything to this file and they will be disconnected
> > from each other.
> 
> Do you think it would be better to put the 'unbind' file in the driver's
> directory and have it accept the bus ID of a device that it's bound to?
> This would make it more similar to the complementary 'bind' functionality.

Yeah, you are right, I'll make that change.  Heh, symmetry, what a
concept...

thanks,

greg k-h
