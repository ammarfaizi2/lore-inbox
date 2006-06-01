Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbWFAWPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbWFAWPV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 18:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbWFAWPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 18:15:20 -0400
Received: from tornado.reub.net ([202.89.145.182]:36780 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S1750724AbWFAWPS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 18:15:18 -0400
Message-ID: <447F66F0.2050402@reub.net>
Date: Fri, 02 Jun 2006 10:15:12 +1200
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: mingo@elte.hu, linux-kernel@vger.kernel.org, htejun@gmail.com,
       jeff@garzik.org, jbeulich@novell.com
Subject: Re: 2.6.17-rc5-mm2
References: <20060601014806.e86b3cc0.akpm@osdl.org>	<447EB4AD.4060101@reub.net>	<20060601025632.6683041e.akpm@osdl.org>	<447EBD46.7010607@reub.net>	<20060601103315.GA1865@elte.hu>	<20060601105300.GA2985@elte.hu>	<20060601112551.GA5811@elte.hu>	<447ED6A2.5000107@reub.net> <20060601092247.8ccc2c49.akpm@osdl.org>
In-Reply-To: <20060601092247.8ccc2c49.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/06/2006 4:22 a.m., Andrew Morton wrote:
> On Thu, 01 Jun 2006 23:59:30 +1200
> Reuben Farrelly <reuben-lkml@reub.net> wrote:
> 
>> Unable to handle kernel NULL pointer dereference at 0000000000000000 RIP:
>>   [<0000000000000000>]
> 
> Seems that a fix got lost.  Please add this:
> 
> 
> From: Ingo Molnar <mingo@elte.hu>
> 
> This is a fixed up and cleaned up replacement for genirq-msi-fixes.patch,
> which should solve the i386 4KSTACKS problem.  I also added Ben's idea of
> pushing the __do_IRQ() check into generic_handle_irq().

Indeed, that fixes it and -rc5-mm2 is now up and running.

Thanks,
Reuben

