Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750933AbWCHN0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933AbWCHN0s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 08:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbWCHN0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 08:26:48 -0500
Received: from rtr.ca ([64.26.128.89]:5572 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750933AbWCHN0s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 08:26:48 -0500
Message-ID: <440EDB91.90700@rtr.ca>
Date: Wed, 08 Mar 2006 08:26:41 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8) Gecko/20060305 SeaMonkey/1.1a
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Gaston, Jason D" <jason.d.gaston@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: SATA ATAPI AHCI error messages?
References: <26CEE2C804D7BE47BC4686CDE863D0F50660ABA5@orsmsx410> <1141823834.7605.35.camel@localhost.localdomain>
In-Reply-To: <1141823834.7605.35.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
..
>> ata2: translated ATA stat/err 0x51/24 to SCSI SK/ASC/ASCQ 0xb/00/00
>> sr0: CDROM (ioctl) error, command: <6>Test Unit Ready 00 00 00 00 00 00
>> sr: Current [descriptor]: sense key: Aborted Command
>>     Additional sense: No additional sense information
> 
> TUR should not be getting aborted command replies off a CD. Most odd

It's been a while, and my memory of such is fuzzy,
but I think I have commonly seen ATAPI drives (in the past)
that simply fail TUR as above when the drive is open
or media is not present (one of those two, forgot which).

Cheers
