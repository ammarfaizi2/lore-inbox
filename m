Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263931AbTDWBnu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 21:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263932AbTDWBnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 21:43:40 -0400
Received: from granite.he.net ([216.218.226.66]:28688 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S263931AbTDWBng (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 21:43:36 -0400
Date: Tue, 22 Apr 2003 18:57:52 -0700
From: Greg KH <greg@kroah.com>
To: Dave Jones <davej@codemonkey.org.uk>, Hanno B?ck <hanno@gmx.de>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       Linux-usb-users@lists.sourceforge.net
Subject: Re: PATCH: some additional unusual_devs-entries for usb-storage-driver, kernel 2.5.68
Message-ID: <20030423015752.GA6315@kroah.com>
References: <20030421214805.7de5e4f3.hanno@gmx.de> <20030422213247.GA5076@kroah.com> <20030423004508.GA4158@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030423004508.GA4158@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 23, 2003 at 01:45:08AM +0100, Dave Jones wrote:
> On Tue, Apr 22, 2003 at 02:32:47PM -0700, Greg KH wrote:
>  > On Mon, Apr 21, 2003 at 09:48:05PM +0200, Hanno B?ck wrote:
>  > > This patch against 2.5.68 adds support for some digital cameras.
>  > > Same patch is already applied to the 2.4-ac-series.
>  > > It is taken from the lycoris kernel-source.
>  > 
>  > Ok, in talking with the usb-storage author, I'll be accepting all
>  > unushal_devs.h patches now, as long as they contain the following:
>  > 	- a comment above the entry with a email address of someone who
>  > 	  has this device that this entry fixes the driver for them.
>  > 	  This is to allow us to possibly remove entries at a later time
>  > 	  if the core changes, and get a verification that it's ok to do
>  > 	  so.
>  > 	- a copy of the /proc/bus/usb/devices device entry with the
>  > 	  device plugged in and the driver loaded (this should not be in
>  > 	  the patch, but in the body of the email.)
>  > 	  
>  > So, if there are any outstanding drivers/usb/storage/unusual_devs.h
>  > entries that people have floating around, sent them on!
> 
> I've been carrying these for _moons_. The only reason I've never punted
> them on is that the US_FL_SL_IDE_BUG bit is odd (nothing seems to use
> it, so at some point, I must have dropped the other half of the diff).

Hm, that is strange, I'll ignore that part of the patch :)

And what are the odds of getting /proc/bus/usb/devices from those email
addresses?  I'll try offline to collect them.

thanks,

greg k-h
