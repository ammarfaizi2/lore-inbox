Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbTEOHAQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 03:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262193AbTEOHAQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 03:00:16 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:20720 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262060AbTEOHAP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 03:00:15 -0400
Date: Thu, 15 May 2003 00:13:18 -0700
From: Greg KH <greg@kroah.com>
To: jt@hpl.hp.com
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: airo and firmware upload (was Re: 2.6 must-fix list, v3)
Message-ID: <20030515071317.GB6497@kroah.com>
References: <20030514211222.GA10453@bougret.hpl.hp.com> <3EC2BDEC.6020401@pobox.com> <20030514233235.GA11581@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030514233235.GA11581@bougret.hpl.hp.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 14, 2003 at 04:32:35PM -0700, Jean Tourrilhes wrote:
> 	Ok, so I ask it this way : currently the kernel include some
> drivers containing some binary firmwares blobs which are linked
> directly into the kernel/module (including networking). Does this mean
> that you are going to remove those driver from the kernel ASAP ? Or
> does this mean that the rule above only apply to wireless drivers ?
> 	Let's be logical and coherent here...

I've stated this for _years_ now, I'm very glad to take patches to move
the firmware blobs out of the usb drivers that currently have them, and
move it to userspace, if people send me those patches.  For all the
whining on debian-legal about them over the _years_, no one has sent me
such a patch.

Ok, yes, I did get the start of some patches in the early 2.4 series, I
said I would accept them in 2.5 as it was too radical of a change to
take during a stable kernel series (the developer agreed with me.)  They
were never resubmitted to me during the entire 2.5 development time.

thanks,

greg k-h
