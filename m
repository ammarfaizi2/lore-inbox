Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129982AbRATSAu>; Sat, 20 Jan 2001 13:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130217AbRATSAk>; Sat, 20 Jan 2001 13:00:40 -0500
Received: from colorfullife.com ([216.156.138.34]:42253 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129982AbRATSA0>;
	Sat, 20 Jan 2001 13:00:26 -0500
Message-ID: <3A69D235.F1EE4CA6@colorfullife.com>
Date: Sat, 20 Jan 2001 19:00:21 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: johannes@erdfelt.com, linux-kernel@vger.kernel.org
Subject: Re: Inefficient PCI DMA usage (was: [experimental patch] UHCI updates)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> TD's are around 32 bytes big (actually, they may be 48 or even 64 now, I 
> haven't checked recently). That's a waste of space for an entire page. 
> 
> However, having every driver implement it's own slab cache seems a 
> complete waste of time when we already have the code to do so in 
> mm/slab.c. It would be nice if we could extend the generic slab code to 
> understand the PCI DMA API for us. 
>
I missed the beginning of the thread:

What are the exact requirements for TD's?
I have 3 tiny updates for mm/slab.c that I'll send to Linus as soon as
2.4 has stabilized a bit more, perhaps I can integrate the code for USB.

--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
