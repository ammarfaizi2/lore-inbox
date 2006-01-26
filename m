Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbWAZFud@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbWAZFud (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 00:50:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbWAZFud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 00:50:33 -0500
Received: from mail.kroah.org ([69.55.234.183]:35280 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750710AbWAZFuc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 00:50:32 -0500
Date: Wed, 25 Jan 2006 21:39:41 -0800
From: Greg KH <greg@kroah.com>
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] Re: 2.6.16-rc1-mm3
Message-ID: <20060126053941.GA13361@kroah.com>
References: <20060124232406.50abccd1.akpm@osdl.org> <43D7567E.60003@reub.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43D7567E.60003@reub.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2006 at 11:44:14PM +1300, Reuben Farrelly wrote:
> 
> 
> On 25/01/2006 8:24 p.m., Andrew Morton wrote:
> >http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc1/2.6.16-rc1-mm3/
> >
> >- Dropped the timekeeping patch series due to a complex timesource 
> >selection
> >  bug.
> >
> >- Various fixes and updates.
> 
> Generally quite good again :)
> 
> I'm seeing this USB "handoff" warning message logged when booting up:
> 
> 0000:00:1d.7 EHCI: BIOS handoff failed (BIOS bug ?)
> 
> This is not new to this -mm release, looking back over my bootlogs I note 
> that 2.6-15-rc5-mm1 was OK, but 2.6.15-mm4 was showing this message.  I'll 
> narrow it down if it doesn't appear obvious what the problem is.

When this happens, does your usb-ehci driver still work properly
(meaning do usb 2.0 devices connect and go at the proper high speeds)?

And if you change the USB setting in your bios, does this error message
go away?

thanks,

greg k-h
