Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268257AbUH3Ojb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268257AbUH3Ojb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 10:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268340AbUH3OiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 10:38:05 -0400
Received: from wasp.net.au ([203.190.192.17]:35011 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S268257AbUH3Oh1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 10:37:27 -0400
Message-ID: <41333BC9.1050903@wasp.net.au>
Date: Mon, 30 Aug 2004 18:38:01 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Mozilla Thunderbird 0.7+ (X11/20040730)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: libata dev_config call order wrong.
References: <41320DAF.2060306@wasp.net.au> <41321288.4090403@pobox.com>	 <413216CC.5080100@wasp.net.au> <4132198B.8000504@pobox.com>	 <41321F7F.7050300@pobox.com>	 <1093805994.28289.4.camel@localhost.localdomain>	 <4132EF78.9000200@wasp.net.au> <1093872174.30146.15.camel@localhost.localdomain>
In-Reply-To: <1093872174.30146.15.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Llu, 2004-08-30 at 10:12, Brad Campbell wrote:
> 
>>Given that the SATA->PATA bridge boards support 80 pin detection, then bit 13 of word 93 must be 
>>high on any drive that supports lba48, and given the *current* sata spec states that word 93 must be 
>>zero, we should be able to use this detection method.
> 
> 
> Word 53 is the important one and essentially tells you what else to
> believe later on in the configuration.

Ok, well acording to my copy of the ATA-6 spec, word 53 mentions nothing about word 93. From 
everything I have read in ATA-5 -> ATA-7 (Draft) word 93 appears to be pretty fixed.
It certainly works with my limited test set (all WD unfortunately)

