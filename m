Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270717AbUJUPHt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270717AbUJUPHt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 11:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270742AbUJUPDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 11:03:50 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:46348 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S270718AbUJUPBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 11:01:35 -0400
Message-ID: <4177D20F.2080205@techsource.com>
Date: Thu, 21 Oct 2004 11:13:19 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
References: <4176E08B.2050706@techsource.com> <9e4733910410201808c0796c8@mail.gmail.com>
In-Reply-To: <9e4733910410201808c0796c8@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jon Smirl wrote:
> I have heard a lot of complaints from embedded people about having few
> choices for graphics chips. Many of the low end chips from ATI/NVidia
> are no longer in production and you are forced into buying more chip
> than you want. You should ask about this on embedded developer lists.
> 
> For the new X servers you have to have hardware alpha blending.
> Another important feature is accelerated drawing to off-screen
> buffers. Also, DMA command queues help a lot with parallelizing
> drawing.

DMA not only allows for more parallelism, but it's also more efficient 
to transport commands and image data using DMA than with PIO, particular 
on some platforms which do not try to optimize PIOs.

> If you implement VGA you will be able to boot and work in any x86
> system without writing any code other than the BIOS.

I don't think we can get away without supporting some minimal VGA 
functionality.

