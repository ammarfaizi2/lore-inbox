Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262032AbTEOSTn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 14:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262363AbTEOSTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 14:19:43 -0400
Received: from fed1mtao05.cox.net ([68.6.19.126]:20354 "EHLO
	fed1mtao05.cox.net") by vger.kernel.org with ESMTP id S262032AbTEOSTm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 14:19:42 -0400
Date: Thu, 15 May 2003 11:32:27 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: rmk@arm.linux.org.uk, Linux Kernel List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: [PATCH] IRQ and resource for platform_device
Message-ID: <20030515113227.D7685@home.com>
References: <20030515145920.B31491@flint.arm.linux.org.uk> <20030515090350.A7685@home.com> <20030515173052.C31491@flint.arm.linux.org.uk> <20030515103513.B7685@home.com> <20030515191336.E31491@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030515191336.E31491@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Thu, May 15, 2003 at 07:13:36PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 15, 2003 at 07:13:36PM +0100, Russell King wrote:
> On Thu, May 15, 2003 at 10:35:13AM -0700, Matt Porter wrote:
> > I think having an array of irqs and resources of max count 8 should
> > do it for now.
> > 
> > No matter what we choose, the hardware designers will screw it up
> > eventually.
> 
> Hmm, how would people feel if I suggested just:
> 
> 	int num_resources;
> 	struct resource	*resources;
> 
> We have an IORESOURCE_IRQ, which can be used to indicate IRQ
> resources.

I like that approach...simple and flexible.

-Matt
