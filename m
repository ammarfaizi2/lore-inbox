Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932371AbVIEIrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbVIEIrL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 04:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbVIEIrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 04:47:11 -0400
Received: from tornado.reub.net ([202.89.145.182]:4552 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S932371AbVIEIrK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 04:47:10 -0400
Message-ID: <431C0605.4090608@reub.net>
Date: Mon, 05 Sep 2005 20:47:01 +1200
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 1.6a1 (Windows/20050903)
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
CC: Andrew Morton <akpm@osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] Re: 2.6.13-mm1
References: <Pine.LNX.4.44L0.0509021110480.5367-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0509021110480.5367-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On 3/09/2005 3:19 a.m., Alan Stern wrote:
> On Thu, 1 Sep 2005, Andrew Morton wrote:
> 
>> Reuben Farrelly <reuben-lkml@reub.net> wrote:
> 
>>> I'm also observing some USB messages logged:
>>>
>>> Sep  2 13:26:22 tornado kernel: usb 5-1: new full speed USB device using 
>>> uhci_hcd and address 13
>>> Sep  2 13:26:22 tornado kernel: drivers/usb/class/usblp.c: usblp0: USB 
>>> Bidirectional printer dev 13 if 0 alt 0 proto 2 vid 0x03F0 pid 0x6204
>>> Sep  2 13:26:23 tornado kernel: hub 5-0:1.0: port 1 disabled by hub (EMI?), 
>>> re-enabling...
> 
> This message means pretty much what it says: noise or something else 
> caused the connection to be disabled.  In theory this could be caused by a 
> problem with the host controller, the cable, or the printer.  Does this 
> happen consistently with 2.6.13-mm1?  Did it happen with 2.6.12?

It may have just been a red herring, as I haven't had the problem appear 
since, nor had I seen it before then.  I've done multiple reboots, plug and 
unplugs to test since and all have been OK.

Thanks for taking the time to reply.

reuben
