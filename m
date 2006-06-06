Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbWFFQ4y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbWFFQ4y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 12:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbWFFQ4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 12:56:54 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:43481 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1750746AbWFFQ4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 12:56:53 -0400
Subject: Re: genirq
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <20060606144242.GB29798@elte.hu>
References: <20060604135011.decdc7c9.akpm@osdl.org>
	 <20060606144242.GB29798@elte.hu>
Content-Type: text/plain
Date: Tue, 06 Jun 2006 09:56:49 -0700
Message-Id: <1149613010.15050.1.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-06 at 16:42 +0200, Ingo Molnar wrote:

> there hasnt been any real problem since the MSI one. The core bits are 
> rather stable. The patch-queue had positive input from the maintainers 
> of the two architectures with the most complex IRQ hardware (arm and 
> ppc*), and that's reassuring. But in any case, other architectures are 
> not affected at all (sans brow paperbag build bugs and typos), their 
> __do_IRQ() handling remains unchanged. So i'd like to see this in 
> 2.6.18. (there a good deal of stuff we have ontop of genirq)

There was a problem reported by Kevin Hillman , the -v5 version was not
functional on ARM omap boards .. Was that handled already in -v6?

Daniel

