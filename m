Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262198AbTJIOSe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 10:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbTJIOSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 10:18:34 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5607 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262198AbTJIOSa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 10:18:30 -0400
Message-ID: <3F856E27.1010203@pobox.com>
Date: Thu, 09 Oct 2003 10:18:15 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] laptop mode
References: <3F856A7E.2010607@pobox.com> <Pine.LNX.4.44.0310091109010.3040-100000@logos.cnet> <20031009141143.GF1232@suse.de>
In-Reply-To: <20031009141143.GF1232@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Thu, Oct 09 2003, Marcelo Tosatti wrote:
> 
>>
>>On Thu, 9 Oct 2003, Jeff Garzik wrote:
>>
>>
>>>Linux Kernel Mailing List wrote:
>>>
>>>>ChangeSet 1.1150.1.52, 2003/10/08 10:49:45-03:00, axboe@suse.de
>>>>
>>>>	[PATCH] laptop mode
>>>>	
>>>>	Hi Marcelo,
>>>>	
>>>>	Lots of people have been using this patch with great success, and it's
>>>>	been in the SuSE kernel for some months now too. It is also in the -benh
>>>>	ppc tree
>>>>	
>>>>	Basically, it introduces a write back mode of dirty and journal data
>>>>	that is more suitable for laptops. At the block layer end, it schedules
>>>>	write out of dirty data after the disk has been idle for 5 seconds.
>>>>	
>>>>	Laptop mode can be switched on and off with /proc/sys/vm/laptop_mode.
>>>>	There is also a block_dump sysctl, which if enabled will dump who
>>>>	dirties and writes out data. This is very helpful in pinning down who is
>>>>	causing unnecessary writes to the disk.
>>>
>>>Red Hat just dropped this patch since it was suspected of data 
>>>corruption ;-(
>>
>>Uh, oh... Jens? 
> 
> 
> See my previous mail. I don't see any problems with it, and I've
> certainly not heard of (or experienced myself) problems with the patch.
> I'm waiting for Jeff to expand on his mail, surely he/RH must know more
> about this issue.


That's 100% of my knowledge.  Talk to arjan/davej/sct for more info...

That's what RH's field testing showed us, ignore it if you wish... :)

	Jeff



