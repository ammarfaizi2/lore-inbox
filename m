Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261637AbUCNV3M (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 16:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261658AbUCNV3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 16:29:12 -0500
Received: from marco.bezeqint.net ([192.115.104.4]:62653 "EHLO
	marco.bezeqint.net") by vger.kernel.org with ESMTP id S261637AbUCNV3K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 16:29:10 -0500
Date: Sun, 14 Mar 2004 23:28:20 +0200
From: Micha Feigin <michf@post.tau.ac.il>
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.2 reboot hangs on AMD Athlon System
Message-ID: <20040314212820.GI3829@luna.mooo.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <A6974D8E5F98D511BB910002A50A6647615F4EB9@hdsmsx402.hd.intel.com> <1079244503.2173.142.camel@dhcppc4> <20040314183558.GA563@kenny.sha-bang.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040314183558.GA563@kenny.sha-bang.local>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 14, 2004 at 07:35:58PM +0100, Sascha Wilde wrote:
> On Sun, Mar 14, 2004 at 01:08:25AM -0500, Len Brown wrote:
> > Curious that this happens
> > 1. only on 2.6
> 
> yes, but true: any other reboot code I've come across (including
> those of the other Linux kernel versions) work as expected on the box.
> 
> > 2. with acpi=off and "acpi=on"
> 

also try with noapic boot option. It was supposedly fixed (cause a
problem with my system) but may still causing problems for you.

> yust retested it with the latest (2.6.4) kernel -- yes, regardless of
> which (or none) powermanagement is used, the reboot freezes the mashine.
> 
> > Would be good to know that the system is running the latest BIOS.
> 
> afaik I'm using the latest available BIOS for the board.
> 
> btw. the toppic is false, that should be 
> "Kernel 2.6.x reboot hangs on AMD Athlon System"
> 
> cheers
> sascha
> -- 
> Sascha Wilde
> "Gimme about 10 seconds to think for a minute..."
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
