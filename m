Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131601AbRCQLWa>; Sat, 17 Mar 2001 06:22:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131606AbRCQLWW>; Sat, 17 Mar 2001 06:22:22 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:52095 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S131601AbRCQLWP>; Sat, 17 Mar 2001 06:22:15 -0500
Date: Sat, 17 Mar 2001 06:21:19 -0500
From: Tim Waugh <twaugh@redhat.com>
To: "Michael B. Allen" <mballen@erols.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: parport not detected
Message-ID: <20010317062119.B13877@redhat.com>
In-Reply-To: <20010316185253.A865@nano.foo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010316185253.A865@nano.foo.net>; from mballen@erols.com on Fri, Mar 16, 2001 at 06:52:53PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2001 at 06:52:53PM -0500, Michael B. Allen wrote:

> The parallel port is not being detected on my ABIT KT7A KT133 w/ Athlon

Need dmesg output to see what parport is being told and what is
finding out for itself.

> BIOS options are:
> 
> 728/IRQ5
  ^^^ 278, probably

> 378/IRQ7
> 3BC/IRQ7

But which one is it actually set to?

> Of the above what's optimal?

It depends what you're doing, really.

> I also tried an options line in modules.conf. I believe it was:
> 
> options parport_pc io=0x3bc irq=7

Take that out and see what happens.

> That was reflected in /proc but no difference in actually "detecting"
> the parallel port.

I don't know what you mean really.  Are you saying that you can't
print, or just that the device ID probe (to get the printer name)
isn't working?

> Also, if I build parpart into the kernel I get nothing but a
> hard lockup on 'Starting kswapd v 1.5'.

That's quite strange.

Which kernel version are you using?  Take a look at the
'troubleshooting' section of Documentation/parport.txt.

Tim.
*/
