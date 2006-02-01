Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423012AbWBAXIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423012AbWBAXIR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 18:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423014AbWBAXIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 18:08:17 -0500
Received: from xproxy.gmail.com ([66.249.82.192]:25411 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1423012AbWBAXIQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 18:08:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=ht7jnHUC83UM8sbUHlP+VRDXSdFguyNZIKWnXimskUc/LPeJ852NQTRacbvF0Sp0IfKIkF2QA6LihTOZkuBEJsbNHFHDIAc64N224RVcz4y8CYV1sWO/+7F3eokoeREr6nh0Vj4ywEOjs/SC6u9gPo/c25FbqLS3xrpV0Miwdbk=
Message-ID: <43E13F57.40808@gmail.com>
Date: Thu, 02 Feb 2006 08:08:07 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: "Vladimir B. Savkin" <master@sectorb.msk.ru>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: Broken sata (VIA) on Asus A8V (kernel 2.6.14+)
References: <20060201162800.GA32196@tentacle.sectorb.msk.ru>
In-Reply-To: <20060201162800.GA32196@tentacle.sectorb.msk.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vladimir B. Savkin wrote:
> Hello!
> 
> My system based on Asus A8V (VIA chipset) works fine with 2.6.13.3,
> but after upgrading (kernels 2.6.14.7 and 2.6.15.1 tried) it
> gaves error messages some minutes after boot.
> 
> The messages are as following:
>   ata2: command 0xXX timeout, stat 0x50 host_stat 0x4
> where XX gets different values from time to time, 0x25 mostly.
> I/O to this controller halts after that.
> 
> Attached are boot dmesg log and lspci output.
> 

[CC'ing linux-ide]

Hello, Vladimir.

How reproducible is the problem?  With how much certainty can you say 
the problem is introduced by newer kernels?  e.g. If the problem occurs 
most of the time with 2.5.15.1 but it stops happending after switching 
back to 2.6.13.3, you can be pretty sure.

Can you also please post dmesg of 2.6.13.3?

-- 
tejun
