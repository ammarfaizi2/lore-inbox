Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261462AbVGLOfH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbVGLOfH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 10:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261458AbVGLOdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 10:33:12 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:41975 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261453AbVGLObm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 10:31:42 -0400
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-24
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Karsten Wiese <annabellesgarden@yahoo.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20050712142828.GA20798@elte.hu>
References: <200507121223.10704.annabellesgarden@yahoo.de>
	 <20050712140251.GB18296@elte.hu>
	 <1121178339.10199.8.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <20050712142828.GA20798@elte.hu>
Content-Type: text/plain
Date: Tue, 12 Jul 2005 07:31:36 -0700
Message-Id: <1121178696.10199.11.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-07-12 at 16:28 +0200, Ingo Molnar wrote:
> * Daniel Walker <dwalker@mvista.com> wrote:
> 
> > I observed a situation on a dual xeon where IOAPIC_POSTFLUSH , if on, 
> > would actually cause spurious interrupts. It was odd cause it's 
> > suppose to stop them .. If there was a lot of interrupt traffic on one 
> > IRQ , it would cause interrupt traffic on another IRQ. This would 
> > result in "nobody cared" messages , and the storming IRQ line would 
> > get shutdown.
> > 
> > This would only happen in PREEMPT_RT .
> 
> does it happen with the latest kernel too? There were a couple of things 
> broken in the IOAPIC code in various earlier versions.


I haven't tested it recently . This was on an older version of RT
though . I could try it if it's interesting ? Or do you think it's
already fixed?

Daniel

