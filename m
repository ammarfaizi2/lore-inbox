Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267681AbTACVlF>; Fri, 3 Jan 2003 16:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267682AbTACVlE>; Fri, 3 Jan 2003 16:41:04 -0500
Received: from jamesconeyisland.com ([66.64.43.2]:45836 "EHLO
	mail.jamesconeyisland.com") by vger.kernel.org with ESMTP
	id <S267681AbTACVlE> convert rfc822-to-8bit; Fri, 3 Jan 2003 16:41:04 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ron cooper <rcooper@jamesconeyisland.com>
Organization: James Coney island
To: "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: Gigabit/SMP performance problem
Date: Fri, 3 Jan 2003 15:49:29 -0600
User-Agent: KMail/1.4.3
References: <OFC4D9AF0E.DA93F4D7-ON85256CA3.0058C567-85256CA3.00592873@symantec.com> <14000000.1041617118@flay>
In-Reply-To: <14000000.1041617118@flay>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301031549.29549.rcooper@jamesconeyisland.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 03 January 2003 12:05 pm, Martin J. Bligh wrote:

> Dual what Xeon? I presume a P4 thing. Can you cat /proc/interrupts?
> Are you using the irq_balance code? If so, I think you'll only use
> 1 cpu to process all the interrupts from each gigabit card. Not that
> you have much choice, since Intel broke the P4's interrupt routing.
>

You got my attention with this statement.  I've have Dual Xeon Prestonias on 
an I860 chipset (IWill dp400).  cat  /proc/interrupts indeed shows CPU0 as 
processing all IRQ's instead of sharing them with CPU1 on a 2.4.x kernel.

Is there a work around for this, or is this *really* a problem?  Some say it 
might be a problem depending on how many interrupts need to be processed per 
second.  Others imply that cpu0 catching  the irq's might be a good thing.

I happen to have PIII's using VIA chipsets that dont have this issue with 
proc/interrupts.  This is very annonying, but I wonder if it is worth 
worrying about.


Ron.




