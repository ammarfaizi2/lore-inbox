Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261237AbVHAUcB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261237AbVHAUcB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 16:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbVHAUb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 16:31:56 -0400
Received: from mail.dvmed.net ([216.237.124.58]:37602 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261225AbVHAUan (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 16:30:43 -0400
Message-ID: <42EE866B.5030005@pobox.com>
Date: Mon, 01 Aug 2005 16:30:35 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Daniel Drake <dsd@gentoo.org>, Otto Meier <gf435@gmx.net>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: Driver for sata adapter promise sata300 tx4
References: <42EDE918.9040807@gmx.net> <42EE3501.7010107@gentoo.org> <42EE3FB8.10008@gmx.net> <42EE4ADF.4080502@gentoo.org> <20050801201756.GQ22569@suse.de>
In-Reply-To: <20050801201756.GQ22569@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Mon, Aug 01 2005, Daniel Drake wrote:
> 
>>Otto Meier wrote:
>>
>>>My question is also are these features (NCQ/TCQ) and the heigher 
>>>datarate be supported by this
>>>modification? or is only the basic feature set of sata 150 TX4 supported?
>>
>>NCQ support is under development. Search the archives for Jens Axboe's 
>>recent patches to support this. I don't know about TCQ.
> 
> 
> It's done for ahci, because we have documentation. I have no intention
> on working on NCQ for chipset where full documentation is not available.
> But the bulk of the code is the libata core support, adding NCQ support
> to a sata_* driver should now be fairly trivial (with docs).


I have docs for the Promise NCQ stuff.  Once NCQ is fully fleshed out (I 
haven't wrapped my brain around it in a couple weeks), it shouldn't be 
difficult to add NCQ support to sata_promise.

	Jeff


