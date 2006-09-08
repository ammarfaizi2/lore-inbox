Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751105AbWIHNe6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbWIHNe6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 09:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbWIHNe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 09:34:58 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:19900 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751105AbWIHNe5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 09:34:57 -0400
Message-ID: <4501717F.1070807@garzik.org>
Date: Fri, 08 Sep 2006 09:34:55 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: BUG in sata_mv
References: <Pine.LNX.4.61.0609081327010.3319@filestore.ivimey.org>
In-Reply-To: <Pine.LNX.4.61.0609081327010.3319@filestore.ivimey.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ruth Ivimey-Cook wrote:
> Folks,
> 
> In the interests of reporting bugs, I've attached the following dmesg 
> output, containing 2 bugs. I've inlined the start of each below:
> 
> BUG: warning at drivers/scsi/sata_mv.c:1919/__msleep() (Not tainted)
>  <f8876660> __mv_phy_reset+0xeb/0x3a7 [sata_mv]  <c04c9784> 
> __freed_request+0x1f/0x6f
>  <f8877cce> mv_interrupt+0x209/0x310 [sata_mv]  <c043db72> 
> handle_IRQ_event+0x23/0x4c
>  <c043dc17> __do_IRQ+0x7c/0xd1  <c0405035> do_IRQ+0x63/0x80

The latest version of sata_mv shouldn't have this problem...

	Jeff



