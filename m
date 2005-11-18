Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932400AbVKRQcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932400AbVKRQcZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 11:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932397AbVKRQcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 11:32:25 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:47373 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932334AbVKRQcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 11:32:24 -0500
Date: Fri, 18 Nov 2005 16:32:09 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Adrian Bunk <bunk@stusta.de>, saw@saw.sw.com.sg,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [RFC: 2.6 patch] remove drivers/net/eepro100.c
Message-ID: <20051118163208.GA23355@flint.arm.linux.org.uk>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Adrian Bunk <bunk@stusta.de>, saw@saw.sw.com.sg,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>
References: <20051118033302.GO11494@stusta.de> <20051118090158.GA11621@flint.arm.linux.org.uk> <437DFD6C.1020106@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <437DFD6C.1020106@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2005 at 11:12:28AM -0500, Jeff Garzik wrote:
> Russell King wrote:
> >On Fri, Nov 18, 2005 at 04:33:02AM +0100, Adrian Bunk wrote:
> >
> >>This patch removes the obsolete drivers/net/eepro100.c driver.
> >>
> >>Is there any reason why it should be kept?
> >
> >
> >Tt's the only driver which works correctly on ARM CPUs.  e100 is
> >basically buggy.  This has been discussed here on lkml and more
> >recently on linux-netdev.  If anyone has any further questions
> >please read the archives of those two lists.
> 
> After reading the archives, one discovers the current status is:
> 
> 	waiting on ARM folks to test e100
> 
> Latest reference is public message-id <4371A373.6000308@pobox.com>, 
> which was CC'd to you.
> 
> There is a patch in netdev-2.6.git#e100-sbit and in Andrew's -mm tree 
> that should solve the ARM problems, and finally allow us to kill 
> eepro100.  But it's waiting for feedback...

So what you're saying is that it's down to me to test the thing.

Ok.

I've been extremely patient waiting for e100 to get fixed (it's been
literally _years_), and I think it isn't surprising that the hardware
it was noticed on has been packed away.

Now I ask the same of others for when I'm (a) well enough to enter
the cold environment in which this machine is currently stored and
(b) can find the time to resurect the machine.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
