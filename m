Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751399AbWIIJFf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbWIIJFf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 05:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbWIIJFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 05:05:35 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:52189 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751399AbWIIJFe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 05:05:34 -0400
Message-ID: <450283D5.1020404@garzik.org>
Date: Sat, 09 Sep 2006 05:05:25 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Matt Domsch <Matt_Domsch@dell.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.18-rc5] PCI: sort device lists breadth-first
References: <20060908031422.GA4549@lists.us.dell.com> <20060908112035.f7a83983.akpm@osdl.org>
In-Reply-To: <20060908112035.f7a83983.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wanted to note what Martin Mares just raised in the thread "State of 
the Linux PCI Subsystem for 2.6.18-rc6":

> Changing the device order in the middle of the 2.6 cycle doesn't sound
> like a sane idea to me. Many people have changed their systems' configuration
> to adapt to the 2.6 ordering and this patch would break their setups.
> I have seen many such examples in my vicinity.
> 
> I believe that not breaking existing 2.6 setups is much more important
> than keeping compatibility with 2.4 kernels, especially when the problem
> is discovered after more than 2 years after release of the first 2.6.


I'm not siding with either Martin or Matt explicitly, just noting that 
there are good arguments for both sides.

	Jeff



