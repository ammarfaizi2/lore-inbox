Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129501AbRCHBjb>; Wed, 7 Mar 2001 20:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129652AbRCHBjW>; Wed, 7 Mar 2001 20:39:22 -0500
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:778 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S129501AbRCHBjQ>;
	Wed, 7 Mar 2001 20:39:16 -0500
Date: Wed, 7 Mar 2001 17:36:40 -0800
From: Greg KH <greg@kroah.com>
To: Erik DeBill <edebill@swbell.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.2ac12 and ac13 breaks usb-visor
Message-ID: <20010307173640.A14818@kroah.com>
In-Reply-To: <E14aQA9-0001br-00@the-village.bc.nu> <20010307172056.A8647@austin.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010307172056.A8647@austin.rr.com>; from edebill@swbell.net on Wed, Mar 07, 2001 at 05:20:56PM -0600
X-Operating-System: Linux 2.2.18-immunix (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07, 2001 at 05:20:56PM -0600, Erik DeBill wrote:
> 
> I went to install some new software on my Visor yesterday and got a
> rude surpise, as my system froze hard (unpingable, no response to
> keyboard or mouse, no oops).  A bit of experimenting shows:
> 
> It works fine with usb-uhci in all versions I tested.
> 
> Plain 2.4.2 works fine with either usb-uhci or uhci.

uhci.o will cause crashes eventually.  It doesn't work with the visor
driver, sorry.  Stick with usb-uhci is you use the visor USB driver.

I just tried -ac14, with all of the usb subsystem as modules, and
everything worked fine syncing data, and installing packages on my
visor.

I'll try to run with everything compiled into the kernel later tonight.
Does -ac14 with all of USB as modules, using usb-uhci work for you?

thanks,

greg k-h

-- 
greg@(kroah|wirex).com
