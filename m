Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268041AbUHFBqy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268041AbUHFBqy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 21:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268049AbUHFBqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 21:46:53 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18618 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268041AbUHFBqv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 21:46:51 -0400
Message-ID: <4112E2D7.9020606@pobox.com>
Date: Thu, 05 Aug 2004 21:45:59 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Brett Russ <russb@emc.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [PATCH] (IDE) restore access to low order LBA following error
References: <41126458.1050203@emc.com>	 <1091724300.8043.58.camel@localhost.localdomain>	 <4112BF1E.9070404@pobox.com> <1091750465.8366.54.camel@localhost.localdomain>
In-Reply-To: <1091750465.8366.54.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Gwe, 2004-08-06 at 00:13, Jeff Garzik wrote:
> 
>>Alan Cox wrote:
>>
>>>Once Jeff has MWDMA and ATAPI in the new SATA/ATA driver he wrote then
>>>migration might be an even better option. It'll certainly be easier to
>>>do a lot of things right with the newest SATA code than with the current
>>>IDE layer.
>>
>>BTW MWDMA is already done and checked in :)
> 
> 
> Do ATAPI and I'll be glad to help move the other drivers over. I need
> hotplug for my PIIX controller and SI680!


ATAPI works too.....  assuming your CD/DVD drive never encounters a 
CHECK CONDITION requiring REQUEST SENSE to be issued...  ;-)

	Jeff


