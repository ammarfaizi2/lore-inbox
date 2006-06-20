Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbWFTMqt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbWFTMqt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 08:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750709AbWFTMqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 08:46:49 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:56463 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1750705AbWFTMqs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 08:46:48 -0400
Message-ID: <4497EE3A.5040703@drzeus.cx>
Date: Tue, 20 Jun 2006 14:46:50 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Russell King <rmk+lkml@arm.linux.org.uk>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] New MMC driver model
References: <449553E5.9030004@drzeus.cx> <1150796122.18381.24.camel@localhost>
In-Reply-To: <1150796122.18381.24.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcel Holtmann wrote:
>> The "interrupt pending" register also allows us to do a polled solution
>> for non-SDIO capable hosts. I'm unsure how to get a good balance between
>> latency and resource usage though.
>>     
>
> I think that polled solution is not really working out. Especially if
> you need some high speed transfers.
>
>   

It probably won't give you any fantastic performance, but if the choice
is between crappy performance or none at all...

Also it would allow me to do some testing on my controller. Which brings
me to...

> My understanding of the current MMC core is rather limited and I think
> that I am not of any good help to get this started. However I have a
> couple of SDIO cards (various types) for testing and I am happy to test
> any patch you send around.
>
>   

If you have any SDIO cards to spare, I'd really appreciate if I could
borrow one or two for testing.

Rgds
Pierre

