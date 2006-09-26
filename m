Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964811AbWIZVZw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964811AbWIZVZw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 17:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964815AbWIZVZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 17:25:51 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:60306 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964812AbWIZVZr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 17:25:47 -0400
Message-ID: <45199AD7.1060805@pobox.com>
Date: Tue, 26 Sep 2006 17:25:43 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Olivier Galibert <galibert@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libata-sff: use our IRQ defines
References: <1159289737.11049.261.camel@localhost.localdomain>	 <20060926204433.GA77171@dspnet.fr.eu.org> <1159305562.11049.312.camel@localhost.localdomain>
In-Reply-To: <1159305562.11049.312.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ar Maw, 2006-09-26 am 22:44 +0200, ysgrifennodd Olivier Galibert:
>>>  		if (probe_ent->irq)
>>> -			probe_ent->irq2 = 15;
>>> +			probe_ent->irq2 = ATA_SECONDARY_IRQ;
>>>  		else
>>>  			probe_ent->irq = 15;
>> Isn't that one supposed to be ATA_SECONDARY_IRQ too?
>>
>>>  		probe_ent->port[1].cmd_addr = ATA_SECONDARY_CMD;
> 
> Duh yes...
> 
> (adds another paper bag to the pile)

committed obvious fix...


