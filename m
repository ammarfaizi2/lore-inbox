Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319425AbSH3ES7>; Fri, 30 Aug 2002 00:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319426AbSH3ES7>; Fri, 30 Aug 2002 00:18:59 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:51729 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S319425AbSH3ES6>;
	Fri, 30 Aug 2002 00:18:58 -0400
Date: Thu, 29 Aug 2002 21:22:28 -0700
From: Greg KH <greg@kroah.com>
To: abhishek Sinha <aby_sinha@yahoo.com>
Cc: linux-usb-users@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: AMD 768 USB Controller
Message-ID: <20020830042228.GB6486@kroah.com>
References: <20020830001234.GJ5074@kroah.com> <20020830002137.13089.qmail@web20709.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020830002137.13089.qmail@web20709.mail.yahoo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2002 at 05:21:37PM -0700, abhishek Sinha wrote:
> > Looks like the usb-ohci driver bound to your device
> > just fine :)
> 
> OOPs mistake from my side.It must be the ohci driver
> instead of the uhci..(just got confused).
> 
> "all apologies"
> > 
> > And what happens when you plug in your USB device?
> 
> When i plug the device into the machine the kernel
> crashes.Thinking it might be something with the
> hotplug i disabled it (mv /sbin/hotplug
> /sbin/hotplug.old) and inserted the modules one by
> one.When i insert the st module the kernel crashes.
> When i just leave everything to work magically this is
> what happens(same message as when  insert the module)
> 
>  EFLAGS: 00010293
> lh35s: EIP is at dl_done_list [usb-ohci] 0X76
> (2.4.18-3SMP)
> e0>ax: 0000000 ebx:f7607080 ecx: 37d92fc7 edx:
> f7607080
> 
> <0>Kernel panic: Aiee, killing interupt handler!

So the USB modules were loaded just fine?
Can you run the oops message through ksymoops and send us the output?

thanks,

greg k-h
