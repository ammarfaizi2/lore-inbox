Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271214AbTHHBlP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 21:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271222AbTHHBlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 21:41:15 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:736 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S271214AbTHHBlN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 21:41:13 -0400
Message-ID: <3F32FFAD.1050203@pobox.com>
Date: Thu, 07 Aug 2003 21:41:01 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: William Enck <wenck@wapu.org>
CC: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [bk patches] 2.6.x net driver updates
References: <20030808000508.GA4464@gtf.org> <20030808013649.GA20003@chaos.byteworld.com>
In-Reply-To: <20030808013649.GA20003@chaos.byteworld.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Enck wrote:
> On Thu, Aug 07, 2003 at 08:05:08PM -0400, Jeff Garzik wrote:
> 
>>Linus, please do a
>>
>>	bk pull bk://kernel.bkbits.net/jgarzik/net-drivers-2.6
>>
>>Others may download the patch from
>>
>>ftp://ftp.??.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/2.6.0-test2-bk7-netdrvr1.patch.bz2
>>
>>This will update the following files:
> 
> ..snip..
> 
>> drivers/net/wireless/orinoco_cs.c   |   16 -
> 
> 
> dmesg gave the folloing with 2.6.0-test2-bk7
> 
> orinoco.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and others)
> orinoco_cs.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and others)
> orinoco_cs: RequestIRQ: Unsupported mode
> 
> I thought the above patch might fix it, so I patched and recompiled. I
> still see the following in 2.6.0-test2-bk7-netdrvr1
> 
> orinoco_cs.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and others)
> orinoco_cs: RequestIRQ: Unsupported mode
> 
> The module loaded and worked fine in -test2 and -test2-mm4. 


Can you test -test2-bk7 (without my patch)?

	Jeff



