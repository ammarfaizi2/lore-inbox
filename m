Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030382AbWCUNv3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030382AbWCUNv3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 08:51:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030385AbWCUNv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 08:51:29 -0500
Received: from rtr.ca ([64.26.128.89]:56749 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1030381AbWCUNv2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 08:51:28 -0500
Message-ID: <442004E4.7010002@rtr.ca>
Date: Tue, 21 Mar 2006 08:51:32 -0500
From: Mark Lord <liml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8) Gecko/20060305 SeaMonkey/1.1a
MIME-Version: 1.0
To: sander@humilis.net
Cc: Mark Lord <lkml@rtr.ca>, Jeff Garzik <jeff@garzik.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6.xx: sata_mv: another critical fix
References: <441F4F95.4070203@garzik.org> <200603210000.36552.lkml@rtr.ca> <20060321121354.GB24977@favonius>
In-Reply-To: <20060321121354.GB24977@favonius>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sander wrote:
> Mark Lord wrote (ao):
>> This patch addresses a number of weird behaviours observed
>> for the sata_mv driver, by fixing an "off by one" bug in processing
>> of the EDMA response queue.
>>
>> Basically, sata_mv was looking in the wrong place for
>> command results, and this produced a lot of unpredictable behaviour.
> 
> 2.6.16 with this patch and your former patch applied, crashes during
> stressing a raid5 connected to a MV88SX6081.
> 
> 2.6.16-rc6 crashes too.
> 
> 2.6.16-rc6-mm2 is rock solid wrt sata_mv.
> 
> I get no output of the crash on netconsole. Would it help if I get the
> output of the crash (if any)? In that case I'll connect a screen and see
> what it produces.

Yes, most helpful, please.
Even a digital camera snapshot of the oops would be handy to see.

Thanks!
