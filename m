Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261542AbVBRWjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261542AbVBRWjx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 17:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261543AbVBRWjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 17:39:53 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:7886 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261542AbVBRWjv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 17:39:51 -0500
Date: Fri, 18 Feb 2005 14:39:49 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Joerg Sommrey <jo@sommrey.de>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Question on CONFIG_IRQBALANCE / 2.6.x
Message-ID: <4440000.1108766389@flay>
In-Reply-To: <20050218213332.GA13485@sommrey.de>
References: <20050218213332.GA13485@sommrey.de>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> there's something I don't understand:  With IRQBALANCE *enabled* almost
> all interrupts are processed on CPU0.  This changed in an unexpected way
> after disabling IRQBALANCE: now all interrupts are distributed uniformly
> to both CPUs.  Maybe it's intentional, but it's not what I expect when a
> config option named IRQBALANCE is *disabled*.
> 
> Can anybody comment on this?

If you have a Pentium 3 based system, by default they'll round robin.
If you turn on IRQbalance, they won't move until the traffic gets high
enough load to matter. That's presumably what you're seeing.

m.

