Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318299AbSGRSej>; Thu, 18 Jul 2002 14:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318301AbSGRSej>; Thu, 18 Jul 2002 14:34:39 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:21766 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S318299AbSGRSei>;
	Thu, 18 Jul 2002 14:34:38 -0400
Date: Thu, 18 Jul 2002 11:36:17 -0700
From: Greg KH <greg@kroah.com>
To: Duncan Sands <duncan.sands@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.26 hotplug failure
Message-ID: <20020718183617.GI15529@kroah.com>
References: <200207180950.42312.duncan.sands@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200207180950.42312.duncan.sands@wanadoo.fr>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Thu, 20 Jun 2002 16:36:31 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2002 at 09:50:42AM +0200, Duncan Sands wrote:
> I just gave 2.5.26 a whirl.  The first thing I noticed was
> that the hotplug system didn't run the script for my usb
> modem...
> 
> kernel: usb.c: USB disconnect on device 2
> kernel: hub.c: new USB device 00:0b.0-2, assigned address 4
> kernel: usb.c: USB device 4 (vend/prod 0x6b9/0x4061) is not claimed by any active driver.
> /etc/hotplug/usb.agent: ... no modules for USB product 6b9/4061/0
> 
> however this works just fine with 2.4.19-rc1 and 2.5.24 (i.e. only difference
> is the change in kernel)...

But that message is from the hotplug agent, right?

What kind of script used to get run, and how was it run (i.e. on network
interface registration, etc.)

thanks,

greg k-h
