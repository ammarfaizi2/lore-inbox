Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264147AbTFPSem (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 14:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264143AbTFPScX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 14:32:23 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:62122 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264146AbTFPSa0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 14:30:26 -0400
Date: Mon, 16 Jun 2003 10:33:10 -0700
From: Greg KH <greg@kroah.com>
To: "Martin A. Brooks" <martin@hinterlands.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB and/or keyboard bizarreness
Message-ID: <20030616173310.GC25132@kroah.com>
Reply-To: linux-kernel@vger.kernel.org
References: <6.0.0.9.0.20030615121539.02b98950@10.119.48.254>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6.0.0.9.0.20030615121539.02b98950@10.119.48.254>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 15, 2003 at 12:49:55PM +0100, Martin A. Brooks wrote:
> 
> Hi
> 
> I recently purchased an Epox 8RDA (nforce2) motherboard.  I'm using 1 gig 
> of ddr 266 memory and an athlon 1.3ghz downclocked to 1.1ghz.
> 
> At the BIOS screen, the keyboard works just fine when connected via either 
> the USB or PS2 port.
> 
> When booting 2.4.18, the kernel halts when loading the OHCI driver.
> When booting 2.4.20, the system comes up but the keyboard doesn't respond 
> when plugged in to the ps2 port, I can't try it with USB.
> When booting 2.4.21, kernel panic.

Can you try disabling BIOS USB support and see if that helps?

And what is the panic?  Can you run it though ksymoops and send it to
us?

thanks,

greg k-h
