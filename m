Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263225AbTCZDyk>; Tue, 25 Mar 2003 22:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263279AbTCZDyk>; Tue, 25 Mar 2003 22:54:40 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:23044 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S263225AbTCZDyi>;
	Tue, 25 Mar 2003 22:54:38 -0500
Date: Tue, 25 Mar 2003 20:05:05 -0800
From: Greg KH <greg@kroah.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: addition to visor.c
Message-ID: <20030326040505.GB20858@kroah.com>
References: <20030326021847.GA21363@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030326021847.GA21363@localhost>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 26, 2003 at 02:18:47AM +0000, iain d broadfoot wrote:
> First off, hi all and thanks for all the kernels. :D
> 
> I have fiddled together the following info for a sony clie nz90, which i
> believe should go in drivers/usb/serial/visor.{h,c}.

Thanks, but this device is already supported in the latest 2.5 kernel :)

And it's in my queue of patches to send to Marcelo for 2.4, so it will
show up there too eventually.

> ok, it recognizes, but none of the apps i have seem to like the clie - i
> get 'please press hotsync button now' messages, despite the fact that
> the /dev/ttyUSB1 device is only there after the button has been
> pressed... :(

Try the latest version of pilot-link, from pilot-link.org.  You need
that.  If that doesn't work, try ttyUSB0, that might be the correct port
for this device.

Thanks,

greg k-h
