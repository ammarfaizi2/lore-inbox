Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266179AbUGOMFW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266179AbUGOMFW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 08:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266183AbUGOMFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 08:05:21 -0400
Received: from penguin.linuxhardware.org ([63.173.68.170]:21394 "EHLO
	penguin.linuxhardware.org") by vger.kernel.org with ESMTP
	id S266179AbUGOMFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 08:05:15 -0400
Date: Thu, 15 Jul 2004 08:10:18 -0400 (EDT)
From: augustus@linuxhardware.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Via Velocity Concerns
In-Reply-To: <40F621B9.7020407@pobox.com>
Message-ID: <Pine.LNX.4.58.0407150807200.7017@penguin.linuxhardware.org>
References: <Pine.LNX.4.58.0407142336280.7017@penguin.linuxhardware.org>
 <40F621B9.7020407@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just tried his 2.6.8-rc1-mm1 and it doesn't fix it.  In fact, EHCI USB 
support seems to hang.  I disabled it and it booted to the same point as 
before and kernel paniced.  FYI, the driver also didn't compile cleanly.  
I had to add a member to a struct to get it to compile correctly.  I'll 
get you specifics on that if needed but it's very easy to spot if you 
attempt to compile the driver.  Where should I go from here?  I can work 
on getting the info from the panic but since the system is almost dead at 
that point cutting and pasting is not an option.

Thanks,
Kris Kersey (Augustus)
LinuxHardware.org Site Manager
augustus@linuxhardware.org
Gentoo Linux AMD64 Developer
augustus@gentoo.org

On Thu, 15 Jul 2004, Jeff Garzik wrote:

> augustus@linuxhardware.org wrote:
> > I am testing the via velocity gigabit ethernet drivers in the 2.6.8-rc1 
> > kernel.  It seems to work fine unless it is compiled into the kernel.  If 
> > it is compiled in then it kernel panics as soon as it tries to bring up 
> > the device with dhcpcd.  If you load the driver as a module though, all is 
> > fine.
> 
> Try the updated velocity driver in Andrew's -mm tree.
> 
> 	Jeff
> 
> 
> 
