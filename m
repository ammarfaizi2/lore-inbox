Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263606AbTJ0Vky (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 16:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263607AbTJ0Vky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 16:40:54 -0500
Received: from fw.osdl.org ([65.172.181.6]:31900 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263606AbTJ0Vkx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 16:40:53 -0500
Date: Mon, 27 Oct 2003 13:49:58 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Mark Bellon <mbellon@mvista.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: ANNOUNCE: User-space System Device Enumeration (uSDE)
In-Reply-To: <3F9D8332.3060003@mvista.com>
Message-ID: <Pine.LNX.4.44.0310271343170.13116-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Initial availability of User-Space System Device Enumeration (uSDE) 
> package, version 0.74, can be found at http://sourceforge.net/projects/usde
> 
> The uSDE provides an open framework for the enumeration (specification) 
> of system devices in a dynamic environment. Device handling is 
> implemented via plug-in programs known as policy methods. Policy methods 
> are free to handle their devices in any way, from trivial to complex - 
> anything from providing LSB device nodes to persistent device name 
> handling with
> replacement and relocation strategies.
> 
> The uSDE depends on /sbin/hotplug (for dynamic insertions and removals), 
> sysfs (for device information) and /proc (various pieces of 
> information). It is not dependent on initrd - it explicitly scans sysfs 
> upon system startup to determine the initial device ensemble.

How does uSDE relate to udev? You do not mention it in your email, though 
it claims to implement similar, if not identical functionality. Is it 
related? Is it built on top of it? 

If not, are you planning on merging your efforts with udev in the future? 

Are you using the libsysfs library for accessing sysfs data? If not, I 
highly recommend it. 

I would also recommend sending email to the linux-hotplug list, as most of 
the hotplug-related applications are discussed and developed via that 
list.


	Pat

