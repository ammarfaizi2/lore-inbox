Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319499AbSH3ARP>; Thu, 29 Aug 2002 20:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319509AbSH3ARP>; Thu, 29 Aug 2002 20:17:15 -0400
Received: from web20709.mail.yahoo.com ([216.136.226.182]:52741 "HELO
	web20709.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S319499AbSH3ARO>; Thu, 29 Aug 2002 20:17:14 -0400
Message-ID: <20020830002137.13089.qmail@web20709.mail.yahoo.com>
Date: Thu, 29 Aug 2002 17:21:37 -0700 (PDT)
From: abhishek Sinha <aby_sinha@yahoo.com>
Subject: Re: AMD 768 USB Controller
To: Greg KH <greg@kroah.com>
Cc: linux-usb-users@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20020830001234.GJ5074@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Looks like the usb-ohci driver bound to your device
> just fine :)

OOPs mistake from my side.It must be the ohci driver
instead of the uhci..(just got confused).

"all apologies"
> 
> And what happens when you plug in your USB device?

When i plug the device into the machine the kernel
crashes.Thinking it might be something with the
hotplug i disabled it (mv /sbin/hotplug
/sbin/hotplug.old) and inserted the modules one by
one.When i insert the st module the kernel crashes.
When i just leave everything to work magically this is
what happens(same message as when  insert the module)

 EFLAGS: 00010293
lh35s: EIP is at dl_done_list [usb-ohci] 0X76
(2.4.18-3SMP)
e0>ax: 0000000 ebx:f7607080 ecx: 37d92fc7 edx:
f7607080

<0>Kernel panic: Aiee, killing interupt handler!

I looked through the /var/log/messages but no luck for
any errors.

Regards
abhishek



__________________________________________________
Do You Yahoo!?
Yahoo! Finance - Get real-time stock quotes
http://finance.yahoo.com
