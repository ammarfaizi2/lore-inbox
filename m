Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261570AbULTPlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261570AbULTPlr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 10:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbULTPhk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 10:37:40 -0500
Received: from mail.kroah.org ([69.55.234.183]:35508 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261571AbULTPhQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 10:37:16 -0500
Date: Mon, 20 Dec 2004 07:35:08 -0800
From: Greg KH <greg@kroah.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Ed Tomlinson <edt@aei.ca>, Pete Zaitcev <zaitcev@redhat.com>,
       Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       "Randy.Dunlap" <rddunlap@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: RFC: [2.6 patch] let BLK_DEV_UB depend on EMBEDDED
Message-ID: <20041220153508.GB17121@kroah.com>
References: <200412200702.50071.edt@aei.ca> <Pine.LNX.4.44L0.0412201026390.1358-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0412201026390.1358-100000@ida.rowland.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2004 at 10:28:05AM -0500, Alan Stern wrote:
> On Mon, 20 Dec 2004, Ed Tomlinson wrote:
> 
> > Its not that they just enable it.  Its that it has side effects.  I enable it to support
> > one device - it then 'devnaps' other devices that usbstorage supports _much_
> > better.  Is there some way it could work in reverse.  eg. let ub bind only if 
> > usbstorage does not, possibly making usbstorage a _little_ more conservative
> > if ub is present?
> 
> Unfortunately there isn't any way to define which driver should bind to a 
> device, if they are both capable of controlling it.  Maybe there should 
> be.  It might not be too hard to add a sysfs interface for that sort of 
> thing.

We are working on it...

thanks,

greg k-h
