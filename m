Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269787AbRHTXHQ>; Mon, 20 Aug 2001 19:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269796AbRHTXHG>; Mon, 20 Aug 2001 19:07:06 -0400
Received: from nycsmtp2fb.rdc-nyc.rr.com ([24.29.99.78]:48910 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S269787AbRHTXG4>;
	Mon, 20 Aug 2001 19:06:56 -0400
Message-ID: <3B819865.3090007@si.rr.com>
Date: Mon, 20 Aug 2001 19:08:21 -0400
From: Frank Davis <fdavis@si.rr.com>
Reply-To: fdavis@si.rr.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.2) Gecko/20010726 Netscape6/6.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: sound crashes in 2.4
In-Reply-To: <E15Yrzo-0006LI-00@the-village.bc.nu> <000801c129ad$c50c8e60$0200a8c0@home.lan>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
     A trace of the crashes would be helpful.

Regards,
Frank

Chris Pockele wrote:

>>Can you try one other thing.
>>
>>Edit drivers/pci/quirks.c
>>
>>find 
>>
>>int isa_dma_bridge_buggy; /* Exported */
>>
>>and make it read
>>
>>int isa_dma_bridge_buggy = 1;
>>
>>recompile reboot and see if it helps
>>
>>
> Unfortunately, it does not help.  The machine rebooted
> suddenly (i forgot to mention that: sometimes it reboots
> too, but mostly it just hangs).
> 
> btw the system doesn't have a PCI bus, so its kernel
> does not have PCI support enabled
> 
> (it's a SIS85C471B-based ISA/VLB motherboard)
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 


