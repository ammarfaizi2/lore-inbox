Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264146AbTEORMG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 13:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264147AbTEORMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 13:12:06 -0400
Received: from palrel13.hp.com ([156.153.255.238]:26031 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S264146AbTEORMD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 13:12:03 -0400
Date: Thu, 15 May 2003 10:24:46 -0700
To: Greg KH <greg@kroah.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: airo and firmware upload (was Re: 2.6 must-fix list, v3)
Message-ID: <20030515172446.GD17496@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20030514211222.GA10453@bougret.hpl.hp.com> <3EC2BDEC.6020401@pobox.com> <20030514233235.GA11581@bougret.hpl.hp.com> <20030515071317.GB6497@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030515071317.GB6497@kroah.com>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 15, 2003 at 12:13:18AM -0700, Greg KH wrote:
> On Wed, May 14, 2003 at 04:32:35PM -0700, Jean Tourrilhes wrote:
> > 	Ok, so I ask it this way : currently the kernel include some
> > drivers containing some binary firmwares blobs which are linked
> > directly into the kernel/module (including networking). Does this mean
> > that you are going to remove those driver from the kernel ASAP ? Or
> > does this mean that the rule above only apply to wireless drivers ?
> > 	Let's be logical and coherent here...
> 
> I've stated this for _years_ now, I'm very glad to take patches to move
> the firmware blobs out of the usb drivers that currently have them, and
> move it to userspace, if people send me those patches.  For all the
> whining on debian-legal about them over the _years_, no one has sent me
> such a patch.
> 
> Ok, yes, I did get the start of some patches in the early 2.4 series, I
> said I would accept them in 2.5 as it was too radical of a change to
> take during a stable kernel series (the developer agreed with me.)  They
> were never resubmitted to me during the entire 2.5 development time.
> 
> thanks,
> 
> greg k-h

	At this point, we must get something ASAP in the kernel,
otherwise the various drivers waiting for it will just implement their
own proprietary solutions and be done with it. And it doesn't need to
be perfect at this stage, as long as it can evolve in the right
direction.
	Manuel Estrada sent me a proposal for that. As it seems it's
the only one we have on the table right now, I will spend some time
looking at it and convincing other wireless driver authors to adopt
it. I hope you will help us getting that integrated and adopted.
	Thanks...

	Jean
