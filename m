Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261863AbVBIRmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbVBIRmz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 12:42:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261864AbVBIRmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 12:42:55 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:45039 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261863AbVBIRmx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 12:42:53 -0500
Subject: Re: Preempt Real-time for ARM
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>,
       Sven Dietrich <sdietrich@mvista.com>,
       Russell King - ARM Linux <linux@arm.linux.org.uk>
In-Reply-To: <20050209125044.A6312@flint.arm.linux.org.uk>
References: <1107628604.5065.54.camel@dhcp153.mvista.com>
	 <1107948492.17747.31.camel@tglx.tec.linutronix.de>
	 <20050209113140.GB13274@elte.hu>
	 <20050209125044.A6312@flint.arm.linux.org.uk>
Content-Type: text/plain
Organization: MontaVista
Message-Id: <1107970869.10177.12.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 09 Feb 2005 09:41:10 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-02-09 at 04:50, Russell King wrote:


> What you'll find is that the ARM interrupt structure is designed to
> efficiently meet the requirements of our wide range of hardware interrupt
> controllers, with chained interrupt controllers, with as low latency as
> possible.
> 
> In essence, I'm opposed to completely rewriting the ARM interrupt
> handling at this stage.


	Everyone wants this as the final solution, but all I want right now is
to have a clean patch for ARM RT .. It would be nice if ARM had the
generics, but It's not _my_ goal. 

	All I want to do is integrate the common IRQ threading code. To do that
I need things , from Russell, like per descriptor locks .. And I need
things , from Ingo, like pulling out the IRQ threading code..


Daniel

