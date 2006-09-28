Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161041AbWI1XHN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161041AbWI1XHN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 19:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbWI1XHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 19:07:13 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:14224 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750826AbWI1XHL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 19:07:11 -0400
Message-ID: <451C5599.80402@garzik.org>
Date: Thu, 28 Sep 2006 19:07:05 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: oe@hentges.net
CC: Andrew Morton <akpm@osdl.org>, Stephen Hemminger <shemminger@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Netdev List <netdev@vger.kernel.org>
Subject: sky2 (was Re: 2.6.18-mm2)
References: <20060928155053.7d8567ae.akpm@osdl.org>
In-Reply-To: <20060928155053.7d8567ae.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Another customer..
> 
> Begin forwarded message:
> 
> Date: Fri, 29 Sep 2006 00:44:01 +0200
> From: Matthias Hentges <oe@hentges.net>
> To: Andrew Morton <akpm@osdl.org>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: 2.6.18-mm2
> 
> 
> Hello all,
> 
> I've just tested -mm2 on my C2D system and I'm getting a lot of these
> messages:
> 
> "[  139.143807] printk: 131 messages suppressed.
> [  139.148235] sky2 0000:03:00.0: pci express error (0x500547)"
> 
> Please note that the "sky2" driver has always been the black sheep on
> that system due to regular full lock-ups of the driver, requiring a
> rmmod sky2 + modprobe sky2 cycle.
> 
> This happens often enough to warrant writing a cronjob checking the
> network and auto-rmmod'ing the module.....
> 
> While the above is bloody annoying at times (heh), the driver never
> caused any messages like the ones I now get with -mm2 .

sky2 just turned on PCI Express error reporting, so it makes sense that 
messages would appear.  The better question is whether this is a driver 
problem, or a hardware problem.  With your "black sheep" comment, I 
wonder if it isn't a hardware problem that's been hidden.

	Jeff


