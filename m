Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265620AbUAZXkR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 18:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265623AbUAZXkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 18:40:17 -0500
Received: from mail.kroah.org ([65.200.24.183]:6609 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265620AbUAZXjj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 18:39:39 -0500
Date: Mon, 26 Jan 2004 15:39:39 -0800
From: Greg KH <greg@kroah.com>
To: Robert Reardon <rreardon@dsl.pipex.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: (Wrong ID) USB Crontroller
Message-ID: <20040126233939.GB7535@kroah.com>
References: <1075147348.7156.12.camel@mordor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1075147348.7156.12.camel@mordor>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 26, 2004 at 08:02:28PM +0000, Robert Reardon wrote:
> Hi all,
> 
> I've been trying to get USB working with the 2.6 and keep getting 
> the attached error messages. The kernel appears (to me at least)
> to detect the USB controller correctly on boot, but it still doesn't
> want to work. This is my first post to the list, so please be gentle
> :-).
> 
> The motherboard is a Supermicro 370DDE, currently running
> kernel-2.6.2-rc1-mm3. I've tried to attached any relevant information
> but I'm happy to provide more if it's needed.
> 
> cat /proc/version reports:
> 
> Linux version 2.6.2-rc1-mm3 (root@mordor) (gcc version 3.3.2 20031218
> (Gentoo Linux 3.3.2-r5, propolice-3.3-7)) #2 SMP Sun Jan 25 21:16:13 GMT
> 2004
> 
> Anyone got any ideas?

Yeah, get rid of your usbmodules binary.  It's not needed and is causing
the problem.

thanks,

greg k-h
