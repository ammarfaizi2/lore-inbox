Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932492AbWFQAWT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932492AbWFQAWT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 20:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932491AbWFQAWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 20:22:19 -0400
Received: from ns2.suse.de ([195.135.220.15]:6301 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932492AbWFQAWS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 20:22:18 -0400
Date: Fri, 16 Jun 2006 17:19:08 -0700
From: Greg KH <greg@kroah.com>
To: Ram <vshrirama@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk
Subject: Re: procfs and sysfs changes?
Message-ID: <20060617001908.GA30204@kroah.com>
References: <8bf247760606160428s4070f543t329eee7fb44921c7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bf247760606160428s4070f543t329eee7fb44921c7@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2006 at 04:58:59PM +0530, Ram wrote:
> Hi,
>  i am porting a driver from 2.4 to 2.6.
> 
>   I went thru the porting guide available in lwn.net. some parts of
> the document is difficult to follow for begineers.
> 
> 
>  am confused.
> 
>  Could any one let me know what changes i need to make in a 2.4 driver
>  as far as /proc interface is concerned.

You should not put anything in /proc for a driver.

>  Should i make any new additions to support sysfs?.  am cofused
> regarding the need
>  of sysfs when /proc is already there.

What do you need to put in sysfs becides what is automatically created
for you by the driver core?

It really depends on what you are wanting to do.

>  Could anyone help me on this.
> 
>  pointers will be very helpful.

Take a look at the book, "Linux Device Drivers, third edition", online
for free, for more details about sysfs and the driver core.

hope this helps,

greg k-h
