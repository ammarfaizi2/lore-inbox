Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261547AbVBRW63@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261547AbVBRW63 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 17:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261548AbVBRW63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 17:58:29 -0500
Received: from bender.bawue.de ([193.7.176.20]:13440 "EHLO bender.bawue.de")
	by vger.kernel.org with ESMTP id S261547AbVBRW6Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 17:58:25 -0500
Date: Fri, 18 Feb 2005 23:57:22 +0100
From: Joerg Sommrey <jo@sommrey.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Question on CONFIG_IRQBALANCE / 2.6.x
Message-ID: <20050218225722.GA11292@sommrey.de>
Mail-Followup-To: Joerg Sommrey <jo@sommrey.de>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20050218213332.GA13485@sommrey.de> <4440000.1108766389@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4440000.1108766389@flay>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2005 at 02:39:49PM -0800, Martin J. Bligh wrote:
> > 
> > there's something I don't understand:  With IRQBALANCE *enabled* almost
> > all interrupts are processed on CPU0.  This changed in an unexpected way
> > after disabling IRQBALANCE: now all interrupts are distributed uniformly
> > to both CPUs.  Maybe it's intentional, but it's not what I expect when a
> > config option named IRQBALANCE is *disabled*.
> > 
> > Can anybody comment on this?
> 
> If you have a Pentium 3 based system, by default they'll round robin.
> If you turn on IRQbalance, they won't move until the traffic gets high
> enough load to matter. That's presumably what you're seeing.

It's an Athlon box that propably has the same behaviour.  Just another
question on this topic:  with IRQBALANCE enabled, almost all interupts
are routet to CPU0.  Lately irq 0 runs on CPU1 and never returns to CPU0
- is there any obvious reason for that?

-jo

-- 
-rw-r--r--  1 jo users 63 2005-02-18 23:29 /home/jo/.signature
