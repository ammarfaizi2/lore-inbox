Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261466AbVA1PuE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261466AbVA1PuE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 10:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261467AbVA1PuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 10:50:04 -0500
Received: from a26.t1.student.liu.se ([130.236.221.26]:62418 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S261466AbVA1Pt6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 10:49:58 -0500
Message-ID: <41FA5F22.5020008@drzeus.cx>
Date: Fri, 28 Jan 2005 16:49:54 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: PNP and bus association
References: <41F95A42.40001@drzeus.cx> <41F97185.6030905@osdl.org>
In-Reply-To: <41F97185.6030905@osdl.org>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:

> Pierre Ossman wrote:
>
>> I recently tried out adding PNP support to my driver to remove the 
>> hassle of finding the correct parameters for it. This, however, 
>> causes it to show up under the pnp bus, where as it previously was 
>> located under the platform bus.
>>
>> Is the idea that PNP devices should only reside on the PNP bus or is 
>> there some magic available to get the device to appear on several 
>> buses? It's a bit of a hassle to search in two different places in 
>> sysfs depending on if PNP is used or not.
>>
>> Also, the PNP bus doesn't really say that much about where the device 
>> is physically connected. The other bus types usually give a hint 
>> about this.
>
>
> Not to take away from your question, but:
> Is there "the PNP bus"?  I've seen an ISA bus that (sort of)
> supports PNP, PCI PNP, NuBus PNP, USB PNP, IEEE 1394 PNP, etc.
>
It's not a physical bus but it is a bus as far as the kernel is 
concerned. And that's really my problem. I want it to support PNP, but 
also to associate with the physical bus it's connected to.

Rgds
Pierre

PS. Your outgoing mail server gives the wrong HELO

