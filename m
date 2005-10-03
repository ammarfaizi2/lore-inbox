Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932334AbVJCP5v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334AbVJCP5v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 11:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbVJCP5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 11:57:48 -0400
Received: from mail.dvmed.net ([216.237.124.58]:25244 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932329AbVJCP5p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 11:57:45 -0400
Message-ID: <434154F0.9070105@pobox.com>
Date: Mon, 03 Oct 2005 11:57:36 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Luben Tuikov <luben_tuikov@adaptec.com>
CC: Andre Hedrick <andre@linux-ide.org>,
       "David S. Miller" <davem@davemloft.net>, willy@w.ods.org,
       patmans@us.ibm.com, ltuikov@yahoo.com, linux-kernel@vger.kernel.org,
       akpm@osdl.org, torvalds@osdl.org, linux-scsi@vger.kernel.org,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
References: <Pine.LNX.4.10.10509300015100.27623-100000@master.linux-ide.org> <433D8542.1010601@adaptec.com> <433DD0F8.4000501@pobox.com> <43413CE8.1090306@adaptec.com>
In-Reply-To: <43413CE8.1090306@adaptec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luben Tuikov wrote:
> On 09/30/05 19:57, Jeff Garzik wrote:
>>Luben Tuikov wrote:
>>>MPT-based drivers + James Bottomley's "transport attributes"

>>You continue to fail to see that a transport class is more than just 
>>transport attributes.
>>
>>You continue to fail to see that working on transport class support IS a 
>>transport layer, that includes management.
>>
>>Is you don't understand this fundamental stuff, how can we expect you to 
>>get it right?
> 
> 
>>From what I see, because of its *layering* position
> JB's "transport attributes" cannot satisfy open transport.

Repeating verbatim the above quote:  a transport class is more than just 
transport attributes.


> The reason is that MPT-based drivers indeed do need host template
> in the LLDD.

> Open Transport (SBP/USB/SAS) do not, since the chip is only
> an interface to the transport.

> The host template is implemented by a transport layer,
> say USB Storage or the SAS Transport Layer.

Every chip is ultimately an interface to the transport, regardless of 
whether the transport layer is largely managed by software (aic94xx) or 
firmware (MPT).  SCSI host template can work just fine with open 
transport hardware.

	Jeff


