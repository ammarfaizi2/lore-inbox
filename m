Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266491AbSL2IFy>; Sun, 29 Dec 2002 03:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266497AbSL2IFy>; Sun, 29 Dec 2002 03:05:54 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:4108 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S266491AbSL2IFx>;
	Sun, 29 Dec 2002 03:05:53 -0500
Date: Sun, 29 Dec 2002 00:09:36 -0800
From: Greg KH <greg@kroah.com>
To: Ed Tomlinson <tomlins@cam.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] USB changes for 2.5.53
Message-ID: <20021229080935.GA19453@kroah.com>
References: <20021228075959.GA14314@kroah.com> <20021228200120.79E3F10BA@oscar.casa.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021228200120.79E3F10BA@oscar.casa.dyndns.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 28, 2002 at 03:01:19PM -0500, Ed Tomlinson wrote:
> Greg KH wrote:
> 
> > Hi,
> > 
> > Here's a lot of little USB changes, mostly all of them are conversions
> > to using the driver core model better for usb and usb-serial devices.
> > 
> > Please pull from:  bk://linuxusb.bkbits.net/linus-2.5
> 
> Something in this seems to be ooping here:

Hm, I can't duplicate this myself here.  My pl2303 device works just
fine, but it is one that doesn't need the "hack" to work properly.  And
I didn't change any code in that area.

Can you duplicate this when you plug in your pl2303 device, after
booting?  And can you enable CONFIG_KALLSYMS to get a better oops
message that might be more helpful?

thanks,

greg k-h
