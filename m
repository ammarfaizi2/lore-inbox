Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751098AbWA0OPD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbWA0OPD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 09:15:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbWA0OPD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 09:15:03 -0500
Received: from [85.8.13.51] ([85.8.13.51]:16857 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1751098AbWA0OPB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 09:15:01 -0500
Message-ID: <43DA2ADA.4070309@drzeus.cx>
Date: Fri, 27 Jan 2006 15:14:50 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5 (X11/20060112)
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Russell King <rmk+lkml@arm.linux.org.uk>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: How to map high memory for block io
References: <43D9C19F.7090707@drzeus.cx> <20060127102611.GC4311@suse.de> <43D9F705.5000403@drzeus.cx> <20060127104321.GE4311@suse.de> <43DA0E97.5030504@drzeus.cx> <20060127123917.GI4311@suse.de> <43DA1D23.1000508@drzeus.cx> <43DA24A0.70004@drzeus.cx> <20060127140030.GL4311@suse.de>
In-Reply-To: <20060127140030.GL4311@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Fri, Jan 27 2006, Pierre Ossman wrote:
>   
>>
>> If I set the limit to BLK_BOUNCE_HIGH then (page_address(sg->page) +
>> sg->offset) is guaranteed to be directly accessible for the entire
>> sg->length on all architectures, right? This seems to be the assumption
>> in the USB ub driver at least.
>>     
>
> Yes, hence my initial suggestion to just do that.
>
>   

Just making sure I understood it correctly. These bugs tend to be a pain
to debug so I'd prefer to get it right from the start. :)

Thanks for the help.

Rgds
Pierre


