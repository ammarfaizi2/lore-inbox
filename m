Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263910AbSITXG3>; Fri, 20 Sep 2002 19:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263917AbSITXG3>; Fri, 20 Sep 2002 19:06:29 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:269 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S263910AbSITXG3>;
	Fri, 20 Sep 2002 19:06:29 -0400
Date: Fri, 20 Sep 2002 16:11:12 -0700
From: Greg KH <greg@kroah.com>
To: David Brownell <david-b@pacbell.net>
Cc: Brad Hards <bhards@bigpond.net.au>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: 2.5.26 hotplug failure
Message-ID: <20020920231112.GC24813@kroah.com>
References: <200207180950.42312.duncan.sands@wanadoo.fr> <E17rwAI-0000vM-00@starship> <20020919164924.GB15956@kroah.com> <200209200656.23956.bhards@bigpond.net.au> <20020919230643.GD18000@kroah.com> <3D8B884A.7030205@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D8B884A.7030205@pacbell.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2002 at 01:42:50PM -0700, David Brownell wrote:
> 
> Actually it does more than that ... it tells you what minor numbers
> are assigned to the drivers _currently loaded_ which means that it's
> not really useful the instant someone plugs in another device.

Wait, I'm confused, which one is "it"?  The old /proc/bus/usb/drivers
file, or the new driverfs stuff?

> You can't use it to allocate numbers or tell what /dev/file/name matches
> a given device ... so what is its value, other than providing a limited
> minor number counterpart to /proc/devices?  (Which, confusingly, doesn't
> list devices but major numbers.)

I'm working on adding the minor number info to the usb driverfs code
right now, so that info will be available. 

thanks,

greg k-h
