Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268233AbUHKVbX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268233AbUHKVbX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 17:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268244AbUHKVbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 17:31:23 -0400
Received: from mail.kroah.org ([69.55.234.183]:24210 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268233AbUHKVbT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 17:31:19 -0400
Date: Wed, 11 Aug 2004 14:23:08 -0700
From: Greg KH <greg@kroah.com>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: David Brownell <david-b@pacbell.net>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Oliver Neukum <oliver@neukum.org>, Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: What PM should be and do (Was Re: Solving suspend-level confusion)
Message-ID: <20040811212308.GH21894@kroah.com>
References: <20040730164413.GB4672@elf.ucw.cz> <200408031928.08475.david-b@pacbell.net> <1091588163.5225.77.camel@gaston> <200408032030.41410.david-b@pacbell.net> <1091594872.3191.71.camel@laptop.cunninghams> <20040805181925.GB30543@kroah.com> <1091744073.2597.15.camel@laptop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091744073.2597.15.camel@laptop.cunninghams>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2004 at 08:14:34AM +1000, Nigel Cunningham wrote:
> Hi.
> 
> On Fri, 2004-08-06 at 04:19, Greg KH wrote:
> > On Wed, Aug 04, 2004 at 02:47:52PM +1000, Nigel Cunningham wrote:
> > > - support for telling what class of device a driver is handling (I'm
> > > particularly interested in keeping the keyboard, screen and storage
> > > devices alive while suspending).
> > 
> > You can see that info today from userspace by looking in
> > /sys/class/input, /sys/class/graphics, and /sys/block
> 
> Does this apply to all devices

No.

>, and how do I tell it 'programmatically'?

 From within the kernel?  I don't think you really can, sorry.

greg k-h
